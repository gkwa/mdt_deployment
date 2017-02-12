$jb = {
	param([string]$write_dir)
	set-location $write_dir
	set-psdebug -trace 1
	&7z x -o"./Standard 7 SP1 64bit IBW" "Standard 7 SP1 64bit IBW.iso"
	set-psdebug -trace 0
}

$script_dir_base = Split-Path -Parent $MyInvocation.MyCommand.Path
$job = Start-Job $jb -Arg $script_dir_base -OutVariable oTest
Wait-Job $job
Receive-Job $job -OutVariable otest
$oTest
