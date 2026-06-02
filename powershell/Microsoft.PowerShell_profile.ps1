# --- Tool integrations ---

# Zoxide (smart cd)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Starship prompt
Invoke-Expression (&starship init powershell)

# fzf keybindings (Ctrl-R for history search)
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
