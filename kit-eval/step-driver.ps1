<#
.SYNOPSIS
    Ignition Kit step driver for GitHub Copilot CLI - fresh session per step,
    gate-enforced, two-strikes model escalation.

.DESCRIPTION
    TEMPLATE - verify flag names against `copilot --help` on the target machine
    before first use (CLI ships changes constantly; default model and flags move).

    Per step: invoke `copilot -p` non-interactively (each invocation = fresh
    session; the agent's internal tool loop + prompt caching happen inside the
    invocation), then run the kit's Output gate. Exit 0 -> next step. Exit 2 ->
    retry once with the gate's BLOCKED output appended (strike 1); still blocked
    -> escalate one model tier and retry (strike 2); still blocked -> stop and
    surface for a human. Never softens or overrules a gate result.

.EXAMPLE
    ./step-driver.ps1 -FromStep 3 -ToStep 6
#>
param(
    [int]$FromStep = 1,
    [int]$ToStep   = 24,
    [string]$PromptDir = ".github/prompts",
    [string]$GateScript = ".github/scripts/shared/verify-step-artifacts.ps1"
)

$ErrorActionPreference = 'Stop'

# Tier map: cheapest that is certified for the step (see PROMPT-OPT-PLAYBOOK.md §4).
# Escalation ladder used on strike 2: cheap -> mid -> top.
$TierLadder = @('<CHEAP_MODEL>', '<MID_MODEL>', '<TOP_MODEL>')   # e.g. haiku-class, sonnet-class, opus-class ids from `copilot /models`
$StepTier = @{}
1..24 | ForEach-Object { $StepTier[$_] = 1 }                      # default: mid
@(1, 2, 18) | ForEach-Object { $StepTier[$_] = 0 }                # certified-cheap candidates
@(3, 5, 24) | ForEach-Object { $StepTier[$_] = 2 }                # judgment steps: top tier

function Invoke-Step {
    param([int]$Step, [string]$Model, [string]$ExtraContext)

    $promptFile = Get-ChildItem $PromptDir -Filter ("{0:d2}-*.prompt.md" -f $Step) | Select-Object -First 1
    if (-not $promptFile) { throw "No prompt file for step $Step in $PromptDir" }

    $prompt = Get-Content $promptFile.FullName -Raw
    if ($ExtraContext) {
        $prompt += "`n`n--- PRIOR ATTEMPT BLOCKED ---`n$ExtraContext`nResolve the BLOCKED condition above, then complete the step."
    }

    Write-Host ("=== Step {0} on {1} ===" -f $Step, $Model) -ForegroundColor Cyan
    # Fresh session per invocation. Verify exact flags with `copilot --help`.
    copilot -p $prompt --model $Model --allow-all-tools
}

function Test-Gate {
    param([int]$Step)
    $out = & pwsh -NoProfile -File $GateScript -Step $Step -Mode Output 2>&1 | Out-String
    Write-Host $out
    return @{ Passed = ($LASTEXITCODE -eq 0); Output = $out }
}

for ($step = $FromStep; $step -le $ToStep; $step++) {
    $tier = $StepTier[$step]
    Invoke-Step -Step $step -Model $TierLadder[$tier]
    $gate = Test-Gate -Step $step
    if (-not $gate.Passed) {
        Write-Host "Step $step BLOCKED - strike 1, retrying with gate output." -ForegroundColor Yellow
        Invoke-Step -Step $step -Model $TierLadder[$tier] -ExtraContext $gate.Output
        $gate = Test-Gate -Step $step
    }
    if (-not $gate.Passed -and $tier -lt ($TierLadder.Count - 1)) {
        Write-Host "Step $step BLOCKED - strike 2, escalating tier." -ForegroundColor Yellow
        Invoke-Step -Step $step -Model $TierLadder[$tier + 1] -ExtraContext $gate.Output
        $gate = Test-Gate -Step $step
    }
    if (-not $gate.Passed) {
        Write-Host "Step $step still BLOCKED after escalation - stopping for human review." -ForegroundColor Red
        exit 2
    }
    Write-Host "Step $step complete (gate OK)." -ForegroundColor Green
}
Write-Host "All requested steps complete." -ForegroundColor Green
