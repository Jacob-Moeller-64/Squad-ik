import { execute, npmAuth, npmInstall } from './tools.mjs';

export async function preBuild(start) {
    if (start) {
        await npmAuth();
    }

    // npm install
    console.log('installing npm packages...');
    await npmInstall();

    // clean
    console.log('cleaning...');
    await execute('npm run clean');

    // lint
    console.log('linting projects...');
    await execute('npm run lint');
}
