<#

usage:
# install chocolatey first
set-executionpolicy bypass -force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

$url='https://raw.githubusercontent.com/TaylorMonacelli/mdt_deployment/tm/use_powershell_instead/mdtdown.ps1'
$output='mdtdown.ps1'
(New-Object System.Net.WebClient).DownloadFile($url, $output)
. .\mdtdown.ps1

#>

$write_dir = Split-Path -Parent $MyInvocation.MyCommand.Path
&7z x -y -o"$write_dir\Standard 7 SP1 64bit IBW" "Standard 7 SP1 64bit IBW.iso"
