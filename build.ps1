# ============================================================
# build.ps1 — Single source of truth for all AI tool configs
# Run this after editing anything in agents/ or tools/
# Usage: .\build.ps1
# Override project root: .\build.ps1 -ProjectRoot "C:\path\to\your\project"
# ============================================================

param(
    [string]$ProjectRoot = ".."
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$AgentsDir = Join-Path $ScriptDir "agents"

$ClaudeCommandsDest = Join-Path $ProjectRoot ".claude\commands"
$WindsurfDest       = Join-Path $ProjectRoot ".windsurf\rules"
$CopilotAgentsDest  = Join-Path $ProjectRoot ".github\agents"

Write-Host "Building AI tool configs from source..." -ForegroundColor Cyan
Write-Host "   Project root: $ProjectRoot"
Write-Host ""

# ---- 1. Claude Code → .claude\commands\<agent>.md ----
New-Item -ItemType Directory -Force -Path $ClaudeCommandsDest | Out-Null
foreach ($agent in Get-ChildItem "$AgentsDir\*.md") {
    Copy-Item $agent.FullName (Join-Path $ClaudeCommandsDest $agent.Name) -Force
}
Write-Host "✅ Claude Code   → $ClaudeCommandsDest\" -ForegroundColor Green

# ---- 2. Windsurf Cascade → .windsurf\rules\<agent>.md ----
New-Item -ItemType Directory -Force -Path $WindsurfDest | Out-Null
foreach ($agent in Get-ChildItem "$AgentsDir\*.md") {
    Copy-Item $agent.FullName (Join-Path $WindsurfDest $agent.Name) -Force
}
Write-Host "✅ Windsurf       → $WindsurfDest\" -ForegroundColor Green

# ---- 3. GitHub Copilot → .github\agents\<agent>.agent.md ----
New-Item -ItemType Directory -Force -Path $CopilotAgentsDest | Out-Null
foreach ($agent in Get-ChildItem "$AgentsDir\*.md") {
    $agentName = $agent.BaseName + ".agent.md"
    Copy-Item $agent.FullName (Join-Path $CopilotAgentsDest $agentName) -Force
}
Write-Host "✅ GitHub Copilot → $CopilotAgentsDest\" -ForegroundColor Green

Write-Host ""
Write-Host "Done. All configs updated." -ForegroundColor Cyan
Write-Host "   Edit agents\*.md, then re-run this script."
Write-Host ""
Write-Host "Did you calibrate a prompt? Log it:" -ForegroundColor Yellow
Write-Host "  notepad $ScriptDir\CHANGELOG.md"
Write-Host ""
Write-Host "Tip: create a shortcut for your project so you don't have to type the path each time:" -ForegroundColor Yellow
Write-Host "  Add this to your PowerShell profile (notepad `$PROFILE):"
Write-Host "  function build-ai { C:\Users\$env:USERNAME\ai-config\build.ps1 -ProjectRoot `"C:\path\to\your\project`" }"
Write-Host "  Then just type: build-ai"
