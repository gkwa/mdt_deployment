wget.exe --output-file=%0.log --limit-rate=2m -P "%CD%\.." --timestamping --input-file urls_ws7e_toolkit.txt
cd ..
"Standard 7 SP1 Toolkit.part01.exe" -s -d .
