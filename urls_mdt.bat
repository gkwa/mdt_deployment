wget.exe --output-file=%0.log --limit-rate=2m -P "%CD%\.." --timestamping --input-file urls_mdt.txt
cd ..
scripts\7za.exe x -y -o. "MDT 2013 Documentation.zip"
