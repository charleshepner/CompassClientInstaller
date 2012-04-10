; ExperienceUI installation
Name "ExperienceUI SDK"

SetCompressor /final /solid lzma

!define XPUI_ABORTWARNING
!define XPUI_SYSDIR ".\Contrib\ExperienceUI"
!include "${XPUI_SYSDIR}\XPUI.nsh"
Caption "$(^Name) v${XPUI_VERSION} Setup"
OutFile "experienceui-${XPUI_VERSION}.exe"
InstallDir "$PROGRAMFILES\NSIS\ExperienceUI"
InstallDirRegKey HKLM "Software\NSIS\ExperienceUI" ""
RequestExecutionLevel admin

${Page} Welcome2
${LicensePage} "Contrib\ExperienceUI\License.rtf"
${Page} Directory
${Page} InstConfirm
${Page} InstFiles
${Page} Abort

${UnPage} Welcome2
${UnPage} UnConfirm
${UnPage} InstFiles
${UnPage} Finish

${Language} English

Function .onInit
  ClearErrors
  ReadRegStr $0 HKLM "Software\NSIS" ""
  IfErrors 0 +2
    Return
    
  ; Set installation dir only if the ExUI is not installed
  ClearErrors
  ReadRegStr $R0 HKLM "Software\NSIS\ExperienceUI" ""
  IfErrors +2
    Return
    
  StrCpy $INSTDIR "$0\ExperienceUI"
FunctionEnd

Section
  SetOutPath $INSTDIR
  File /r Contrib
  File /r Docs
  File /r Examples
  File /r Include
  File /r Plugins
  
  ; Write install dir
  WriteRegStr HKLM "Software\NSIS\ExperienceUI" "" "$INSTDIR"
  
  ; Write uninstaller
  WriteUninstaller "$INSTDIR\uninstall-exui.exe"
  
  ; Registry stuff
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "DisplayName" "$(^Name)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "UninstallString" "$INSTDIR\uninstall-exui.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "DisplayIcon" "$INSTDIR\Contrib\Graphics\Icons\XPUI-install.ico"
  
  ; Register with NSIS
  ClearErrors
  ReadRegStr $0 HKLM "Software\NSIS" ""
  IfErrors 0 +3
    ; NSIS not found
    MessageBox MB_OK|MB_ICONEXCLAMATION "Setup did not detect NSIS on your system. Integrating the ExperienceUI with NSIS will be your job once you install NSIS."
    Return
    
  MessageBox MB_YESNO|MB_ICONQUESTION "Found NSIS installation at $0. Do you want to register the ExperienceUI SDK with this copy of NSIS?$\n$\n(If you don't, you'll have to specify the full path to XPUI.nsh in your scripts.)" IDYES +2
    Return
    
  ; Write in .nsh
  ; $0 = NSIS installation dir
  ClearErrors
  FileOpen $1  "$0\Include\XPUI.nsh" "w"
  FileWrite $1 "!define XPUI_SYSDIR $\"$INSTDIR\Contrib\ExperienceUI$\"$\r$\n"
  FileWrite $1 "!include $\"$$"
  ; stupid compiler bugs...
  FileWrite $1 "{XPUI_SYSDIR}\XPUI.nsh$\"$\r$\n"
  FileClose $0
SectionEnd

Section "Uninstall"
  Delete "$INSTDIR\uninstall-exui.exe"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)"
  DeleteRegKey HKLM "Software\NSIS\ExperienceUI"
  
  ; The goal here: completely clean up the ExperienceUI, but if
  ; there's other stuff, don't touch it
  
  ; Remember, only RmDir /r removes directories with files.
  ; Otherwise, it only removes fully empty directories.

  ; Contrib
  RmDir /r "$INSTDIR\Contrib\ExperienceUI"
  Delete "$INSTDIR\Contrib\Graphics\Icons\XPUI-install.ico"
  Delete "$INSTDIR\Contrib\Graphics\Icons\XPUI-uninstall.ico"
  RmDir  "$INSTDIR\Contrib\Graphics\Icons"
  RmDir  "$INSTDIR\Contrib\Graphics"
  RmDir  "$INSTDIR\Contrib"
  
  ; Docs
  RmDir /r "$INSTDIR\Docs\ExperienceUI"
  RmDir "$INSTDIR\Docs"
  
  ; Examples
  RmDir /r "$INSTDIR\Examples\ExperienceUI"
  RmDir "$INSTDIR\Examples"
  
  ; Include
  Delete "$INSTDIR\Include\NSISArray.nsh"
  Delete "$INSTDIR\Include\RecFind.nsh"
  Delete "$INSTDIR\Include\system.nsh"
  Delete "$INSTDIR\Include\XPUI.nsh"
  RmDir "$INSTDIR\Include"
  
  ; Plugins
  Delete "$INSTDIR\Plugins\DcryptDll.dll"
  Delete "$INSTDIR\Plugins\messagebox.dll"
  Delete "$INSTDIR\Plugins\newadvsplash.dll"
  Delete "$INSTDIR\Plugins\NSISArray.dll"
  Delete "$INSTDIR\Plugins\WAnsis.dll"
  Delete "$INSTDIR\Plugins\ZipDLL.dll"
  RmDir "$INSTDIR\Plugins"
  
  RmDir "$INSTDIR"
  
  ClearErrors
  ReadRegStr $0 HKLM "Software\NSIS" ""
  IfErrors +2
    Return
    
  Delete "$0\Include\XPUI.nsh"
  
SectionEnd