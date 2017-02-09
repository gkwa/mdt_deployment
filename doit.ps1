if(!(test-path 'wget.exe')){
	Invoke-WebRequest 'http://installer-bin.streambox.com/wget.exe' -OutFile 'wget.exe'
}

./wget --quiet --no-check-certificate --limit-rate=2m --directory-prefix=. --timestamping http://installer-bin.streambox.com/7za.exe

# Windows Embedded Standard 7 Service Pack 1 Evaluation Edition
Start-Job -ScriptBlock {
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
'@ | Out-File -encoding ASCII urls_ws7e_64bit.txt

}
