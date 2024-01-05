Invoke-Expression (&starship init powershell)
$Env:KOMOREBI_CONFIG_HOME = 'C:\Users\William\.config\komorebi'

Set-PSReadLineOption -EditMode Emacs

Set-PSReadlineKeyHandler -Key Alt+n -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Alt+p -Function HistorySearchBackward

# keep or reset to powershell default
# Set-PSReadlineKeyHandler -Key Shift+Tab -Function TabCompletePrevious

# define Ctrl+Tab like default Tab behavior
# Set-PSReadlineKeyHandler -Key Ctrl+Tab -Function TabCompleteNext

# define Tab like bash
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete