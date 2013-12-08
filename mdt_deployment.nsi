!include LogicLib.nsh
!include FileFunc.nsh
!include MUI2.NSH
!include nsDialogs.nsh
!include x64.nsh

Name "${name}"
OutFile "${outfile}"

XPStyle on
ShowInstDetails show
ShowUninstDetails show
RequestExecutionLevel admin
Caption "Streambox $(^Name) Installer"

# use this as installdir
InstallDir '$PROGRAMFILES\Streambox\${name}'
#...butif this reg key exists, use this installdir instead of the above line
InstallDirRegKey HKLM 'Software\Streambox\${name}' InstallDir

VIAddVersionKey ProductName "My Fun Product"
VIAddVersionKey FileDescription "Creates fun things"
VIAddVersionKey Language "English"
VIAddVersionKey LegalCopyright "@Streambox"
VIAddVersionKey CompanyName "Streambox"
VIAddVersionKey ProductVersion "${version}"
VIAddVersionKey FileVersion "${version}"
VIProductVersion "${version}"

;--------------------------------
; docs
# http://nsis.sourceforge.net/Docs
# http://nsis.sourceforge.net/Macro_vs_Function
# http://nsis.sourceforge.net/Adding_custom_installer_pages
# http://nsis.sourceforge.net/ConfigWrite
# loops
# http://nsis.sourceforge.net/Docs/Chapter2.html#\2.3.6

;--------------------------------
Var sysdrive
var debug

;--------------------------------
;Interface Configuration

!define MUI_WELCOMEPAGE_TITLE "Welcome to the Streambox setup wizard."
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP sblogo.bmp
!define MUI_WELCOMEFINISHPAGE_BITMAP sbside.bmp
!define MUI_UNWELCOMEFINISHPAGE_BITMAP sbside.bmp
!define MUI_ABORTWARNING
!define MUI_ICON Streambox_128.ico

;--------------------------------
;Pages

!insertmacro MUI_PAGE_INSTFILES # this macro is the macro that invokes the Sections
;--------------------------------
; Languages

!insertmacro MUI_LANGUAGE "English"

;--------------------------------
; Functions

Function .onInit
	StrCpy $sysdrive $WINDIR 1

	##############################
	# did we call with "/debug"
	StrCpy $debug 0
	${GetParameters} $0
	ClearErrors
	${GetOptions} $0 '/debug' $1
	${IfNot} ${Errors}
		StrCpy $debug 1
		SetAutoClose false #leave installer window open when /debug
	${EndIf}
	ClearErrors

FunctionEnd

Section section1 section_section1
	SetShellVarContext current
	SetOutPath '$DOCUMENTS\${name}'

	SetOverwrite off
	File wget.exe
	File 7za.exe
	SetOverwrite on
	ExpandEnvStrings $0 %COMSPEC%
	exec '"$0" /k cd "$DOCUMENTS\${name}" && start .'

	# ##############################
	# ADK
	# ##############################
	nsExec::ExecToLog '"wget.exe" --timestamping "http://download.microsoft.com/download/9/9/F/99F5E440-5EB5-4952-9935-B99662C3DF70/adk/adksetup.exe"'

# http://msdn.microsoft.com/en-us/library/windows/hardware/hh825494.aspx#InstallingNonNetworked
#	nsExec::ExecToLog '"adksetup.exe" /quiet /installpath /features +'
	exec '"adksetup.exe" /quiet /features +'
	ExpandEnvStrings $0 %TEMP%
	CreateShortCut '$DOCUMENTS\${name}\adksetup_log.lnk' '$0\adk'

	# ##############################
	# IBW and toolkit
	# ##############################

	File urls.txt
	FileOpen $1 getbits1.bat  w
	FileWrite $1 'wget.exe --timestamping --input-file urls.txt$\r$\n'
	FileWrite $1 '7za.exe e -y -o. "MDT 2013 Documentation.zip"$\r$\n'
	FileClose $1
	ExpandEnvStrings $0 %COMSPEC%
	exec '"$0" /c start /D "$DOCUMENTS\${name}" getbits1.bat && exit'

	FileOpen $1 getbits2.bat  w
	FileWrite $1 'wget.exe --timestamping --input-file urls2.txt$\r$\n'
	${If} ${RunningX64}
		File '/oname=$DOCUMENTS\${name}\urls2.txt' urls64bit.txt
		FileWrite $1 '"Standard 7 SP1 64bit IBW.part1.exe" -s -d "$DOCUMENTS\${name}"$\r$\n'
	${Else}
		File '/oname=$DOCUMENTS\${name}\urls2.txt' urls32bit.txt
		FileWrite $1 '"Standard 7 SP1 Toolkit.part01.exe" -s -d "$DOCUMENTS\${name}"$\r$\n'
	${EndIf}
	FileClose $1
	ExpandEnvStrings $0 %COMSPEC%
	exec '"$0" /c start /D "$DOCUMENTS\${name}" getbits2.bat && exit'

SectionEnd


# Emacs vars
# Local Variables: ***
# comment-column:0 ***
# tab-width: 2 ***
# comment-start:"# " ***
# End: ***
