; Script generated by the HM NIS Edit Script Wizard.
; Compass client-side installer
; Version 2012.04.20
; Charles Hepner (chepner@teamnorthwoods.com)
; Michael Randall (mrandall@teamnorthwoods.com)



; HM NIS Edit Wizard helper defines
; These constants are used to name and version the installer
; and for display in the Add/Remove dialog in Windows
!define PRODUCT_NAME "Compass Client Components"
!define PRODUCT_VERSION "2012.04.20"
!define PRODUCT_PUBLISHER "Northwoods"
!define PRODUCT_WEB_SITE "http://www.teamnorthwoods.com"
!define PRODUCT_HELP_SITE "http://www.teamnorthwoods.com/contact/support-center/"
!define PRODUCT_HELP_PHONE "1 (866) 424-7800"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_SIZE_KB 340



; MUI start ------

; This header file tells the installer to use the "Modern" user interface (MUI)
!include "MUI2.nsh"

; MUI Settings
!define MUI_ABORTWARNING
; Icons for the installer and uninstaller executables
!define MUI_ICON "Resources\CompassPilot.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"
; Settings for the Finish page in the wizard
!define MUI_FINISHPAGE_NOAUTOCLOSE



; These macros insert pages into the setup wizard and determine the order of the pages
; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page - currently commented out, can be brought back if a EULA is needed
;!insertmacro MUI_PAGE_LICENSE "Resources\license.txt"
; Components page
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE RequireOneComponent ; Call this function when leaving the Components page
!define MUI_COMPONENTSPAGE_SMALLDESC
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Begin Custom settings page ------
; handle variables for controls on the settings page
Var hCtl_customsettings
Var hCtl_customsettings_GroupBox1
Var hCtl_customsettings_TextBox1
Var hCtl_customsettings_DropList1
Var hCtl_customsettings_GroupBox2
Var hCtl_customsettings_TextBox2
Var hCtl_customsettings_Label1
Var hCtl_customsettings_Label2
; Call the function fnc_customsettings_Show to insert the custom page
Page custom fnc_customsettings_Show
; End Custom settings page ------
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!insertmacro MUI_PAGE_FINISH

; This macro insert pages into the uninstall wizard
; which has only one page and which auto-closes, so it pops up and disappears
; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------



; Feature descriptions
LangString DESC_COMPASS_SMICON ${LANG_ENGLISH} "Create Start Menu shortcut for the Compass client"
LangString DESC_COMPASS_ICON ${LANG_ENGLISH} "Create Desktop shortcut for the Compass client"
LangString DESC_LEADTOOLS_DLLS ${LANG_ENGLISH} "Install LEADTOOLS DLL's for Compass Forms"
LangString DESC_FORMS_PRINTER ${LANG_ENGLISH} "Create a local printer (Forms Printer) for virtual printing"
LangString DESC_TIFCONVERT_PRINTER ${LANG_ENGLISH} "Create a local printer (TifConvert) for forms conversion"
LangString DESC_CAPTURE_KIOSK_SMICON ${LANG_ENGLISH} "Create Start Menu shortcut for Capture Kiosk"
LangString DESC_CAPTURE_KIOSK_ICON ${LANG_ENGLISH} "Create Desktop shortcut for Capture Kiosk"
LangString DESC_SELF_SCAN_KIOSK_SMICON ${LANG_ENGLISH} "Create Start Menu shortcut for the Self Scan Kiosk"
LangString DESC_SELF_SCAN_KIOSK_ICON ${LANG_ENGLISH} "Create Desktop shortcut for the Self Scan Kiosk"
LangString DESC_NORTHWOODS_ICON ${LANG_ENGLISH} "Create Start Menu shortcut for the Northwoods website"


; Includes ------
; Add includes for any needed header files here
!addplugindir "Plugins" ; include any third-party DLL's in this directory
!addincludedir "Include" ; include any third-party header files in this directory
!include "LogicLib.nsh" ; allow use of conditionals and loops (e.g. ${If}) instead of jumps
!include "WinVer.nsh" ; detect Windows versions (e.g. ${If} ${IsWinXP})
!include "x64.nsh" ; detect if the OS is 64-bit (e.g. ${If} ${RunningX64})
!include "nsDialogs.nsh" ; used for the custom settings page
!include "FileFunc.nsh" ; used for the GetOptions function to parse command-line parameters
!include "DotNetChecker.nsh" ; detect installed versions of .NET, offer to download and install
!include "Sections.nsh" ; control sections (select/deselect)

; define one new macro that extend LogicLib and replace one macro: FileExists and DirExists
; to use the macros: ${If} ${FileExists} or ${If} ${DirExists}
;FileExists is already part of LogicLib, but returns true for directories as well as files
!macro _FileExists2 _a _b _t _f
	!insertmacro _LOGICLIB_TEMP
	StrCpy $_LOGICLIB_TEMP "0"
	StrCmp `${_b}` `` +4 0 ;if path is not blank, continue to next check
	IfFileExists `${_b}` `0` +3 ;if path exists, continue to next check (IfFileExists returns true if this is a directory)
	IfFileExists `${_b}\*.*` +2 0 ;if path is not a directory, continue to confirm exists
	StrCpy $_LOGICLIB_TEMP "1" ;file exists
	;now we have a definitive value - the file exists or it does not
	StrCmp $_LOGICLIB_TEMP "1" `${_t}` `${_f}`
!macroend
!undef FileExists
!define FileExists `"" FileExists2`
!macro _DirExists _a _b _t _f
	!insertmacro _LOGICLIB_TEMP
	StrCpy $_LOGICLIB_TEMP "0"
	StrCmp `${_b}` `` +3 0 ;if path is not blank, continue to next check
	IfFileExists `${_b}\*.*` 0 +2 ;if directory exists, continue to confirm exists
	StrCpy $_LOGICLIB_TEMP "1"
	StrCmp $_LOGICLIB_TEMP "1" `${_t}` `${_f}`
!macroend
!define DirExists `"" DirExists`



; Defines ------
; Define constants here
!define PRINTER_DRIVER32 "HP LaserJet 4"
!define PRINTER_DRIVER64 "HP LaserJet 4100 series PCL6"
!define FORMS_PRINTER_NAME "Compass Forms Printer"
!define FORMS_PORT_NAME "FormsPrinterPort"
!define FORMS_PORT_QUEUE "compass"
!define PSPDESIGN_PRINTER_NAME "PSPDesign"
!define PSPDESIGN_PORT_NAME "PSPDesignPrinterPort"
!define PSPDESIGN_PORT_QUEUE "pspdesign"
!define TIFCONVERT_PRINTER_NAME "Tifconvert"
!define TIFCONVERT_PORT_NAME "TifconvertPrinterPort"
!define TIFCONVERT_PORT_QUEUE "tifconvert"
!define ANSWER_FILE "answer.txt"
; These constants are compiled into the installer.  A corresponding variable exists for each of these constants.
; If an answer file cannot be found, the values of these contants are copied in the corresponding variables and used for configuration.
; If an answer file is available, the values from it will be copied in the variables and used for configuration instead of these constants.
; Mixing and matching is not supported at this time.
!define COMPASS_CLICKONCE_PROTOCOL "http://"
!define COMPASS_CLICKONCE_URL "[CompassClickOnceServer]/compassframework/compassapi.application"
!define COMPASS_PRINT_SERVER "[CompassPrintServer]"
!define INSTALL_COMPASSCLIENT_SMICON "True"
!define INSTALL_COMPASSCLIENT_ICON "True"
!define INSTALL_LEADTOOLSDLLS "True"
!define INSTALL_FORMSPRINTER "True"
!define INSTALL_TIFCONVERTPRINTER "False"
!define INSTALL_CAPTUREKIOSK_SMICON "False"
!define INSTALL_CAPTUREKIOSK_ICON "False"
!define INSTALL_SELFSCANKIOSK_SMICON "False"
!define INSTALL_SELFSCANKIOSK_ICON "False"
!define INSTALL_NORTHWOODS_ICON "True"
!define CLEAR_CLICKONCE_CACHE "True"

; This macro can be used for creating Internet shortcuts since the built-in CreateShortcut command
; creates .lnk files instead of .url files
!macro CreateInternetShortcut FILENAME URL ICONFILE ICONINDEX
WriteINIStr "${FILENAME}.url" "InternetShortcut" "URL" "${URL}"
WriteINIStr "${FILENAME}.url" "InternetShortcut" "IconFile" "${ICONFILE}"
WriteINIStr "${FILENAME}.url" "InternetShortcut" "IconIndex" "${ICONINDEX}"
!macroend



; These installer attributes control the name of the installer, where files are installed by default, etc
Name "${PRODUCT_NAME}"
OutFile "Installer\${PRODUCT_NAME} Setup.exe"
InstallDir "$PROGRAMFILES\Northwoods\${PRODUCT_NAME}"
ShowInstDetails show
ShowUnInstDetails show
RequestExecutionLevel admin
BrandingText "Installer version: ${PRODUCT_VERSION}"






Section "-Pre"
  ; Sets the context of variables such as $DESKTOP to the all users desktop, instead of the current user's desktop
  SetShellVarContext all

  ; The special logging build of NSIS is required for the following command to work
  ; It causes a detailed log on the installation to be written to install.log in the installation directory
  LogSet on

  ; Set output directory to the installation directory chosen in the setup wizard
  ; Causes the installation directory to be created, this directory *must* be created very early
  ; in this section, or the various commands will not be able to log to install.log
  SetOutPath "$INSTDIR"
  
  SetOverwrite ifnewer
  
  Var /global AnswerFilePath
  Var /global CompassClickOnceProtocol
  Var /global CompassClickOnceURL
  Var /global CompassPrintServer
  Var /global InstallCompassClientSMIcon
  Var /global InstallCompassClientIcon
  Var /global InstallLEADTOOLSDLLs
  Var /global InstallFormsPrinter
  Var /global InstallTifconvertPrinter
  Var /global InstallCaptureKioskSMIcon
  Var /global InstallCaptureKioskIcon
  Var /global InstallSelfScanKioskSMIcon
  Var /global InstallSelfScanKioskIcon
  Var /global InstallNorthwoodsIcon
  Var /global ClearClickOnceCache

  ; Log information about whether an answer file was used
  ${If} "$AnswerFilePath" == ""
	DetailPrint "No answer file found."
  ${ElseIf} "$AnswerFilePath" == "$EXEDIR\${ANSWER_FILE}"
	DetailPrint "Answer file being used: $AnswerFilePath"
  ${Else}
	DetailPrint "Answer file being used: $AnswerFilePath"
  ${EndIf}

  ; Log information about the values read from an answer file if one was provided
  ${If} "$AnswerFilePath" != ""
    DetailPrint "Answer file - CompassClickOnceProtocol: $CompassClickOnceProtocol"
    DetailPrint "Answer file - CompassClickOnceURL: $CompassClickOnceURL"
    DetailPrint "Answer file - CompassPrintServer: $CompassPrintServer"
    DetailPrint "Answer file - InstallCompassClientSMIcon: $InstallCompassClientSMIcon"
    DetailPrint "Answer file - InstallCompassClientIcon: $InstallCompassClientIcon"
    DetailPrint "Answer file - InstallLEADTOOLSDLLs: $InstallLEADTOOLSDLLs"
    DetailPrint "Answer file - InstallFormsPrinter: $InstallFormsPrinter"
    DetailPrint "Answer file - InstallTifconvertPrinter: $InstallTifconvertPrinter"
    DetailPrint "Answer file - InstallCaptureKioskSMIcon: $InstallCaptureKioskSMIcon"
    DetailPrint "Answer file - InstallCaptureKioskIcon: $InstallCaptureKioskIcon"
    DetailPrint "Answer file - InstallSelfScanKioskSMIcon: $InstallSelfScanKioskSMIcon"
    DetailPrint "Answer file - InstallSelfScanKioskIcon: $InstallSelfScanKioskIcon"
    DetailPrint "Answer file - InstallNorthwoodsIcon: $InstallNorthwoodsIcon"
    DetailPrint "Answer file - ClearClickOnceCache: $ClearClickOnceCache"
  ${EndIf}

  ; Check if .NET 4.0 Full/Extended Profile is installed
  ; If it is not installed prompt the user, if it is installed proceed with no prompt
  ; If user clicks Yes .NET 4.0 Extended will be automatically downloaded and installed.
  ; If user clicks No abort the installation
  ; If the install is silent, the Yes option will be automatically chosen
  !insertmacro CheckNetFramework 40Full
  
  ; Clear ClickOnce Cache during installation
  ${If} $ClearClickOnceCache == "True"
    DetailPrint "Clearing Microsoft ClickOnce Cache."
	nsExec::Exec 'rundll32 C:\Windows\System32\dfshim.dll CleanOnlineAppCache'
  ${EndIf}
SectionEnd





SectionGroup "Compass Client"

; These commands are run when the Install button is clicked in the setup wizard if the section is selected on the components page
Section "Desktop Shortcut" SECCOMPASSICON
  ; Set installation directory back to the installation directory chosen in the setup wizard
  SetOutPath "$INSTDIR"
  File "Resources\CompassPilot.ico"

  ; Create the Desktop shortcut
  !insertmacro CreateInternetShortcut "$DESKTOP\Compass Pilot" "$CompassClickOnceProtocol$CompassClickOnceURL" "$INSTDIR\CompassPilot.ico" "0"
SectionEnd




; These commands are run when the Install button is clicked in the setup wizard if the section is selected on the components page
Section "Start Menu Shortcut" SECCOMPASSSMICON
  ; Set installation directory back to the installation directory chosen in the setup wizard
  SetOutPath "$INSTDIR"
  File "Resources\CompassPilot.ico"

  ; Create the Start Menu shortcut
  CreateDirectory "$SMPROGRAMS\Compass Pilot"
  !insertmacro CreateInternetShortcut "$SMPROGRAMS\Compass Pilot\Compass Pilot" "$CompassClickOnceProtocol$CompassClickOnceURL" "$INSTDIR\CompassPilot.ico" "0"
SectionEnd





SectionGroup /e "Compass Forms"

; These commands are run when the Install button is clicked in the setup wizard if the section is selected on the components page
Section "LEADTOOLS DLL's" SECLEADTOOLSDLLS
  Var /global DLL_INSTALL_PATH

  ; Set the path to install the Leadtools DLL's correctly based on whether the machine is 32 or 64-bit
  ${If} ${RunningX64}
    DetailPrint "64-bit OS detected."
    StrCpy $DLL_INSTALL_PATH "$WINDIR\SysWOW64"
  ${Else}
    DetailPrint "32-bit OS detected."
    StrCpy $DLL_INSTALL_PATH "$WINDIR\System32"
  ${EndIf}
  ; Set installation directory to where we want to put the Leadtools DLL's (see above)
  SetOutPath "$DLL_INSTALL_PATH"
  File "Resources\Ltbar7r15u.dll"
  File "Resources\Ltbar7w15u.dll"
SectionEnd



; These commands are run when the Install button is clicked in the setup wizard if the section is selected on the components page
Section "Forms Printer" SECFORMSPRINTER
  ; Install a printer using the path to the printer management vbscripts on Windows XP machines
  ${If} ${IsWinXP}
    DetailPrint "Windows XP detected."
    DetailPrint "Installing FORMS Printer Port."
    nsExec::Exec 'cscript C:\Windows\System32\prnport.vbs -a -r ${FORMS_PORT_NAME} -h $CompassPrintServer -q ${FORMS_PORT_QUEUE} -o lpr -n 515 -2e -md'
    DetailPrint "Installing FORMS Printer."
    nsExec::Exec 'cscript C:\Windows\System32\prnmngr.vbs -a -p "${FORMS_PRINTER_NAME}" -m "${PRINTER_DRIVER32}" -r "${FORMS_PORT_NAME}"'
  ${EndIf}

  ; Install a printer using the path to the printer management vbscripts on Windows Vista or higher machines
  ${If} ${AtLeastWinVista}
    DetailPrint "Windows Vista or Higher Detected."
    DetailPrint "Installing Compass Forms Printer Port"
    nsExec::Exec 'cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnport.vbs -a -r ${FORMS_PORT_NAME} -h $CompassPrintServer -q ${FORMS_PORT_QUEUE} -o lpr -n 515 -2e -md'
    DetailPrint "Installing Compass Forms Printer"
    nsExec::Exec 'cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs -a -p "${FORMS_PRINTER_NAME}" -m "${PRINTER_DRIVER64}" -r "${FORMS_PORT_NAME}"'
  ${EndIf}
SectionEnd



; These commands are run when the Install button is clicked in the setup wizard if the section is selected on the components page
Section "Tifconvert Printer" SECTIFCONVERTPRINTER
  ; Install a printer using the path to the printer management vbscripts on Windows XP machines
  ${If} ${IsWinXP}
    DetailPrint "Windows XP detected."
    DetailPrint "Installing Tifconvert Printer Port"
    nsExec::Exec 'cscript C:\Windows\System32\prnport.vbs -a -r ${TIFCONVERT_PORT_NAME} -h $CompassPrintServer -q ${TIFCONVERT_PORT_QUEUE} -o lpr -n 515 -2e -md'
    DetailPrint "Installing Tifconvert Printer"
    nsExec::Exec 'cscript C:\Windows\System32\prnmngr.vbs -a -p "${TIFCONVERT_PRINTER_NAME}" -m "${PRINTER_DRIVER32}" -r "${TIFCONVERT_PORT_NAME}"'
  ${EndIf}

  ; Install printers using the path to the printer management vbscripts on Windows Vista or higher machines
  ${If} ${AtLeastWinVista}
    DetailPrint "Windows Vista or Higher Detected."
    DetailPrint "Installing Tifconvert Printer Port"
    nsExec::Exec 'cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnport.vbs -a -r ${TIFCONVERT_PORT_NAME} -h $CompassPrintServer -q ${TIFCONVERT_PORT_QUEUE} -o lpr -n 515 -2e -md'
    DetailPrint "Installing Tifconvert Printer"
    nsExec::Exec 'cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs -a -p "${TIFCONVERT_PRINTER_NAME}" -m "${PRINTER_DRIVER64}" -r "${TIFCONVERT_PORT_NAME}"'
  ${EndIf}
SectionEnd


SectionGroupEnd ; End SectionGroup "Compass Forms"


SectionGroupEnd ; End SectionGroup "Compass Client"



SectionGroup "Compass Capture Kiosk"

; These commands are run when the Install button is clicked in the setup wizard if the section is selected on the components page
Section "Desktop Shortcut" SECCAPTUREKIOSKICON
  ; Set installation directory back to the installation directory chosen in the setup wizard
  SetOutPath "$INSTDIR"
  File "Resources\CompassPilot.ico"

  ; Create the Desktop shortcut
  !insertmacro CreateInternetShortcut "$DESKTOP\Compass Capture Kiosk" "$CompassClickOnceProtocol$CompassClickOnceURL?AppID=10&action=kiosk" "$INSTDIR\CompassPilot.ico" "0"
SectionEnd



; These commands are run when the Install button is clicked in the setup wizard if the section is selected on the components page
Section "Start Menu Shortcut" SECCAPTUREKIOSKSMICON
  ; Set installation directory back to the installation directory chosen in the setup wizard
  SetOutPath "$INSTDIR"
  File "Resources\CompassPilot.ico"

  ; Create the Start Menu shortcut
  CreateDirectory "$SMPROGRAMS\Compass Pilot"
  !insertmacro CreateInternetShortcut "$SMPROGRAMS\Compass Pilot\Compass Capture Kiosk" "$CompassClickOnceProtocol$CompassClickOnceURL?AppID=10&action=kiosk" "$INSTDIR\CompassPilot.ico" "0"
SectionEnd

SectionGroupEnd ;End Compass Capture Kiosk section



SectionGroup "Compass Self Scan Kiosk"

; These commands are run when the Install button is clicked in the setup wizard if the section is selected on the components page
Section "Desktop Shortcut" SECSELFSCANKIOSKICON
  ; Set installation directory back to the installation directory chosen in the setup wizard
  SetOutPath "$INSTDIR"
  File "Resources\CompassPilot.ico"

  ; Create the Desktop shortcut
  !insertmacro CreateInternetShortcut "$DESKTOP\Compass Self-Scan Kiosk" "$CompassClickOnceProtocol$CompassClickOnceURL?AppID=20&action=kiosk" "$INSTDIR\CompassPilot.ico" "0"
SectionEnd



; These commands are run when the Install button is clicked in the setup wizard if the section is selected on the components page
Section "Start Menu Shortcut" SECSELFSCANKIOSKSMICON
  ; Set installation directory back to the installation directory chosen in the setup wizard
  SetOutPath "$INSTDIR"
  File "Resources\CompassPilot.ico"

  ; Create the Start Menu shortcut
  CreateDirectory "$SMPROGRAMS\Compass Pilot"
  !insertmacro CreateInternetShortcut "$SMPROGRAMS\Compass Pilot\Compass Self-Scan Kiosk" "$CompassClickOnceProtocol$CompassClickOnceURL?AppID=20&action=kiosk" "$INSTDIR\CompassPilot.ico" "0"
SectionEnd

SectionGroupEnd ; End Compass Self Scan Kiosk section



; These commands are run when the Install button is clicked in the setup wizard if the section is selected on the components page
Section "Northwoods Website Icon" SECNORTHWOODSICON
  ; Create the Start Menu shortcut
  CreateDirectory "$SMPROGRAMS\Compass Pilot"
  !insertmacro CreateInternetShortcut "$SMPROGRAMS\Compass Pilot\Northwoods Website" "${PRODUCT_WEB_SITE}" "" "0"
SectionEnd



; Sections preceded with a minus (-) will always run, and will not show on the components page
; Write uninstaller executable to the installation directory and put uninstall information in the registry
; so that this Client Components installer can be removed from Add/Remove programs
Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "HelpLink" "${PRODUCT_HELP_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "HelpTelephone" "${PRODUCT_HELP_PHONE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\CompassPilot.ico"
  WriteRegDWORD ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "EstimatedSize" 340
SectionEnd






!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SECCOMPASSSMICON} $(DESC_COMPASS_SMICON)
  !insertmacro MUI_DESCRIPTION_TEXT ${SECCOMPASSICON} $(DESC_COMPASS_ICON)
  !insertmacro MUI_DESCRIPTION_TEXT ${SECLEADTOOLSDLLS} $(DESC_LEADTOOLS_DLLS)
  !insertmacro MUI_DESCRIPTION_TEXT ${SECFORMSPRINTER} $(DESC_FORMS_PRINTER)
  !insertmacro MUI_DESCRIPTION_TEXT ${SECTIFCONVERTPRINTER} $(DESC_TIFCONVERT_PRINTER)
  !insertmacro MUI_DESCRIPTION_TEXT ${SECCAPTUREKIOSKSMICON} $(DESC_CAPTURE_KIOSK_SMICON)
  !insertmacro MUI_DESCRIPTION_TEXT ${SECCAPTUREKIOSKICON} $(DESC_CAPTURE_KIOSK_ICON)
  !insertmacro MUI_DESCRIPTION_TEXT ${SECSELFSCANKIOSKSMICON} $(DESC_SELF_SCAN_KIOSK_SMICON)
  !insertmacro MUI_DESCRIPTION_TEXT ${SECSELFSCANKIOSKICON} $(DESC_SELF_SCAN_KIOSK_ICON)
  !insertmacro MUI_DESCRIPTION_TEXT ${SECNORTHWOODSICON} $(DESC_NORTHWOODS_ICON)
!insertmacro MUI_FUNCTION_DESCRIPTION_END






; This function is called immediately before the Welcome page appears
Function .onInit
  ; Require Windows XP or higher
  ${IfNot} ${AtLeastWinXP}
	MessageBox MB_OK|MB_ICONSTOP "This installer can only be run on Windows XP or higher."
	Abort
  ${EndIf}

  Var /global UninstallerPath
  
  ; Check the registry to see if Compass Client Components is already installed
  ReadRegStr $UninstallerPath ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString"

  ; If there is no path to the uninstaller in the registry, Compass Client Components is not installed, so do nothing
  ${If} $UninstallerPath != ""
	MessageBox MB_ICONQUESTION|MB_OKCANCEL "Compass Client Components is already installed. Click OK to uninstall the version currently installed \
	or Cancel to abort this installation." /SD IDOK IDOK +2
	Abort
	; Uninstall the previous version
	nsExec::Exec "$UninstallerPath /S"
  ${EndIf}


  ;Show a dialog explaining the command-line parameters if /? is passed on the command-line
  ClearErrors
  ${GetOptions} $cmdLineParams "/?" $R0
  IfErrors +3 0
  MessageBox MB_OK "Installs Compass client components$\r$\n$\r$\nCompass Client Components Setup.exe [/S] [/ANSWERFILE=path] $\r$\n$\r$\n\
  /S		install silently (case sensitive) $\r$\n\
  /ANSWERFILE	use an answerfile to automate prompts for a silent install $\r$\n\
  path		absolute or relative path to the location of the answer file"
  Abort
  Pop $R0

  ;Get the answerfile path if /ANSWERFILE is passed on the command-line
  ClearErrors
  ${GetOptions} $CMDLINE "/ANSWERFILE=" $AnswerFilePath
  ; If /ANSWSERFILE is passed jump to AnswerFileProvided: otherwise, look in the current directory for the answer file
  IfErrors 0 AnswerFileProvided
  ${If} ${FileExists} "$EXEDIR\${ANSWER_FILE}"
    StrCpy "$AnswerFilePath" "$EXEDIR\${ANSWER_FILE}"
  ${EndIf}

  AnswerFileProvided:
  ; If an answer file is provided, read the values out of it into the configuration variables
  ; If any of the values were omitted from the answerfile default that value to false
  ${If} ${FileExists} "$AnswerFilePath"
    ReadIniStr $CompassClickOnceProtocol "$AnswerFilePath" "Settings" "CompassClickOnceProtocol"
    ${If} $CompassClickOnceProtocol == ""
	  StrCpy $CompassClickOnceProtocol "http://" ; default to http if omitted
    ${EndIf}
    ReadIniStr $CompassClickOnceURL "$AnswerFilePath" "Settings" "CompassClickOnceURL"
    ${If} $CompassClickOnceURL == ""
	  StrCpy $CompassClickOnceURL "" ; default to blank if omitted
    ${EndIf}
    ReadIniStr $CompassPrintServer "$AnswerFilePath" "Settings" "CompassPrintServer"
    ${If} $CompassPrintServer == ""
	  StrCpy $CompassPrintServer "" ; default to blank if omitted
    ${EndIf}
    ReadIniStr $InstallCompassClientSMIcon "$AnswerFilePath" "Features" "InstallCompassClientSMIcon"
    ${If} $InstallCompassClientSMIcon == ""
	  StrCpy $InstallCompassClientSMIcon "False" ; default to false if omitted
    ${EndIf}
    ReadIniStr $InstallCompassClientIcon "$AnswerFilePath" "Features" "InstallCompassClientIcon"
    ${If} $InstallCompassClientIcon == ""
	  StrCpy $InstallCompassClientIcon "False" ; default to false if omitted
    ${EndIf}
    ReadIniStr $InstallLEADTOOLSDLLs "$AnswerFilePath" "Features" "InstallLEADTOOLSDLLs"
    ${If} $InstallLEADTOOLSDLLs == ""
	  StrCpy $InstallLEADTOOLSDLLs "False" ; default to false if omitted
    ${EndIf}
    ReadIniStr $InstallFormsPrinter "$AnswerFilePath" "Features" "InstallFormsPrinter"
    ${If} $InstallFormsPrinter == ""
	  StrCpy $InstallFormsPrinter "False" ; default to false if omitted
    ${EndIf}
    ReadIniStr $InstallTifconvertPrinter "$AnswerFilePath" "Features" "InstallTifconvertPrinter"
    ${If} $InstallTifconvertPrinter == ""
	  StrCpy $InstallTifconvertPrinter "False" ; default to false if omitted
    ${EndIf}
    ReadIniStr $InstallCaptureKioskSMIcon "$AnswerFilePath" "Features" "InstallCaptureKioskSMIcon"
    ${If} $InstallCaptureKioskSMIcon == ""
	  StrCpy $InstallCaptureKioskSMIcon "False" ; default to false if omitted
    ${EndIf}
    ReadIniStr $InstallCaptureKioskIcon "$AnswerFilePath" "Features" "InstallCaptureKioskIcon"
    ${If} $InstallCaptureKioskIcon == ""
	  StrCpy $InstallCaptureKioskIcon "False" ; default to false if omitted
    ${EndIf}
    ReadIniStr $InstallSelfScanKioskSMIcon "$AnswerFilePath" "Features" "InstallSelfScanKioskSMIcon"
    ${If} $InstallSelfScanKioskSMIcon == ""
	  StrCpy $InstallSelfScanKioskSMIcon "False" ; default to false if omitted
    ${EndIf}
    ReadIniStr $InstallSelfScanKioskIcon "$AnswerFilePath" "Features" "InstallSelfScanKioskIcon"
    ${If} $InstallSelfScanKioskIcon == ""
	  StrCpy $InstallSelfScanKioskIcon "False" ; default to false if omitted
    ${EndIf}
    ReadIniStr $InstallNorthwoodsIcon "$AnswerFilePath" "Features" "InstallNorthwoodsIcon"
    ${If} $InstallNorthwoodsIcon == ""
	  StrCpy $InstallNorthwoodsIcon "False" ; default to false if omitted
    ${EndIf}
    ReadIniStr $ClearClickOnceCache "$AnswerFilePath" "Options" "ClearClickOnceCache"
    ${If} $ClearClickOnceCache == ""
	  StrCpy $ClearClickOnceCache "False" ; default to false if omitted
    ${EndIf}
  ${Else}
  ; If we get here, no answer file was provided so read the compiled in constants into the variables for configuration
    StrCPy "$CompassClickOnceProtocol" "${COMPASS_CLICKONCE_PROTOCOL}"
    StrCpy "$CompassClickOnceURL" "${COMPASS_CLICKONCE_URL}"
    StrCpy "$CompassPrintServer" "${COMPASS_PRINT_SERVER}"
    StrCpy "$InstallCompassClientIcon" "${INSTALL_COMPASSCLIENT_ICON}"
    StrCpy "$InstallLEADTOOLSDLLs" "${INSTALL_LEADTOOLSDLLS}"
    StrCpy "$InstallFormsPrinter" "${INSTALL_FORMSPRINTER}"
    StrCpy "$InstallTifconvertPrinter" "${INSTALL_TIFCONVERTPRINTER}"
    StrCpy "$InstallCaptureKioskIcon" "${INSTALL_CAPTUREKIOSK_ICON}"
    StrCpy "$InstallSelfScanKioskIcon" "${INSTALL_SELFSCANKIOSK_ICON}"
    StrCpy "$InstallNorthwoodsIcon" "${INSTALL_NORTHWOODS_ICON}"
    StrCpy "$ClearClickOnceCache" "${CLEAR_CLICKONCE_CACHE}"
  ${EndIf}
  

  ; Set which features should be selected by default on the Components page
  ; either from the compiled in constans or from the answer file if present
  ${If} $InstallCompassClientSMIcon == "True"
	!insertmacro SelectSection ${SECCOMPASSSMICON}
  ${ElseIf} $InstallCompassClientSMIcon == "False"
	!insertmacro UnselectSection ${SECCOMPASSSMICON}
  ${EndIf}

  ${If} $InstallCompassClientIcon == "True"
	!insertmacro SelectSection ${SECCOMPASSICON}
  ${ElseIf} $InstallCompassClientIcon == "False"
	!insertmacro UnselectSection ${SECCOMPASSICON}
  ${EndIf}
  
  ${If} $InstallLEADTOOLSDLLs == "True"
	!insertmacro SelectSection ${SECLEADTOOLSDLLS}
  ${ElseIf} $InstallLEADTOOLSDLLs == "False"
	!insertmacro UnselectSection ${SECLEADTOOLSDLLS}
  ${EndIf}

  ${If} $InstallFormsPrinter == "True"
	!insertmacro SelectSection ${SECFORMSPRINTER}
  ${ElseIf} $InstallFormsPrinter == "False"
	!insertmacro UnselectSection ${SECFORMSPRINTER}
  ${EndIf}

  ${If} $InstallTifconvertPrinter == "True"
	!insertmacro SelectSection ${SECTIFCONVERTPRINTER}
  ${ElseIf} $InstallTifconvertPrinter == "False"
	!insertmacro UnselectSection ${SECTIFCONVERTPRINTER}
  ${EndIf}

  ${If} $InstallCaptureKioskSMIcon == "True"
	!insertmacro SelectSection ${SECCAPTUREKIOSKSMICON}
  ${ElseIf} $InstallCaptureKioskSMIcon == "False"
	!insertmacro UnselectSection ${SECCAPTUREKIOSKSMICON}
  ${EndIf}
  
  ${If} $InstallCaptureKioskIcon == "True"
	!insertmacro SelectSection ${SECCAPTUREKIOSKICON}
  ${ElseIf} $InstallCaptureKioskIcon == "False"
	!insertmacro UnselectSection ${SECCAPTUREKIOSKICON}
  ${EndIf}

  ${If} $InstallSelfScanKioskSMIcon == "True"
	!insertmacro SelectSection ${SECSELFSCANKIOSKSMICON}
  ${ElseIf} $InstallSelfScanKioskSMIcon == "False"
	!insertmacro UnselectSection ${SECSELFSCANKIOSKSMICON}
  ${EndIf}
  
  ${If} $InstallSelfScanKioskIcon == "True"
	!insertmacro SelectSection ${SECSELFSCANKIOSKICON}
  ${ElseIf} $InstallSelfScanKioskIcon == "False"
	!insertmacro UnselectSection ${SECSELFSCANKIOSKICON}
  ${EndIf}
  
  ${If} $InstallNorthwoodsIcon == "True"
	!insertmacro SelectSection ${SECNORTHWOODSICON}
  ${ElseIf} $InstallNorthwoodsIcon == "False"
	!insertmacro UnselectSection ${SECNORTHWOODSICON}
  ${EndIf}
FunctionEnd



; This code generated from Coolsoft's NSIS Dialog Designer for the custom settings page
; We populate the controls on the custom settings page from the configuration variables
Function fnc_customsettings_Create

  ; === customsettings (type: Dialog) ===
  nsDialogs::Create 1018
  Pop $hCtl_customsettings
  ${If} $hCtl_customsettings == error
    Abort
  ${EndIf}
  !insertmacro MUI_HEADER_TEXT "Set Compass Client Components Settings" "Configure the ClickOnce URL for Compass Pilot and the Print Server name"

  ; === GroupBox1 (type: GroupBox) ===
  ${NSD_CreateGroupBox} 8u 25u 280u 29u "Compass Launch URL"
  Pop $hCtl_customsettings_GroupBox1

  ; === TextBox1 (type: Text) ===
  ${NSD_CreateText} 56u 35u 227u 11u "$CompassClickOnceURL"
  Pop $hCtl_customsettings_TextBox1
  
  ${NSD_OnChange} $hCtl_customsettings_TextBox1 nsDialogsTextBox1

  ; === DropList1 (type: DropList) ===
  ${NSD_CreateDropList} 12u 35u 40u 12u ""
  Pop $hCtl_customsettings_DropList1
  SetCtlColors $hCtl_customsettings_DropList1 0x000000 0xFFFFFF
  ${NSD_CB_AddString} $hCtl_customsettings_DropList1 "http://"
  ${NSD_CB_AddString} $hCtl_customsettings_DropList1 "https://"
  ${NSD_CB_SelectString} $hCtl_customsettings_DropList1 "$CompassClickOnceProtocol"

  ${NSD_OnChange} $hCtl_customsettings_DropList1 nsDialogsDropList1

  ; === GroupBox2 (type: GroupBox) ===
  ${NSD_CreateGroupBox} 8u 73u 280u 28u "Print Server Name"
  Pop $hCtl_customsettings_GroupBox2

  ; === TextBox2 (type: Text) ===
  ${NSD_CreateText} 12u 84u 271u 11u "$CompassPrintServer"
  Pop $hCtl_customsettings_TextBox2
  
  ${NSD_OnChange} $hCtl_customsettings_TextBox2 nsDialogsTextBox2

  ; === Label1 (type: Label) ===
  ${NSD_CreateLabel} 8u 5u 280u 19u "Enter the URL from which Compass Pilot will be launched.  Either http or https can be chosen depending on how the server is configured."
  Pop $hCtl_customsettings_Label1

  ; === Label2 (type: Label) ===
  ${NSD_CreateLabel} 12u 61u 275u 10u "Enter the network name of the print server."
  Pop $hCtl_customsettings_Label2
FunctionEnd



; This code generated from Coolsoft's NSIS Dialog Designer for the custom settings page
; dialog show function
Function fnc_customsettings_Show
  Call fnc_customsettings_Create
  nsDialogs::Show $hCtl_customsettings
FunctionEnd



; Put the contents of the drop-list back in to the configuration variable
; so any changes by the user running the installer are preserved
Function nsDialogsDropList1
	Pop $1
    ${NSD_GetText} $hCtl_customsettings_DropList1 $CompassClickOnceProtocol
FunctionEnd



; Put the contents of the text box back in to the configuration variable
; so any changes by the user running the installer are preserved
Function nsDialogsTextBox1
	Pop $1
	${NSD_GetText} $hCtl_customsettings_TextBox1 $CompassClickOnceURL
FunctionEnd



; Put the contents of the text box back in to the configuration variable
; so any changes by the user running the installer are preserved
Function nsDialogsTextBox2
	Pop $1
	${NSD_GetText} $hCtl_customsettings_TextBox2 $CompassPrintServer
FunctionEnd



Function RequireOneComponent
  ; Add code here to ensure that at least one component is selected
  ; before leaving the features page.  Make sure it works with silent installs!
  SectionGetFlags "${SECCOMPASSSMICON}" $0
  IntOp $1 $0 & ${SF_SELECTED}
  SectionGetFlags "${SECCOMPASSICON}" $0
  IntOp $0 $0 & ${SF_SELECTED}
  IntOp $1 $1 + $0
  SectionGetFlags "${SECLEADTOOLSDLLS}" $0
  IntOp $0 $0 & ${SF_SELECTED}
  IntOp $1 $1 + $0
  SectionGetFlags "${SECFORMSPRINTER}" $0
  IntOp $0 $0 & ${SF_SELECTED}
  IntOp $1 $1 + $0
  SectionGetFlags "${SECTIFCONVERTPRINTER}" $0
  IntOp $0 $0 & ${SF_SELECTED}
  IntOp $1 $1 + $0
  SectionGetFlags "${SECCAPTUREKIOSKSMICON}" $0
  IntOp $0 $0 & ${SF_SELECTED}
  IntOp $1 $1 + $0
  SectionGetFlags "${SECCAPTUREKIOSKICON}" $0
  IntOp $0 $0 & ${SF_SELECTED}
  IntOp $1 $1 + $0
  SectionGetFlags "${SECSELFSCANKIOSKSMICON}" $0
  IntOp $0 $0 & ${SF_SELECTED}
  IntOp $1 $1 + $0
  SectionGetFlags "${SECSELFSCANKIOSKICON}" $0
  IntOp $0 $0 & ${SF_SELECTED}
  IntOp $1 $1 + $0
  SectionGetFlags "${SECNORTHWOODSICON}" $0
  IntOp $0 $0 & ${SF_SELECTED}
  IntOp $1 $1 + $0
  StrCmp $1 "0" 0 +3
  MessageBox MB_OK|MB_ICONSTOP "You must select at least one component to continue."
  Abort     ;stay at page
FunctionEnd














; Called immediately before before the uninstaller appears
Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" /SD IDYES IDYES +2
  Abort
FunctionEnd



; These commands are run when the Uninstaller is executed
Section Uninstall
  ; Sets the context of variables such as $DESKTOP to the all users desktop, instead of the current user's desktop
  SetShellVarContext all
  
  ; Set the path to remove the Leadtools DLL's correctly based on whether the machine is 32 or 64-bit
  ${If} ${RunningX64}
    DetailPrint "64-bit OS detected."
    StrCpy $DLL_INSTALL_PATH "$WINDIR\SysWOW64"
  ${Else}
    DetailPrint "32-bit OS detected."
    StrCpy $DLL_INSTALL_PATH "$WINDIR\System32"
  ${EndIf}

  ; Delete all the files deployed by the installer
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\CompassPilot.ico"
  Delete "$INSTDIR\install.log"
  Delete "$DLL_INSTALL_PATH\Ltbar7w15u.dll"
  Delete "$DLL_INSTALL_PATH\Ltbar7r15u.dll"
  
   ; Uninstall Compass Forms and Tifconvert Ports for Windows XP
  ${If} ${IsWinXP}
    DetailPrint "Uninstalling Tifconvert Printer for Windows XP"
    nsExec::Exec 'cscript C:\Windows\System32\prnmngr.vbs -d -p "${TIFCONVERT_PRINTER_NAME}"'
    DetailPrint "Uninstalling Compass Forms Printer for Windows XP"
    nsExec::Exec 'cscript C:\Windows\System32\prnmngr.vbs -d -p "${FORMS_PRINTER_NAME}"'
  ${EndIf}

    ; Uninstall Compass Forms and Tifconvert Printers for Windows XP
  ${If} ${IsWinXP}
    DetailPrint "Uninstalling Tifconvert Port for Windows XP"
    nsExec::Exec 'cscript C:\Windows\System32\prnport.vbs -d -r "${TIFCONVERT_PORT_NAME}"'
    DetailPrint "Uninstalling Compass Forms Printer Port for Windows XP"
    nsExec::Exec 'cscript C:\Windows\System32\prnport.vbs -d -r "${FORMS_PORT_NAME}"'
  ${EndIf}

  ; Uninstall Compass Forms and Tifconvert Ports for Windows Vista or Higher
  ${If} ${AtLeastWinVista}
    DetailPrint "Uninstalling Tifconvert Printer for Windows Vista or Higher"
    nsExec::Exec 'cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs -d -p "${TIFCONVERT_PRINTER_NAME}"'
    DetailPrint "Uninstalling Compass Forms Printer for Windows 7"
    nsExec::Exec 'cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs -d -p "${FORMS_PRINTER_NAME}"'
  ${EndIf}
  
    ; Uninstall Compass Forms and Tifconvert Printers for Windows Vista or Higher
  ${If} ${AtLeastWinVista}
    DetailPrint "Uninstalling Tifconvert Port for Windows Vista or Higher"
    nsExec::Exec 'cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnport.vbs -d -r "${TIFCONVERT_PORT_NAME}"'
    DetailPrint "Uninstalling Compass Forms Printer Port for Windows 7"
    nsExec::Exec 'cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnport.vbs -d -r "${FORMS_PORT_NAME}"'
  ${EndIf}

  ; Remove the desktop shortcut and Start Menu items
  Delete "$DESKTOP\Compass Pilot.url"
  Delete "$DESKTOP\Compass Capture Kiosk.url"
  Delete "$DESKTOP\Compass Self-Scan Kiosk.url"
  Delete "$SMPROGRAMS\Compass Pilot\Compass Pilot.url"
  Delete "$SMPROGRAMS\Compass Pilot\Compass Capture Kiosk.url"
  Delete "$SMPROGRAMS\Compass Pilot\Compass Self-Scan Kiosk.url"
  Delete "$SMPROGRAMS\Compass Pilot\Northwoods Website.url"

  ; Remove the Start Menu folder and the installation directory
  RMDir "$SMPROGRAMS\Compass Pilot"
  RMDir "$INSTDIR"

  ; Remove information from the registry
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd



; Called after the uninstaller completes successfully
Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer." /SD IDOK
FunctionEnd