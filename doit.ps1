if(!(test-path wget.exe)){
	(new-object System.Net.WebClient).DownloadFile('http://installer-bin.streambox.com/wget.exe','wget.exe')
}

./wget --quiet --no-check-certificate --limit-rate=2m --directory-prefix=. --timestamping http://installer-bin.streambox.com/7za.exe

$jobs = @()

$j = {
	param($write_dir)

	@'
# Windows Embedded Standard 7 Service Pack 1 Evaluation Edition
# http://www.microsoft.com/en-us/download/details.aspx?id=11887
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard%207%20SP1%2064bit%20IBW.part1.exe
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard%207%20SP1%2064bit%20IBW.part2.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard%207%20SP1%2064bit%20IBW.part3.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard%207%20SP1%2064bit%20IBW.part4.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard%207%20SP1%2064bit%20IBW.part5.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard%207%20SP1%2064bit%20IBW.part6.rar
http://download.microsoft.com/download/1/B/5/1B5FDE63-DA91-4A22-A320-91E002DE1326/Standard_7SP1_64bit/Standard%207%20SP1%2064bit%20IBW.part7.rar
'@ | Out-File -encoding ASCII "$write_dir/urls_ws7e_64bit.txt"

	$exe="$write_dir/wget.exe"
	&$exe --quiet --timestamping --no-check-certificate --limit-rate=2m `
	  --directory-prefix=$write_dir --input-file=$write_dir/urls_ws7e_64bit.txt
	$exe="$write_dir/Standard 7 SP1 64bit IBW.part1.exe"
	&$exe -s -d .
	$exe="$write_dir/7za.exe"
	&$exe x -o"Standard 7 SP1 64bit IBW" "Standard 7 SP1 64bit IBW.iso"
}

$jobs += $j

$script_dir_base = Split-Path -Parent $MyInvocation.MyCommand.Path
foreach($job in $jobs)
{
	Start-Job $job -Arg $script_dir_base
}
