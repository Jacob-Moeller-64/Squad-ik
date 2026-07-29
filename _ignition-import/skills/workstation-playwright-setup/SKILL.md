---
name: workstation-playwright-setup
description: Reusable Playwright workstation setup and validation for Step 1 readiness, Step 3 legacy screenshot capture, and later UI parity workflows.
argument-hint: Prepare Playwright and Chromium runtime for this workspace or troubleshoot Playwright setup failures
---

# Workstation Playwright Setup

Use this skill when the user needs Playwright setup or troubleshooting so Step 3 and UI parity capture work without blockers.

## Scope

- Install Playwright in the app client workspace
- Install matching Chromium binaries for the locally resolved Playwright version
- Run a quick probe screenshot to verify capture path health
- Resolve common TLS and version-mismatch install failures

## Setup Commands

Run from repository root.

1. Install Playwright package in the app client workspace.

```powershell
Push-Location src\<AppName>.Web.Client
npm install --save-dev playwright
```

2. Install Chromium binaries using the workspace-local Playwright CLI.

```powershell
node .\node_modules\playwright\cli.js install chromium
Pop-Location
```

## Optional Probe

Use this only to validate runtime capture mechanics before Step 3.

```powershell
Push-Location src\<AppName>.Web.Client
node -e "const { chromium } = require('playwright'); (async () => { const b = await chromium.launch({ headless: true }); const p = await b.newPage({ viewport: { width: 1920, height: 1080 } }); await p.goto('http://localhost:56383/#table-details', { waitUntil: 'domcontentloaded' }); await p.screenshot({ path: '../../.modernization/portal/data/images/legacy-system-analysis/playwright-probe.png', fullPage: true }); await b.close(); console.log('PLAYWRIGHT_PROBE_OK'); })();"
Pop-Location
```

## Common Issues

- Executable does not exist under playwright chromium revision path.
  - Cause: browser binaries were not installed for the currently resolved Playwright package.
  - Fix: run `node .\node_modules\playwright\cli.js install chromium` from `src\<AppName>.Web.Client`.

- unable to get local issuer certificate while downloading browser binaries.
  - Cause: enterprise TLS chain blocks CDN download.
  - Fix (process-local only):

```powershell
Push-Location src\<AppName>.Web.Client
$env:NODE_TLS_REJECT_UNAUTHORIZED='0'
node .\node_modules\playwright\cli.js install chromium
Remove-Item Env:\NODE_TLS_REJECT_UNAUTHORIZED -ErrorAction SilentlyContinue
Pop-Location
```

- npx playwright install downloads a revision different from the runtime package.
  - Cause: multiple Playwright versions in dependency tree.
  - Fix: use workspace-local CLI path `node .\node_modules\playwright\cli.js install chromium`.

## Capture Policy Reminder

- Use desktop viewport baselines for Step 3 and parity captures.
- Include modal/dialog states that belong to user workflows.
- Suppress duplicates when two routes render equivalent visual output.
