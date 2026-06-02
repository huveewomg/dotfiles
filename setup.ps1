# dotfiles setup script for Windows
# Run: powershell -ExecutionPolicy Bypass -File setup.ps1

Write-Host "=== RT's Dotfiles Setup ===" -ForegroundColor Cyan

# --- Install scoop if missing ---
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Installing scoop..." -ForegroundColor Yellow
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

$scoop = "$env:USERPROFILE\scoop\shims\scoop.cmd"

# --- Add extras bucket ---
& $scoop bucket add extras 2>$null

# --- CLI tools ---
$tools = @(
    "zoxide",      # smart cd
    "fzf",         # fuzzy finder
    "bat",         # better cat
    "delta",       # better git diff
    "eza",         # better ls
    "fd",          # better find
    "starship",    # cross-shell prompt
    "lazygit",     # git TUI
    "lazydocker",  # docker TUI
    "dive"         # docker image explorer
)

Write-Host "`nInstalling CLI tools..." -ForegroundColor Yellow
& $scoop install @tools

# --- pip tools ---
Write-Host "`nInstalling pip tools..." -ForegroundColor Yellow
pip install gita --quiet

# --- gh extensions ---
Write-Host "`nInstalling gh extensions..." -ForegroundColor Yellow
gh extension install dlvhdr/gh-dash 2>$null

# --- Symlink configs ---
Write-Host "`nLinking config files..." -ForegroundColor Yellow
$dotfiles = Split-Path -Parent $MyInvocation.MyCommand.Path

# PowerShell profile
$psProfileDir = Split-Path $PROFILE
if (-not (Test-Path $psProfileDir)) {
    New-Item -ItemType Directory -Path $psProfileDir -Force | Out-Null
}
Copy-Item "$dotfiles\powershell\Microsoft.PowerShell_profile.ps1" $PROFILE -Force
Write-Host "  PowerShell profile -> $PROFILE"

# .gitconfig (delta config only — user section left to git config)
$gitconfigExtra = "$dotfiles\git\.gitconfig-tools"
git config --global include.path $gitconfigExtra
Write-Host "  .gitconfig-tools included via git include.path"

# Oh My Posh theme
Copy-Item "$dotfiles\ohmyposh\mytheme.omp.json" "$env:USERPROFILE\mytheme.omp.json" -Force
Write-Host "  Oh My Posh theme -> ~/mytheme.omp.json"

# Install oh-my-posh if missing
if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Write-Host "`nInstalling Oh My Posh..." -ForegroundColor Yellow
    winget install JanDeDobbeleer.OhMyPosh --accept-source-agreements --accept-package-agreements
}

# .bashrc additions are appended manually — sourced from dotfiles
Write-Host "`n  Bash: add this to your .bashrc:"
Write-Host '  source "$HOME/Desktop/Personal Project/dotfiles/bash/.bashrc-tools"' -ForegroundColor Green

Write-Host "`n=== Done! Open a new terminal to activate. ===" -ForegroundColor Cyan
