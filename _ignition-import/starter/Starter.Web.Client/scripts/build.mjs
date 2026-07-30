import process from 'node:process';
import fs from 'node:fs/promises';
import path from 'node:path';
import { execute } from './tools.mjs';
import { preBuild } from './pre-build.mjs';

await preBuild(false);

await fs.mkdir(path.join(process.cwd(), 'obj', 'Debug'), { recursive: true });

const configuration = process.argv.find((p) => p.startsWith('configuration:'))?.replace('configuration:', '') || 'local';
console.log(`building with configuration: ${configuration}`);
await execute(`ng build --configuration ${configuration}`);
