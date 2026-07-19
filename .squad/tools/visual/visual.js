#!/usr/bin/env node
/* Baseline capture + visual regression for Squad-ik.
 *
 * Usage:
 *   node visual.js capture <base-url> --inventory <ui-inventory.json> --out <baseline-dir>
 *   node visual.js diff    <base-url> --inventory <ui-inventory.json> --baselines <dir> --out <diff-dir> [--threshold 0.1]
 *
 * Deterministic capture: fixed viewport, animations/transitions/caret disabled, network
 * idle + settle delay. Threshold is the failing fraction of differing pixels (percent).
 * Exit codes: 0 clean; 1 diffs/missing baselines; 2 usage/environment error.
 *
 * Uses playwright-core with the pre-installed browser: set CHROMIUM_PATH or rely on
 * the default /opt/pw-browsers/chromium provided by Claude Code cloud / CI images.
 */
const fs = require('fs');
const path = require('path');
const { chromium } = require('playwright-core');
const { PNG } = require('pngjs');
const pixelmatch = require('pixelmatch');

const NORMALIZE_CSS = `
  *, *::before, *::after {
    animation: none !important;
    transition: none !important;
    caret-color: transparent !important;
  }
`;

function parseArgs(argv) {
  const [cmd, baseUrl, ...rest] = argv;
  const opts = { threshold: 0.1 };
  for (let i = 0; i < rest.length; i += 2) {
    opts[rest[i].replace(/^--/, '')] = rest[i + 1];
  }
  return { cmd, baseUrl, opts };
}

function slug(route, state) {
  return `${route.replace(/[^a-zA-Z0-9]+/g, '_').replace(/^_+|_+$/g, '')}--${state}.png`;
}

function findExecutable() {
  if (process.env.CHROMIUM_PATH) return process.env.CHROMIUM_PATH;
  const candidates = ['/opt/pw-browsers/chromium', '/usr/bin/chromium', '/usr/bin/chromium-browser'];
  for (const c of candidates) {
    if (fs.existsSync(c)) {
      const stat = fs.statSync(c);
      if (stat.isFile()) return c;
      // directory install: find the chrome binary inside
      const inner = ['chrome-linux/chrome', 'chrome'].map((p) => path.join(c, p)).find(fs.existsSync);
      if (inner) return inner;
    }
  }
  return null; // let playwright-core try its own resolution
}

async function shoot(page, url) {
  await page.goto(url, { waitUntil: 'networkidle' });
  await page.addStyleTag({ content: NORMALIZE_CSS });
  await page.waitForTimeout(400); // settle: fonts, angular digest
  return page.screenshot({ fullPage: true });
}

async function main() {
  const { cmd, baseUrl, opts } = parseArgs(process.argv.slice(2));
  if (!['capture', 'diff'].includes(cmd) || !baseUrl || !opts.inventory) {
    console.error('usage: visual.js capture|diff <base-url> --inventory FILE [--out DIR] [--baselines DIR] [--threshold PCT]');
    process.exit(2);
  }
  const inv = JSON.parse(fs.readFileSync(opts.inventory, 'utf8'));
  const outDir = opts.out || (cmd === 'capture' ? 'baselines' : 'visual-diffs');
  fs.mkdirSync(outDir, { recursive: true });

  const executablePath = findExecutable();
  const browser = await chromium.launch(executablePath ? { executablePath } : {});
  const page = await browser.newPage({ viewport: { width: 1280, height: 800 }, deviceScaleFactor: 1 });

  let failures = 0;
  for (const route of inv.routes) {
    // Distinct states need distinct URLs: routes[].stateUrls maps state -> path override.
    // Without it, every state of a route screenshots the same page — warn loudly so
    // multi-state baselines are never silently identical.
    if (route.states.length > 1 && !route.stateUrls) {
      console.log(`WARN: ${route.path} has ${route.states.length} states but no stateUrls — all states will capture the same URL`);
    }
    for (const state of route.states) {
      const file = slug(route.path, state);
      const statePath = (route.stateUrls && route.stateUrls[state]) || route.path;
      const url = baseUrl.replace(/\/$/, '') + statePath;
      const png = await shoot(page, url);
      if (cmd === 'capture') {
        fs.writeFileSync(path.join(outDir, file), png);
        console.log(`captured: ${file}`);
      } else {
        const basePath = path.join(opts.baselines, file);
        if (!fs.existsSync(basePath)) {
          console.log(`FAIL: no baseline for ${file}`);
          failures++;
          continue;
        }
        const a = PNG.sync.read(fs.readFileSync(basePath));
        const b = PNG.sync.read(png);
        if (a.width !== b.width || a.height !== b.height) {
          console.log(`FAIL: ${file} size ${b.width}x${b.height} != baseline ${a.width}x${a.height}`);
          fs.writeFileSync(path.join(outDir, file), png);
          failures++;
          continue;
        }
        const diff = new PNG({ width: a.width, height: a.height });
        const mismatched = pixelmatch(a.data, b.data, diff.data, a.width, a.height, { threshold: 0.1 });
        const pct = (100 * mismatched) / (a.width * a.height);
        if (pct > parseFloat(opts.threshold)) {
          fs.writeFileSync(path.join(outDir, file), PNG.sync.write(diff));
          console.log(`FAIL: ${file} — ${pct.toFixed(3)}% pixels differ (diff written)`);
          failures++;
        } else {
          console.log(`ok  : ${file} (${pct.toFixed(3)}%)`);
        }
      }
    }
  }
  await browser.close();
  if (cmd === 'diff') {
    console.log(failures === 0 ? 'visual: clean' : `visual: ${failures} failure(s)`);
  }
  process.exit(failures === 0 ? 0 : 1);
}

main().catch((e) => {
  console.error(e);
  process.exit(2);
});
