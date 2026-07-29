---
name: tests-commenting-standards
description: Tutorial-level commenting and file-header rules for every maintained file under tests/.
applyTo: "tests/**"
---

# Tests Commenting Standards

## Purpose

- Use this file for every maintained file under `tests/`.
- The goal is tutorial-level clarity, not just minimal documentation.
- A developer should be able to walk through any test, helper, script, project file, or support file in `tests/` and explain what it does without guessing.

## Required Top-Of-File Description

- Every maintained file under `tests/` must start with a short header comment that explains exactly what the file is.
- The header must explain all of these items in very simple English:
  - file purpose
  - main responsibility
  - important collaborators or dependencies
  - any safety, parity, or runtime constraints that matter to the file
- Use the native comment style for the file type:
  - `//` or `/* */` for TypeScript and C#
  - XML comments or XML block comments only when the file format requires XML-safe comments, such as `.csproj`
  - PowerShell comment blocks for `.ps1`
  - HTML comments for markup-style files
  - markdown prose for `.md` files, starting with a clear opening description paragraph

## Required Comment Density

- Tests in `tests/` must be commented aggressively enough to support a live tutorial walkthrough.
- Do not leave helpers, configuration files, or runner scripts as bare implementation.
- Explain the intent of each section in the order a reader encounters it.
- Prefer many short comments in plain English over a few dense comments.

## Test Case Rules

- Every test case must keep or add explicit metadata comments:
  - `CaseId`
  - `Scenario`
  - `Description`
  - `Input`
  - `Expected`
- Every test body must keep or add explicit flow comments:
  - `Given`
  - `When`
  - `Then`
- If a test has multiple important checkpoints, add simple `And` comments where they help a junior reader follow the sequence.

## Helper And Utility Rules

- Helper files under `tests/` must explain:
  - what shared problem the helper solves
  - why the helper exists instead of repeating logic in each test
  - what each exported function is responsible for
  - any selector, routing, auth, or runtime assumptions the helper depends on
- Add short comments inside helper functions ahead of meaningful steps, especially when the helper hides Playwright, HTTP, or setup complexity.

## Configuration File Rules

- Test configuration files must explain the reason for each important setting block.
- Add comments before environment-variable fallbacks, timeout values, reporter settings, runtime URLs, managed web-server settings, and browser or device selections.
- The reader should understand why a setting exists, not just what the setting value is.

## Script Rules

- Runner and characterization scripts under `tests/` must explain the sequence of operations in order.
- Add comments before parameter blocks, environment setup, path resolution, external command execution, and exit-code propagation.
- Scripts should read like a step-by-step walkthrough.

## Project File Rules

- Test project files such as `.csproj` files must begin with an XML-safe comment block that explains:
  - what test suite the project owns
  - why the project exists separately from other test projects
  - the key package or project references that make the suite work
- Add short XML comments above non-obvious property groups or item groups when they carry suite-specific intent.

## Tutorial-Level Standard

- Optimize every `tests/` file for a walkthrough where the developer explains the file line by line.
- This does not mean every line needs a separate comment.
- It does mean every block, decision, dependency, and non-obvious setting must be explained before the reader has to infer intent.
- If a file still feels bare during a walkthrough, it is under-commented.

## No Surprise Rule

- Do not create or modify files under `tests/` without bringing them up to this commenting standard in the same change.
- Do not leave config, helper, script, `.csproj`, or proof-of-concept files less documented than the test cases.
