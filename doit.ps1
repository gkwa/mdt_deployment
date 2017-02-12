$jobs = @()

$j = {
	param([string]$write_dir)

	&rar x -y "$write_dir/Standard 7 SP1 32bit IBW.part1.exe"
	&"$write_dir/7za.exe" x -o"Standard 7 SP1 32bit IBW" "Standard 7 SP1 32bit IBW.iso"
}

$jobs += $j

$script_dir_base = Split-Path -Parent $MyInvocation.MyCommand.Path
foreach($job in $jobs)
{
	Start-Job $job -Arg $script_dir_base
}
