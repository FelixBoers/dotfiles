if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

Add-Type @"
using System;
using System.Runtime.InteropServices;

namespace mklink
{
    public class hardlink
    {
        [DllImport("Kernel32.dll")]
        public static extern bool CreateHardLink(string lpFileName,string lpExistingFileName,IntPtr lpSecurityAttributes);
    }
}
"@

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
            if (Test-Path $path) {
                Remove-Item $path -Force
            }

            Write-Host "Create file $path ... " -NoNewLine
            $result = [mklink.hardlink]::CreateHardLink(
                $path,
                $file.FullName,
                [IntPtr]::Zero
            )
            Write-Host $result
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