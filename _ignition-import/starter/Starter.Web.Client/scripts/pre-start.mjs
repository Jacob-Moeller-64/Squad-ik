import console from 'node:console';
import { preBuild } from './pre-build.mjs';
import { execute } from './tools.mjs';

await preBuild(true);

// Setup https certificate
console.log('setting up https certificate...');
await execute(`dotnet dev-certs https --trust`);
await execute(`dotnet dev-certs https --export-path ./cert.pem --format Pem --no-password`);
