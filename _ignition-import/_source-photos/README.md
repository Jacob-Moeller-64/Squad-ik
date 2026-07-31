# Source photos for the incomplete transcriptions

These are the screen photographs for the **ten files under `_ignition-import/scripts/`
that are not fully transcribed**. They were preserved here because the originals live in
a session-scoped upload directory inside an ephemeral container — starting a new session
would have destroyed them.

- Downscaled to **2000 px wide, JPEG q82**. That is the exact resolution the reading tool
  downsamples to anyway, so **no information is lost** relative to the originals.
- 88 photos, 41 MB (from 340 MB of originals).
- Filenames are `NN-<hash>.jpg` where **NN is the order the photos were sent in**.

## How to use these

Each folder maps to a file under `_ignition-import/scripts/<same path>.ps1`. The
partially-transcribed `.PARTIAL.ps1` / `.FRAGMENT-*.ps1` / `.TAIL-*.ps1` files in that
directory each carry a delimited header stating exactly which source line ranges they
cover and which are missing.

Working method used so far, worth continuing:

1. Read the photos in order; note the line numbers in the editor gutter.
2. Transcribe **verbatim** — do not normalise indentation, quoting, or trailing
   newlines.
3. Verify the written file against the photographed gutter anchors before committing
   (`awk 'NR==<n> {print}'`). Every committed file was checked this way.
4. Record structural facts and findings in `_ignition-import/README.md`.
5. Never commit real secrets, credentials, Okta tenant/client IDs, or internal
   hostnames — redact with a placeholder and note it in the uncertainties section.

## Status: BACKFILL COMPLETE (2026-07-31)

All ten files were transcribed from these photos by a 22-agent verification
workflow (transcribe → independently verify against photos → fix). Every file
now lives at its canonical path with the `.PARTIAL`/`.FRAGMENT`/`.TAIL`
intermediates removed. See the "Backfill pass" section of
`_ignition-import/README.md` for per-file verification stats and findings.

**One gap remains:** `shared/verify-step-artifacts.ps1` source lines **354-398**
(45 lines) are covered by no photo in this set — `06-23e594b2` ends at gutter
353 and `07-4c3ec0a1` begins at 399. The file carries a delimited
`# TRANSCRIPTION GAP` placeholder preserving true line numbers, and does not
parse until that range is re-photographed and spliced in.

These photos are retained as the source evidence for the import.

## What is already complete

Everything under `_ignition-import/starter/`, all of `instructions/`, `prompts/`,
`skills/`, `agents/`, `contracts/`, `templates/`, plus these fully-verified scripts:
`scan-api-dto-coverage.ps1`, `scan-backend-parity.ps1`, `scan-functional-parity-ledger.ps1`,
`scan-scaffold-debt.ps1`, `selftest-backend-parity.ps1`, `verify-gate-integrity.ps1`.
Their photos were not preserved — they had served their purpose.
