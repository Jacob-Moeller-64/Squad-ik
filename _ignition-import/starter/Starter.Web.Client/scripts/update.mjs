import { npmAuth, npmInstall, npmUpdate } from './tools.mjs';

await npmAuth();
await npmUpdate();
