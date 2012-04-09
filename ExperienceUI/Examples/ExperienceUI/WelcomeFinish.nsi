;ExperienceUI for NSIS
;Welcome/Finish Page Example Script
;Written by Dan Fuhry

;OK, I cheated, Joost wrote it :)

;This script has been tested to compile with the Modern UI, ExperienceUI,
;UltraModernUI, and InstallSpider UI.  All compiled w/o warnings.

;!define XPUI_VERBOSE 4

;--------------------------------
;Include ExperienceUI

  !define XPUI_SKIN "Windows XP"
  !define XPUI_DISABLEBG
  !define UI "XPUI"
  !include "XPUI.nsh"

;--------------------------------
;General

  ;Name and file
  Name "ExperienceUI Test"
  OutFile "WelcomeFinish.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\ExperienceUI Test"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\ExperienceUI Test" ""

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING
  
;--------------------------------
;Pages

  !insertmacro ${UI}_PAGE_WELCOME
  !insertmacro ${UI}_PAGE_LICENSE "${XPUI_SYSDIR}\License.rtf"
  !ifdef XPUI_INCLUDED
  !define ${UI}_FINISHPAGE_RUN        "$SYSDIR\Write.exe"
  !define ${UI}_FINISHPAGE_RUN_FILE   "$SYSDIR\Write.exe"
  !define ${UI}_FINISHPAGE_DOCS       "$SYSDIR\Write.exe"
  !define ${UI}_FINISHPAGE_DOCS_FILE  "$SYSDIR\Write.exe"
  !endif
  !insertmacro ${UI}_PAGE_FINISH
  !ifdef XPUI_INCLUDED
  !insertmacro ${UI}_PAGE_WELCOME2
  !endif
  !insertmacro ${UI}_PAGE_COMPONENTS
  !insertmacro ${UI}_PAGE_DIRECTORY
  !insertmacro ${UI}_PAGE_INSTFILES
  !ifdef XPUI_INCLUDED
  !define ${UI}_FINISHPAGE_RUN        "$WINDIR\Notepad.exe"
  !define ${UI}_FINISHPAGE_RUN_FILE   "$WINDIR\Notepad.exe"
  !define ${UI}_FINISHPAGE_DOCS       "$WINDIR\Notepad.exe"
  !define ${UI}_FINISHPAGE_DOCS_FILE  "$WINDIR\Notepad.exe"
  !endif
  !define MUI_PAGE_ABORT
  !insertmacro ${UI}_PAGE_FINISH
  
  !ifdef XPUI_VERSION
    !insertmacro XPUI_PAGE_ABORT
  !endif

  !ifdef XPUI_VERSION
    !insertmacro XPUI_PAGEMODE_UNINST
    !insertmacro XPUI_PAGE_WELCOME
    !insertmacro XPUI_PAGE_UNINSTCONFIRM_NSIS
    !insertmacro XPUI_PAGE_INSTFILES
    !define ${UI}_UNFINISHPAGE_RUN        "$WINDIR\Notepad.exe"
    !define ${UI}_UNFINISHPAGE_RUN_FILE   "$WINDIR\Notepad.exe"
    !define ${UI}_UNFINISHPAGE_DOCS       "$WINDIR\Notepad.exe"
    !define ${UI}_UNFINISHPAGE_DOCS_FILE  "$WINDIR\Notepad.exe"
    !insertmacro XPUI_PAGE_FINISH
    !insertmacro XPUI_PAGE_ABORT
  !else
    !insertmacro MUI_UNPAGE_WELCOME
    !insertmacro MUI_UNPAGE_CONFIRM
    !insertmacro MUI_UNPAGE_INSTFILES
    !insertmacro MUI_UNPAGE_FINISH
  !endif
  
  !ifdef XPUI_VERSION
    !insertmacro XPUI_PAGE_ABORT
  !endif
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
  
  ;Store installation folder
  WriteRegStr HKCU "Software\ExperienceUI Test" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecDummy ${LANG_ENGLISH} "A test section."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END
 
;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\Uninstall.exe"

  RMDir "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\ExperienceUI Test"

SectionEnd  

;--------------------------------
; InstallSpider settings

  Function .onInit
    !ifmacrodef MUI_SHOWBANNER
      !insertmacro MUI_SHOWBANNER
      StrCpy $0 0
      loop:
        IntOp $0 $0 + 1
        !insertmacro MUI_SETPOS $0
        Sleep 20
        IntCmp $0 100 +2 0 +2
        Goto loop
      !insertmacro MUI_DESTROYBANNER
      !insertmacro MUI_UNLOAD_DLL
    !endif
  FunctionEnd