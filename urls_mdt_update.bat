wget.exe --limit-rate=2m --directory-prefix="%CD%\.." --timestamping --input-file=urls_mdt_update.txt
cd ..
scripts\7za.exe x -o. windowsembeddedstandard7sp1-december_2013_toolkit_update_1fb0cd69ef7b9e76a01c48538533551097baa92f.cab
