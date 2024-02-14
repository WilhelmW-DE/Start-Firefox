<#
    .Description
    Startet Firefox mit Profilauswahl
#>
function Start-Firefox {
   Param(
        [string]
        $profile
    )
    Start-Process -FilePath 'C:\Program Files\Mozilla Firefox\Firefox.exe' -ArgumentList @('-P', $profile)
}

Register-ArgumentCompleter -CommandName Start-Firefox -ParameterName profile -ScriptBlock {
    param ($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParams)

    $profiles = @()
    Get-Content ~\AppData\Roaming\Mozilla\Firefox\profiles.ini | ForEach-Object {
        if($_.startsWith($('Name=' + $wordToComplete), 'CurrentCultureIgnoreCase')){
            $profiles += ($_ -replace 'Name=', '')
        }
    }
    $profiles = $profiles | Sort-Object

    return $profiles
}

New-Alias -Name ff -Value Start-Firefox