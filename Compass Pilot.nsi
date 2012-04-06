; Script generated by the HM NIS Edit Script Wizard.
; Compass client-side installer
; Version 2012-4.5
; Charles Hepner (chepner@teamnorthwoods.com)
; Michael Randall (mrandall@teamnorthwoods.com)

!define PROJECT_DIR "C:\Users\chepner\Git\CompassClientInstaller"

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Compass Pilot"
!define PRODUCT_VERSION "4.3"
!define PRODUCT_PUBLISHER "Northwoods"
!define PRODUCT_WEB_SITE "http://www.teamnorthwoods.com"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"



; MUI start ------
!include "MUI2.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_SHOWREADME ""
!define MUI_FINISHPAGE_SHOWREADME_CHECKED
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Create Desktop Shortcut"
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION CreatePilotDesktopShortcut

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "${PROJECT_DIR}\license.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
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
!addincludedir "${PROJECT_DIR}\Include"
!include "LogicLib.nsh"
!include "DotNetVer.nsh"

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


Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME} ${PRODUCT_VERSION} Setup.exe"
InstallDir "$PROGRAMFILES\Northwoods\Compass Pilot"
ShowInstDetails show
ShowUnInstDetails show



Section "MainSection" SEC01

  Var /global IS_64_BIT
  Var /global DLL_INSTALL_PATH

  ${If} ${HasDotNet4.0}
    DetailPrint "Microsoft .NET Framework 4.0 installed."
    ;${If} ${DOTNETVER_4_0} HasDotNetClientProfile 1
    ;   DetailPrint "Microsoft .NET Framework 4.0 (Client Profile) available."
    ;${EndIf}
    ${If} ${DOTNETVER_4_0} HasDotNetFullProfile 1
      DetailPrint "Microsoft .NET Framework 4.0 (Extended Profile) available."
    ${Else}
      Abort ".NET 4.0 Extended Profile must be installed prior to installing ${PRODUCT_NAME} ${PRODUCT_VERSION}"
    ${EndIf}
  ${Else}
    Abort ".NET 4.0 Extended Profile must be installed prior to installing ${PRODUCT_NAME} ${PRODUCT_VERSION}"
  ${EndIf}

  ${If} $IS_64_BIT == "True"
    DetailPrint "64-bit OS detected."
    StrCpy $DLL_INSTALL_PATH "$WINDIR\SysWOW64"
  ${ElseIf} $IS_64_BIT == "False"
    DetailPrint "32-bit OS detected."
    StrCpy $DLL_INSTALL_PATH "$WINDIR\System32"
  ${Else}
    ;help I'm not 64 or 32-bit
  ${EndIf}

 
 #printer creation goes here

  SetOverwrite ifnewer
  SetOutPath "$DLL_INSTALL_PATH"
  File "${PROJECT_DIR}\Ltbar7r15u.dll"
  File "${PROJECT_DIR}\Ltbar7w15u.dll"
  SetOutPath "$INSTDIR"
  File "${PROJECT_DIR}\CompassPilot.ico"
  ;LogSet on

SectionEnd

Section -AdditionalIcons
  CreateDirectory "$SMPROGRAMS\Compass Pilot"
  !insertmacro CreateInternetShortcut "$SMPROGRAMS\Compass Pilot\Compass Pilot" "${PILOT_LAUNCH_URL}" "$INSTDIR\CompassPilot.ico" "0"
  CreateShortCut "$SMPROGRAMS\Compass Pilot\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

Function .onInit
  SetShellVarContext all
  ; Install to the correct directory on 32 bit or 64 bit machines
  IfFileExists $WINDIR\SysWOW64\*.* Is64bit Is32bit
  Is32bit:
    SetRegView 32
    StrCpy $IS_64_BIT "False"
    Goto End32Bitvs64BitCheck
  Is64bit:
    SetRegView 64
    StrCpy $IS_64_BIT "True"
  End32Bitvs64BitCheck:
FunctionEnd

Function CreatePilotDesktopShortcut
  !insertmacro CreateInternetShortcut "$DESKTOP\Compass Pilot" "${PILOT_LAUNCH_URL}" "$INSTDIR\CompassPilot.ico" "0"
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
  
  ; Install to the correct directory on 32 bit or 64 bit machines
  IfFileExists $WINDIR\SysWOW64\*.* Is64bit Is32bit
  Is32bit:
    ;MessageBox MB_OK "32 bit"
    SetRegView 32
    StrCpy $IS_64_BIT "False"
    Goto End32Bitvs64BitCheck
  Is64bit:
    DetailPrint "64-bit OS detected."
    ;MessageBox MB_OK "64 bit"
    SetRegView 64
    StrCpy $IS_64_BIT "True"
  End32Bitvs64BitCheck:


  ${If} $IS_64_BIT == "True"
    StrCpy $DLL_INSTALL_PATH "$WINDIR\SysWOW64"
  ${ElseIf} $IS_64_BIT == "False"
    StrCpy $DLL_INSTALL_PATH "$WINDIR\System32"
  ${Else}
    ;help I'm not 64 or 32-bit
  ${EndIf}
  
  Delete "$INSTDIR\CompassPilot.ico"
  Delete "$INSTDIR\uninst.exe"
  Delete "$DLL_INSTALL_PATH\Ltbar7w15u.dll"
  Delete "$DLL_INSTALL_PATH\Ltbar7r15u.dll"

  Delete "$DESKTOP\Compass Pilot.url"
  Delete "$SMPROGRAMS\Compass Pilot\Uninstall.lnk"
  Delete "$SMPROGRAMS\Compass Pilot\Compass Pilot.url"

  RMDir "$SMPROGRAMS\Compass Pilot"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd