wget.exe --limit-rate=2m --directory-prefix="%CD%\.." --timestamping --input-file=urls_ws7e_toolkit.txt
cd ..
"Standard 7 SP1 Toolkit.part01.exe" -s -d .
scripts\7za.exe x -o"Standard 7 SP1 Toolkit" "Standard 7 SP1 Toolkit.iso"