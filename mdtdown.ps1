<#

usage:
# install chocolatey first
set-executionpolicy bypass -force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

(new-object System.Net.WebClient).DownloadFile('http://installer-bin.streambox.com/wget.exe','wget.exe')
rm alias:\wget
./wget --timestamping --quiet --no-check-certificate https://raw.githubusercontent.com/TaylorMonacelli/mdt_deployment/tm/use_powershell_instead/mdtdown.ps1
. .\mdtdown.ps1

#>


$jobs = @()

# ##############################

$j = {
	param([string]$write_dir)

	@'
# Windows Embedded Standard 7 Service Pack 1 Evaluation Edition
# http://www.microsoft.com/en-us/download/details.aspx?id=11887
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard 7 SP1 64bit IBW.part1.exe
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard 7 SP1 64bit IBW.part2.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard 7 SP1 64bit IBW.part3.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard 7 SP1 64bit IBW.part4.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard 7 SP1 64bit IBW.part5.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard 7 SP1 64bit IBW.part6.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard 7 SP1 64bit IBW.part7.rar
'@ | Out-File -encoding ASCII "$write_dir/urls_ws7e_64bit.txt"

	if(!(test-path "$write_dir/Standard 7 SP1 64bit IBW.iso"))
	{
		&"$write_dir/wget.exe" --quiet --no-check-certificate --timestamping --limit-rate=2m `
		  --directory-prefix=$write_dir --input-file="$write_dir/urls_ws7e_64bit.txt"
		&rar x -y "$write_dir/Standard 7 SP1 64bit IBW.part1.exe" "$write_dir/"
	}
	&7z x -o"$write_dir/Standard 7 SP1 64bit IBW" "Standard 7 SP1 64bit IBW.iso"
}

$jobs += $j

# ##############################

# Windows Embedded Standard 7 Service Pack 1 Evaluation Edition
$j = {
	param([string]$write_dir)

	@'
# Windows Embedded Standard 7 Service Pack 1 Evaluation Edition
# http://www.microsoft.com/en-us/download/details.aspx?id=11887
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard 7 SP1 Toolkit.part01.exe
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard 7 SP1 Toolkit.part02.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard 7 SP1 Toolkit.part03.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard 7 SP1 Toolkit.part04.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard 7 SP1 Toolkit.part05.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard 7 SP1 Toolkit.part06.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard 7 SP1 Toolkit.part07.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_Toolkit/Standard 7 SP1 Toolkit.part08.rar
'@ | Out-File -encoding ASCII "$write_dir/urls_ws7e_toolkit.txt"

	if(!(test-path "$write_dir/Standard 7 SP1 Toolkit.iso"))
	{
		&"$write_dir/wget.exe" --quiet --no-check-certificate --timestamping --limit-rate=2m `
		  --directory-prefix=$write_dir --input-file="$write_dir/urls_ws7e_toolkit.txt"
		&rar x -y "$write_dir/Standard 7 SP1 Toolkit.part01.exe" "$write_dir/"
	}
	&7z x -o"$write_dir/Standard 7 SP1 Toolkit" "Standard 7 SP1 Toolkit.iso"
}

$jobs += $j

# ##############################

# Windows Assessment and Deployment Kit (Windows ADK) for Windows 10
# http://msdn.microsoft.com/en-us/library/windows/hardware/hh825494.aspx#InstallingNonNetworked
$j = {
	param([string]$write_dir)

	@'
# Windows Assessment and Deployment Kit (Windows ADK) for Windows 10
http://download.microsoft.com/download/9/A/E/9AE69DD5-BA93-44E0-864E-180F5E700AB4/adk/adksetup.exe
'@ | Out-File -encoding ASCII "$write_dir/urls_adk.txt"

	&"$write_dir/wget.exe" --quiet --no-check-certificate --timestamping --limit-rate=2m `
	  --directory-prefix=$write_dir --input-file="$write_dir/urls_adk.txt"
	&"$write_dir/adksetup.exe" /log "$write_dir/adksetup1.log" /quiet /features +
	# you can't use $lastExitCode here, its always 0...maybe due to /quiet
	$m=gc "$write_dir/adksetup1.log" | select-string -quiet -case 'ERROR:'
	if($m.Count){
		throw "adksetup.exe failed, see $write_dir/adksetup1.log"
	}
	&"$write_dir/adksetup.exe" /log "$write_dir/adksetup2.log" /ceip on /quiet /features +
	$m=gc "$write_dir/adksetup2.log" | select-string -quiet -case 'ERROR:'
	if($m.Count){
		throw "adksetup.exe failed, see $write_dir/adksetup2.log"
	}
}

$jobs += $j

# ##############################

# Microsoft deployment toolkit
$j = {
	param([string]$write_dir)

	@'
http://download.microsoft.com/download/B/F/5/BF5DF779-ED74-4BEC-A07E-9EB25694C6BB/Whats New in MDT 2013 Guide.docx
http://download.microsoft.com/download/B/F/5/BF5DF779-ED74-4BEC-A07E-9EB25694C6BB/MDT 2013 Documentation.zip
http://download.microsoft.com/download/B/F/5/BF5DF779-ED74-4BEC-A07E-9EB25694C6BB/MDT 2013 Release Notes.docx
https://download.microsoft.com/download/3/3/9/339BE62D-B4B8-4956-B58D-73C4685FC492/MicrosoftDeploymentToolkit_x64.msi
https://download.microsoft.com/download/3/3/9/339BE62D-B4B8-4956-B58D-73C4685FC492/MicrosoftDeploymentToolkit_x86.msi
'@ | Out-File -encoding ASCII "$write_dir/urls_mdt.txt"

	&"$write_dir/wget.exe" --quiet --no-check-certificate --timestamping --limit-rate=2m `
	  --directory-prefix=$write_dir --input-file="$write_dir/urls_mdt.txt"
	&7z x -y -o. "MDT 2013 Documentation.zip"
}

$jobs += $j

# ##############################


# customized wedu installer wedu_defaults_install_v1.2.exe
# FIXME: replace this nsis nonsense with powershell
$j = {
	param([string]$write_dir)

	@'
http://installer-bin.streambox.com/wedu_defaults_install_v1.2.exe
'@ | Out-File -encoding ASCII "$write_dir/urls_wedu.txt"

	&"$write_dir/wget.exe" --quiet --no-check-certificate --timestamping --limit-rate=2m `
	  --directory-prefix=$write_dir --input-file="$write_dir/urls_wedu.txt"
}

$jobs += $j

# ##############################

$j = {
	param([string]$write_dir)

	@'
http://taylors-bucket.s3.amazonaws.com/win7_pro_oem.iso
'@ | Out-File -encoding ASCII "$write_dir/urls_win7pro.txt"

	&"$write_dir/wget.exe" --quiet --no-check-certificate --timestamping --limit-rate=20m `
	  --directory-prefix=$write_dir --input-file="$write_dir/urls_win7pro.txt"
}

$jobs += $j

# ##############################

$j = {
	param([string]$write_dir)

	@'
http://taylors-bucket.s3.amazonaws.com/WS7P_2013-12-09-1641.wim
http://taylors-bucket.s3.amazonaws.com/WS7P_2014-01-01-1045.wim
http://taylors-bucket.s3.amazonaws.com/mdt.7z
'@ | Out-File -encoding ASCII "$write_dir/urls_mdt_taylor_made.txt"

	&"$write_dir/wget.exe" --quiet --no-check-certificate --timestamping --limit-rate=20m `
	  --directory-prefix=$write_dir --input-file="$write_dir/urls_mdt_taylor_made.txt"
}

$jobs += $j

# ##############################

# Windows Embedded Standard 7 Service Pack 1 Evaluation Edition
$j = {
	param([string]$write_dir)

	@'
# Windows Embedded Standard 7 Service Pack 1 Evaluation Edition
# http://www.microsoft.com/en-us/download/details.aspx?id=11887
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_32bit/Standard 7 SP1 32bit IBW.part1.exe
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_32bit/Standard 7 SP1 32bit IBW.part2.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_32bit/Standard 7 SP1 32bit IBW.part3.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_32bit/Standard 7 SP1 32bit IBW.part4.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_32bit/Standard 7 SP1 32bit IBW.part5.rar
'@ | Out-File -encoding ASCII "$write_dir/urls_ws7e.txt"

	if(!(test-path "$write_dir/Standard 7 SP1 32bit IBW.iso"))
	{
		&"$write_dir/wget.exe" --quiet --no-check-certificate --timestamping --limit-rate=2m `
		  --directory-prefix=$write_dir --input-file="$write_dir/urls_ws7e.txt"
		&rar x -y "$write_dir/Standard 7 SP1 32bit IBW.part1.exe" "$write_dir/"
	}
	&7z x -o"$write_dir/Standard 7 SP1 32bit IBW" "Standard 7 SP1 32bit IBW.iso"
}

$jobs += $j

# ##############################
# main
# ##############################

cinst --yes winrar 7zip.install
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1" -Force
$path = gci -ea 0 "${env:SYSTEMDRIVE}/Prog*/winrar/rar.exe" | select -exp fullname
Install-BinFile -Path $path -Name rar

cinst --yes winrar 7zip.install
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1" -Force
$path = gci -ea 0 "${env:SYSTEMDRIVE}/Prog*/7-zip/7z.exe" | select -exp fullname
Install-BinFile -Path $path -Name 7z

if(!(test-path wget.exe)){
	Invoke-WebRequest -Uri 'http://installer-bin.streambox.com/wget.exe' -OutFile 'wget.exe'
}

$script_dir_base = Split-Path -Parent $MyInvocation.MyCommand.Path
foreach($job in $jobs)
{
	Start-Job $job -Arg $script_dir_base
}