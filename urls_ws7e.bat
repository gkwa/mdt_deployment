wget.exe --output-file=%0.log --limit-rate=2m --directory-prefix="%CD%\.." --timestamping --input-file=urls_ws7e.txt
cd ..
"Standard 7 SP1 32bit IBW.part1.exe" -s -d .
