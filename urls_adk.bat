rem http://msdn.microsoft.com/en-us/library/windows/hardware/hh825494.aspx#InstallingNonNetworked
wget.exe --limit-rate=2m --directory-prefix="%CD%\.." --timestamping --input-file=urls_adk.txt

cd ..

rem adksetup.exe /quiet /installpath /features +
adksetup.exe /ceip on /log adksetup.log /quiet /features +
