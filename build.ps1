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
$ToolsDir  = Join-Path $ScriptDir "tools"

$ClaudeDest   = Join-Path $ProjectRoot ".claude\CLAUDE.md"
$WindsurfDest = Join-Path $ProjectRoot ".windsurf\rules"
$CopilotDest  = Join-Path $ProjectRoot ".github\copilot-instructions.md"

Write-Host "Building AI tool configs from source..." -ForegroundColor Cyan
Write-Host "   Project root: $ProjectRoot"
Write-Host ""

# ---- 1. Claude Code → .claude\CLAUDE.md ----
New-Item -ItemType Directory -Force -Path (Split-Path $ClaudeDest) | Out-Null
Get-Content (Join-Path $ToolsDir "claude\wrapper.md") | Set-Content $ClaudeDest
foreach ($agent in Get-ChildItem "$AgentsDir\*.md") {
    Add-Content $ClaudeDest ""
    Add-Content $ClaudeDest "---"
    Add-Content $ClaudeDest ""
    Get-Content $agent.FullName | Add-Content $ClaudeDest
}
Write-Host "✅ Claude Code   → $ClaudeDest" -ForegroundColor Green

# ---- 2. Windsurf Cascade → .windsurf\rules\*.md ----
New-Item -ItemType Directory -Force -Path $WindsurfDest | Out-Null
Copy-Item (Join-Path $ToolsDir "windsurf\wrapper.md") (Join-Path $WindsurfDest "00-base.md") -Force
foreach ($agent in Get-ChildItem "$AgentsDir\*.md") {
    Copy-Item $agent.FullName (Join-Path $WindsurfDest $agent.Name) -Force
}
Write-Host "✅ Windsurf       → $WindsurfDest\" -ForegroundColor Green

# ---- 3. GitHub Copilot → .github\copilot-instructions.md ----
New-Item -ItemType Directory -Force -Path (Split-Path $CopilotDest) | Out-Null
Get-Content (Join-Path $ToolsDir "copilot\wrapper.md") | Set-Content $CopilotDest
foreach ($agent in Get-ChildItem "$AgentsDir\*.md") {
    Add-Content $CopilotDest ""
    Add-Content $CopilotDest "---"
    Add-Content $CopilotDest ""
    Get-Content $agent.FullName | Add-Content $CopilotDest
}
Write-Host "✅ GitHub Copilot → $CopilotDest" -ForegroundColor Green

Write-Host ""
Write-Host "Done. All configs updated." -ForegroundColor Cyan
Write-Host "   Edit agents\*.md or tools\*\wrapper.md, then re-run this script."
Write-Host ""
Write-Host "Did you calibrate a prompt? Log it:" -ForegroundColor Yellow
Write-Host "  notepad $ScriptDir\CHANGELOG.md"
Write-Host ""
Write-Host "Tip: create a shortcut for your project so you don't have to type the path each time:" -ForegroundColor Yellow
Write-Host "  Add this to your PowerShell profile (notepad `$PROFILE):"
Write-Host "  function build-ai { C:\Users\$env:USERNAME\ai-config\build.ps1 -ProjectRoot `"C:\path\to\your\project`" }"
Write-Host "  Then just type: build-ai"
