wget.exe --limit-rate=2m --directory-prefix="%CD%\.." --timestamping --input-file=urls_ws7e.txt
cd ..
"Standard 7 SP1 32bit IBW.part1.exe" -s -d .
scripts\7za.exe x -o"Standard 7 SP1 32bit IBW" "Standard 7 SP1 32bit IBW.iso"
