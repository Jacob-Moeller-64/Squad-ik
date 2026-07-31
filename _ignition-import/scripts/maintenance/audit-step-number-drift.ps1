<#
.SYNOPSIS
    Detects step-number drift left over from the 26-step -> 24-step renumbering across the
    reusable toolkit (prompts, agents, instructions, scripts), and validates that every
    prompt slash-command / referenced prompt file actually resolves on disk.

.DESCRIPTION
    The kit was originally a 26-step flow and was later compressed to 24 steps. The H1 headers
    and file names were corrected, but many in-body self-references, cross-references, agent
    button labels, script output strings, and instruction notes still carry the OLD numbers.
    Hand-sweeping that drift is error-prone (long files hide stragglers), so this script does
    the enumeration deterministically and flags the violations it can prove.

    It runs THREE deterministic checks plus one completeness enumeration:

      Check A - Self-reference consistency (numbered prompt files only)
        A numbered prompt `NN-...prompt.md` must refer to ITSELF as Step NN. The H1
        `# Step M ...` and the frontmatter `description:` "Step M" must have M == NN.

      Check B - Reference resolution (all scanned files)
        Every prompt slash-command (`/NN-slug`) and every "run `NN-slug`" prompt reference
        must resolve to a real file under .github/prompts/. This deterministically catches
        broken or dangling invocations (the highest-severity drift, because a developer who
        clicks one gets nothing).

      Check C - Title-anchored step number (all scanned files)
        When text says `Step N <Title>` and <Title> matches a canonical step's readableName,
        the cited N must equal that step's number. This is the workhorse that catches drift in
        agent labels, script output, and instruction notes - anywhere a title travels with a
        number - without needing to understand the surrounding prose.

      Enumeration - Every `Step \d+` reference (review backstop)
        Lists each reference with a classification tag so a maintainer can review the residue
        that carries no title (bare "Step 14 or later") which no automated rule can safely judge.

    Canonical step titles are read at runtime from AppMod-Artifact-Contract.json, so this script
    stays data-driven and never hard-codes the step list.

.PARAMETER RepoRoot
    Optional repository root. Defaults to the repo root derived from this script's location.

.PARAMETER AsJson
    Emit a machine-readable JSON summary instead of human-readable text.

.PARAMETER IncludeEnumeration
    Include the full per-reference enumeration in the output. Off by default to keep the
    routine gate output focused on violations.

.OUTPUTS
    Exit code 0 when no deterministic violations (A/B/C) are found.
    Exit code 2 when at least one deterministic violation is found.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/maintenance/audit-step-number-drift.ps1

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File .github/scripts/maintenance/audit-step-number-drift.ps1 -IncludeEnumeration -AsJson
#>
[CmdletBinding()]
param(
  [string]$RepoRoot,
  [switch]$AsJson,
  [switch]$IncludeEnumeration
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Resolve-AuditRepoRoot {
  param([string]$Override)
  if (-not [string]::IsNullOrWhiteSpace($Override)) {
    return (Resolve-Path -LiteralPath $Override).Path
  }
  # This script lives at .github/scripts/maintenance/ ; repo root is three levels up.
  $candidate = Join-Path $PSScriptRoot '..' | Join-Path -ChildPath '..' | Join-Path -ChildPath '..'
  return (Resolve-Path -LiteralPath $candidate).Path
}

function Get-NormalizedTitle {
  # Lowercase, drop every non-alphanumeric character. "Frontend Foundation & Scaffold" and
  # "FrontEnd Foundation & Scaffold" both normalize to "frontendfoundationscaffold".
  param([string]$Text)
  if ([string]::IsNullOrWhiteSpace($Text)) { return '' }
  return (($Text -replace '[^A-Za-z0-9]', '')).ToLowerInvariant()
}

function Get-FollowingTitleKey {
  # Build a normalized key from the text that FOLLOWS a "Step N" match, so a canonical title
  # can be prefix-matched against it. Leading 'dev'/'qa' marker words are dropped first so
  # "DEV (Frontend Platform Integration)" still resolves to the title.
  param([string]$Following)
  $tokens = @($Following -split '[^A-Za-z0-9]+' | Where-Object { $_ -ne '' })
  while ($tokens.Count -gt 0 -and ($tokens[0] -ieq 'dev' -or $tokens[0] -ieq 'qa')) {
    if ($tokens.Count -eq 1) { $tokens = @() } else { $tokens = $tokens[1..($tokens.Count - 1)] }
  }
  return (($tokens -join '')).ToLowerInvariant()
}

$root = Resolve-AuditRepoRoot -Override $RepoRoot

# --- Load canonical step titles (data-driven, from the artifact contract) -----------------
$contractPath = Join-Path $root '.github/instructions/AppMod-Artifact-Contract.json'
if (-not (Test-Path -LiteralPath $contractPath)) {
  Write-Error "Artifact contract not found at $contractPath"
  exit 2
}
$contract = Get-Content -LiteralPath $contractPath -Raw | ConvertFrom-Json

# normalizedTitle -> step number. Sorted longest-first so prefix matching prefers the most
# specific title (prevents a short title from shadowing a longer one).
$titleToStep = @()
foreach ($s in $contract.steps) {
  $norm = Get-NormalizedTitle -Text ([string]$s.readableName)
  if ($norm.Length -ge 6) {
    $titleToStep += [pscustomobject]@{ Norm = $norm; Step = [int]$s.step; Title = [string]$s.readableName }
  }
}
$titleToStep = @($titleToStep | Sort-Object { $_.Norm.Length } -Descending)

# --- Enumerate target files ---------------------------------------------------------------
# Canonical sources of truth are excluded from violation flagging (their numbers ARE the map).
$excludeNames = @('AppMod-Artifact-Contract.json', 'AppMod-Step-Contract.json')
$targets = New-Object System.Collections.Generic.List[string]
$globs = @(
  '.github/prompts',
  '.github/agents',
  '.github/instructions',
  '.github/scripts'
)
$extensions = @('.prompt.md', '.agent.md', '.instructions.md', '.md', '.ps1')
foreach ($g in $globs) {
  $base = Join-Path $root $g
  if (-not (Test-Path -LiteralPath $base)) { continue }
  Get-ChildItem -LiteralPath $base -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
    $name = $_.Name
    if ($excludeNames -contains $name) { return }
    $match = $false
    foreach ($ext in $extensions) { if ($name.EndsWith($ext)) { $match = $true; break } }
    if ($match) { $targets.Add($_.FullName) | Out-Null }
  }
}

# A set of real prompt slash-command names (file stem without .prompt.md) for Check B.
$promptStems = @{}
$promptDir = Join-Path $root '.github/prompts'
if (Test-Path -LiteralPath $promptDir) {
  Get-ChildItem -LiteralPath $promptDir -Recurse -File -Filter '*.prompt.md' -ErrorAction SilentlyContinue | ForEach-Object {
    $stem = $_.Name -replace '\.prompt\.md$', ''
    $promptStems[$stem.ToLowerInvariant()] = $true
  }
}

$violations = New-Object System.Collections.Generic.List[object]
$enumeration = New-Object System.Collections.Generic.List[object]

function Add-Drift {
  param([string]$Check, [string]$File, [int]$Line, [string]$Message)
  $violations.Add([pscustomobject]@{
      Check   = $Check
      File    = $File
      Line    = $Line
      Message = $Message
    }) | Out-Null
}

foreach ($file in $targets) {
  $rel = $file.Substring($root.Length).TrimStart('\', '/') -replace '\\', '/'
  $isNumberedPrompt = $rel -match '/prompts/(\d{2})-[^/]*\.prompt\.md$'
  $selfNum = if ($isNumberedPrompt) { [int]$Matches[1] } else { 0 }

  $lines = Get-Content -LiteralPath $file -ErrorAction SilentlyContinue
  if ($null -eq $lines) { continue }

  for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = [string]$lines[$i]
    $lineNo = $i + 1

    # --- Check A: self-reference consistency (numbered prompts only) ---
    if ($isNumberedPrompt) {
      if ($line -match '^\s*#\s+Step\s+(\d+)\b') {
        if ([int]$Matches[1] -ne $selfNum) {
          Add-Drift -Check 'A-self-H1' -File $rel -Line $lineNo -Message ("H1 says Step {0} but file is step {1}." -f $Matches[1], $selfNum)
        }
      }
      if ($line -match '^\s*description:\s*"?Step\s+(\d+)\b') {
        if ([int]$Matches[1] -ne $selfNum) {
          Add-Drift -Check 'A-self-desc' -File $rel -Line $lineNo -Message ("description says Step {0} but file is step {1}." -f $Matches[1], $selfNum)
        }
      }
    }

    # --- Check B: prompt slash-command / reference resolution ---
    # Matches /NN-slug and backticked `NN-slug` that look like prompt invocations.
    foreach ($m in [regex]::Matches($line, '[/`](\d{2}[A-Za-z0-9][A-Za-z0-9-]*)')) {
      $token = $m.Groups[1].Value.ToLowerInvariant()
      # Only treat as a prompt reference when it has a slug body (a dash), not a bare number.
      if ($token -notmatch '-') { continue }
      if (-not $promptStems.ContainsKey($token)) {
        Add-Drift -Check 'B-broken-ref' -File $rel -Line $lineNo -Message ("References prompt '{0}' but no .github/prompts/{0}.prompt.md exists." -f $token)
      }
    }

    # --- Check C + enumeration: every "Step N" reference ---
    foreach ($m in [regex]::Matches($line, 'Step\s+(\d+)')) {
      $citedNum = [int]$m.Groups[1].Value
      $tailStart = $m.Index + $m.Length
      $tail = if ($tailStart -lt $line.Length) { $line.Substring($tailStart) } else { '' }
      $key = Get-FollowingTitleKey -Following $tail

      $matchedStep = 0
      $matchedTitle = ''
      if ($key.Length -ge 6) {
        foreach ($entry in $titleToStep) {
          if ($key.StartsWith($entry.Norm)) { $matchedStep = $entry.Step; $matchedTitle = $entry.Title; break }
        }
      }

      $tag = 'review'
      if ($matchedStep -gt 0) {
        if ($matchedStep -eq $citedNum) {
          $tag = 'ok-title'
        }
        else {
          $tag = 'mismatch-title'
          Add-Drift -Check 'C-title' -File $rel -Line $lineNo -Message ("Step {0} '{1}' should be Step {2}." -f $citedNum, $matchedTitle, $matchedStep)
        }
      }
      elseif ($isNumberedPrompt -and $citedNum -eq $selfNum) {
        $tag = 'ok-self'
      }

      if ($IncludeEnumeration) {
        $enumeration.Add([pscustomobject]@{
            File  = $rel
            Line  = $lineNo
            Cited = $citedNum
            Tag   = $tag
            Title = $matchedTitle
          }) | Out-Null
      }
    }
  }
}

$hasViolations = ($violations.Count -gt 0)

if ($AsJson) {
  [pscustomobject]@{
    repoRoot       = $root
    filesScanned   = $targets.Count
    violationCount = $violations.Count
    violations     = $violations
    enumeration    = if ($IncludeEnumeration) { $enumeration } else { @() }
    blocked        = $hasViolations
  } | ConvertTo-Json -Depth 6
  exit $(if ($hasViolations) { 2 } else { 0 })
}

Write-Host ""
Write-Host ("Step-number drift audit  (scanned {0} files)" -f $targets.Count) -ForegroundColor Cyan

if ($violations.Count -eq 0) {
  Write-Host "  No deterministic drift violations found (Checks A, B, C clean)." -ForegroundColor Green
}
else {
  foreach ($grp in ($violations | Group-Object Check | Sort-Object Name)) {
    Write-Host ""
    Write-Host ("  [{0}]  {1} issue(s)" -f $grp.Name, $grp.Count) -ForegroundColor Yellow
    foreach ($v in $grp.Group) {
      Write-Host ("    {0}:{1}  {2}" -f $v.File, $v.Line, $v.Message) -ForegroundColor Red
    }
  }
}

if ($IncludeEnumeration) {
  $review = @($enumeration | Where-Object { $_.Tag -eq 'review' })
  Write-Host ""
  Write-Host ("  Enumeration: {0} total 'Step N' references; {1} carry no title and need human review." -f $enumeration.Count, $review.Count) -ForegroundColor Gray
  foreach ($r in $review) {
    Write-Host ("    review  {0}:{1}   Step {2}" -f $r.File, $r.Line, $r.Cited) -ForegroundColor DarkGray
  }
}

Write-Host ""
if ($hasViolations) {
  Write-Host ("RESULT: DRIFT FOUND - {0} deterministic violation(s). Fix from the list above." -f $violations.Count) -ForegroundColor Red
  exit 2
}
Write-Host "RESULT: OK - no deterministic step-number drift." -ForegroundColor Green
exit 0
