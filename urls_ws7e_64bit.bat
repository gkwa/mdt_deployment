wget.exe --output-file=%0.log --limit-rate=2m --directory-prefix="%CD%\.." --timestamping --input-file=urls_ws7e_64bit.txt
cd ..
"Standard 7 SP1 64bit IBW.part1.exe" -s -d .
