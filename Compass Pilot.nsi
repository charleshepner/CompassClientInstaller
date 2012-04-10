; Script generated by the HM NIS Edit Script Wizard.
; Compass client-side installer
; Version 2012-4.9
; Charles Hepner (chepner@teamnorthwoods.com)
; Michael Randall (mrandall@teamnorthwoods.com)

!define PROJECT_DIR "C:\Users\chepner\Git\CompassClientInstaller"

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Compass Client-Side Components"
!define PRODUCT_VERSION "2012-04.09"
!define PRODUCT_PUBLISHER "Northwoods"
!define PRODUCT_WEB_SITE "http://www.teamnorthwoods.com"
!define PRODUCT_HELP_SITE "http://www.teamnorthwoods.com/contact/support-center/"
!define PRODUCT_HELP_PHONE "1 (866) 424-7800"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_SIZE_KB 340



; MUI start ------
!include "MUI2.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${PROJECT_DIR}\Resources\CompassPilot.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_SHOWREADME ""
!define MUI_FINISHPAGE_SHOWREADME_CHECKED
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Create Desktop Shortcut"
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION CreatePilotDesktopShortcut


; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
;!insertmacro MUI_PAGE_LICENSE "${PROJECT_DIR}\license.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
;Custom settings page
; handle variables
Var hCtl_customsettings
Var hCtl_customsettings_GroupBox1
Var hCtl_customsettings_TextBox1
Var hCtl_customsettings_DropList1
Var hCtl_customsettings_Label3
Var hCtl_customsettings_Label4
Var hCtl_customsettings_GroupBox2
Var hCtl_customsettings_TextBox2
Var hCtl_customsettings_Label1
Var hCtl_customsettings_Label2
;Page custom fnc_customsettings_Show
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------



; Includes ------
; Add includes for any needed header files here
!addplugindir "${PROJECT_DIR}\Plugins"
!addincludedir "${PROJECT_DIR}\Include"
!include "LogicLib.nsh"
!include "DotNetChecker.nsh"
!include "WinVer.nsh"
!include "x64.nsh"
!include "nsDialogs.nsh"

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
; Define variables here
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
!define PORT_HOST_ADDRESS "ec2-23-21-113-174.compute-1.amazonaws.com"
!define PILOT_LAUNCH_URL "http://ec2-23-21-113-174.compute-1.amazonaws.com/compassframework/compassapi.application"


!macro CreateInternetShortcut FILENAME URL ICONFILE ICONINDEX
WriteINIStr "${FILENAME}.url" "InternetShortcut" "URL" "${URL}"
WriteINIStr "${FILENAME}.url" "InternetShortcut" "IconFile" "${ICONFILE}"
WriteINIStr "${FILENAME}.url" "InternetShortcut" "IconIndex" "${ICONINDEX}"
!macroend


Name "${PRODUCT_NAME}"
OutFile "Installer\${PRODUCT_NAME} Setup.exe"
InstallDir "$PROGRAMFILES\Northwoods\Compass"
ShowInstDetails show
ShowUnInstDetails show
RequestExecutionLevel admin

Function .onInit
  SetShellVarContext all

  Var /global AnswerFileExists
  Var /global ClickOnceServer
  Var /global CompassPilotURL
  Var /global PrintServer

  ${If} ${FileExists} "$EXEDIR\answer.txt"
    ReadIniStr $ClickOnceServer "$EXEDIR\answer.txt" "Settings" "ClickOnceServer"
    ReadIniStr $CompassPilotURL "$EXEDIR\answer.txt" "Settings" "CompassPilotURL"
    ReadIniStr $PrintServer "$EXEDIR\answer.txt" "Settings" "PrintServer"
    StrCpy "$AnswerFileExists" "True"
  ${Else}
    StrCpy "$AnswerFileExists" "False"
    StrCpy "$CompassPilotURL" "${PILOT_LAUNCH_URL}"
    StrCpy "$PrintServer" "${PORT_HOST_ADDRESS}"
  ${EndIf}
FunctionEnd

Section "MainSection" SEC01

  Var /global DLL_INSTALL_PATH

  LogSet on
  
  ${If} "$AnswerFileExists" == "True"
    DetailPrint "Answer file found. Using these answers:"
    DetailPrint "CompassPilotURL: $CompassPilotURL"
    DetailPrint "PrintServer: $PrintServer"
  ${Else}
    DetailPrint "No answer file found."
  ${EndIf}

  !insertmacro CheckNetFramework 40Full

  ${If} ${RunningX64}
    DetailPrint "64-bit OS detected."
    StrCpy $DLL_INSTALL_PATH "$WINDIR\SysWOW64"
  ${Else}
    DetailPrint "32-bit OS detected."
    StrCpy $DLL_INSTALL_PATH "$WINDIR\System32"
  ${EndIf}

  ${If} ${IsWinXP}
    DetailPrint "Windows XP detected."
    DetailPrint "Installing Tifconvert Printer Port."
    nsExec::Exec 'cscript C:\Windows\System32\prnport.vbs -a -r ${TIFCONVERT_PORT_NAME} -h $PrintServer -q ${TIFCONVERT_PORT_QUEUE} -o lpr -n 515 -2e -md'
    DetailPrint "Installing Tifconvert Printer."
    nsExec::Exec 'cscript C:\Windows\System32\prnmngr.vbs -a -p "${TIFCONVERT_PRINTER_NAME}" -m "${PRINTER_DRIVER32}" -r "${TIFCONVERT_PORT_NAME}"'
  ${EndIf}

  ${If} ${IsWin7}
    DetailPrint "Windows 7 detected."
    DetailPrint "Installing Tifconvert Printer Port."
    nsExec::Exec 'cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnport.vbs -a -r ${TIFCONVERT_PORT_NAME} -h $PrintServer -q ${TIFCONVERT_PORT_QUEUE} -o lpr -n 515 -2e -md'
    DetailPrint "Installing Tifconvert Printer."
    nsExec::Exec 'cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs -a -p "${TIFCONVERT_PRINTER_NAME}" -m "${PRINTER_DRIVER64}" -r "${TIFCONVERT_PORT_NAME}"'
  ${EndIf}

  SetOverwrite ifnewer
  SetOutPath "$DLL_INSTALL_PATH"
  File "${PROJECT_DIR}\Resources\Ltbar7r15u.dll"
  File "${PROJECT_DIR}\Resources\Ltbar7w15u.dll"
  SetOutPath "$INSTDIR"
  File "${PROJECT_DIR}\Resources\CompassPilot.ico"
  
  IfSilent 0 +2
    Call CreatePilotDesktopShortcut

SectionEnd

Section -AdditionalIcons
  CreateDirectory "$SMPROGRAMS\Compass Pilot"
  !insertmacro CreateInternetShortcut "$SMPROGRAMS\Compass Pilot\Compass Pilot" "$CompassPilotURL" "$INSTDIR\CompassPilot.ico" "0"
  !insertmacro CreateInternetShortcut "$SMPROGRAMS\Compass Pilot\Northwoods Website" "${PRODUCT_WEB_SITE}" "" "0"
  ;CreateShortCut "$SMPROGRAMS\Compass Pilot\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

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


; dialog create function
Function fnc_customsettings_Create

  ; === customsettings (type: Dialog) ===
  nsDialogs::Create 1018
  Pop $hCtl_customsettings
  ${If} $hCtl_customsettings == error
    Abort
  ${EndIf}
  !insertmacro MUI_HEADER_TEXT "Set Compass Settings" "Configure the Compass Pilot launch URL and print server name"

  ; === GroupBox1 (type: GroupBox) ===
  ${NSD_CreateGroupBox} 8u 25u 280u 29u "Compass Launch URL"
  Pop $hCtl_customsettings_GroupBox1

  ; === TextBox1 (type: Text) ===
  ${NSD_CreateText} 58u 36u 72u 11u ""
  Pop $hCtl_customsettings_TextBox1

  ; === DropList1 (type: DropList) ===
  ${NSD_CreateDropList} 12u 35u 30u 12u ""
  Pop $hCtl_customsettings_DropList1
  SetCtlColors $hCtl_customsettings_DropList1 0x000000 0xFFFFFF
  ${NSD_CB_AddString} $hCtl_customsettings_DropList1 "http"
  ${NSD_CB_AddString} $hCtl_customsettings_DropList1 "https"
  ${NSD_CB_SelectString} $hCtl_customsettings_DropList1 "http"

  ; === Label3 (type: Label) ===
  ${NSD_CreateLabel} 46u 38u 14u 10u "://"
  Pop $hCtl_customsettings_Label3

  ; === Label4 (type: Label) ===
  ${NSD_CreateLabel} 133u 37u 150u 13u "/compassframework/compassapi.application"
  Pop $hCtl_customsettings_Label4

  ; === GroupBox2 (type: GroupBox) ===
  ${NSD_CreateGroupBox} 8u 73u 280u 28u "Print Server Name"
  Pop $hCtl_customsettings_GroupBox2

  ; === TextBox2 (type: Text) ===
  ${NSD_CreateText} 12u 84u 106u 11u ""
  Pop $hCtl_customsettings_TextBox2

  ; === Label1 (type: Label) ===
  ${NSD_CreateLabel} 8u 5u 280u 19u "Enter the URL from which Compass Pilot will be launched.  Either http or https can be chosen depending on how the server is configured."
  Pop $hCtl_customsettings_Label1

  ; === Label2 (type: Label) ===
  ${NSD_CreateLabel} 12u 61u 275u 10u "Enter the network name of the print server."
  Pop $hCtl_customsettings_Label2

FunctionEnd


; dialog show function
Function fnc_customsettings_Show
  Call fnc_customsettings_Create
  nsDialogs::Show $hCtl_customsettings
FunctionEnd




Function CreatePilotDesktopShortcut
  !insertmacro CreateInternetShortcut "$DESKTOP\Compass Pilot" "$CompassPilotURL" "$INSTDIR\CompassPilot.ico" "0"
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  SetShellVarContext all
  
  ${If} ${RunningX64}
    DetailPrint "64-bit OS detected."
    StrCpy $DLL_INSTALL_PATH "$WINDIR\SysWOW64"
  ${Else}
    DetailPrint "32-bit OS detected."
    StrCpy $DLL_INSTALL_PATH "$WINDIR\System32"
  ${EndIf}

  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\CompassPilot.ico"
  Delete "$INSTDIR\install.log"
  Delete "$DLL_INSTALL_PATH\Ltbar7w15u.dll"
  Delete "$DLL_INSTALL_PATH\Ltbar7r15u.dll"
  
  ;START TIFCONVERT PRINTER UNINSTALL

  ${If} ${IsWinXP}
    DetailPrint "Uninstalling Windows XP Tifconvert"
    nsExec::Exec 'cscript C:\Windows\System32\prnport.vbs -d -r ${TIFCONVERT_PORT_NAME}'
    nsExec::Exec 'cscript C:\Windows\System32\prnmngr.vbs -d -p ${TIFCONVERT_PRINTER_NAME}'
  ${EndIf}

  ${If} ${IsWin7}
    DetailPrint "Uninstalling Windows 7 Tifconvert"
    nsExec::Exec 'cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnport.vbs -d -r ${TIFCONVERT_PORT_NAME}'
    nsExec::Exec 'cscript C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs -d -p ${TIFCONVERT_PRINTER_NAME}'
  ${EndIf}

  ;END TIFCONVERT PRINTER UNINSTALL

  Delete "$DESKTOP\Compass Pilot.url"
  ;Delete "$SMPROGRAMS\Compass Pilot\Uninstall.lnk"
  Delete "$SMPROGRAMS\Compass Pilot\Compass Pilot.url"
  Delete "$SMPROGRAMS\Compass Pilot\Northwoods Website.url"

  RMDir "$SMPROGRAMS\Compass Pilot"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd