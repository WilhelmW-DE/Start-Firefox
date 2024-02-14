<#
    .Description
    Startet Firefox mit Profilauswahl
#>
function Start-Firefox {
   Param(
        [string]
        $profile
    )
    $FilePath = 'C:\Program Files\Mozilla Firefox\Firefox.exe'
    $args = @('')
    if($profile) {
        Start-Process -FilePath $FilePath -ArgumentList @('-P', $profile)
    } else {
        Start-Process -FilePath $FilePath
    }
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