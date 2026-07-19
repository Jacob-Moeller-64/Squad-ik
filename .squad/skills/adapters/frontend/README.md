# Frontend adapters

One directory per supported legacy frontend flavor. Same contract as backend adapters:
stack-specific *how*, canonical artifacts out. Required sections in each `skill.md`:

1. **Detection** — how step 00 identifies this flavor and version.
2. **Extraction** — how to enumerate routes/states/components for the UI inventory;
   how to run the app locally for baseline capture.
3. **Upgrade path** — target frontend framework (pinned per kit release); migration
   strategy and known breakages.
4. **Component idioms** — how components/bindings in this stack map to modern
   component/props shapes (feeds step 12 classification).

Tier status lives in `support-matrix.md`. STUB = Planned = halt on detection.
