$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
$AgentsDir = Join-Path $HOME ".agents"
New-Item -ItemType Directory -Force -Path $AgentsDir | Out-Null

$Agents = Join-Path $AgentsDir "AGENTS.md"
$Progress = Join-Path $AgentsDir "PROGRESS.md"

if (-not (Test-Path $Agents)) {
  Copy-Item (Join-Path $Root "templates/AGENTS.md") $Agents
  Write-Host "created $Agents"
} else { Write-Host "keep existing $Agents" }

if (-not (Test-Path $Progress) -and -not (Test-Path (Join-Path $AgentsDir "进度.md"))) {
  Copy-Item (Join-Path $Root "templates/PROGRESS.md") $Progress
  Write-Host "created $Progress"
} else { Write-Host "keep existing progress file" }

function Link-Or-Copy($Src, $Dest) {
  $dir = Split-Path -Parent $Dest
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  if (Test-Path $Dest) { Write-Host "skip existing $Dest"; return }
  try {
    New-Item -ItemType HardLink -Path $Dest -Target $Src | Out-Null
    Write-Host "linked $Dest"
  } catch {
    Copy-Item $Src $Dest
    Write-Host "copied $Dest"
  }
}

Link-Or-Copy $Agents (Join-Path $HOME ".claude/CLAUDE.md")
Link-Or-Copy $Agents (Join-Path $HOME ".codex/AGENTS.md")

Write-Host ""
Write-Host "Setup done. Edit AGENTS.md, then run a tiny task and check PROGRESS.md."
Write-Host "See docs/EXTENDING.md for VS Code / Xcode / Copilot / JetBrains."
