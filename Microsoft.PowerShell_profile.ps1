oh-my-posh init pwsh --config $Home\AppData\Local\Programs\oh-my-posh\themes\material.omp.json | Invoke-Expression
Import-Module posh-git

chcp 65001

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
# Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
# Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Write-Output -InputObject "Hello, $env:USERNAME at $(pwd.exe)."

function lvlme {
    if ($(whoami /groups) -match "S-1-16-8192") {
        Write-Output "Medium Mandatory Level"
    } elseif ($(whoami /groups) -match "S-1-16-12288") {
        Write-Output "High Mandatory Level"
    }
}

## End PROFILE ##

# Functions

function dhome {
    Set-Location D:/$Env:USERNAME;
}

# Aliases

function __ll_function_alias {
    ls.exe -al
}

New-Alias -Name ll -Value __ll_function_alias;
