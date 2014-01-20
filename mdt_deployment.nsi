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
	SetAutoClose true
FunctionEnd

Section section1 section_section1
	SetShellVarContext current
	SetOutPath '$EXEDIR\mdt\scripts'

	SetOverwrite off
	File wget.exe
	File 7za.exe
	SetOverwrite on
	ExpandEnvStrings $0 %COMSPEC%
	exec '"$0" /k cd "$EXEDIR\mdt" && start .'

	# ##############################
	# ADK
	# ##############################

	ExpandEnvStrings $0 %COMSPEC%
	ExpandEnvStrings $1 %TEMP%

	File urls_win7pro.txt
	File urls_win7pro.bat
	exec '"$0" /c start /D "$EXEDIR\mdt\scripts" urls_win7pro.bat && exit'

	File urls_adk.bat
	File urls_adk.txt
	exec '"$0" /c start /D "$EXEDIR\mdt\scripts" urls_adk.bat && exit'

	File urls_mdt.bat
	File urls_mdt.txt
	exec '"$0" /c start /D "$EXEDIR\mdt\scripts" urls_mdt.bat && exit'

	File urls_ws7e.bat
	File urls_ws7e.txt
	exec '"$0" /c start /D "$EXEDIR\mdt\scripts" urls_ws7e.bat && exit'

	File urls_ws7e_64bit.bat
	File urls_ws7e_64bit.txt
	exec '"$0" /c start /D "$EXEDIR\mdt\scripts" urls_ws7e_64bit.bat && exit'

	File urls_mdt_taylor_made.bat
	File urls_mdt_taylor_made.txt
	exec '"$0" /c start /D "$EXEDIR\mdt\scripts" urls_mdt_taylor_made.bat && exit'

	File urls_ws7e_toolkit.bat
	File urls_ws7e_toolkit.txt
	exec '"$0" /c start /D "$EXEDIR\mdt\scripts" urls_ws7e_toolkit.bat && exit'

	File urls_wedu.bat
	File urls_wedu.txt
	exec '"$0" /c start /D "$EXEDIR\mdt\scripts" urls_wedu.bat && exit'

SectionEnd

# Emacs vars
# Local Variables: ***
# comment-column:0 ***
# tab-width: 2 ***
# comment-start:"# " ***
# End: ***
