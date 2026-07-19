# Backend adapters

One directory per supported legacy backend flavor. An adapter defines *how* this stack
is analyzed, upgraded, and restructured — while emitting only canonical artifacts
(`schemas/`). Required sections in each `skill.md`:

1. **Detection** — how step 00 identifies this flavor (project files, packages, markers).
2. **Extraction** — how to enumerate endpoints for the inventory; how to run the app
   locally for golden capture.
3. **Upgrade path** — target: cross-platform .NET (version pinned per kit release);
   known incompatibilities and their standard fixes.
4. **Hazard hotspots** — where this stack typically hides in-proc session, local file
   writes, Windows dependencies.

Tier status lives in `support-matrix.md`. A `skill.md` marked STUB means Planned:
profile detection must halt, not improvise.
