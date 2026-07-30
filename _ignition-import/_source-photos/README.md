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

## Current gaps

| Target file | Total lines | Transcribed | Missing |
|---|---|---|---|
| `parity/scan-styling-foundation.ps1` | ? | **nothing** | all |
| `parity/scan-ui-parity-gaps.ps1` | ~950+ | 1-454 | **455-end** |
| `parity/selftest-functional-parity-ledger.ps1` | 340 | 1-121, 284-341 | **122-283** |
| `parity/selftest-parity-gate.ps1` | ? | 1-66 | rest |
| `parity/selftest-scaffold-debt.ps1` | ? | 1-65 | rest |
| `shared/field-contract.ps1` | ? | 1-63 | rest |
| `shared/Invoke-StepReconciliation.ps1` | 803 | 1-67, 274-336, 755-804 | **68-273, 337-754** |
| `shared/verify-step-artifacts.ps1` | ~1017 | 1-66, 291-353, 610-669, 951-1017 | **67-290, 354-609, 670-950** |
| `shared/verify-upgrade-invariants.ps1` | 306 | 1-66, 251-307 | **67-250** |
| `maintenance/audit-step-number-drift.ps1` | 290 | 1-67, 248-291 | **68-247** |

Highest value first: **`shared/Invoke-StepReconciliation.ps1` lines 68-273** — that range
holds `$RuleRegistry`, which is the last unanswered question in the review (see the
"0 references" note in `_ignition-import/README.md`).

## What is already complete

Everything under `_ignition-import/starter/`, all of `instructions/`, `prompts/`,
`skills/`, `agents/`, `contracts/`, `templates/`, plus these fully-verified scripts:
`scan-api-dto-coverage.ps1`, `scan-backend-parity.ps1`, `scan-functional-parity-ledger.ps1`,
`scan-scaffold-debt.ps1`, `selftest-backend-parity.ps1`, `verify-gate-integrity.ps1`.
Their photos were not preserved — they had served their purpose.
