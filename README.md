# dotfiles

Personal dev environment config. Run `setup.ps1` on a fresh Windows machine to install everything.

## What's included

### CLI tools (via scoop)
- `zoxide` — smart cd that learns your directories
- `fzf` — fuzzy finder (Ctrl-R history search)
- `bat` — cat with syntax highlighting
- `delta` — beautiful git diffs (side-by-side)
- `eza` — ls with git status + icons
- `fd` — fast find replacement
- `starship` — cross-shell prompt
- `lazygit` — git TUI
- `lazydocker` — docker TUI
- `dive` — docker image layer explorer

### pip tools
- `gita` — multi-repo git commands

### gh extensions
- `gh-dash` — PR/issue dashboard across repos

### Shell theme
- `oh-my-posh` — custom prompt (teal + pink) for bash
- `starship` — cross-shell prompt for PowerShell

## Config files

| File | Target | Notes |
|------|--------|-------|
| `powershell/Microsoft.PowerShell_profile.ps1` | `$PROFILE` | zoxide + starship + fzf |
| `bash/.bashrc-tools` | source from `.bashrc` | zoxide + fzf + scoop PATH |
| `git/.gitconfig-tools` | included via `git config --global include.path` | delta pager config |
| `ohmyposh/mytheme.omp.json` | `~/mytheme.omp.json` | custom oh-my-posh prompt theme |

## Setup

```powershell
powershell -ExecutionPolicy Bypass -File setup.ps1
```

For bash, add this to your `.bashrc`:
```bash
source "$HOME/Desktop/Personal Project/dotfiles/bash/.bashrc-tools"
```
