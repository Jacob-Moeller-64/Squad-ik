import child_process from 'node:child_process';
import fs from 'node:fs';
import fsPromises from 'node:fs/promises';
import path from 'node:path';
import process from 'node:process';
import util from 'node:util';
import { EOL } from 'os';
import { safePackageInstalls } from './npm-safe-package-installs.mjs';

const exec = util.promisify(child_process.exec);

export async function appendLine(file, text) {
    await fsPromises.appendFile(file, text + EOL);
}

export async function execute(command, workingDir) {
    const { stdout, stderr } = await exec(command, { cwd: workingDir ?? process.cwd() });

    if (stdout) {
        console.log(`${stdout}`);
    }

    if (stderr) {
        console.error(`${stderr}`);
    }
}

export async function executeWithResult(command, workingDir) {
    const { stdout, stderr } = await exec(command, { cwd: workingDir ?? process.cwd() });

    if (stderr) {
        throw new Error(`${stderr}`);
    }

    return stdout;
}

export function getFullPath(entry) {
    return `${entry.parentPath}/${entry.name}`;
}

export async function installSafePackages(projectDirectory) {
    if (!projectDirectory) {
        projectDirectory = './';
    }

    const nodeModulesPath = path.join(projectDirectory, 'node_modules');
    for (const safePackage in safePackageInstalls) {
        const packagePath = path.join(nodeModulesPath, safePackage);
        if (fs.existsSync(packagePath)) {
            console.log(`installing safe package - ${safePackage}`);
            await execute(`npm run ${safePackageInstalls[safePackage]} --ignore-scripts false`, packagePath);
        }
    }
}

export async function listFiles(path) {
    const dir = await fsPromises.opendir(path);
    const results = [];
    for await (const dirent of dir) {
        // automatically closes the dir
        if (dirent.isFile()) {
            results.push(dirent);
        }
    }

    return results;
}

export async function listFolders(path) {
    const dir = await fsPromises.opendir(path);
    const results = [];
    for await (const dirent of dir) {
        // automatically closes the dir
        if (dirent.isDirectory()) {
            results.push(dirent);
        }
    }

    return results;
}

export async function npmAuth(projectDirectory, installVsts) {
    if (!projectDirectory) {
        projectDirectory = './';
    }

    const npmrcPath = path.join(projectDirectory, '.npmrc');
    const npmrc = await fsPromises.readFile(npmrcPath, 'utf8');

    if (npmrc.includes('<SONATYPE-NPM-HOST>')) {
        console.log('using Sonatype npm registry configuration from .npmrc');
        console.log('npmAuth is a no-op for Sonatype-backed installs; provide auth through user or environment npm config when needed.');
        return;
    }

    if (process.platform === 'win32') {
        console.log('legacy npm auth flow detected, but Azure Artifacts auth is no longer used by this workspace.');
    } else {
        console.log('manual npm authentication is required for non-Sonatype registries.');
    }
}
export async function npmInstall(projectDirectory, force) {
    if (!projectDirectory) {
        projectDirectory = './';
    }

    const nodeModulesPath = path.join(projectDirectory, 'node_modules');

    if (fs.existsSync(nodeModulesPath) && !force) {
        console.log('node_modules already exists, skipping install...');
        return;
    }

    const projectLockFile = path.join(projectDirectory, 'package-lock.json');

    try {
        if (fs.existsSync(projectLockFile) && !force) {
            console.log('installing packages via - npm ci');
            await execute('npm ci', projectDirectory);
        } else {
            console.log('installing packages via - npm install');
            await execute('npm install', projectDirectory);
        }
        await installSafePackages(projectDirectory);
    } catch (error) {
        console.error(`Error installing packages: ${error.message}`);

        // Attempt to remove node_modules
        const nodeModulesPath = path.join(projectDirectory, 'node_modules');
        if (fs.existsSync(nodeModulesPath)) {
            console.log(`Removing node_modules at ${nodeModulesPath}`);
            try {
                await removePath(nodeModulesPath);
            } catch (removeError) {
                console.error(`Error removing node_modules: ${removeError.message}`);
            }
        }
    }
}

export async function npmUpdate(projectDirectory) {
    if (!projectDirectory) {
        projectDirectory = './';
    }

    console.log('updating packages');
    try {
        await execute('npm update', projectDirectory);
        await installSafePackages(projectDirectory);
    } catch (error) {
        console.error(`Error updating packages: ${error.message}`);

        // Attempt to remove node_modules
        const nodeModulesPath = path.join(projectDirectory, 'node_modules');
        if (fs.existsSync(nodeModulesPath)) {
            console.log(`Removing node_modules at ${nodeModulesPath}`);
            try {
                await removePath(nodeModulesPath);
            } catch (removeError) {
                console.error(`Error removing node_modules: ${removeError.message}`);
            }
        }
    }
}

export async function removePath(folder) {
    await fsPromises.rm(folder, { force: true, recursive: true });
}

export function spawn(command, args, workingDir) {
    const child = child_process.spawn(command, args, {
        cwd: workingDir,
        detached: true,
        env: process.env,
        shell: true,
        stdio: 'ignore'
    });
    child.unref();
}
