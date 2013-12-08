wget.exe -P "%CD%\.." --timestamping --input-file urls_mdt.txt
cd ..
scripts\7za.exe x -y -o. "MDT 2013 Documentation.zip"
