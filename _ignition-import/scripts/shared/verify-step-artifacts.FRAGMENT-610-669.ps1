# ===========================================================================
# TRANSCRIPTION FRAGMENT -- NOT A RUNNABLE FILE.
# Source lines 610-669 of verify-step-artifacts.ps1, inside
# function Get-StepSemanticReadinessFindings (begins line 249).
# Lines 67-290, 354-609 and 670-end are NOT transcribed.
# Long Add-ReadinessFinding -Message/-Remediation strings are single source
# lines that soft-wrap in the photo; reproduced unwrapped.
# ===========================================================================

  # Behavioral-parity checkpoint: block only on an explicitly recorded overall=fail.
  # Emitted by behavioral-parity.journey.spec.ts when E2E_BEHAVIORAL_PARITY_ENABLED=1.
  # When the spec hasn't run yet (no file) this gate is skipped, not blocked - the spec
  # is an opt-in runtime proof, not a mandatory artifact. An overall=fail means at least
  # one registered interactive element produced no behavioral effect at runtime: filter
  # did not filter, dropdown had no options, command triggered nothing, or grid was empty.
  $behavioralCheckpointPath = Join-Path $RepoRoot '.modernization/ignition-artifacts/discovery/behavioral-parity-checkpoint.json'
  if (Test-Path -LiteralPath $behavioralCheckpointPath) {
    try {
      $bc = Get-Content -LiteralPath $behavioralCheckpointPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
      $bcOverall = if ($bc.PSObject.Properties.Name -contains 'overall') { [string]$bc.overall } else { '' }
      if ($bcOverall -match '(?i)^fail') {
        $bcFail = if ($bc.PSObject.Properties.Name -contains 'fail') { [int]$bc.fail } else { 0 }
        Add-ReadinessFinding -Message ("Step {0} cannot close: behavioral-parity-checkpoint.json records overall='{1}' ({2} behavioral assertion failure(s)). A runtime behavioral effect was promised by the behavior plan but not observed - filter did not change rows, dropdown had no options, command triggered no effect, or grid showed no real rows. This is the failure mode static gates cannot see." -f $Step, $bcOverall, $bcFail) -Remediation "Fix the failing behavioral binding and re-run the behavioral-parity spec (E2E_BEHAVIORAL_PARITY_ENABLED=1) until overall=pass. See tests/frontend/e2e/journeys/behavioral-parity.journey.spec.ts."
      }
    }
    catch {
      Write-Verbose ("Step {0} behavioral-checkpoint read issue: {1}" -f $Step, $_.Exception.Message)
    }
  }

  # Scaffold-debt drain gate: surviving deferral markers ("Step N wires ...", "wired in a
  # later step", placeholder bodies) whose owning step has been reached must not ship. This
  # is the class that let a from-memory scaffold pass with its behavior announced-but-unwired
  # in comments no gate ever scanned. Fires only when the scaffold-debt scan artifact exists.
  $scaffoldScanPath = Join-Path $RepoRoot '.modernization/ignition-artifacts/discovery/scaffold-debt-scan.json'
  if (Test-Path -LiteralPath $scaffoldScanPath) {
    try {
      $debt = Get-Content -LiteralPath $scaffoldScanPath -Raw -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
      $overdueDebt = New-Object System.Collections.Generic.List[string]
      if (($debt.PSObject.Properties.Name -contains 'findings') -and $debt.findings) {
        foreach ($d in @($debt.findings)) {
          if ($null -eq $d) { continue }
          $sev = if ($d.PSObject.Properties.Name -contains 'severity') { [string]$d.severity } else { '' }
          if ($sev -eq 'accepted') { continue }
          $impliedStep = if (($d.PSObject.Properties.Name -contains 'impliedStep') -and ($null -ne $d.impliedStep)) { [int]$d.impliedStep } else { 0 }
          if ($impliedStep -gt 0 -and $impliedStep -le $Step) {
            $overdueDebt.Add(("{0}:{1}" -f ([string]$d.file), ([string]$d.line))) | Out-Null
          }
        }
      }
      if ($overdueDebt.Count -gt 0) {
        $sample = (($overdueDebt | Select-Object -First 5) -join ', ')
        Add-ReadinessFinding -Message ("Step {0} cannot close: {1} scaffold-debt marker(s) owned by Step {0} or earlier still survive in src (e.g. {2}). A 'Step N wires this' / 'wired in a later step' note that outlives its step means the behavior was announced but not finished, or a stale scaffold note was never cleaned." -f $Step, $overdueDebt.Count, $sample) -Remediation "Finish the announced behavior against the legacy answer key and remove the now-inaccurate scaffold marker; or, only if the note is genuinely intentional, accept it in .modernization/ignition-artifacts/discovery/scaffold-debt-registry.json with a reason. Then re-run scan-scaffold-debt.ps1 -CurrentStep <n>."
      }
    }
    catch {
      Add-ReadinessFinding -Message ("Step {0} scaffold-debt gate could not read the scan: {1}" -f $Step, $_.Exception.Message) -Remediation "Regenerate it by running .github/scripts/parity/scan-scaffold-debt.ps1 from the repo root, then re-run the step gate."
    }
  }

  if (($Step -eq 9 -or $Step -eq 12) -and ($VerificationMode -eq 'Output' -or $VerificationMode -eq 'Both')) {
    # Legacy-anchored backend functionality-parity gate. Every OTHER gate verifies "what EXISTS
    # in modern is wired"; none verified "everything in LEGACY was carried over". That let a
    # modernization port only the READ path (GET) and silently drop the entire WRITE path
    # (POST/PUT/DELETE - Add/Edit/Delete/Link/Export), while the UI still showed the buttons
    # (opening placeholder modals) so the UI parity + UI->API wiring gates both reported green.
    # This gate blocks closure when a legacy MUTATION endpoint has no modern counterpart and no
