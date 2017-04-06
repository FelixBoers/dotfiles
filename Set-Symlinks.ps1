if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

$machineDir = "$PSScriptRoot\$env:COMPUTERNAME"
$domainDir = "$PSScriptRoot\$env:USERDOMAIN"
$commonDir = "$PSScriptRoot\Common"

$dirs = $machineDir,$domainDir,$commonDir

function Set-Symlink {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')]
    param(
        [Parameter(Position=0,ValueFromPipeLine,Mandatory)]
        [System.IO.FileInfo[]]$dotfiles
    )
    process {
        foreach ($file in $dotfiles) {
            $path = Join-Path $env:USERPROFILE $file.Name
            New-Item -Path $path -ItemType SymbolicLink -Value $file.FullName -Force
        }
    }
}

$added = new-object System.Collections.ArrayList
foreach ($dir in $dirs) {
    if (Test-Path $dir) {
        $dotfiles = gci $dir -Recurse -File | ?{ $added -notcontains $_.Name }
        foreach ($file in $dotfiles) {
            Set-Symlink $file
            $added.Add($file.Name) > $null
        }
    }
}

$added.Clear()

Sleep 5