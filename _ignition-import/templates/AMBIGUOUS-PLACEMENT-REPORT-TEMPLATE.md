# LegacyCode -> <ArchitectureStyle> Gap Analysis

Use this template when a legacy file, folder, or test surface does not map cleanly into the approved target structure and the placement needs a durable review artifact.

## Purpose

- Decision this report supports:
- Why the source surface is ambiguous:
- Modernization step / slice:

## Assumptions Used

- Architecture style:
- Source-of-truth references:
- Evidence inspected:
- Known limits:

## Executive Summary

- Source surface:
- Recommended destination:
- Confidence:
- Key reason:
- Reviewer decision:

## Detailed Findings

### 1. Source Surface

- Source path:
- Artifact type:
- Current usage boundary:
- Why the name or folder is misleading:

### 2. Evidence Snapshot

| Evidence Type | Observation | Placement Impact |
| --- | --- | --- |
| Controller/API usage |  |  |
| Service/feature usage |  |  |
| Repository/persistence usage |  |  |
| DI or startup wiring |  |  |
| Test or call-site evidence |  |  |
| Naming/folder clues |  |  |

### 3. Candidate Destinations

| Candidate Destination | Why It Fits | Why It Might Be Wrong | Confidence |
| --- | --- | --- | --- |
|  |  |  | `High/Medium/Low` |
|  |  |  | `High/Medium/Low` |
|  |  |  | `High/Medium/Low` |

### 4. Recommended Placement

- Destination:
- Supporting reason:
- Required companion moves:
- Validation to run:

### 5. Risks And Decision Check

- What could invalidate this:
- What evidence would settle it:
- Reviewer decision: `Approve`, `Approve with follow-up`, `Needs more evidence`, or `Reject`
- Notes:

## Proposed Skill/Reference Enhancements

- Add or clarify:
- Why it would help the next slice:

## Highest-Confidence Immediate Recommendations

1.
2.
3.

## Items That Likely Need Explicit User Direction

-
