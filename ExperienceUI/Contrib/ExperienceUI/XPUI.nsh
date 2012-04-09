; NSIS ExperienceUI User Interface version 1.3.2
; Macro System and Main Logic
; Written by Dan Fuhry

; Copyright © 2004-2009 Dan Fuhry
; Portions written by Joost Verburg
; Copyright © 2002-2004 Joost Verburg

; This program is free software; you redistribute and/or modify it
; under the terms of the zlib/libpng license.

; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; merchantability or fitness for a particular purpose.  See the
; zlib/libpng license for details.

; You should have received a copy of the zlib/libpng license with
; this program; if not, visit http://xpui.sf.net/docs/?start=legal.htm.

!ifdef XPUI_INCLUDED
!warning `The ExperienceUI was included multiple times. Please include it only once in your script.`
!endif

!ifndef XPUI_INCLUDED

; We're in. Set verbosity.

!ifndef XPUI_VERBOSE
  !define XPUI_VERBOSE 1
!endif

!verbose push
!verbose ${XPUI_VERBOSE}

!define XPUI_INCLUDED
!define XPUI_VERSION 1.3.2

!ifndef XPUI_SYSDIR
  !define XPUI_SYSDIR "${NSISDIR}\Contrib\ExperienceUI"
!endif

; Add include and plugin directories
!addincludedir "${XPUI_SYSDIR}\..\..\Include"
!addplugindir "${XPUI_SYSDIR}\..\..\Plugins"

; Do some pretty stuff

!verbose 4

; my infamous (new) ASCII art
!ifndef XPUI_SILENT
!echo "\
+-----------------------------------------------------------------------------+$\n\
|                                                                             |$\n\
| |¯¯¯¯¯¯¯|                         _                           |¯|  |¯| |¯|  |$\n\
| | |¯¯¯¯¯                         |_|                          | |  | | | |  |$\n\
| |  ¯¯¯|   _  _        ___   ___   _   ___   ____    ____  ___ | |  | | | |  |$\n\
| | |¯¯¯    \\// |¯¯¯\ / __\ |  _| | | / __\ |  _  \ / __/ / __\| |__| | | |  |$\n\
| |  ¯¯¯¯¯| //\\ | __/ \___/ |_|   |_| \___/ |_| |_| \___\ \___/\______/ |_|  |$\n\
|  ¯¯¯¯¯¯¯  ¯  ¯ |_|                                  [ A better installer ]  |$\n\
+-----------------------------------------------------------------------------+$\n"

!echo `NSIS ExperienceUI User Interface version ${XPUI_VERSION}   $\n\
       Copyright © 2004-2009 Dan Fuhry                            $\n\
                                                                  $\n\
       Portions written by Joost Verburg                          $\n\
       Copyright © 2002-2004 Joost Verburg                        $\n\
                                                                  $\n\
       XPUI: Processing XPUI code...                       $\n`

!endif

!verbose ${XPUI_VERBOSE}

; Compiler check

!define XPUI_NSIS_REQUIRED_FLAGS "NSIS_CONFIG_VISIBLE_SUPPORT | \
                                  NSIS_CONFIG_ENHANCEDUI_SUPPORT | \
                                  NSIS_SUPPORT_CODECALLBACKS | \
                                  NSIS_SUPPORT_INTOPTS | \
                                  NSIS_SUPPORT_STROPTS | \
                                  NSIS_SUPPORT_STACK | \
                                  NSIS_SUPPORT_INIFILES | \
                                  NSIS_SUPPORT_EXECUTE | \
                                  NSIS_SUPPORT_FILE | \
                                  NSIS_SUPPORT_DELETE | \
                                  NSIS_SUPPORT_MESSAGEBOX | \
                                  NSIS_CONFIG_PLUGIN_SUPPORT"

  !ifndef ${XPUI_NSIS_REQUIRED_FLAGS}
          
    !verbose 4
    !error   "$\n  ExperienceUI: FATAL: MakeNSIS was compiled without certain options that are required in order for the \
                ExperienceUI to work.$\n  The compiler options required in order for core ExperienceUI functionality are: \
                ${XPUI_NSIS_REQUIRED_FLAGS}.$\n  Please remove the ExperienceUI from your script or recompile NSIS to \
                support these features."
  !endif
  
; Variables
  
Var /GLOBAL XPUI_TEMP1
Var /GLOBAL XPUI_TEMP2
Var /GLOBAL XPUI_ABORTED
Var /GLOBAL XPUI_HWND
Var /GLOBAL XPUI_NOABORTWARNING

; Basic macros

!macro XPUI_DEFAULT S V
  !ifndef `${S}`
    !define `${S}` `${V}`
  !endif
!macroend

!macro XPUI_SET S V
  !ifdef `${S}`
    !undef `${S}`
  !endif
  !define `${S}` `${V}`
!macroend

!macro XPUI_UNSET S
  !ifdef `${S}`
    !undef `${S}`
  !endif
!macroend

!macro MUI_DEFAULT S V
  !ifndef `${S}`
    !define `${S}` `${V}`
  !endif
!macroend

!macro XPUI_SET_QUOTE_ALT SYMBOL CONTENT
  !ifdef "${SYMBOL}"
    !undef "${SYMBOL}"
  !endif
  !define "${SYMBOL}" "${CONTENT}"
!macroEnd

!macro XPUI_CREATEID

  !ifndef XPUI_UNIQUEID
    !define XPUI_UNIQUEID ${__LINE__}
  !endif

  !ifdef XPUI_UNIQUEID
    !undef XPUI_UNIQUEID
    !define XPUI_UNIQUEID ${__LINE__}
  !endif

!macroend

!macro XPUI_CONVERT XPUI MUI

  !ifdef ${MUI}
    !insertmacro XPUI_SET ${XPUI} `${${MUI}}`
    !undef ${MUI}
  !endif

!macroend

!macro XPUI_CONVERT_QUOTE_ALT XPUI MUI

  !ifdef ${MUI}
    !insertmacro XPUI_SET_QUOTE_ALT ${XPUI} "${${MUI}}"
  !endif

!macroend

!macro XPUI_CONTROL_SKIN HWND
  !ifdef XPUI_FASTERSKINNING
    SetCtlColors ${HWND} `${XPUI_TEXT_COLOR}` `${XPUI_TEXT_BGCOLOR}`
  !else
  !ifdef XPUI_INTERNAL_INTERFACE_INSERTED
    SetCtlColors ${HWND} `${XPUI_TEXT_COLOR}` `${XPUI_TEXT_BGCOLOR}`
  !else
    !ifndef XPUI_EXTERNAL_SKINNER
      Push "${HWND}"
      Call ${XPUI_UNFUNC}xpui.SkinControl
      Pop "${HWND}"
    !endif
  !endif
  !endif
!macroend

!macro XPUI_CONTROL_SKIN_LIGHT HWND
  !ifdef XPUI_FASTERSKINNING
    SetCtlColors ${HWND} `${XPUI_TEXT_LIGHTCOLOR}` `${XPUI_TEXT_BGCOLOR}`
  !else
  !ifdef XPUI_INTERNAL_INTERFACE_INSERTED
    SetCtlColors ${HWND} `${XPUI_TEXT_LIGHTCOLOR}` `${XPUI_TEXT_BGCOLOR}`
  !else
  !ifndef XPUI_EXTERNAL_SKINNER
  Push "${HWND}"
  Call ${XPUI_UNFUNC}xpui.SkinControl.light
  Pop "${HWND}"
  !endif
  !endif
  !endif
!macroend

!macro XPUI_CONTROL_SKIN_TRANS HWND
  !ifdef XPUI_FASTERSKINNING
    SetCtlColors ${HWND} `${XPUI_TEXT_COLOR}` `Transparent`
  !else
  !ifdef XPUI_INTERNAL_INTERFACE_INSERTED
    SetCtlColors ${HWND} `${XPUI_TEXT_COLOR}` `Transparent`
  !else
  !ifndef XPUI_EXTERNAL_SKINNER
  Push "${HWND}"
  Call ${XPUI_UNFUNC}xpui.SkinControl.trans
  Pop "${HWND}"
  !endif
  !endif
  !endif
!macroend

!macro XPUI_CONTROL_SKIN_LIGHT_TRANS HWND
  !ifdef XPUI_FASTERSKINNING
    SetCtlColors ${HWND} `${XPUI_TEXT_LIGHTCOLOR}` `Transparent`
  !else
  !ifdef XPUI_INTERNAL_INTERFACE_INSERTED
    SetCtlColors ${HWND} `${XPUI_TEXT_LIGHTCOLOR}` `Transparent`
  !else
  !ifndef XPUI_EXTERNAL_SKINNER  
  Push "${HWND}"
  Call ${XPUI_UNFUNC}xpui.SkinControl.light.trans
  Pop "${HWND}"
  !endif
  !endif
  !endif
!macroend

!macro XPUI_PAGE_CUSTOMFUNCTION Z

  !ifdef XPUI_PAGE_CUSTOMFUNCTION_${Z}
    Call `${XPUI_PAGE_CUSTOMFUNCTION_${Z}}`
    !undef XPUI_PAGE_CUSTOMFUNCTION_${Z}
  !endif
  
  ; Modern UI Compatible
  !ifdef MUI_PAGE_CUSTOMFUNCTION_${Z}
    Call `${MUI_PAGE_CUSTOMFUNCTION_${Z}}`
    !undef MUI_PAGE_CUSTOMFUNCTION_${Z}
  !endif
  
!macroend

!macro XPUI_CONTROL_SKIN_PAGE HWND
  
  !ifndef XPUI_EXTERNAL_SKINNER
    !ifndef XPUI_BGIMAGE
      !insertmacro XPUI_CONTROL_SKIN ${HWND}
    !else
      !insertmacro XPUI_CONTROL_SKIN_TRANS ${HWND}
    !endif
  !endif
  
!macroend

!macro XPUI_CONTROL_SKIN_PAGE_NOTRANS HWND
  
  !ifndef XPUI_EXTERNAL_SKINNER
    !insertmacro XPUI_CONTROL_SKIN ${HWND}
  !endif
  
!macroend

!macro XPUI_PAGECOLOR_INIT ID

  Push $XPUI_HWND
  FindWindow $XPUI_HWND "#32770" "" $HWNDPARENT
  GetDlgItem $XPUI_HWND $XPUI_HWND ${ID}
  !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_HWND
  Pop $XPUI_HWND

!macroend

!macro XPUI_PAGEMODE_INST
  !echo `XPUI Page Mode: INSTALL`
  !insertmacro XPUI_SET XPUI_PAGEMODE_INSERTED ``
  !insertmacro XPUI_SET XPUI_UN ``
  !insertmacro XPUI_SET XPUI_UNINST ``
  !insertmacro XPUI_SET XPUI_UNFUNC ``
  !insertmacro XPUI_SET XPUI_PAGEMODE `Install`
!macroend

!macro XPUI_PAGEMODE_UNINST
  !echo `XPUI Page Mode: UNINSTALL`
  !insertmacro XPUI_SET XPUI_PAGEMODE_INSERTED ``
  !insertmacro XPUI_SET XPUI_UN `UN`
  !insertmacro XPUI_SET XPUI_UNINST `Uninst`
  !insertmacro XPUI_SET XPUI_UNFUNC `un.`
  !insertmacro XPUI_SET XPUI_PAGEMODE `Uninstall`
  
  !ifndef XPUI_UNINSTALLER
    !define XPUI_UNINSTALLER
  !endif
!macroend

!macro XPUI_PAGEMODE_PUSH
  !insertmacro XPUI_SET XPUI_UN_PUSHED "${XPUI_UN}"
  !insertmacro XPUI_SET XPUI_UNINST_PUSHED "${XPUI_UNINST}"
  !insertmacro XPUI_SET XPUI_UNFUNC_PUSHED "${XPUI_UNFUNC}"
!macroend

!macro XPUI_PAGEMODE_POP
  !insertmacro XPUI_SET XPUI_UN "${XPUI_UN_PUSHED}"
  !insertmacro XPUI_SET XPUI_UNINST "${XPUI_UNINST_PUSHED}"
  !insertmacro XPUI_SET XPUI_UNFUNC "${XPUI_UNFUNC_PUSHED}"
!macroend

!macro XPUI_HEADER_TEXT T S
  Push $XPUI_TEMP1
  GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1037
  SendMessage $XPUI_TEMP1 0xC 0 `STR:${T}`
  GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1038
  SendMessage $XPUI_TEMP1 0xC 0 `STR:${S}`
  !ifdef TEMP
    !define TEMP_PUSH `${TEMP}`
    !undef TEMP
  !endif
  !ifdef XPUI_HEADERIMAGE_NORESIZETOFIT
    !define TEMP " "
  !else
    !define TEMP /RESIZETOFIT
  !endif
  !ifndef XPUI_BGIMAGE
  SetBrandingImage /IMGID=1046 ${TEMP} "$PLUGINSDIR\Header.bmp" ; ...finally...
  !else
  SetBrandingImage /IMGID=1099 ${TEMP} "$PLUGINSDIR\BgImage.bmp"
  !endif
  !undef TEMP
  !ifdef TEMP_PUSH
    !define TEMP `${TEMP_PUSH}`
    !undef TEMP_PUSH
  !endif
  Pop $XPUI_TEMP1
!macroend

!macro XPUI_USERABORT
  StrCmp $XPUI_NOABORTWARNING 1 +7
  IfFileExists $PLUGINSDIR\Finish.ini `` +3
  WriteINIStr $PLUGINSDIR\Finish.ini `Field 1` State 0
  WriteINIStr $PLUGINSDIR\Finish.ini `Field 2` State 0
  StrCpy $XPUI_ABORTED 1
  SendMessage $HWNDPARENT `0x408` `1` ``
  Abort
!macroend

!macro XPUI_INNERDIALOG_TEXT TEXT ID

  Push $XPUI_HWND
  FindWindow $XPUI_HWND "#32770" "" $HWNDPARENT
  GetDlgItem $XPUI_HWND $XPUI_HWND `${ID}`
  SendMessage $XPUI_HWND 0xC 0 `STR:${TEXT}`
  Pop $XPUI_HWND

!macroend

!ifdef XPUI_WANSIS
  !ifndef XPUI_EXTERNAL_SKINNER
    !define XPUI_EXTERNAL_SKINNER
  !endif
!endif

; Install Options

!insertmacro XPUI_DEFAULT XPUI_INSTALLOPTIONS_MAXFIELD 1250

!macro XPUI_INSTALLOPTIONS_EXTRACT FILE
  !verbose push
  !verbose ${XPUI_VERBOSE}
  InitPluginsDir
  IfFileExists "$PLUGINSDIR\${FILE}" +2
    File `/oname=$PLUGINSDIR\${FILE}` `${FILE}`
  
  !insertmacro XPUI_INSTALLOPTIONS_WRITE `${FILE}` `Settings` `RTL` `$(^RTL)`
  !verbose pop
!macroend

!macro XPUI_INSTALLOPTIONS_EXTRACT_AS FILE FILENAME
  !verbose push
  !verbose ${XPUI_VERBOSE}
  InitPluginsDir
  IfFileExists "$PLUGINSDIR\${FILENAME}" +2
    File `/oname=$PLUGINSDIR\${FILENAME}` `${FILE}`
    
  !insertmacro XPUI_INSTALLOPTIONS_WRITE `${FILENAME}` `Settings` `RTL` `$(^RTL)`
  !verbose pop
!macroend

!macro XPUI_INSTALLOPTIONS_DISPLAY FILE
  !verbose push
  !verbose ${XPUI_VERBOSE}
  !insertmacro XPUI_CREATEID
  StrCmp $XPUI_ABORTED 1 `` +2
  Abort
  WriteINIStr `$PLUGINSDIR\${FILE}` `Settings` `RTL` `$(^RTL)`

  !insertmacro XPUI_INSTALLOPTIONS_INITDIALOG `${FILE}`
  InstallOptions::show
  !verbose pop
!macroend

!macro XPUI_INSTALLOPTIONS_DISPLAY_RETURN FILE
  !verbose push
  !verbose ${XPUI_VERBOSE}
  !insertmacro XPUI_CREATEID
  StrCmp $XPUI_ABORTED 1 `` +2
  Abort
  WriteINIStr `$PLUGINSDIR\${FILE}` `Settings` `RTL` `$(^RTL)`

  !insertmacro XPUI_INSTALLOPTIONS_INITDIALOG `${FILE}` 
  InstallOptions::show
  !verbose pop
!macroend

!macro XPUI_INSTALLOPTIONS_INITDIALOG FILE
  !verbose push
  !verbose ${XPUI_VERBOSE}
  !insertmacro XPUI_CREATEID
  StrCmp $XPUI_ABORTED 1 `` +2
  Abort
  WriteINIStr `$PLUGINSDIR\${FILE}` `Settings` `RTL` `$(^RTL)`
  InstallOptions::initDialog /NOUNLOAD `$PLUGINSDIR\${FILE}`
  Pop $XPUI_HWND
  LockWindow on
  !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_HWND
  
  Push $R0
  Push $R1
  
  StrCpy $R0 0
  StrCpy $R1 1199
  
  ; $R0 = field count
  ; $R1 = control count
  ; $XPUI_TEMP2 = total field count
  
  ReadINIStr $XPUI_TEMP2 `$PLUGINSDIR\${FILE}` "Settings" "NumFields"
  
  XPUI.loop.setctl.${XPUI_UNIQUEID}:
    
    IntOp $R0 $R0 + 1
    IntOp $R1 $R1 + 1
    
    ReadINIStr $XPUI_TEMP1 `$PLUGINSDIR\${FILE}` "Field $R0" "Type"
    StrCmp $XPUI_TEMP1 "Text"        XPUI.SkinNoTrans.${XPUI_UNIQUEID}
    StrCmp $XPUI_TEMP1 "Password"    XPUI.SkinNoTrans.${XPUI_UNIQUEID}
    StrCmp $XPUI_TEMP1 "Listbox"     XPUI.SkinNoTrans.${XPUI_UNIQUEID}
    StrCmp $XPUI_TEMP1 "Combobox"    XPUI.SkinNoTrans.${XPUI_UNIQUEID}
    StrCmp $XPUI_TEMP1 "Droplist"    XPUI.SkinNoTrans.${XPUI_UNIQUEID}
    
    StrCmp $XPUI_TEMP1 "FileRequest" XPUI.SkinMulti.${XPUI_UNIQUEID}
    StrCmp $XPUI_TEMP1 "DirRequest"  XPUI.SkinMulti.${XPUI_UNIQUEID}
    
      GetDlgItem $XPUI_TEMP1 $XPUI_HWND $R1
      !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
      Goto XPUI.SkinDone.${XPUI_UNIQUEID}
      
    XPUI.SkinNoTrans.${XPUI_UNIQUEID}:
      GetDlgItem $XPUI_TEMP1 $XPUI_HWND $R1
      !insertmacro XPUI_CONTROL_SKIN_PAGE_NOTRANS $XPUI_TEMP1
      Goto XPUI.SkinDone.${XPUI_UNIQUEID}
      
    XPUI.SkinMulti.${XPUI_UNIQUEID}:
      GetDlgItem $XPUI_TEMP1 $XPUI_HWND $R1
      !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
      IntOp $R1 $R1 + 1
      GetDlgItem $XPUI_TEMP1 $XPUI_HWND $R1
      !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
      Goto XPUI.SkinDone.${XPUI_UNIQUEID}
    
    XPUI.SkinDone.${XPUI_UNIQUEID}:
    
    IntCmp $R0 $XPUI_TEMP1 0 XPUI.loop.setctl.${XPUI_UNIQUEID}
    
  Pop $R1
  Pop $R0
    
  SetBrandingImage /IMGID=1019 /RESIZETOFIT "$PLUGINSDIR\page.bmp"
  LockWindow off
  Push $XPUI_HWND
  !verbose pop
!macroend

!macro XPUI_INSTALLOPTIONS_SHOW

  !verbose push
  !verbose ${XPUI_VERBOSE}
  InstallOptions::show
  Pop $XPUI_TEMP1
  !verbose pop
!macroend

!macro XPUI_INSTALLOPTIONS_SHOW_RETURN

  !verbose push
  !verbose ${XPUI_VERBOSE}
  InstallOptions::show
  !verbose pop
!macroend

!macro XPUI_INSTALLOPTIONS_READ VAR FILE SECTION KEY
  !verbose push
  !verbose ${XPUI_VERBOSE}
  ReadIniStr ${VAR} `$PLUGINSDIR\${FILE}` `${SECTION}` `${KEY}`
  !verbose pop
!macroend

!macro XPUI_INSTALLOPTIONS_WRITE FILE SECTION KEY VALUE

  !verbose push
  !verbose ${XPUI_VERBOSE}
  WriteIniStr `$PLUGINSDIR\${FILE}` `${SECTION}` `${KEY}` `${VALUE}`
  !verbose pop
!macroend

!macro XPUI_RESERVEFILE_INSTALLOPTIONS
  !verbose push
  !verbose ${XPUI_VERBOSE}
  ReserveFile `${NSISDIR}\Plugins\InstallOptions.dll`
  !verbose pop
!macroend

!macro MUI_INSTALLOPTIONS_EXTRACT F
  !insertmacro XPUI_INSTALLOPTIONS_EXTRACT `${F}`
!macroend

!macro MUI_INSTALLOPTIONS_EXTRACT_AS O N
  !insertmacro XPUI_INSTALLOPTIONS_EXTRACT_AS `${O}` `${N}`
!macroend

!macro MUI_INSTALLOPTIONS_DISPLAY F
  !insertmacro XPUI_INSTALLOPTIONS_DISPLAY `${F}`
!macroend

!macro MUI_INSTALLOPTIONS_DISPLAY_RETURN F
  !insertmacro XPUI_INSTALLOPTIONS_DISPLAY_RETURN `${F}`
!macroend

!macro MUI_INSTALLOPTIONS_INITDIALOG F
  !insertmacro XPUI_INSTALLOPTIONS_INITDIALOG `${F}`
!macroend

!macro MUI_INSTALLOPTIONS_SHOW
  !insertmacro XPUI_INSTALLOPTIONS_SHOW
!macroend

!macro MUI_INSTALLOPTIONS_SHOW_RETURN
  !insertmacro XPUI_INSTALLOPTIONS_SHOW_RETURN
!macroend

!macro MUI_INSTALLOPTIONS_READ VAR FILE SECTION KEY
  !verbose push
  !verbose ${XPUI_VERBOSE}
  ReadIniStr ${VAR} `$PLUGINSDIR\${FILE}` `${SECTION}` `${KEY}`
  !verbose pop
!macroend

!macro MUI_INSTALLOPTIONS_WRITE FILE SECTION KEY VALUE

  !verbose push
  !verbose ${XPUI_VERBOSE}
  WriteIniStr `$PLUGINSDIR\${FILE}` `${SECTION}` `${KEY}` `${VALUE}`
  !verbose pop
!macroend

!macro MUI_RESERVEFILE_INSTALLOPTIONS
  !verbose push
  !verbose ${XPUI_VERBOSE}
  ReserveFile `${NSISDIR}\Plugins\InstallOptions.dll`
  !verbose pop
!macroend

; Interface - Compile time settings

!insertmacro XPUI_DEFAULT XPUI_UI          "${XPUI_SYSDIR}\UIs\UI.exe"

ChangeUI all `${XPUI_UI}`

!ifdef XPUI_WANSIS
  !ifndef XPUI_EXTERNAL_SKINNER
  !define XPUI_EXTERNAL_SKINNER
  !endif
!endif

!ifdef XPUI_BGIMAGE & XPUI_WANSIS
  !verbose push
  !verbose 4
  !warning "ExperienceUI: WARNING: The set of visual features you defined for the installer - XPUI_WANSIS and XPUI_BGIMAGE - does not work.  The ExperienceUI will use WAnsis support only."
  !undef XPUI_BGIMAGE
  !verbose pop
!endif

; Interface - Runtime Settings

!macro XPUI_INTERFACE

  ; Defaults
  
  ; Skin Includes
  !ifdef XPUI_SKIN
    !ifndef XPUI_SKIN_INCLUDED
    !define XPUI_SKIN_INCLUDED
    !verbose push
    !verbose 3 ; Allow errors to be exposed
    !include "${XPUI_SYSDIR}\Skins\${XPUI_SKIN}.xpuiskin"
    !verbose pop
    !endif
  !endif
  
  ; We'll just assume that if the user defined UMUI_SKIN he wants a UMUI-style installer
  !ifdef UMUI_SKIN
    !include "${NSISDIR}\Contrib\UltraModernUI\Skins\${UMUI_SKIN}.nsh"
    !insertmacro XPUI_LANGUAGE_CONVERT
  !endif
  
  !ifdef XPUI_BGIMAGE & XPUI_WANSIS
    !verbose 4
    !warning "ExperienceUI: WARNING: The set of visual features you defined for the installer - XPUI_WANSIS and XPUI_BGIMAGE - does not work.  The ExperienceUI will use WAnsis support only."
    !undef XPUI_BGIMAGE
  !endif
  
  ; WAnsis settings
  !ifdef XPUI_WANSIS
    !insertmacro XPUI_DEFAULT XPUI_WANSIS_SKIN Forum
    !insertmacro XPUI_DEFAULT XPUI_LEFTLOGO               `${XPUI_SYSDIR}\Skins\${XPUI_WANSIS_SKIN}\LeftLogo.bmp`
    !insertmacro XPUI_DEFAULT XPUI_BOTTOMIMAGE            ``
    !insertmacro XPUI_DEFAULT XPUI_UNBOTTOMIMAGE          ``
    !insertmacro XPUI_DEFAULT XPUI_BOTTOMIMAGE_BMP        `${XPUI_SYSDIR}\Skins\${XPUI_WANSIS_SKIN}\Bottom.bmp`
    !insertmacro XPUI_DEFAULT XPUI_WANSIS_GEN             `${XPUI_SYSDIR}\Skins\${XPUI_WANSIS_SKIN}\gen.bmp`
    !insertmacro XPUI_DEFAULT XPUI_WANSIS_GENEX           `${XPUI_SYSDIR}\Skins\${XPUI_WANSIS_SKIN}\genex.bmp`
    !insertmacro XPUI_DEFAULT XPUI_WANSIS_HEADERIMAGE_BMP `${XPUI_SYSDIR}\Skins\${XPUI_WANSIS_SKIN}\header.bmp`
    !insertmacro XPUI_DEFAULT XPUI_WANSIS_CHECKS          `${XPUI_SYSDIR}\Skins\${XPUI_WANSIS_SKIN}\checks.bmp`
    
    !insertmacro XPUI_DEFAULT XPUI_WANSIS_UI              `${XPUI_SYSDIR}\UIs\WAnsis_UI.exe`
    
    ChangeUI all `${XPUI_WANSIS_UI}`
    CheckBitmap `${XPUI_WANSIS_CHECKS}`
    
    !ifndef XPUI_EXTERNAL_SKINNER
      !define XPUI_EXTERNAL_SKINNER
    !endif
    
    !warning "ExperienceUI: WARNING: WAnsis has been known to be unstable with certain configurations."
    
  !endif
  
  ; Interface Colors
  !insertmacro XPUI_DEFAULT XPUI_TEXT_COLOR `0xB4D3EA`
  !insertmacro XPUI_DEFAULT XPUI_TEXT_BGCOLOR `0x566978`
  !insertmacro XPUI_DEFAULT XPUI_TEXT_LIGHTCOLOR `0xFFFFFF`
  
  !insertmacro XPUI_DEFAULT XPUI_HEADER_TEXT_COLOR "${XPUI_TEXT_COLOR}"
  
  ; Icons
  !insertmacro XPUI_DEFAULT XPUI_ICON `${XPUI_SYSDIR}\..\Graphics\Icons\XPUI-install.ico`
  !insertmacro XPUI_DEFAULT XPUI_UNICON `${XPUI_SYSDIR}\..\Graphics\Icons\XPUI-uninstall.ico`

  !ifdef XPUI_ICON
  Icon `${XPUI_ICON}`
  !Endif

  !ifdef XPUI_UNICON
  UninstallIcon `${XPUI_UNICON}`
  !Endif
  
  ; Check bitmap
  !ifndef XPUI_WANSIS
    !insertmacro XPUI_DEFAULT XPUI_CHECKBITMAP "${NSISDIR}\Contrib\Graphics\Checks\modern.bmp"
    CheckBitmap "${XPUI_CHECKBITMAP}"
  !endif
  
  ; Header image
  !insertmacro XPUI_DEFAULT XPUI_HEADERIMAGE `${XPUI_SYSDIR}\Skins\Default\Header.bmp`
  !insertmacro XPUI_DEFAULT XPUI_UNHEADERIMAGE `${XPUI_HEADERIMAGE}`

  ; Left Logo
  !insertmacro XPUI_DEFAULT XPUI_LEFTLOGO `${XPUI_SYSDIR}\Skins\Default\LeftBranding.bmp`
  !insertmacro XPUI_DEFAULT XPUI_UNLEFTLOGO `${XPUI_LEFTLOGO}`

  ; Bottom Image
  
  !ifndef XPUI_BOTTOMIMAGE
    !define XPUI_BOTTOMIMAGE
  !endif
  !ifdef XPUI_NOBOTTOMIMAGE
    !undef XPUI_BOTTOMIMAGE
  !endif

  !ifndef XPUI_UNBOTTOMIMAGE
    !define XPUI_UNBOTTOMIMAGE
  !endif
  !ifdef XPUI_NOUNBOTTOMIMAGE
    !undef XPUI_UNBOTTOMIMAGE
  !endif
  
  !ifdef XPUI_BGIMAGE
    !ifndef XPUI_BOTTOMIMAGE
      !define XPUI_NOBOTTOMIMAGE
    !endif
    !ifndef XPUI_COMPONENTSPAGE_NODESC
      !define XPUI_COMPONENTSPAGE_NODESC
    !endif
  !endif
  
  !insertmacro XPUI_DEFAULT XPUI_BOTTOMIMAGE_BMP `${XPUI_SYSDIR}\Skins\Default\Bottom.bmp`
  !insertmacro XPUI_DEFAULT XPUI_UNBOTTOMIMAGE_BMP `${XPUI_BOTTOMIMAGE_BMP}`
  
  !ifdef XPUI_BGIMAGE
    !insertmacro XPUI_DEFAULT XPUI_BGIMAGE_BMP "${XPUI_SYSDIR}\Skins\Default\BgImage.bmp"
    !insertmacro XPUI_DEFAULT XPUI_BGIMAGE_UI  "${XPUI_SYSDIR}\UIs\BGui.exe"
    ChangeUI all `${XPUI_BGIMAGE_UI}`
  !endif

  ; Branding Text
  !insertmacro XPUI_DEFAULT XPUI_BRANDINGTEXT ` `
  !insertmacro XPUI_DEFAULT XPUI_BRANDINGTEXT_COLOR_FG 606060
  !insertmacro XPUI_DEFAULT XPUI_BRANDINGTEXT_COLOR_BG 808080
  
  ; BG Gradient
  !ifndef XPUI_DISABLEBG
    !ifdef XPUI_BGGRADIENT
      !ifndef XPUI_BGGRADIENT_CUSTOMCOLORS
        BGGradient ${XPUI_TEXT_COLOR} ${XPUI_TEXT_BGCOLOR} ${XPUI_TEXT_LIGHTCOLOR}
      !endif
    !ifdef XPUI_BGGRADIENT_CUSTOMCOLORS
      !insertmacro XPUI_DEFAULT XPUI_BGGRADIENT_CUSTOMCOLORS_TOP `${XPUI_TEXT_COLOR}`
      !insertmacro XPUI_DEFAULT XPUI_BGGRADIENT_CUSTOMCOLORS_BOTTOM `${XPUI_TEXT_BGCOLOR}`
        !insertmacro XPUI_DEFAULT XPUI_BGGRADIENT_CUSTOMCOLORS_TEXT `${XPUI_TEXT_LIGHTCOLOR}`
        BGGradient `${XPUI_BGGRADIENT_CUSTOMCOLORS_TOP}` `${XPUI_BGGRADIENT_CUSTOMCOLORS_BOTTOM}` `${XPUI_BGGRADIENT_CUSTOMCOLORS_TEXT}`
      !endif
    !endif
  !endif
  
  ; Installer Attributes
  
  !ifdef XPUI_WANSIS
    XPStyle off
  !else
    XPStyle on
  !endif
  InstallColors `${XPUI_TEXT_COLOR}` `${XPUI_TEXT_BGCOLOR}`
  
  !insertmacro XPUI_DEFAULT XPUI_AUTOCLOSE false
  AutoCloseWindow ${XPUI_AUTOCLOSE}
  !insertmacro XPUI_DEFAULT XPUI_SHOWDETAILS show
  ShowInstDetails ${XPUI_SHOWDETAILS}
  
  ; Modern UI Compatibility
  !insertmacro XPUI_LANGUAGE_CONVERT
  
   !ifdef MUI_ABORTWARNING
  !ifndef XPUI_ABORTWARNING
  !define XPUI_ABORTWARNING
  !endif
  !endif
   !ifdef MUI_UNABORTWARNING
  !ifndef XPUI_UNABORTWARNING
  !define XPUI_UNABORTWARNING
  !endif
  !endif
  
  !ifndef XPUI_FASTERSKINNING
    !ifdef XPUI_INTERNAL_PAGEUSED_STARTMENU
      !insertmacro XPUI_STARTMENUPAGE_INITARRAY
    !endif
  !endif
  
  Function .onGUIInit
    !insertmacro XPUI_GUIINIT "" ""
  FunctionEnd
  
  !ifdef XPUI_UNINSTALLER
    Function un.onGUIInit
      !insertmacro XPUI_GUIINIT "UN" "un."
    FunctionEnd
  !endif

  !ifndef XPUI_FASTERSKINNING
    !ifdef XPUI_INTERNAL_PAGEUSED_STARTMENU
      !insertmacro XPUI_STARTMENUPAGE_INITARRAY
    !endif
  !endif
  
  Function .onGUIEnd
    LockWindow off
    !ifdef XPUI_WANSIS
      SetPluginUnload manual
      wansis::unskinit
    !endif
    
    !ifmacrodef XPUI_BGFILES_DELETE

        !ifdef XPUI_ENABLEBG

          !insertmacro XPUI_BGFILES_DELETE

        !endif

      !endif
      
  FunctionEnd
  
  !ifdef XPUI_UNINSTALLER
    Function un.onGUIEnd
      LockWindow off
      !ifdef XPUI_WANSIS
        SetPluginUnload manual
        wansis::unskinit
      !endif
      
     !ifmacrodef XPUI_BGFILES_DELETE

        !ifdef XPUI_ENABLEBG

          !insertmacro XPUI_BGFILES_DELETE

        !endif

      !endif
  
    FunctionEnd
  !endif
  
  !ifdef XPUI_ABORTWARNING

    Function .onUserAbort
    
      StrCmp $XPUI_NOABORTWARNING 1 xpui.exit

        MessageBox MB_YESNO|MB_ICONQUESTION "$(XPUI_ABORTWARNING_TEXT)" IDNO NoExit
        !insertmacro XPUI_USERABORT
        NoExit:
        Abort

      xpui.exit:
    
    FunctionEnd
  
  !endif
  
  !ifdef XPUI_ABORTWARNING & XPUI_UNINSTALLER
  
    Function un.onUserAbort

      StrCmp $XPUI_NOABORTWARNING 1 xpui.exit

        MessageBox MB_YESNO|MB_ICONQUESTION "$(XPUI_ABORTWARNING_TEXT)" IDNO NoExit
        !insertmacro XPUI_USERABORT
        NoExit:
        Abort

      xpui.exit:

    FunctionEnd

  !endif
  
  !ifdef XPUI_EXTERNAL_SKINNER | XPUI_FASTERSKINNING
  !else
  
    Function xpui.skinControl
      Exch "$XPUI_TEMP2"
      SetCtlColors $XPUI_TEMP2 "${XPUI_TEXT_COLOR}" "${XPUI_TEXT_BGCOLOR}"
      Exch "$XPUI_TEMP2"
    FunctionEnd
    
    Function xpui.skinControl.trans
      Exch "$XPUI_TEMP2"
      SetCtlColors $XPUI_TEMP2 "${XPUI_TEXT_COLOR}" "Transparent"
      Exch "$XPUI_TEMP2"
    FunctionEnd
    
    Function xpui.skinControl.light
      Exch "$XPUI_TEMP2"
      SetCtlColors $XPUI_TEMP2 "${XPUI_TEXT_LIGHTCOLOR}" "${XPUI_TEXT_BGCOLOR}"
      Exch "$XPUI_TEMP2"
    FunctionEnd
    
    Function xpui.skinControl.light.trans
      Exch "$XPUI_TEMP2"
      SetCtlColors $XPUI_TEMP2 "${XPUI_TEXT_LIGHTCOLOR}" "Transparent"
      Exch "$XPUI_TEMP2"
    FunctionEnd
    
    !ifdef XPUI_UNINSTALLER
  
      Function un.xpui.skinControl
        Exch "$XPUI_TEMP2"
        SetCtlColors $XPUI_TEMP2 "${XPUI_TEXT_COLOR}" "${XPUI_TEXT_BGCOLOR}"
        Exch "$XPUI_TEMP2"
      FunctionEnd
      
      Function un.xpui.skinControl.trans
        Exch "$XPUI_TEMP2"
        SetCtlColors $XPUI_TEMP2 "${XPUI_TEXT_COLOR}" "Transparent"
        Exch "$XPUI_TEMP2"
      FunctionEnd
      
      Function un.xpui.skinControl.light
        Exch "$XPUI_TEMP2"
        SetCtlColors $XPUI_TEMP2 "${XPUI_TEXT_LIGHTCOLOR}" "${XPUI_TEXT_BGCOLOR}"
        Exch "$XPUI_TEMP2"
      FunctionEnd
      
      Function un.xpui.skinControl.light.trans
        Exch "$XPUI_TEMP2"
        SetCtlColors $XPUI_TEMP2 "${XPUI_TEXT_LIGHTCOLOR}" "Transparent"
        Exch "$XPUI_TEMP2"
      FunctionEnd
    
    !endif
  
  !endif
  
!macroend

!macro XPUI_GUIINIT UN UNFUNC

  !insertmacro XPUI_PAGEMODE_PUSH
  !define XPUI_UNCHECK_${UN}
  !ifdef XPUI_UNCHECK_UN
    !insertmacro XPUI_PAGEMODE_UNINST
  !else
    !insertmacro XPUI_PAGEMODE_INST
  !endif
  !undef XPUI_UNCHECK_${UN}

  !ifndef XPUI_BGIMAGE
    InitPluginsDir
    SetOutPath $PLUGINSDIR
    File /oname=header.bmp "${XPUI_HEADERIMAGE}"
    !ifdef XPUI_BOTTOMIMAGE
    File /oname=btmimg.bmp "${XPUI_BOTTOMIMAGE_BMP}"
    !endif
    File /oname=leftimg.bmp "${XPUI_LEFTLOGO}"
  !else
    InitPluginsDir
    SetOutPath $PLUGINSDIR
    File /oname=BgImage.bmp "${XPUI_BGIMAGE_BMP}"
  !endif
  
  !ifndef XPUI_EXTERNAL_SKINNER  
    
    ; Skin the window background
    !ifndef XPUI_BGIMAGE
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1099
    !insertmacro XPUI_CONTROL_SKIN $XPUI_TEMP1
    !endif
    
    !ifdef XPUI_BOTTOMIMAGE
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1045
      ShowWindow $XPUI_TEMP1 0
    !else
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1039
      ShowWindow $XPUI_TEMP1 0
    !endif
    
    ; Left Message Box rect - hidden for now
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1304
    ShowWindow $XPUI_TEMP1 0
    
    ; Header text
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1037
    SetCtlColors $XPUI_TEMP1 `${XPUI_HEADER_TEXT_COLOR}` `Transparent`
    CreateFont $XPUI_TEMP2 "$(^Font)" 8 700
    SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 0
    
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1038
    SetCtlColors $XPUI_TEMP1 `${XPUI_HEADER_TEXT_COLOR}` `Transparent`
    CreateFont $XPUI_TEMP2 "$(^Font)" 8 350
    SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 0
    
  !else
  
    !ifdef XPUI_BOTTOMIMAGE
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1045
      ShowWindow $XPUI_TEMP1 0
    !else
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1039
      ShowWindow $XPUI_TEMP1 0
    !endif
    
    ; Left Message Box rect - hidden for now
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1304
    ShowWindow $XPUI_TEMP1 0
    
    ; Header text
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1037
    CreateFont $XPUI_TEMP2 "$(^Font)" 8 700
    SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 0
    
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1038
    CreateFont $XPUI_TEMP2 "$(^Font)" 8 350
    SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 0
  
  !endif
    
  ; Header Image
  !ifdef TEMP
    !define TEMP_PUSH `${TEMP}`
    !undef TEMP
  !endif
  !ifdef XPUI_HEADERIMAGE_NORESIZETOFIT
    !define TEMP " "
  !else
    !define TEMP /RESIZETOFIT
  !endif
  !ifndef XPUI_BGIMAGE
  SetBrandingImage /IMGID=1046 ${TEMP} "$PLUGINSDIR\Header.bmp"
  !endif
  !undef TEMP
  !ifdef TEMP_PUSH
    !define TEMP `${TEMP_PUSH}`
    !undef TEMP_PUSH
  !endif
  
  ; Left Logo
  !ifdef TEMP
    !define TEMP_PUSH `${TEMP}`
    !undef TEMP
  !endif
  !ifdef XPUI_LEFTLOGO_NORESIZETOFIT
    !define TEMP " "
  !else
    !define TEMP /RESIZETOFIT
  !endif
  !ifndef XPUI_BGIMAGE
    SetBrandingImage /IMGID=1302 ${TEMP} "$PLUGINSDIR\Leftimg.bmp"
  !endif
  !undef TEMP
  !ifdef TEMP_PUSH
    !define TEMP `${TEMP_PUSH}`
    !undef TEMP_PUSH
  !endif
  
  ; Bottom Image
  !ifdef XPUI_BOTTOMIMAGE
    !ifdef TEMP
      !define TEMP_PUSH `${TEMP}`
      !undef TEMP
    !endif
    !ifdef XPUI_BOTTOMIMAGE_NORESIZETOFIT
      !define TEMP " "
    !else
      !define TEMP /RESIZETOFIT
    !endif
    SetBrandingImage /IMGID=1039 ${TEMP} "$PLUGINSDIR\Btmimg.bmp"
    !undef TEMP
    !ifdef TEMP_PUSH
      !define TEMP `${TEMP_PUSH}`
      !undef TEMP_PUSH
    !endif
  !endif
  
  !ifdef XPUI_BGIMAGE
    !ifdef TEMP
    !define TEMP_PUSH `${TEMP}`
    !undef TEMP
  !endif
  !ifdef XPUI_BGIMAGE_NORESIZETOFIT
    !define TEMP " "
  !else
    !define TEMP /RESIZETOFIT
  !endif

    SetBrandingImage /IMGID=1099 ${TEMP} "$PLUGINSDIR\BgImage.bmp"
    !undef TEMP
  !ifdef TEMP_PUSH
    !define TEMP `${TEMP_PUSH}`
    !undef TEMP_PUSH
  !endif
  !endif
    
    !ifndef XPUI_EXTERNAL_SKINNER
    
      ; Branding Text
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1028
      CreateFont $XPUI_TEMP2 "Trebuchet MS" 10 700
      SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 0
      SendMessage $XPUI_TEMP1 0xC 0 "STR:${XPUI_BRANDINGTEXT}"
      SetCtlColors $XPUI_TEMP1 "${XPUI_BRANDINGTEXT_COLOR_FG}" "Transparent"
      
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1256
      CreateFont $XPUI_TEMP2 "Trebuchet MS" 10 700
      SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 0
      SendMessage $XPUI_TEMP1 0xC 0 "STR:${XPUI_BRANDINGTEXT}"
      SetCtlColors $XPUI_TEMP1 "${XPUI_BRANDINGTEXT_COLOR_BG}" "Transparent"
      
      ; Left Info - Time Counter
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1100
      CreateFont $XPUI_TEMP2 "Arial" 8 700
      SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 0
      !insertmacro XPUI_CONTROL_SKIN_TRANS $XPUI_TEMP1
      ShowWindow $XPUI_TEMP1 0
      
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1101
      CreateFont $XPUI_TEMP2 "Arial" 8 350
      SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 0
      !insertmacro XPUI_CONTROL_SKIN_LIGHT_TRANS $XPUI_TEMP1
      ShowWindow $XPUI_TEMP1 0
      
      ; Skin the child window - to make flashes when changing pages less noticeable
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1018
      !insertmacro XPUI_CONTROL_SKIN $XPUI_TEMP1
    
    !else
    
      ; Branding Text
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1028
      ShowWindow $XPUI_TEMP1 0
      
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1256
      ShowWindow $XPUI_TEMP1 0
      
      ; Left Info - Time Counter
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1100
      CreateFont $XPUI_TEMP2 "Arial" 8 700
      SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 0
      ShowWindow $XPUI_TEMP1 0
      
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1101
      CreateFont $XPUI_TEMP2 "Arial" 8 350
      SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 0
      ShowWindow $XPUI_TEMP1 0
      
    !endif
    
  !ifdef XPUI_WANSIS
  
    SetOutPath $PLUGINSDIR
    File /oname=gen.bmp   `${XPUI_WANSIS_GEN}`
    File /oname=genex.bmp `${XPUI_WANSIS_GENEX}`

     !ifdef XPUI_WANSIS_HEADERIMAGE

      File /oname=header.bmp `${XPUI_WANSIS_HEADERIMAGE_BMP}`
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1047
      ShowWindow $XPUI_TEMP1 0
      SetBrandingImage /IMGID=1046 $PLUGINSDIR\Header.bmp

    !else

      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1046
      ShowWindow $XPUI_TEMP1 0

    !endif
    
    ; Check for msvcr71.dll (alerts user of incompatibility problems on older machines or [in my case] fresh Windows installations)
    ; FIXME: l10n
    IfFileExists $SYSDIR\msvcr71.dll FoundCRT
      MessageBox MB_OK|MB_ICONEXCLAMATION "Setup failed to load the Windows runtime library msvcr71.dll.  Setup will function, but the visual style will not work.  This is most likely caused by a fresh Windows installation." IDOK NoSkin
    FoundCRT:

    wansis::skinit /NOUNLOAD `$PLUGINSDIR\gen.bmp` `$PLUGINSDIR\genex.bmp`
    
    Pop $XPUI_TEMP1
      StrCmp $XPUI_TEMP1 "success" +2
      MessageBox MB_OK|MB_ICONINFORMATION "Setup encountered an error initializing WAnsis skinning engine. $(^Name) Setup will function, but it will not look very nice.$\n$\nReturn from wansis.dll: $XPUI_TEMP1"

    NoSkin:
  
  !endif
  
  ; NSIS is always raving about unused variables, so lets shut it up :)
  
  Goto +5 ; Ahh, the stupidity of computers...
  Push $XPUI_NOABORTWARNING
  Pop  $XPUI_NOABORTWARNING
  Push $XPUI_ABORTED
  Pop  $XPUI_ABORTED
  
  ; What the heck? Lets do it for functions too :D
  
  !ifdef XPUI_EXTERNAL_SKINNER | XPUI_FASTERSKINNING
  !else
  Goto +5 ; This effectively compiles code that will never be executed - costs ~40-50 bytes?
  Call ${UNFUNC}xpui.SkinControl
  Call ${UNFUNC}xpui.SkinControl.light
  Call ${UNFUNC}xpui.SkinControl.trans
  Call ${UNFUNC}xpui.SkinControl.light.trans
  !endif
  
  !ifmacrodef XPUI_SET_BG

    !ifdef XPUI_ENABLEBG

      !insertmacro XPUI_SET_BG

    !endif

  !endif
  
  ; If the faster skinner is disabled, this function will be inserted after pages.
  ; Therefore, we can take care of some page functions before the installer starts.
  ; This makes page initialization MUCH faster.
  
  !ifndef XPUI_FASTERSKINNING

    SetOutPath $PLUGINSDIR
    !ifdef XPUI_INTERNAL_PAGEUSED_WELCOME
      File `${XPUI_SYSDIR}\INI\isWelcome.ini`
    !endif
    !ifdef XPUI_INTERNAL_PAGEUSED_WELCOME2
      File `${XPUI_SYSDIR}\INI\Welcome.ini`
    !endif
    !ifdef XPUI_INTERNAL_PAGEUSED_INSTCONFIRM
      File `${XPUI_SYSDIR}\INI\Confirm.ini`
    !endif
    !ifdef XPUI_INTERNAL_PAGEUSED_INSTSUCCESS
      File `${XPUI_SYSDIR}\INI\Confirm.ini`
    !endif
    !ifdef XPUI_INTERNAL_PAGEUSED_FINISH
      File `${XPUI_SYSDIR}\INI\Finish.ini`
    !endif
    !ifdef XPUI_INTERNAL_PAGEUSED_STARTMENU
      !insertmacro XPUI_STARTMENUPAGE_CREATEINI
    !endif
    
  !endif
  
  !ifdef XPUI_${UN}CUSTOMFUNCTION_GUIINIT
    Call `${XPUI_${UN}CUSTOMFUNCTION_GUIINIT}`
    !undef XPUI_${UN}CUSTOMFUNCTION_GUIINIT
  !endif
  
  ; ShowWindow $HWNDPARENT 2
  
  !insertmacro XPUI_PAGEMODE_POP
!macroend

; Modern UI Compatibility Script

!include "${XPUI_SYSDIR}\MUIConvert.nsh"
!insertmacro XPUI_LANGUAGE_CONVERT

; Pages

!macro XPUI_PAGECHECKS
  ; any checks for settings, etc that will be checked before XPUI pages are inserted go here
  !verbose push
  !verbose ${XPUI_VERBOSE}
  
  !ifdef XPUI_INTERNAL_LANG_INSERTED
    !verbose 4
    !error "ExperienceUI: FATAL: Language files must be inserted after pages.  Please move all lines containing $\"!insertmacro XPUI_LANGUAGE$\" down below page macros."
  !endif
  
  !verbose 0
    !insertmacro XPUI_LANGUAGE_CONVERT
  !verbose ${XPUI_VERBOSE}
  
  !ifdef XPUI_WANSIS
  !ifndef XPUI_EXTERNAL_SKINNER
  !define XPUI_EXTERNAL_SKINNER
  !endif
  !endif
  
  !ifdef XPUI_BGIMAGE
    !ifndef XPUI_COMPONENTSPAGE_NODESC
      !define XPUI_COMPONENTSPAGE_NODESC
    !endif
  !endif
  
!macroend

!macro XPUI_ENDPAGECHECKS
  ; any preproccessor commands after page macros go here
  !verbose pop
!macroend

!macro XPUI_PAGE_WELCOME

  !insertmacro XPUI_PAGECHECKS
  
  !ifndef XPUI_INTERNAL_PAGEUSED_WELCOME
    !define XPUI_INTERNAL_PAGEUSED_WELCOME
  !endif
  
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}WELCOMEPAGE_TITLE "$(XPUI_${XPUI_UN}WELCOMEPAGE_TITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}WELCOMEPAGE_SUBTITLE "$(XPUI_${XPUI_UN}WELCOMEPAGE_SUBTITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}WELCOMEPAGE_TEXT_TOP "$(XPUI_${XPUI_UN}WELCOMEPAGE_TEXT_TOP)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}WELCOMEPAGE_TEXT "$(XPUI_${XPUI_UN}WELCOMEPAGE_TEXT)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}WELCOMEPAGE_CAPTION "$(XPUI_${XPUI_UN}WELCOMEPAGE_CAPTION)"
  
  !insertmacro XPUI_CREATEID
  
  PageEx ${XPUI_UNFUNC}custom
  PageCallbacks ${XPUI_UNFUNC}XPUI.io.WelcomePage.${XPUI_UNIQUEID} ${XPUI_UNFUNC}XPUI.io.WelcomePage.${XPUI_UNIQUEID}.leave
  Caption `${XPUI_${XPUI_UN}WELCOMEPAGE_CAPTION}`
  PageExEnd

  Function ${XPUI_UNFUNC}XPUI.io.WelcomePage.${XPUI_UNIQUEID}
    LockWindow on
    StrCmp $XPUI_ABORTED 1 0 +2
      Abort
    
    !ifdef XPUI_FASTERSKINNING
    SetOutPath $PLUGINSDIR
    File `${XPUI_SYSDIR}\INI\isWelcome.ini`
    !endif

    !insertmacro XPUI_PAGE_CUSTOMFUNCTION PRE    

    WriteINIStr $PLUGINSDIR\isWelcome.ini `Field 1` Text `${XPUI_${XPUI_UN}WELCOMEPAGE_TEXT_TOP}`
    WriteINIStr $PLUGINSDIR\isWelcome.ini `Field 2` Text `${XPUI_${XPUI_UN}WELCOMEPAGE_TEXT}`
    WriteINIStr `$PLUGINSDIR\isWelcome.ini` `Settings` `RTL` `$(^RTL)`
    
    InstallOptions::initDialog /NOUNLOAD `$PLUGINSDIR\isWelcome.ini`
      
      Pop $XPUI_HWND
      !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_HWND
      
      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1200
        CreateFont $XPUI_TEMP2 `$(^Font)` 12 700 ; previously Tahoma
        SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 $XPUI_TEMP2
        !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
      
      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1201
        CreateFont $XPUI_TEMP2 `$(^Font)` 8 350 ; previously Tahoma
        SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 $XPUI_TEMP2
        !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
      
      !insertmacro XPUI_HEADER_TEXT `${XPUI_${XPUI_UN}WELCOMEPAGE_TITLE}` `${XPUI_${XPUI_UN}WELCOMEPAGE_SUBTITLE}`
      
      !insertmacro XPUI_PAGE_CUSTOMFUNCTION SHOW
      
      LockWindow off
      
    InstallOptions::show
    FunctionEnd
    
    Function ${XPUI_UNFUNC}XPUI.io.WelcomePage.${XPUI_UNIQUEID}.leave
    !ifndef XPUI_NOLOCK
    LockWindow on
    !endif
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION LEAVE
  FunctionEnd
  
  !undef XPUI_${XPUI_UN}WELCOMEPAGE_TITLE
  !undef XPUI_${XPUI_UN}WELCOMEPAGE_SUBTITLE
  !undef XPUI_${XPUI_UN}WELCOMEPAGE_TEXT_TOP
  !undef XPUI_${XPUI_UN}WELCOMEPAGE_TEXT
  !undef XPUI_${XPUI_UN}WELCOMEPAGE_CAPTION
  
  !insertmacro XPUI_ENDPAGECHECKS

!macroend

!macro XPUI_PAGE_WELCOME2

  !insertmacro XPUI_PAGECHECKS
  
  !ifndef XPUI_INTERNAL_PAGEUSED_WELCOME2
    !define XPUI_INTERNAL_PAGEUSED_WELCOME2
  !endif
  
  !ifdef XPUI_WELCOMEPAGESTYLE2_TITLE | XPUI_WELCOMEPAGESTYLE2_SUBTITLE | XPUI_WELCOMEPAGESTYLE2_CAPTION | XPUI_WELCOMEPAGESTYLE2_TEXT_TOP | XPUI_WELCOMEPAGESTYLE2_TEXT
    !warning "The XPUI_WELCOMEPAGESTYLE2 defines are deprecated and have been renamed to XPUI_WELCOMEPAGE2_*.  Please update your script."
  !endif
  
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}WELCOMEPAGE2_TITLE "$(XPUI_${XPUI_UN}WELCOMEPAGE2_TITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}WELCOMEPAGE2_SUBTITLE "$(XPUI_${XPUI_UN}WELCOMEPAGE2_SUBTITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}WELCOMEPAGE2_TEXT_TOP "$(XPUI_${XPUI_UN}WELCOMEPAGE2_TEXT_TOP)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}WELCOMEPAGE2_TEXT "$(XPUI_${XPUI_UN}WELCOMEPAGE2_TEXT)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}WELCOMEPAGE2_CAPTION "$(XPUI_${XPUI_UN}WELCOMEPAGE2_CAPTION)"
  
  !insertmacro XPUI_CREATEID
  
  PageEx ${XPUI_UNFUNC}custom
  PageCallbacks ${XPUI_UNFUNC}XPUI.io.WelcomePage2.${XPUI_UNIQUEID} ${XPUI_UNFUNC}XPUI.io.WelcomePage2.${XPUI_UNIQUEID}.leave
  Caption `${XPUI_${XPUI_UN}WELCOMEPAGE2_CAPTION}`
  PageExEnd

  Function ${XPUI_UNFUNC}XPUI.io.WelcomePage2.${XPUI_UNIQUEID}
    LockWindow on
    StrCmp $XPUI_ABORTED 1 0 +2
      Abort
    
    !ifdef XPUI_FASTERSKINNING
    SetOutPath $PLUGINSDIR
    File `${XPUI_SYSDIR}\INI\Welcome.ini`
    !endif

    !insertmacro XPUI_PAGE_CUSTOMFUNCTION PRE    

    WriteINIStr $PLUGINSDIR\Welcome.ini `Field 1` Text `${XPUI_${XPUI_UN}WELCOMEPAGE2_TEXT_TOP}`
    WriteINIStr $PLUGINSDIR\Welcome.ini `Field 2` Text `${XPUI_${XPUI_UN}WELCOMEPAGE2_TEXT}`
    WriteINIStr `$PLUGINSDIR\Welcome.ini` `Settings` `RTL` `$(^RTL)`
    
    InstallOptions::initDialog /NOUNLOAD `$PLUGINSDIR\Welcome.ini`
      
      Pop $XPUI_HWND
      !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_HWND
      
      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1200
        CreateFont $XPUI_TEMP2 `$(^Font)` 8 700 ; previously Tahoma
        SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 $XPUI_TEMP2
        !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
      
      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1201
        CreateFont $XPUI_TEMP2 `$(^Font)` 8 350 ; previously Tahoma
        SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 $XPUI_TEMP2
        !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
      
      !insertmacro XPUI_HEADER_TEXT `${XPUI_${XPUI_UN}WELCOMEPAGE2_TITLE}` `${XPUI_${XPUI_UN}WELCOMEPAGE2_SUBTITLE}`
      
      !insertmacro XPUI_PAGE_CUSTOMFUNCTION SHOW
      
      LockWindow off
      
    InstallOptions::show
    FunctionEnd
    
    Function ${XPUI_UNFUNC}XPUI.io.WelcomePage2.${XPUI_UNIQUEID}.leave
    !ifndef XPUI_NOLOCK
    LockWindow on
    !endif
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION LEAVE
  FunctionEnd
  
  !undef XPUI_${XPUI_UN}WELCOMEPAGE2_TITLE
  !undef XPUI_${XPUI_UN}WELCOMEPAGE2_SUBTITLE
  !undef XPUI_${XPUI_UN}WELCOMEPAGE2_TEXT_TOP
  !undef XPUI_${XPUI_UN}WELCOMEPAGE2_TEXT
  !undef XPUI_${XPUI_UN}WELCOMEPAGE2_CAPTION
  
  !insertmacro XPUI_ENDPAGECHECKS

!macroend

!macro XPUI_PAGE_LICENSE DATA

  !insertmacro XPUI_PAGECHECKS
  
  !ifndef XPUI_INTERNAL_PAGEUSED_LICENSE
    !define XPUI_INTERNAL_PAGEUSED_LICENSE
  !endif
  
  !insertmacro XPUI_DEFAULT MUI_LICENSEPAGE_HEADER_TITLE    "$(XPUI_${XPUI_UN}LICENSEPAGE_TITLE)"
  !insertmacro XPUI_DEFAULT MUI_LICENSEPAGE_HEADER_SUBTITLE "$(XPUI_${XPUI_UN}LICENSEPAGE_SUBTITLE)"
  !insertmacro XPUI_DEFAULT MUI_LICENSEPAGE_TEXT_TOP        "$(XPUI_${XPUI_UN}LICENSEPAGE_TEXT_TOP)"
  !insertmacro XPUI_DEFAULT MUI_LICENSEPAGE_TEXT_BOTTOM     "$(XPUI_${XPUI_UN}LICENSEPAGE_TEXT_BOTTOM)"
  !insertmacro XPUI_DEFAULT MUI_LICENSEPAGE_CAPTION         "$(XPUI_${XPUI_UN}LICENSEPAGE_CAPTION)"
  
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}LICENSEPAGE_CAPTION     "${MUI_LICENSEPAGE_HEADER_CAPTION}"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}LICENSEPAGE_TITLE       "${MUI_LICENSEPAGE_HEADER_TITLE}"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}LICENSEPAGE_SUBTITLE    "${MUI_LICENSEPAGE_HEADER_SUBTITLE}"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}LICENSEPAGE_TEXT_TOP    "${MUI_LICENSEPAGE_TEXT_TOP}"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}LICENSEPAGE_TEXT_BOTTOM "${MUI_LICENSEPAGE_TEXT_BOTTOM}"
  
  ; Fix for John P. on the forums
  !ifdef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}LICENSEPAGE_CHECKBOX_TEXT             "$(^AcceptBtn)"
  !else ifdef XPUI_LICENSEPAGE_RADIOBUTTONS
    !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}LICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT  "$(^AcceptBtn)"
    !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}LICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "$(^DontAcceptBtn)"
  !endif
  
  !insertmacro XPUI_CREATEID
  PageEx ${XPUI_UNFUNC}license
    
    Caption `$(XPUI_${XPUI_UN}LICENSEPAGE_CAPTION)`
    PageCallbacks ${XPUI_UNFUNC}XPUI.lic.${XPUI_UNIQUEID}.pre ${XPUI_UNFUNC}XPUI.lic.${XPUI_UNIQUEID}.show ${XPUI_UNFUNC}XPUI.lic.${XPUI_UNIQUEID}.leave
    LicenseData `${DATA}`
    
    !ifdef XPUI_LICENSEPAGE_RADIOBUTTONS
    LicenseForceSelection radiobuttons `${XPUI_${XPUI_UN}LICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT}` `${XPUI_${XPUI_UN}LICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE}`
    !endif
    
    !ifdef XPUI_LICENSEPAGE_CHECKBOX
    LicenseForceSelection checkbox `${XPUI_${XPUI_UN}LICENSEPAGE_CHECKBOX_TEXT}`
    !endif
  
  PageExEnd
  
  !insertmacro XPUI_DEFAULT XPUI_LICENSEBKCOLOR 0xFFFFFF
  LicenseBkColor `${XPUI_LICENSEBKCOLOR}`
  
  Function ${XPUI_UNFUNC}XPUI.lic.${XPUI_UNIQUEID}.pre
    
    StrCmp $XPUI_ABORTED 1 0 +2
    Abort
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION PRE
    
  FunctionEnd
  
  Function ${XPUI_UNFUNC}XPUI.lic.${XPUI_UNIQUEID}.show
    
    LockWindow On
  
    !insertmacro XPUI_HEADER_TEXT `${XPUI_${XPUI_UN}LICENSEPAGE_TITLE}` `${XPUI_${XPUI_UN}LICENSEPAGE_SUBTITLE}`
    
    FindWindow $XPUI_HWND `#32770` `` $HWNDPARENT
    !insertmacro XPUI_CONTROL_SKIN $XPUI_HWND
    
    GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1034
    !insertmacro XPUI_CONTROL_SKIN_LIGHT $XPUI_TEMP1
      !ifdef XPUI_LICENSEPAGE_RESET
        SendMessage $XPUI_TEMP1 0x00F1 0 0
      !endif
    
    GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1035
    !insertmacro XPUI_CONTROL_SKIN_LIGHT $XPUI_TEMP1
      !ifdef XPUI_LICENSEPAGE_RESET
        SendMessage $XPUI_TEMP1 0x00F1 0 0
        
        GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1
        EnableWindow $XPUI_TEMP1 0
      !endif
      
    FindWindow $XPUI_HWND `#32770` `` $HWNDPARENT
      
    GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1040
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    SendMessage $XPUI_TEMP1 0xC 0 `STR:${XPUI_${XPUI_UN}LICENSEPAGE_TEXT_TOP}`
    
    GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1006
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    
    GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1034
    !insertmacro XPUI_CONTROL_SKIN_LIGHT $XPUI_TEMP1
    
    GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1035
    !insertmacro XPUI_CONTROL_SKIN_LIGHT $XPUI_TEMP1
    
    !ifndef XPUI_${XPUI_UN}LICENSEPAGE_RADIOBUTTONS
      !ifndef XPUI_${XPUI_UN}LICENSEPAGE_CHECKBOX
        !insertmacro XPUI_INNERDIALOG_TEXT `${XPUI_${XPUI_UN}LICENSEPAGE_TEXT_BOTTOM}` 1006
      !endif
    !endif
    
    !ifdef XPUI_${XPUI_UN}LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_INNERDIALOG_TEXT `${XPUI_${XPUI_UN}LICENSEPAGE_TEXT_BOTTOM}` 1006
    !endif
    
    !ifdef XPUI_${XPUI_UN}LICENSEPAGE_RADIOBUTTONS
    !insertmacro XPUI_INNERDIALOG_TEXT `${XPUI_${XPUI_UN}LICENSEPAGE_TEXT_BOTTOM}` 1006
    !endif
    
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_HWND
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION SHOW
    
    LockWindow off
  FunctionEnd
  
  Function ${XPUI_UNFUNC}XPUI.lic.${XPUI_UNIQUEID}.leave
  !ifndef XPUI_NOLOCK
  LockWindow on
  !endif
  
  !insertmacro XPUI_PAGE_CUSTOMFUNCTION LEAVE
  
  FunctionEnd
  
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_PRE
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_SHOW
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_LEAVE
  
  !undef XPUI_${XPUI_UN}LICENSEPAGE_CAPTION
  !undef XPUI_${XPUI_UN}LICENSEPAGE_TITLE
  !undef XPUI_${XPUI_UN}LICENSEPAGE_SUBTITLE
  !undef XPUI_${XPUI_UN}LICENSEPAGE_TEXT_TOP
  !undef XPUI_${XPUI_UN}LICENSEPAGE_TEXT_BOTTOM
  
  !insertmacro XPUI_UNSET XPUI_LICENSEPAGE_CHECKBOX
  !insertmacro XPUI_UNSET XPUI_LICENSEPAGE_RADIOBUTTONS
  
  !undef MUI_LICENSEPAGE_HEADER_TITLE
  !undef MUI_LICENSEPAGE_HEADER_SUBTITLE
  !undef MUI_LICENSEPAGE_TEXT_TOP
  !undef MUI_LICENSEPAGE_TEXT_BOTTOM
  !undef MUI_LICENSEPAGE_CAPTION
  
  !insertmacro XPUI_ENDPAGECHECKS

!macroend

!macro XPUI_PAGE_COMPONENTS

  !insertmacro XPUI_PAGECHECKS
  
  !ifndef XPUI_INTERNAL_PAGEUSED_COMPONENTS
    !define XPUI_INTERNAL_PAGEUSED_COMPONENTS
  !endif
  
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}COMPONENTSPAGE_TITLE "$(XPUI_${XPUI_UN}COMPONENTSPAGE_TITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}COMPONENTSPAGE_SUBTITLE "$(XPUI_${XPUI_UN}COMPONENTSPAGE_SUBTITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}COMPONENTSPAGE_CAPTION "$(XPUI_${XPUI_UN}COMPONENTSPAGE_CAPTION)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_DESCRIPTION_INFO "$(XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_DESCRIPTION_INFO)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "$(XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE)"
  
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_TOP      "$(^ComponentsText)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_INSTTYPE "$(^ComponentsSubText1)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_SECLIST  "$(^ComponentsSubText2)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_SECLIST_NOINSTTYPE  "$(^ComponentsSubText2_NoInstTypes)"
  
  !insertmacro XPUI_CREATEID
  PageEx ${XPUI_UNFUNC}components
    Caption `$(XPUI_${XPUI_UN}COMPONENTSPAGE_CAPTION)`
    PageCallbacks ${XPUI_UNFUNC}XPUI.cmp.${XPUI_UNIQUEID}.pre ${XPUI_UNFUNC}XPUI.cmp.${XPUI_UNIQUEID}.show ${XPUI_UNFUNC}XPUI.cmp.${XPUI_UNIQUEID}.leave
    ComponentText "${XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_TOP}" "${XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_INSTTYPE}" "${XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_SECLIST}"
  PageExEnd
  
  Function ${XPUI_UNFUNC}XPUI.cmp.${XPUI_UNIQUEID}.pre
    
    StrCmp $XPUI_ABORTED 1 0 +2
      Abort
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION PRE
  
  FunctionEnd
  
  Function ${XPUI_UNFUNC}XPUI.cmp.${XPUI_UNIQUEID}.show
  
    !insertmacro XPUI_HEADER_TEXT `${XPUI_${XPUI_UN}COMPONENTSPAGE_TITLE}` `${XPUI_${XPUI_UN}COMPONENTSPAGE_SUBTITLE}`
    
    !insertmacro XPUI_PAGECOLOR_INIT 1022
    !insertmacro XPUI_PAGECOLOR_INIT 1021
    !insertmacro XPUI_PAGECOLOR_INIT 1023
    !insertmacro XPUI_PAGECOLOR_INIT 1006
    !insertmacro XPUI_PAGECOLOR_INIT 1042
    !insertmacro XPUI_PAGECOLOR_INIT 1043
    
    FindWindow $XPUI_HWND "#32770" "" "$HWNDPARENT"
    GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1032
    SetCtlColors $XPUI_TEMP1 0x000000 0xFFFFFF
    
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_HWND
    
    GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1043
      SendMessage $XPUI_TEMP1 0xC 0 `STR:${XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_DESCRIPTION_INFO}`
      StrCpy $XPUI_HWND "${XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_DESCRIPTION_INFO}"
      EnableWindow $XPUI_TEMP1 0
    
    InstTypeGetText 0 $XPUI_TEMP1
    StrCmp $XPUI_TEMP1 "" "" XPUI.using_insttypes
      !insertmacro XPUI_INNERDIALOG_TEXT "${XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_SECLIST_NOINSTTYPE}" 1022
      !insertmacro XPUI_INNERDIALOG_TEXT " " 1021
    XPUI.using_insttypes:
    
    !ifdef XPUI_COMPONENTSPAGE_NODESC
      FindWindow $XPUI_TEMP1 `#32770` `` `$HWNDPARENT`
      GetDlgItem $XPUI_TEMP2 $XPUI_TEMP1 1042
      ShowWindow $XPUI_TEMP2 0
      GetDlgItem $XPUI_TEMP2 $XPUI_TEMP1 1043
      ShowWindow $XPUI_TEMP2 0
    !endif
    
    !insertmacro XPUI_INNERDIALOG_TEXT `${XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE}` 1042
    StrCpy $XPUI_TEMP2 "${XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE}"
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION SHOW
    
    !ifndef XPUI_NOLOCK
    LockWindow off
    !endif
  FunctionEnd
  
  Function ${XPUI_UNFUNC}XPUI.cmp.${XPUI_UNIQUEID}.leave
  
    !ifndef XPUI_NOLOCK
      LockWindow on
    !endif
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION LEAVE
  
  FunctionEnd
  
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_PRE
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_SHOW
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_LEAVE
  
  !undef XPUI_${XPUI_UN}COMPONENTSPAGE_TITLE
  !undef XPUI_${XPUI_UN}COMPONENTSPAGE_CAPTION
  !undef XPUI_${XPUI_UN}COMPONENTSPAGE_SUBTITLE
  !undef XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE
  !undef XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_DESCRIPTION_INFO
  !undef XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_TOP
  !undef XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_INSTTYPE
  !undef XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_SECLIST
  !undef XPUI_${XPUI_UN}COMPONENTSPAGE_TEXT_SECLIST_NOINSTTYPE
  
  !insertmacro XPUI_ENDPAGECHECKS

!macroend

!macro XPUI_PAGE_DIRECTORY

  !insertmacro XPUI_PAGECHECKS
  
  !ifndef XPUI_INTERNAL_PAGEUSED_DIRECTORY
    !define XPUI_INTERNAL_PAGEUSED_DIRECTORY
  !endif
  
  !insertmacro XPUI_DEFAULT MUI_DIRECTORYPAGE_HEADER_TITLE     "$(XPUI_${XPUI_UN}DIRECTORYPAGE_TITLE)"
  !insertmacro XPUI_DEFAULT MUI_DIRECTORYPAGE_HEADER_SUBTITLE  "$(XPUI_${XPUI_UN}DIRECTORYPAGE_SUBTITLE)"
  !insertmacro XPUI_DEFAULT MUI_DIRECTORYPAGE_TEXT_TOP         "$(XPUI_${XPUI_UN}DIRECTORYPAGE_TEXT_TOP)"
  !insertmacro XPUI_DEFAULT MUI_DIRECTORYPAGE_CAPTION          "$(XPUI_${XPUI_UN}DIRECTORYPAGE_CAPTION)"
  !insertmacro XPUI_DEFAULT MUI_DIRECTORYPAGE_TEXT_DESTINATION "$(^DirSubText)"
  !insertmacro XPUI_DEFAULT MUI_DIRECTORYPAGE_BROWSEDIALOG     "$(^DirBrowseText)"
  !insertmacro XPUI_DEFAULT MUI_DIRECTORYPAGE_BROWSEBUTTON     "$(^BrowseBtn)"
    
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}DIRECTORYPAGE_TITLE         "${MUI_DIRECTORYPAGE_HEADER_TITLE}"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}DIRECTORYPAGE_SUBTITLE      "${MUI_DIRECTORYPAGE_HEADER_SUBTITLE}"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}DIRECTORYPAGE_CAPTION       "${MUI_DIRECTORYPAGE_CAPTION}"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}DIRECTORYPAGE_TEXT_TOP      "${MUI_DIRECTORYPAGE_TEXT_TOP}"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}DIRECTORYPAGE_SUBTEXT       "${MUI_DIRECTORYPAGE_TEXT_DESTINATION}"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}DIRECTORYPAGE_BROWSEDIALOG  "${MUI_DIRECTORYPAGE_BROWSEDIALOG}"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}DIRECTORYPAGE_BROWSEBUTTON  "${MUI_DIRECTORYPAGE_BROWSEBUTTON}"
  
  !insertmacro XPUI_DEFAULT MUI_DIRECTORYPAGE_VARIABLE "$INSTDIR"
  !insertmacro XPUI_DEFAULT XPUI_DIRVAR "${MUI_DIRECTORYPAGE_VARIABLE}"
  
  PageEx ${XPUI_UNFUNC}directory
    Caption `${XPUI_${XPUI_UN}DIRECTORYPAGE_CAPTION}`
    DirVar ${XPUI_DIRVAR}
    PageCallbacks ${XPUI_UNFUNC}XPUI.dir.${XPUI_UNIQUEID}.pre ${XPUI_UNFUNC}XPUI.dir.${XPUI_UNIQUEID}.show ${XPUI_UNFUNC}XPUI.dir.${XPUI_UNIQUEID}.leave
    DirText "${XPUI_${XPUI_UN}DIRECTORYPAGE_TEXT_TOP}" "${XPUI_${XPUI_UN}DIRECTORYPAGE_SUBTEXT}" "${XPUI_${XPUI_UN}DIRECTORYPAGE_BROWSEBUTTON}" "${XPUI_${XPUI_UN}DIRECTORYPAGE_BROWSEDIALOG}"
  PageExEnd
  
  Function ${XPUI_UNFUNC}XPUI.dir.${XPUI_UNIQUEID}.pre
    StrCmp $XPUI_ABORTED 1 0 +2
      Abort
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION PRE
    
  FunctionEnd
  
  Function ${XPUI_UNFUNC}XPUI.dir.${XPUI_UNIQUEID}.show
  
    !insertmacro XPUI_HEADER_TEXT `${XPUI_${XPUI_UN}DIRECTORYPAGE_TITLE}` `${XPUI_${XPUI_UN}DIRECTORYPAGE_SUBTITLE}`
    
    FindWindow $XPUI_TEMP1 `#32770` `` $HWNDPARENT
    !insertmacro XPUI_CONTROL_SKIN $XPUI_TEMP1
    
    !insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXTBOX_COLOR "${XPUI_TEXT_BGCOLOR}"
    
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP1 1019
    SetCtlColors $XPUI_TEMP1 0x000000 0xFFFFFF
    
    !insertmacro XPUI_PAGECOLOR_INIT 1001
    !insertmacro XPUI_PAGECOLOR_INIT 1008
    !insertmacro XPUI_PAGECOLOR_INIT 1006
    !insertmacro XPUI_PAGECOLOR_INIT 1020
    !insertmacro XPUI_PAGECOLOR_INIT 1023
    !insertmacro XPUI_PAGECOLOR_INIT 1024
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION SHOW
    
    !ifndef XPUI_NOLOCK
    LockWindow off
    !endif
    FunctionEnd
    
  Function ${XPUI_UNFUNC}XPUI.dir.${XPUI_UNIQUEID}.leave
    
    !ifndef XPUI_NOLOCK
    LockWindow on
    !endif
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION LEAVE
  
  FunctionEnd
  
  !undef XPUI_DIRVAR
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_PRE
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_SHOW
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_LEAVE
  
  !undef XPUI_${XPUI_UN}DIRECTORYPAGE_TITLE
  !undef XPUI_${XPUI_UN}DIRECTORYPAGE_SUBTITLE
  !undef XPUI_${XPUI_UN}DIRECTORYPAGE_CAPTION
  !undef XPUI_${XPUI_UN}DIRECTORYPAGE_TEXT_TOP
  !undef XPUI_${XPUI_UN}DIRECTORYPAGE_SUBTEXT
  !undef XPUI_${XPUI_UN}DIRECTORYPAGE_BROWSEBUTTON
  !undef XPUI_${XPUI_UN}DIRECTORYPAGE_BROWSEDIALOG
  
  !undef MUI_DIRECTORYPAGE_HEADER_TITLE
  !undef MUI_DIRECTORYPAGE_HEADER_SUBTITLE
  !undef MUI_DIRECTORYPAGE_TEXT_TOP
  !undef MUI_DIRECTORYPAGE_CAPTION
  !undef MUI_DIRECTORYPAGE_TEXT_DESTINATION
  !undef MUI_DIRECTORYPAGE_BROWSEDIALOG
  !undef MUI_DIRECTORYPAGE_BROWSEBUTTON
  
  !insertmacro XPUI_ENDPAGECHECKS

!macroend

; Before you read this code, let me tell you a secret:
; I HAD TO WRITE THIS D*** THING MYSELF because the StartMenu.dll plugin is too shy - it has to hide behind any control
; below it - in this case, LABEL 1099, the background for the entire window.  The only other option was to discontinue
; the start menu page...be glad I chose to write a new one...

!macro XPUI_PAGE_STARTMENU_INIT ID VAR

  !insertmacro XPUI_PAGECHECKS

  !ifndef XPUI_INTERNAL_PAGEUSED_STARTMENU
    !define XPUI_INTERNAL_PAGEUSED_STARTMENU
  !endif
  
  !insertmacro XPUI_CREATEID
  
  !insertmacro XPUI_DEFAULT XPUI_INTERNAL_STARTMENUPAGE_ID_DEFAULT ${ID}

  !insertmacro XPUI_DEFAULT MUI_STARTMENUPAGE_DEFAULTFOLDER "$(^Name)"
  !insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_DEFAULTFOLDER "${MUI_STARTMENUPAGE_DEFAULTFOLDER}"
  !insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_FOLDER "${XPUI_STARTMENUPAGE_DEFAULTFOLDER}"
  
  !define XPUI_STARTMENUPAGE_VARIABLE "${VAR}"
  !define "XPUI_STARTMENUPAGE_${ID}_VARIABLE" "${XPUI_STARTMENUPAGE_VARIABLE}"
  !define "XPUI_STARTMENUPAGE_${ID}_DEFAULTFOLDER" "${XPUI_STARTMENUPAGE_FOLDER}"
  
  !ifdef MUI_STARTMENUPAGE_REGISTRY_ROOT & MUI_STARTMENUPAGE_REGISTRY_KEY & MUI_STARTMENUPAGE_REGISTRY_VALUENAME

  !ifdef MUI_STARTMENUPAGE_REGISTRY_ROOT
    !define "XPUI_STARTMENUPAGE_${ID}_REGISTRY_ROOT" "${MUI_STARTMENUPAGE_REGISTRY_ROOT}"
  !endif
  !ifdef MUI_STARTMENUPAGE_REGISTRY_KEY
    !define "XPUI_STARTMENUPAGE_${ID}_REGISTRY_KEY" "${MUI_STARTMENUPAGE_REGISTRY_KEY}"
  !endif
  !ifdef MUI_STARTMENUPAGE_REGISTRY_VALUENAME
    !define "XPUI_STARTMENUPAGE_${ID}_REGISTRY_VALUENAME" "${MUI_STARTMENUPAGE_REGISTRY_VALUENAME}"
  !endif
  
  !else ifdef XPUI_STARTMENUPAGE_REGISTRY_ROOT & XPUI_STARTMENUPAGE_REGISTRY_KEY & XPUI_STARTMENUPAGE_REGISTRY_VALUENAME
  
  !ifdef XPUI_STARTMENUPAGE_REGISTRY_ROOT
    !define "XPUI_STARTMENUPAGE_${ID}_REGISTRY_ROOT" "${XPUI_STARTMENUPAGE_REGISTRY_ROOT}"
  !endif
  !ifdef XPUI_STARTMENUPAGE_REGISTRY_KEY
    !define "XPUI_STARTMENUPAGE_${ID}_REGISTRY_KEY" "${XPUI_STARTMENUPAGE_REGISTRY_KEY}"
  !endif
  !ifdef XPUI_STARTMENUPAGE_REGISTRY_VALUENAME
    !define "XPUI_STARTMENUPAGE_${ID}_REGISTRY_VALUENAME" "${XPUI_STARTMENUPAGE_REGISTRY_VALUENAME}"
  !endif
  
  !endif
  
  !ifdef XPUI_FASTERSKINNING
    !insertmacro XPUI_STARTMENUPAGE_INITARRAY
  !endif
  
  !define XPUI_STARTMENUPAGE_${ID}_ID "${XPUI_UNIQUEID}"
  
  Function ${XPUI_UNFUNC}xpui.StartMenu.show.${XPUI_UNIQUEID}
    StrCmp $XPUI_ABORTED 1 0 +2
      Abort
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION PRE

     !ifdef XPUI_STARTMENUPAGE_REGISTRY_ROOT & XPUI_STARTMENUPAGE_REGISTRY_KEY & XPUI_STARTMENUPAGE_REGISTRY_VALUENAME

      StrCmp "${XPUI_STARTMENUPAGE_VARIABLE}" "" 0 +4

      ReadRegStr $XPUI_TEMP1 "${XPUI_STARTMENUPAGE_REGISTRY_ROOT}" "${XPUI_STARTMENUPAGE_REGISTRY_KEY}" "${XPUI_STARTMENUPAGE_REGISTRY_VALUENAME}"
        StrCmp $XPUI_TEMP1 "" +2
          StrCpy "${XPUI_STARTMENUPAGE_VARIABLE}" $XPUI_TEMP1

    !endif
    
    StrCmp `${XPUI_STARTMENUPAGE_VARIABLE}` `` 0 +2
      StrCpy `${XPUI_STARTMENUPAGE_VARIABLE}` `${XPUI_STARTMENUPAGE_FOLDER}`
    !ifdef XPUI_FASTERSKINNING
    IfFileExists $PLUGINSDIR\StartMenu.ini 0 +2
      ReadINIStr ${XPUI_STARTMENUPAGE_VARIABLE} $PLUGINSDIR\StartMenu.ini "Field 2" State
    !else
    IfFileExists $PLUGINSDIR\StartMenu.ini 0 +2
      ReadINIStr $XPUI_TEMP1 $PLUGINSDIR\StartMenu.ini "Field 2" State
      StrCmp $XPUI_TEMP1 '$$(^Name)' +2
      StrCpy ${XPUI_STARTMENUPAGE_VARIABLE} $XPUI_TEMP1
    !endif
    
    !insertmacro XPUI_HEADER_TEXT $(XPUI_${XPUI_UN}STARTMENUPAGE_TITLE) $(XPUI_${XPUI_UN}STARTMENUPAGE_SUBTITLE)
    
    !ifdef XPUI_FASTERSKINNING
    
      !insertmacro XPUI_STARTMENUPAGE_CREATEINI
      
    !else
    
    !endif
    
      WriteINIStr $PLUGINSDIR\StartMenu.ini "Field 3" State "${XPUI_STARTMENUPAGE_VARIABLE}"
      WriteINIStr $PLUGINSDIR\StartMenu.ini `Settings` `RTL` `$(^RTL)`
      
      InstallOptions::initDialog /NOUNLOAD $PLUGINSDIR\Startmenu.ini
        Pop $XPUI_HWND
        !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_HWND
        GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1200
          !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
          SendMessage $XPUI_TEMP1 0xC 0 `STR:$(XPUI_${XPUI_UN}STARTMENUPAGE_TEXT)`
        GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1201
        !insertmacro XPUI_CONTROL_SKIN $XPUI_TEMP1
          SendMessage $XPUI_TEMP1 0xC 0 "STR:${XPUI_STARTMENUPAGE_VARIABLE}"
        GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1202
        !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
        GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1203
        !insertmacro XPUI_CONTROL_SKIN $XPUI_TEMP1
        SendMessage $XPUI_TEMP1 0xC 0 `STR:$(XPUI_${XPUI_UN}STARTMENUPAGE_CHECKBOX)`
        !ifdef XPUI_STARTMENUPAGE_NODISABLE
          ShowWindow $XPUI_TEMP1 0
        !endif
        LockWindow off
        !insertmacro XPUI_PAGE_CUSTOMFUNCTION SHOW
        GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1099
        ShowWindow $XPUI_TEMP1 0
        !ifndef XPUI_BGIMAGE
        SetBrandingImage /IMGID=1302 "$PLUGINSDIR\LeftImg.bmp"
        !else
        SetBrandingImage /IMGID=1099 "$PLUGINSDIR\BgImage.bmp"
        !endif
        GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1099
        ShowWindow $XPUI_TEMP1 5
      InstallOptions::show

    LockWindow off
    
  FunctionEnd
  
  Function ${XPUI_UNFUNC}xpui.StartMenu.leave.${XPUI_UNIQUEID}
  
    LockWindow on
    ReadINIStr $XPUI_TEMP1 $PLUGINSDIR\StartMenu.ini Settings State
    StrCmp $XPUI_TEMP1 3 list
    StrCmp $XPUI_TEMP1 4 check
    goto done
    list:
      ReadINIStr $XPUI_TEMP1 $PLUGINSDIR\StartMenu.ini "Field 3" State
      GetDlgItem $XPUI_TEMP2 $XPUI_HWND 1201
      SendMessage $XPUI_TEMP2 0xC 0 STR:$XPUI_TEMP1
      LockWindow off
      abort
    check:
      ReadINIStr $XPUI_TEMP1 $PLUGINSDIR\StartMenu.ini "Field 4" State
      StrCmp $XPUI_TEMP1 1 +3
        StrCpy $XPUI_TEMP1 1
        goto +2
        StrCpy $XPUI_TEMP1 0
      GetDlgItem $XPUI_TEMP2 $XPUI_HWND 1201
      EnableWindow $XPUI_TEMP2 $XPUI_TEMP1
      GetDlgItem $XPUI_TEMP2 $XPUI_HWND 1202
      EnableWindow $XPUI_TEMP2 $XPUI_TEMP1
      
      StrCpy $XPUI_TEMP2 "NOTIFY"
      StrCmp $XPUI_TEMP1 0 0 +2
        StrCpy $XPUI_TEMP2 "NOTIFY|DISABLED"
      WriteINIStr $PLUGINSDIR\StartMenu.ini "Field 2" Flags $XPUI_TEMP2
      WriteINIStr $PLUGINSDIR\StartMenu.ini "Field 3" Flags $XPUI_TEMP2
      LockWindow off
      abort
    done:
      
      ReadINIStr ${XPUI_STARTMENUPAGE_VARIABLE} $PLUGINSDIR\StartMenu.ini "Field 2" State
      ReadINIStr $XPUI_TEMP1 $PLUGINSDIR\StartMenu.ini "Field 4" State
      StrCmp $XPUI_TEMP1 1 0 +2
        StrCpy ${XPUI_STARTMENUPAGE_VARIABLE} >${XPUI_STARTMENUPAGE_VARIABLE}
  
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION LEAVE
    
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1099
      ShowWindow $XPUI_TEMP1 5
    
  FunctionEnd

  !undef XPUI_STARTMENUPAGE_VARIABLE
  
  !ifdef XPUI_FASTERSKINNING
    !insertmacro XPUI_STARTMENUPAGE_KILLARRAY
  !endif
  
  !insertmacro XPUI_ENDPAGECHECKS
  
!macroend

!macro XPUI_PAGE_STARTMENU_SHOW ID
  
  PageEx ${XPUI_UNFUNC}custom 
    PageCallbacks ${XPUI_UNFUNC}xpui.StartMenu.show.${XPUI_STARTMENUPAGE_${ID}_ID} ${XPUI_UNFUNC}xpui.StartMenu.leave.${XPUI_STARTMENUPAGE_${ID}_ID}
    Caption "$(XPUI_${XPUI_UN}STARTMENUPAGE_CAPTION)"
  PageExEnd
  
  !undef XPUI_STARTMENUPAGE_${ID}_ID

!macroend

!macro XPUI_PAGE_STARTMENU ID VAR
  !insertmacro XPUI_PAGE_STARTMENU_INIT `${ID}` `${VAR}`
  !insertmacro XPUI_PAGE_STARTMENU_SHOW `${ID}`
!macroend

!macro XPUI_STARTMENUPAGE_INITARRAY

  !ifndef XPUI_INTERNAL_SMPAGE_ARRAY_DEFINED
  !define XPUI_INTERNAL_SMPAGE_ARRAY_DEFINED

  !include "NSISArray.nsh"
  ${Array} xpuiSM 1024 128
  ${ArrayFunc} Read
  ${ArrayFunc} Clear
  ${ArrayFunc} Push
  ${ArrayFunc} Reverse
  ${ArrayFunc} ReadFirst
  ${ArrayFunc} ReadNext
  ${ArrayFunc} Sort
  ${ArrayFunc} ExistsI
  ${ArrayFunc} ReadClose
  ${ArrayFunc} Debug
  !endif
!macroend

!macro XPUI_STARTMENUPAGE_KILLARRAY
  !ifdef xpui.ArrayNoValVar.notDefined
    !undef ArrayNoValVar
  !endif
!macroend

!macro XPUI_STARTMENUPAGE_CREATEINI
  !ifndef "xpuiSM${Array_Obj}Init"
    !insertmacro XPUI_STARTMENUPAGE_INITARRAY
  !endif
  SetOutPath $PLUGINSDIR
    IfFileExists $PLUGINSDIR\StartMenu.ini +2
    File "${XPUI_SYSDIR}\INI\StartMenu.ini"
    StrCpy $XPUI_TEMP2 ""

    !ifndef XPUI_INTERNAL_SMPAGE_ARRAY_INITED
    !define XPUI_INTERNAL_SMPAGE_ARRAY_INITED
    ${xpuiSM${Array_Obj}Init}
    !endif

    SetShellVarContext current
    FindFirst $XPUI_HWND $XPUI_TEMP1 "$SMPROGRAMS\*"
    FindNext  $XPUI_HWND $XPUI_TEMP1
      loop:
      FindNext  $XPUI_HWND $XPUI_TEMP1
      StrCmp $XPUI_TEMP1 "" exit
      IfFileExists $SMPROGRAMS\$XPUI_TEMP1\* add
      goto loop
      add:
        ${xpuiSM${Array_Obj}ExistsI} $XPUI_TEMP2 $XPUI_TEMP1 0
        StrCmp $XPUI_TEMP2 -1 "" NoAdd
          ${xpuiSM${Array_Obj}Push} $XPUI_TEMP1
        NoAdd:
      goto loop
      exit:
      FindClose $XPUI_HWND
    SetShellVarContext all
    FindFirst $XPUI_HWND $XPUI_TEMP1 "$SMPROGRAMS\*"
    FindNext  $XPUI_HWND $XPUI_TEMP1
      loop2:
      FindNext  $XPUI_HWND $XPUI_TEMP1
      StrCmp $XPUI_TEMP1 "" exit2
      IfFileExists $SMPROGRAMS\$XPUI_TEMP1\* add2
      goto loop2
      add2:
        ${xpuiSM${Array_Obj}ExistsI} $XPUI_TEMP2 $XPUI_TEMP1 0
        StrCmp $XPUI_TEMP2 -1 "" NoAdd2
          ${xpuiSM${Array_Obj}Push} $XPUI_TEMP1
        NoAdd2:
      goto loop2
      exit2:
      FindClose $XPUI_HWND

      ${xpuiSM${Array_Obj}Sort} ""

      ; Build the list
      StrCpy $XPUI_HWND  ""
      StrCpy $XPUI_TEMP1 ""
      StrCpy $XPUI_TEMP2 ""
      ClearErrors
      ${xpuiSM${Array_Obj}ReadFirst} $XPUI_TEMP1 $XPUI_TEMP2
        build:
        IfErrors finish
        StrCmp $XPUI_TEMP2 "" finish
        StrCpy $XPUI_HWND $XPUI_HWND|$XPUI_TEMP2
        ClearErrors
        ${xpuiSM${Array_Obj}ReadNext} $XPUI_TEMP1 $XPUI_TEMP2
        Goto build
      finish:
      ${xpuiSM${Array_Obj}ReadClose} $XPUI_TEMP1
      ${xpuiSM${Array_Obj}Delete}
      StrCpy $XPUI_HWND $XPUI_HWND "" 1
      
      WriteINIStr $PLUGINSDIR\StartMenu.ini "Field 3" ListItems $XPUI_HWND

!macroend

!macro XPUI_STARTMENU_GETFOLDER ID VAR

  !ifdef XPUI_STARTMENUPAGE_${ID}_REGISTRY_ROOT & XPUI_STARTMENUPAGE_${ID}_REGISTRY_KEY & XPUI_STARTMENUPAGE_${ID}_REGISTRY_VALUENAME

    ReadRegStr $XPUI_TEMP1 "${XPUI_STARTMENUPAGE_${ID}_REGISTRY_ROOT}" "${XPUI_STARTMENUPAGE_${ID}_REGISTRY_KEY}" "${XPUI_STARTMENUPAGE_${ID}_REGISTRY_VALUENAME}"
      StrCmp $XPUI_TEMP1 "" +3
        StrCpy "${VAR}" $XPUI_TEMP1
        Goto +2

        StrCpy "${VAR}" "${XPUI_STARTMENUPAGE_${ID}_DEFAULTFOLDER}"

   !else
   
     StrCpy "${VAR}" "${XPUI_STARTMENUPAGE_${ID}_DEFAULTFOLDER}"

   !endif

!macroend

!macro XPUI_STARTMENU_WRITE_BEGIN ID

  !verbose push
  !verbose ${XPUI_VERBOSE}

  !define XPUI_STARTMENUPAGE_CURRENT_ID "${ID}"

  StrCpy $XPUI_TEMP1 "${XPUI_STARTMENUPAGE_${XPUI_STARTMENUPAGE_CURRENT_ID}_VARIABLE}" 1
  StrCmp $XPUI_TEMP1 ">" XPUI.startmenu_write_${XPUI_STARTMENUPAGE_CURRENT_ID}_done

  StrCmp "${XPUI_STARTMENUPAGE_${XPUI_STARTMENUPAGE_CURRENT_ID}_VARIABLE}" "" 0 XPUI.startmenu_writebegin_${XPUI_STARTMENUPAGE_CURRENT_ID}_notempty

    !insertmacro XPUI_STARTMENU_GETFOLDER "${XPUI_STARTMENUPAGE_CURRENT_ID}" "${XPUI_STARTMENUPAGE_${XPUI_STARTMENUPAGE_CURRENT_ID}_VARIABLE}"

  XPUI.startmenu_writebegin_${XPUI_STARTMENUPAGE_CURRENT_ID}_notempty:

  !verbose pop

!macroend

!macro XPUI_STARTMENU_WRITE_END

  !verbose push
  !verbose ${XPUI_VERBOSE}

  !ifdef XPUI_STARTMENUPAGE_${XPUI_STARTMENUPAGE_CURRENT_ID}_REGISTRY_ROOT & XPUI_STARTMENUPAGE_${XPUI_STARTMENUPAGE_CURRENT_ID}_REGISTRY_KEY & XPUI_STARTMENUPAGE_${XPUI_STARTMENUPAGE_CURRENT_ID}_REGISTRY_VALUENAME
    WriteRegStr "${XPUI_STARTMENUPAGE_${XPUI_STARTMENUPAGE_CURRENT_ID}_REGISTRY_ROOT}" "${XPUI_STARTMENUPAGE_${XPUI_STARTMENUPAGE_CURRENT_ID}_REGISTRY_KEY}" "${XPUI_STARTMENUPAGE_${XPUI_STARTMENUPAGE_CURRENT_ID}_REGISTRY_VALUENAME}" "${XPUI_STARTMENUPAGE_${XPUI_STARTMENUPAGE_CURRENT_ID}_VARIABLE}"
  !endif

  XPUI.startmenu_write_${XPUI_STARTMENUPAGE_CURRENT_ID}_done:

  !undef XPUI_STARTMENUPAGE_CURRENT_ID

  !verbose pop

!macroend

; END START MENU PAGE

; INSTALL CONFIRMATION PAGE
!macro XPUI_PAGE_INSTCONFIRM

  !insertmacro XPUI_PAGECHECKS
  
  !ifndef XPUI_INTERNAL_PAGEUSED_INSTCONFIRM
    !define XPUI_INTERNAL_PAGEUSED_INSTCONFIRM
  !endif
  
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}INSTCONFIRMPAGE_TITLE "$(XPUI_${XPUI_UN}INSTCONFIRMPAGE_TITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}INSTCONFIRMPAGE_SUBTITLE "$(XPUI_${XPUI_UN}INSTCONFIRMPAGE_SUBTITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}INSTCONFIRMPAGE_CAPTION "$(XPUI_${XPUI_UN}INSTCONFIRMPAGE_CAPTION)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}INSTCONFIRMPAGE_TEXT_TOP "$(XPUI_${XPUI_UN}INSTCONFIRMPAGE_TEXT_TOP)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}INSTCONFIRMPAGE_TEXT_BOTTOM "$(XPUI_${XPUI_UN}INSTCONFIRMPAGE_TEXT_BOTTOM)"
  
  !insertmacro XPUI_CREATEID
  
  PageEx ${XPUI_UNFUNC}custom
    Caption `${XPUI_${XPUI_UN}INSTCONFIRMPAGE_CAPTION}`
    PageCallbacks `${XPUI_UNFUNC}XPUI.instconfirm.${XPUI_UNIQUEID}.show` `${XPUI_UNFUNC}XPUI.instconfirm.${XPUI_UNIQUEID}.verify`
  PageExEnd
  
  Function `${XPUI_UNFUNC}XPUI.instconfirm.${XPUI_UNIQUEID}.show`
    
    StrCmp $XPUI_ABORTED 1 0 +2
      Abort
      
    !ifdef XPUI_FASTERSKINNING
    SetOutPath $PLUGINSDIR
    File `${XPUI_SYSDIR}\INI\confirm.ini`
    !endif
    
    !insertmacro XPUI_HEADER_TEXT `${XPUI_${XPUI_UN}INSTCONFIRMPAGE_TITLE}` `${XPUI_${XPUI_UN}INSTCONFIRMPAGE_SUBTITLE}`
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION PRE
    
    WriteINIStr $PLUGINSDIR\Confirm.ini `Field 1` Text `${XPUI_${XPUI_UN}INSTCONFIRMPAGE_TEXT_TOP}`
    WriteINIStr $PLUGINSDIR\Confirm.ini `Field 2` Text `${XPUI_${XPUI_UN}INSTCONFIRMPAGE_TEXT_BOTTOM}`
    !ifdef XPUI_INSTCONFIRMPAGE_INFOBOX
      WriteINIStr $PLUGINSDIR\Confirm.ini `Field 2` Bottom 98
      WriteINIStr $PLUGINSDIR\Confirm.ini `Field 5` Type Text
      WriteINIStr $PLUGINSDIR\Confirm.ini `Field 5` Flags GROUP|MULTILINE|READONLY
      WriteINIStr $PLUGINSDIR\Confirm.ini `Field 5` Left 6
      WriteINIStr $PLUGINSDIR\Confirm.ini `Field 5` Right -1
      WriteINIStr $PLUGINSDIR\Confirm.ini `Field 5` Top 104
      WriteINIStr $PLUGINSDIR\Confirm.ini `Field 5` Bottom 204
      WriteINIStr $PLUGINSDIR\Confirm.ini `Field 5` State `Installation Settings:\r\n______________________________________________________________\r\n\r\nDestination folder: $INSTDIR`
    
      !ifdef XPUI_INTERNAL_STARTMENUPAGE_ID_DEFAULT
        !insertmacro XPUI_STARTMENU_WRITE_BEGIN ${XPUI_INTERNAL_STARTMENUPAGE_ID_DEFAULT}
        WriteINIStr $PLUGINSDIR\Confirm.ini `Field 5` State `Installation Settings:\r\n______________________________________________________________\r\n\r\nDestination folder: $INSTDIR\r\nStart Menu Folder: ${XPUI_STARTMENUPAGE_${XPUI_INTERNAL_STARTMENUPAGE_ID_DEFAULT}_VARIABLE}`
        !insertmacro XPUI_STARTMENU_WRITE_END
      !endif
      
      WriteINIStr $PLUGINSDIR\Confirm.ini `Settings` Numfields 5
    !endif
    WriteINIStr `$PLUGINSDIR\Confirm.ini` `Settings` `RTL` `$(^RTL)`
    InstallOptions::initDialog /NOUNLOAD $PLUGINSDIR\confirm.ini
    Pop $XPUI_TEMP2
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP2
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION SHOW
    
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1200
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1201
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1202
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1203
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1204
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    !ifndef XPUI_NOLOCK
    LockWindow off
    !endif
    
    !ifdef UMUI_CONFIRMPAGE_TEXTBOX
    Goto +2
    Call `${UMUI_CONFIRMPAGE_TEXTBOX}`
    !undef UMUI_CONFIRMPAGE_TEXTBOX
    !endif
          
    InstallOptions::show
    
  FunctionEnd
  
  Function `${XPUI_UNFUNC}XPUI.instconfirm.${XPUI_UNIQUEID}.verify`
    
    !ifndef XPUI_NOLOCK
    LockWindow on
    !endif
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION LEAVE
  
  FunctionEnd
  
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_PRE
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_SHOW
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_LEAVE
  
  !undef XPUI_${XPUI_UN}INSTCONFIRMPAGE_TITLE
  !undef XPUI_${XPUI_UN}INSTCONFIRMPAGE_SUBTITLE
  !undef XPUI_${XPUI_UN}INSTCONFIRMPAGE_CAPTION
  !undef XPUI_${XPUI_UN}INSTCONFIRMPAGE_TEXT_TOP
  !undef XPUI_${XPUI_UN}INSTCONFIRMPAGE_TEXT_BOTTOM
  
  !insertmacro XPUI_ENDPAGECHECKS
!macroend

; INSTFILES PAGE
!macro XPUI_PAGE_INSTFILES

  !ifdef UMUI_INSTFILEPAGE_ENABLE_CANCEL_BUTTON
    !ifndef UMUI_NB_CALL_FUNCTION_CANCEL_DEFINED
      !define UMUI_NB_CALL_FUNCTION_CANCEL_DEFINED
      Var UMUI_NB_CALL_FUNCTION_CANCEL
    !endif
  !endif

  !insertmacro XPUI_PAGECHECKS

  !ifndef XPUI_INTERNAL_PAGEUSED_INSTFILES
    !define XPUI_INTERNAL_PAGEUSED_INSTFILES
  !endif
  
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}INSTFILESPAGE_TITLE "$(XPUI_${XPUI_UN}INSTFILESPAGE_TITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}INSTFILESPAGE_SUBTITLE "$(XPUI_${XPUI_UN}INSTFILESPAGE_SUBTITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}INSTFILESPAGE_CAPTION "$(XPUI_${XPUI_UN}INSTFILESPAGE_CAPTION)"
  
  !insertmacro XPUI_CREATEID
  
  PageEx ${XPUI_UNFUNC}instfiles
    Caption `${XPUI_${XPUI_UN}INSTFILESPAGE_CAPTION}`
    PageCallbacks `${XPUI_UNFUNC}XPUI.cpy.${XPUI_UNIQUEID}.pre` `${XPUI_UNFUNC}XPUI.cpy.${XPUI_UNIQUEID}.show` `${XPUI_UNFUNC}XPUI.cpy.${XPUI_UNIQUEID}.leave`
  PageExEnd
  
  Function ${XPUI_UNFUNC}XPUI.cpy.${XPUI_UNIQUEID}.pre
    
    StrCmp $XPUI_ABORTED 1 0 +3
      SetAutoClose true
      Abort
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION PRE
    
    Return
    
  FunctionEnd
  
  Function ${XPUI_UNFUNC}XPUI.cpy.${XPUI_UNIQUEID}.show
  
    !insertmacro XPUI_HEADER_TEXT `${XPUI_${XPUI_UN}INSTFILESPAGE_TITLE}` `${XPUI_${XPUI_UN}INSTFILESPAGE_SUBTITLE}`
    
    FindWindow $XPUI_TEMP1 "#32770" "" $HWNDPARENT
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
  
    !insertmacro XPUI_PAGECOLOR_INIT 1027
    !insertmacro XPUI_PAGECOLOR_INIT 1004
    !insertmacro XPUI_PAGECOLOR_INIT 1006
    !insertmacro XPUI_PAGECOLOR_INIT 1016
    
    !ifdef XPUI_BGIMAGE
      FindWindow $XPUI_TEMP1 "#32770" "" $HWNDPARENT
      GetDlgItem $XPUI_TEMP1 $XPUI_TEMP1 1006
      ShowWindow $XPUI_TEMP1 0
    !endif
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION SHOW
    
      !ifdef UMUI_INSTFILEPAGE_ENABLE_CANCEL_BUTTON
      	StrCpy $UMUI_NB_CALL_FUNCTION_CANCEL 0
	GetDlgItem $XPUI_TEMP1 $HWNDPARENT 2
	EnableWindow $XPUI_TEMP1 1
      !endif
    
    LockWindow off
  FunctionEnd
    
  Function ${XPUI_UNFUNC}XPUI.cpy.${XPUI_UNIQUEID}.leave
  
        !ifdef UMUI_INSTFILEPAGE_ENABLE_CANCEL_BUTTON
		StrCmp $XPUI_ABORTED 1 0 +5
		StrCmp $UMUI_NB_CALL_FUNCTION_CANCEL 0 0 +4
		StrCpy $UMUI_NB_CALL_FUNCTION_CANCEL 1
		Call `${UMUI_INSTFILEPAGE_ENABLE_CANCEL_BUTTON}`
		SetAutoClose true
	!endif
	!insertmacro XPUI_UNSET UMUI_INSTFILEPAGE_ENABLE_CANCEL_BUTTON
    
    LockWindow on
    IfAbort 0 Good
    !insertmacro XPUI_HEADER_TEXT `$(XPUI_${XPUI_UN}INSTFILESPAGE_FAIL_TITLE)` `$(XPUI_${XPUI_UN}INSTFILESPAGE_FAIL_SUBTITLE)`
    Goto TitleFinish
    Good:
    !insertmacro XPUI_HEADER_TEXT `$(XPUI_${XPUI_UN}INSTFILESPAGE_DONE_TITLE)` `$(XPUI_${XPUI_UN}INSTFILESPAGE_DONE_SUBTITLE)`
    TitleFinish:
    LockWindow off
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION LEAVE
  
  FunctionEnd
  
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_PRE
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_SHOW
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_LEAVE
  
  !undef XPUI_${XPUI_UN}INSTFILESPAGE_TITLE
  !undef XPUI_${XPUI_UN}INSTFILESPAGE_SUBTITLE
  !undef XPUI_${XPUI_UN}INSTFILESPAGE_CAPTION
  
  !insertmacro XPUI_ENDPAGECHECKS
!macroend

; FINISH PAGE
!macro XPUI_PAGE_FINISH

  !insertmacro XPUI_PAGECHECKS

  !ifndef XPUI_INTERNAL_PAGEUSED_FINISH
    !define XPUI_INTERNAL_PAGEUSED_FINISH
  !endif
  
  !ifdef MUI_FINISHPAGE_LINK
    !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_LINK ""
    !insertmacro XPUI_SET XPUI_${XPUI_UN}FINISHPAGE_LINK_TEXT `${MUI_FINISHPAGE_LINK}`
    !ifdef MUI_FINISHPAGE_LINK_LOCATION
      !insertmacro XPUI_DEFAULT "XPUI_FINISHPAGE_LINK_LOCATION" "${MUI_FINISHPAGE_LINK_LOCATION}"
    !endif
  !endif
  
  !insertmacro XPUI_LANGUAGE_CONVERT
  
  !insertmacro XPUI_DEFAULT MUI_FINISHPAGE_TITLE             "$(XPUI_${XPUI_UN}FINISHPAGE_TEXT_TOP)"
  !insertmacro XPUI_DEFAULT MUI_FINISHPAGE_TEXT              "$(XPUI_${XPUI_UN}FINISHPAGE_TEXT)"
  !insertmacro XPUI_DEFAULT MUI_FINISHPAGE_BUTTON            "$(^CloseBtn)"
  !insertmacro XPUI_DEFAULT MUI_FINISHPAGE_TEXT_REBOOT       "$(XPUI_${XPUI_UN}FINISHPAGE_TEXT_REBOOT)"
  !insertmacro XPUI_DEFAULT MUI_FINISHPAGE_TEXT_REBOOTNOW    "$(XPUI_${XPUI_UN}FINISHPAGE_RADIOBUTTON_REBOOT)"
  !insertmacro XPUI_DEFAULT MUI_FINISHPAGE_TEXT_REBOOTLATER  "$(XPUI_${XPUI_UN}FINISHPAGE_RADIOBUTTON_NOREBOOT)"
  !insertmacro XPUI_DEFAULT MUI_FINISHPAGE_RUN_TEXT          "$(XPUI_${XPUI_UN}FINISHPAGE_CHECKBOX_RUN)"
  !insertmacro XPUI_DEFAULT MUI_FINISHPAGE_SHOWREADME_TEXT   "$(XPUI_${XPUI_UN}FINISHPAGE_CHECKBOX_DOCS)"
  !ifdef MUI_FINISHPAGE_NOREBOOTSUPPORT
    !define XPUI_${XPUI_UN}FINISHPAGE_REBOOT_DISABLE
    !undef MUI_FINISHPAGE_NOREBOOTSUPPORT
  !endif
  
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_TITLE "$(XPUI_${XPUI_UN}FINISHPAGE_TITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_SUBTITLE "$(XPUI_${XPUI_UN}FINISHPAGE_SUBTITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_CAPTION "$(XPUI_${XPUI_UN}FINISHPAGE_CAPTION)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_CHECKBOX_RUN  "$(XPUI_${XPUI_UN}FINISHPAGE_CHECKBOX_RUN)"   # No LangString for this one
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_CHECKBOX_DOCS "$(XPUI_${XPUI_UN}FINISHPAGE_CHECKBOX_DOCS)"  # No LangString for this one
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_TEXT "$(XPUI_${XPUI_UN}FINISHPAGE_TEXT)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_TEXT_RUN "$(XPUI_${XPUI_UN}FINISHPAGE_TEXT_RUN)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_TEXT_TOP "$(XPUI_${XPUI_UN}FINISHPAGE_TEXT_TOP)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_TEXT_TOP_ALT "$(XPUI_${XPUI_UN}FINISHPAGE_TEXT_TOP_ALT)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_TEXT_REBOOT "$(XPUI_${XPUI_UN}FINISHPAGE_TEXT_REBOOT)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_REBOOT_MESSAGEBOX "$(XPUI_${XPUI_UN}FINISHPAGE_REBOOT_MESSAGEBOX)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_RADIOBUTTON_REBOOT "$(XPUI_${XPUI_UN}FINISHPAGE_RADIOBUTTON_REBOOT)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}FINISHPAGE_RADIOBUTTON_NOREBOOT "$(XPUI_${XPUI_UN}FINISHPAGE_RADIOBUTTON_NOREBOOT)"
  
  PageEx ${XPUI_UNFUNC}custom
    Caption `${XPUI_${XPUI_UN}FINISHPAGE_CAPTION}`
    PageCallbacks `${XPUI_UNFUNC}XPUI.finish.${XPUI_UNIQUEID}.show` `${XPUI_UNFUNC}XPUI.finish.${XPUI_UNIQUEID}.verify`
  PageExEnd
  
  !ifndef XPUI_VAR_REBOOT
  Var XPUI_REBOOT
  !define XPUI_VAR_REBOOT
  !endif
  
  Function `${XPUI_UNFUNC}XPUI.FINISH.${XPUI_UNIQUEID}.show`
  
    StrCmp $XPUI_ABORTED 1 0 +2
      Abort
    
    ; Set the ExUI local reboot flag
    StrCpy $XPUI_REBOOT 0
    
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_REBOOT_FORCE
      StrCpy $XPUI_REBOOT 1
    !endif
    
    !ifndef XPUI_${XPUI_UN}FINISHPAGE_NOREBOOT
      IfRebootFlag `` +2
        StrCpy $XPUI_REBOOT 1
    !endif
    
    !ifdef `XPUI_${XPUI_UN}FINISHPAGE_ABORT_ON_NOREBOOT`
      StrCmp $XPUI_REBOOT 1 `` 0 +2
        Abort
    !endif
    
    ; Extract the INI
    !ifdef XPUI_FASTERSKINNING
    SetOutPath $PLUGINSDIR
    File `${XPUI_SYSDIR}\INI\finish.ini`
    !endif
    
    !insertmacro XPUI_HEADER_TEXT `${XPUI_${XPUI_UN}FINISHPAGE_TITLE}` `${XPUI_${XPUI_UN}FINISHPAGE_SUBTITLE}`
    
    StrCmp $XPUI_REBOOT 1 `` XPUI.finish.norb.${XPUI_UNIQUEID}
    WriteINIStr $PLUGINSDIR\Finish.ini `Field 1` Type RadioButton
    WriteINIStr $PLUGINSDIR\Finish.ini `Field 2` Type RadioButton
    WriteINIStr $PLUGINSDIR\Finish.ini `Field 1` Text `${XPUI_${XPUI_UN}FINISHPAGE_RADIOBUTTON_REBOOT}`
    WriteINIStr $PLUGINSDIR\Finish.ini `Field 2` Text `${XPUI_${XPUI_UN}FINISHPAGE_RADIOBUTTON_NOREBOOT}`
    XPUI.finish.norb.${XPUI_UNIQUEID}:
    
    StrCmp $XPUI_REBOOT 1 XPUI.nochk
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_RUN_NOTCHECKED
    WriteINIStr $PLUGINSDIR\Finish.ini `Field 1` State 0
    !endif
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_DOCS_NOTCHECKED
    WriteINIStr $PLUGINSDIR\Finish.ini `Field 2` State 0
    !endif
    XPUI.nochk:
    
    StrCmp $XPUI_REBOOT 1 `` +2
    WriteINIStr $PLUGINSDIR\Finish.ini `Field 2` State 0
    
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_LINK_TEXT
    WriteINIStr $PLUGINSDIR\Finish.ini `Field 3` Text `${XPUI_${XPUI_UN}FINISHPAGE_LINK_TEXT}`
    !endif
    
    StrCmp $XPUI_REBOOT 1 `` +3
    WriteINIStr $PLUGINSDIR\Finish.ini `Field 5` Text  `${XPUI_${XPUI_UN}FINISHPAGE_TEXT_REBOOT}`
    Goto +2
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_RUN & XPUI_${XPUI_UN}FINISHPAGE_DOCS
    WriteINIStr $PLUGINSDIR\Finish.ini `Field 5` Text `${XPUI_${XPUI_UN}FINISHPAGE_TEXT_RUN}`
    !else
    WriteINIStr $PLUGINSDIR\Finish.ini `Field 5` Text `${XPUI_${XPUI_UN}FINISHPAGE_TEXT}`
    !endif
    
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_TEXT_USE_TOP_ALT
    WriteINIStr $PLUGINSDIR\Finish.ini `Field 4` Top 17
    !endif
    
    !ifndef XPUI_FINISHPAGE_NOCLOSEBUTTON
      WriteINIStr $PLUGINSDIR\Finish.ini Settings NextButtonText $(XPUI_BUTTONTEXT_CLOSE)
    !endif
    
    WriteINIStr `$PLUGINSDIR\Finish.ini` `Settings` `RTL` `$(^RTL)`
    InstallOptions::initDialog /NOUNLOAD $PLUGINSDIR\finish.ini
    Pop $XPUI_TEMP2
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP2
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1
    EnableWindow $XPUI_TEMP1 1
    !ifndef XPUI_FINISHPAGE_NOCLOSEBUTTON
    SendMessage $XPUI_TEMP1 0xC 0 STR:$(XPUI_BUTTONTEXT_CLOSE)
    !endif
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 2
    SendMessage $XPUI_TEMP1 0xC `` `STR:$(^CancelBtn)`
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_CANCEL_ENABLE
    EnableWindow $XPUI_TEMP1 1
    !else
    EnableWindow $XPUI_TEMP1 0
    !endif
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 3
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_NO_REINSTALL
      EnableWindow $XPUI_TEMP1 0
    !endif
    
    LockWindow on
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1200
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    StrCmp $XPUI_REBOOT 1 a
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_RUN
    SendMessage $XPUI_TEMP1 0xC 0 `STR:${XPUI_${XPUI_UN}FINISHPAGE_CHECKBOX_RUN}`
    !endif
    a:
    
    StrCmp $XPUI_REBOOT 1 XPUI.norunchk
    !ifndef XPUI_${XPUI_UN}FINISHPAGE_RUN
    ShowWindow $XPUI_TEMP1 0
    !endif
    XPUI.norunchk:
    
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1201
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    StrCmp $XPUI_REBOOT 1 b
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_DOCS
    SendMessage $XPUI_TEMP1 0xC 0 `STR:${XPUI_${XPUI_UN}FINISHPAGE_CHECKBOX_DOCS}`
    !endif
    b:
    
    StrCmp $XPUI_REBOOT 1 XPUI.nodocchk
    !ifndef XPUI_${XPUI_UN}FINISHPAGE_DOCS
    ShowWindow $XPUI_TEMP1 0
    !endif
    XPUI.nodocchk:
    
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1203
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1203
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    SendMessage $XPUI_TEMP1 0xC 0 `STR:${XPUI_${XPUI_UN}FINISHPAGE_TEXT_TOP}`
    CreateFont $XPUI_HWND `$(^Font)` 12 700 ; previously Tahoma
    SendMessage $XPUI_TEMP1 0x30 $XPUI_HWND $XPUI_HWND
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_TEXT_USE_TOP_ALT
      SendMessage $XPUI_TEMP1 0xC 0 `STR:${XPUI_${XPUI_UN}FINISHPAGE_TEXT_TOP_ALT}`
      CreateFont $XPUI_HWND `$(^Font)` 8 700 ; previously MS Sans Serif
      SendMessage $XPUI_TEMP1 0x30 $XPUI_HWND $XPUI_HWND
    !endif
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1204
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    
    !ifndef XPUI_${XPUI_UN}FINISHPAGE_RUN & XPUI_${XPUI_UN}FINISHPAGE_DOCS
    StrCmp $XPUI_REBOOT 1 XPUI.no-normal-text
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1200
    ShowWindow $XPUI_TEMP1 0
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1201
    ShowWindow $XPUI_TEMP1 0
    XPUI.no-normal-text:
    !endif
    
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1202
    !insertmacro XPUI_CONTROL_SKIN_LIGHT $XPUI_TEMP1
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_LINK_TEXT
    SendMessage $XPUI_TEMP1 0xC 0 `STR:${XPUI_${XPUI_UN}FINISHPAGE_LINK_TEXT}`
    !endif
    !ifndef XPUI_${XPUI_UN}FINISHPAGE_LINK
    ShowWindow $XPUI_TEMP1 0
    !endif
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION SHOW
    SetBrandingImage /IMGID=1019 /RESIZETOFIT "$PLUGINSDIR\page.bmp"
    
    LockWindow off
    InstallOptions::show
  FunctionEnd
  
  Function `${XPUI_UNFUNC}XPUI.FINISH.${XPUI_UNIQUEID}.verify`
    StrCmp $XPUI_ABORTED 1 XPUI.grinding-halt
    
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_LINK
    ReadINIStr $XPUI_TEMP1 `$PLUGINSDIR\Finish.ini` `Settings` `State`
    StrCmp $XPUI_TEMP1 3 `` XPUI.nolink
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_LINK_FUNCTION
    Call `${XPUI_${XPUI_UN}FINISHPAGE_LINK_FUNCTION}`
    !else
      !ifdef XPUI_${XPUI_UN}FINISHPAGE_LINK_LOCATION
        ExecShell open `${XPUI_${XPUI_UN}FINISHPAGE_LINK_LOCATION}`
      !else
        MessageBox MB_OK|MB_ICONINFORMATION `Developer: Please specify a function for the Finish Page link to run in the symbol XPUI_${XPUI_UN}FINISHPAGE_LINK_FUNCTION or specify a location (local or http) to load in XPUI_${XPUI_UN}FINISHPAGE_LINK_LOCATION.  The Abort command is called automatically.$\n$\nUser: The developer of this setup program specified that a link be shown on this page, but he/she did not define what the link will do.  Please contact the company from which you obtained this installer and tell them about this message.`
      !endif
    !endif
    LockWindow off
    Abort
    XPUI.nolink:
    !endif
    
    !ifndef XPUI_${XPUI_UN}FINISHPAGE_NOREBOOT
    ReadINIStr $XPUI_TEMP1 `$PLUGINSDIR\Finish.ini` `Settings` `State`
    StrCmp $XPUI_TEMP1 1 `` XPUI.nodonebutton
    StrCmp $XPUI_TEMP1 2 `` XPUI.nodonebutton
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1
    EnableWindow $XPUI_TEMP1 1
    Abort
    XPUI.nodonebutton:
    !endif
    
    ReadINIStr $XPUI_TEMP1 `$PLUGINSDIR\Finish.ini` `Field 1` `State`
    ReadINIStr $XPUI_TEMP2 `$PLUGINSDIR\Finish.ini` `Field 2` `State`
    
    StrCmp $XPUI_REBOOT 1 `` XPUI.norb2
    StrCmp $XPUI_TEMP1 1 `` XPUI.norb
    MessageBox MB_OKCANCEL|MB_ICONINFORMATION `${XPUI_${XPUI_UN}FINISHPAGE_REBOOT_MESSAGEBOX}` IDCANCEL XPUI.done
    # the big...
    Reboot # REBOOT! (Wow)
    XPUI.norb:
    Goto XPUI.done
    
    XPUI.norb2:
    
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_RUN
      !ifdef XPUI_${XPUI_UN}FINISHPAGE_RUN_FILE
        StrCmp $XPUI_TEMP1 1 `` NoCallRun
        Exec `${XPUI_${XPUI_UN}FINISHPAGE_RUN_FILE}`
      !endif
      !ifdef XPUI_${XPUI_UN}FINISHPAGE_RUN_FUNCTION
        StrCmp $XPUI_TEMP1 1 `` NoCallRun
        Call `${XPUI_${XPUI_UN}FINISHPAGE_RUN_FUNCTION}`
      !endif
      NoCallRun:
    !endif
    
    !ifdef XPUI_${XPUI_UN}FINISHPAGE_DOCS
      !ifdef XPUI_${XPUI_UN}FINISHPAGE_DOCS_FILE
      StrCmp $XPUI_TEMP2 1 `` NoCallDocs
      ExecShell open `${XPUI_${XPUI_UN}FINISHPAGE_DOCS_FILE}`
      !endif
      !ifdef XPUI_${XPUI_UN}FINISHPAGE_DOCS_FUNCTION
      StrCmp $XPUI_TEMP2 1 `` NoCallDocs
      Call `${XPUI_${XPUI_UN}FINISHPAGE_DOCS_FUNCTION}`
      !endif
      NoCallDocs:
    !endif
    
    XPUI.done:
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION LEAVE
    
    XPUI.grinding-halt:
    SetRebootFlag false
  
  FunctionEnd
  
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_PRE
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_SHOW
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_LEAVE
  
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_LINK
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_LINK_FUNCTION
  
  !insertmacro XPUI_UNSET MUI_FINISHPAGE_LINK
  !insertmacro XPUI_UNSET MUI_FINISHPAGE_LINK_LOCATION
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_LINK_LOCATION
  
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_RUN
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_RUN_FILE
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_RUN_FUNCTION
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_DOCS
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_DOCS_FILE
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_DOCS_FUNCTION
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_REBOOT_DISABLE
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_REBOOT_FORCE
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_CHECKBOX_RUN
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_CHECKBOX_DOCS
  !insertmacro XPUI_UNSET XPUI_UNFINISHPAGE_CHECKBOX_RUN
  !insertmacro XPUI_UNSET XPUI_UNFINISHPAGE_CHECKBOX_DOCS
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_NOCLOSEBUTTON
  !insertmacro XPUI_UNSET XPUI_${XPUI_UN}FINISHPAGE_CANCEL_ENABLE
  
  !undef XPUI_${XPUI_UN}FINISHPAGE_CAPTION
  !undef XPUI_${XPUI_UN}FINISHPAGE_TITLE
  !undef XPUI_${XPUI_UN}FINISHPAGE_SUBTITLE
  !undef XPUI_${XPUI_UN}FINISHPAGE_TEXT_TOP
  !undef XPUI_${XPUI_UN}FINISHPAGE_TEXT_TOP_ALT
  !undef XPUI_${XPUI_UN}FINISHPAGE_TEXT
  !undef XPUI_${XPUI_UN}FINISHPAGE_TEXT_RUN
  !undef XPUI_${XPUI_UN}FINISHPAGE_TEXT_REBOOT
  !undef XPUI_${XPUI_UN}FINISHPAGE_RADIOBUTTON_REBOOT
  !undef XPUI_${XPUI_UN}FINISHPAGE_RADIOBUTTON_NOREBOOT
  !undef XPUI_${XPUI_UN}FINISHPAGE_REBOOT_MESSAGEBOX
  
  !undef MUI_FINISHPAGE_TITLE
  !undef MUI_FINISHPAGE_TEXT
  !undef MUI_FINISHPAGE_BUTTON
  !undef MUI_FINISHPAGE_TEXT_REBOOT
  !undef MUI_FINISHPAGE_TEXT_REBOOTNOW
  !undef MUI_FINISHPAGE_TEXT_REBOOTLATER
  !undef MUI_FINISHPAGE_RUN_TEXT
  !undef MUI_FINISHPAGE_SHOWREADME_TEXT
  
  !verbose pop

!macroend

; INSTALL SUCCESS PAGE
!macro XPUI_PAGE_INSTSUCCESS

  !insertmacro XPUI_PAGECHECKS

  !ifndef XPUI_INTERNAL_PAGEUSED_INSTSUCCESS
    !define XPUI_INTERNAL_PAGEUSED_INSTSUCCESS
  !endif
  
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}INSTSUCCESSPAGE_TITLE "$(XPUI_${XPUI_UN}INSTSUCCESSPAGE_TITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}INSTSUCCESSPAGE_SUBTITLE "$(XPUI_${XPUI_UN}INSTSUCCESSPAGE_SUBTITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}INSTSUCCESSPAGE_CAPTION "$(XPUI_${XPUI_UN}INSTSUCCESSPAGE_CAPTION)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}INSTSUCCESSPAGE_TEXT_TOP "$(XPUI_${XPUI_UN}INSTSUCCESSPAGE_TEXT_TOP)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}INSTSUCCESSPAGE_TEXT_BOTTOM "$(XPUI_${XPUI_UN}INSTSUCCESSPAGE_TEXT_BOTTOM)"
  
  !insertmacro XPUI_CREATEID
  
  PageEx ${XPUI_UNFUNC}custom
    Caption `${XPUI_${XPUI_UN}INSTSUCCESSPAGE_CAPTION}`
    PageCallbacks `${XPUI_UNFUNC}XPUI.instSuccess.${XPUI_UNIQUEID}.show` `${XPUI_UNFUNC}XPUI.instSuccess.${XPUI_UNIQUEID}.verify`
  PageExEnd
  
  Function `${XPUI_UNFUNC}XPUI.instSuccess.${XPUI_UNIQUEID}.show`
    StrCmp $XPUI_ABORTED 1 0 +2
      Abort
      
    !ifdef XPUI_FASTERSKINNING
    SetOutPath $PLUGINSDIR
    File `${XPUI_SYSDIR}\INI\confirm.ini`
    !endif
    
    !insertmacro XPUI_HEADER_TEXT `${XPUI_${XPUI_UN}INSTSUCCESSPAGE_TITLE}` `${XPUI_${XPUI_UN}INSTSUCCESSPAGE_SUBTITLE}`
    
    WriteINIStr $PLUGINSDIR\Confirm.ini `Settings` NextButtonText `Close`
    WriteINIStr $PLUGINSDIR\Confirm.ini `Field 1` Text `${XPUI_${XPUI_UN}INSTSUCCESSPAGE_TEXT_TOP}`
    WriteINIStr $PLUGINSDIR\Confirm.ini `Field 2` Text `${XPUI_${XPUI_UN}INSTSUCCESSPAGE_TEXT_BOTTOM}`
    WriteINIStr `$PLUGINSDIR\Confirm.ini` `Settings` `RTL` `$(^RTL)`
    InstallOptions::initDialog /NOUNLOAD $PLUGINSDIR\confirm.ini
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1
    EnableWindow $XPUI_TEMP1 0
    SendMessage $XPUI_TEMP1 0xC `` `STR:Next`
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 2
    SendMessage $XPUI_TEMP1 0xC `` `STR:Close`
    EnableWindow $XPUI_TEMP1 1
    Pop $XPUI_TEMP2
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP2
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION SHOW
    
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1200
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1201
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1202
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1203
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    GetDlgItem $XPUI_TEMP1 $XPUI_TEMP2 1204
    !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
    StrCpy $XPUI_NOABORTWARNING 1
    SetBrandingImage /IMGID=1019 /RESIZETOFIT "$PLUGINSDIR\page.bmp"
    !ifndef XPUI_NOLOCK
    LockWindow off
    !endif
    InstallOptions::show
  FunctionEnd
  
  Function `${XPUI_UNFUNC}XPUI.instSuccess.${XPUI_UNIQUEID}.verify`
    
    !ifndef XPUI_NOLOCK
    LockWindow on
    !endif
    
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION LEAVE
    
  FunctionEnd
  
  !undef XPUI_${XPUI_UN}INSTSUCCESSPAGE_CAPTION
  !undef XPUI_${XPUI_UN}INSTSUCCESSPAGE_TITLE
  !undef XPUI_${XPUI_UN}INSTSUCCESSPAGE_SUBTITLE
  !undef XPUI_${XPUI_UN}INSTSUCCESSPAGE_TEXT_TOP
  !undef XPUI_${XPUI_UN}INSTSUCCESSPAGE_TEXT_BOTTOM
  
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_PRE
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_SHOW
  !insertmacro XPUI_UNSET XPUI_PAGE_CUSTOMFUNCTION_LEAVE
  
  !insertmacro XPUI_ENDPAGECHECKS
  
!macroend

!macro XPUI_PAGE_ABORT

  !insertmacro XPUI_PAGECHECKS
  
  !ifndef XPUI_INTERNAL_PAGEUSED_ABORT
    !define XPUI_INTERNAL_PAGEUSED_ABORT
  !endif
  
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}ABORTPAGE_TITLE "$(XPUI_${XPUI_UN}ABORTPAGE_TITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}ABORTPAGE_SUBTITLE "$(XPUI_${XPUI_UN}ABORTPAGE_SUBTITLE)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}ABORTPAGE_TEXT_TOP "$(XPUI_${XPUI_UN}ABORTPAGE_TEXT_TOP)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}ABORTPAGE_TEXT "$(XPUI_${XPUI_UN}ABORTPAGE_TEXT)"
  !insertmacro XPUI_DEFAULT XPUI_${XPUI_UN}ABORTPAGE_CAPTION "$(XPUI_${XPUI_UN}ABORTPAGE_CAPTION)"
  
  !insertmacro XPUI_CREATEID
  
  PageEx ${XPUI_UNFUNC}custom
  PageCallbacks ${XPUI_UNFUNC}XPUI.io.ABORTPAGE.${XPUI_UNIQUEID} ${XPUI_UNFUNC}XPUI.io.ABORTPAGE.${XPUI_UNIQUEID}.leave
  Caption `${XPUI_${XPUI_UN}ABORTPAGE_CAPTION}`
  PageExEnd

  Function ${XPUI_UNFUNC}XPUI.io.ABORTPAGE.${XPUI_UNIQUEID}
    LockWindow on
    StrCmp $XPUI_ABORTED 1 +2
      Abort
    
    SetOutPath $PLUGINSDIR
    File `${XPUI_SYSDIR}\INI\isWelcome.ini`

    !insertmacro XPUI_PAGE_CUSTOMFUNCTION PRE    

    WriteINIStr $PLUGINSDIR\isWelcome.ini `Field 1` Text `${XPUI_${XPUI_UN}ABORTPAGE_TEXT_TOP}`
    WriteINIStr $PLUGINSDIR\isWelcome.ini `Field 2` Text `${XPUI_${XPUI_UN}ABORTPAGE_TEXT}`
    WriteINIStr `$PLUGINSDIR\isWelcome.ini` `Settings` `RTL` `$(^RTL)`
    
    InstallOptions::initDialog /NOUNLOAD `$PLUGINSDIR\isWelcome.ini`
      
      Pop $XPUI_HWND
      !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_HWND
      
      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1200
        CreateFont $XPUI_TEMP2 `$(^Font)` 8 700 ; previously Tahoma
        SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 $XPUI_TEMP2
        !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
      
      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1201
        CreateFont $XPUI_TEMP2 `$(^Font)` 8 350 ; previously Tahoma
        SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 $XPUI_TEMP2
        !insertmacro XPUI_CONTROL_SKIN_PAGE $XPUI_TEMP1
      
      !insertmacro XPUI_HEADER_TEXT `${XPUI_${XPUI_UN}ABORTPAGE_TITLE}` `${XPUI_${XPUI_UN}ABORTPAGE_SUBTITLE}`
      
      StrCpy $XPUI_NOABORTWARNING 1
      
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1
      EnableWindow $XPUI_TEMP1 0
      SendMessage $XPUI_TEMP1 0xC 0 STR:$(^NextBtn)
      
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 3
      EnableWindow $XPUI_TEMP1 0
      SendMessage $XPUI_TEMP1 0xC 0 STR:$(^BackBtn)
      
      GetDlgItem $XPUI_TEMP1 $HWNDPARENT 2
      EnableWindow $XPUI_TEMP1 1
      SendMessage $XPUI_TEMP1 0xC 0 STR:$(^CloseBtn)
      
      !insertmacro XPUI_PAGE_CUSTOMFUNCTION SHOW
      
      LockWindow off
      
    InstallOptions::show
    FunctionEnd
    
    Function ${XPUI_UNFUNC}XPUI.io.ABORTPAGE.${XPUI_UNIQUEID}.leave
    !ifndef XPUI_NOLOCK
    LockWindow on
    !endif
    !insertmacro XPUI_PAGE_CUSTOMFUNCTION LEAVE
  FunctionEnd
  
  !undef XPUI_${XPUI_UN}ABORTPAGE_TITLE
  !undef XPUI_${XPUI_UN}ABORTPAGE_SUBTITLE
  !undef XPUI_${XPUI_UN}ABORTPAGE_TEXT_TOP
  !undef XPUI_${XPUI_UN}ABORTPAGE_TEXT
  !undef XPUI_${XPUI_UN}ABORTPAGE_CAPTION
  
  !insertmacro XPUI_ENDPAGECHECKS

!macroend

!macro XPUI_PAGE_UNINSTCONFIRM_NSIS

!insertmacro XPUI_PAGECHECKS

!insertmacro XPUI_CREATEID
PageEx un.uninstConfirm
Caption `$(XPUI_UNINSTCONFIRMPAGE_NSIS_CAPTION)`
PageCallbacks `un.XPUI.unc_NSIS.${XPUI_UNIQUEID}.pre` `un.XPUI.unc_NSIS.${XPUI_UNIQUEID}.show` `un.XPUI.unc_NSIS.${XPUI_UNIQUEID}.leave`
PageExEnd

Function `un.XPUI.unc_NSIS.${XPUI_UNIQUEID}.pre`
StrCmp $XPUI_ABORTED 1 `` +2
Abort
!insertmacro XPUI_PAGE_CUSTOMFUNCTION PRE
FunctionEnd

Function `un.XPUI.unc_NSIS.${XPUI_UNIQUEID}.show`

!insertmacro XPUI_HEADER_TEXT `$(XPUI_UNINSTCONFIRMPAGE_NSIS_TITLE)` `$(XPUI_UNINSTCONFIRMPAGE_NSIS_SUBTITLE)`

FindWindow $XPUI_TEMP1 `#32770` `` $HWNDPARENT
!insertmacro XPUI_CONTROL_SKIN $XPUI_TEMP1

!insertmacro XPUI_PAGECOLOR_INIT 1019
!insertmacro XPUI_PAGECOLOR_INIT 1029
!insertmacro XPUI_PAGECOLOR_INIT 1000
!insertmacro XPUI_PAGECOLOR_INIT 1006

!insertmacro XPUI_INNERDIALOG_TEXT `$(XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_TOP)` 1006
!insertmacro XPUI_INNERDIALOG_TEXT `$(XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_FOLDER)` 1029
!ifndef XPUI_NOLOCK
LockWindow off
!endif
!insertmacro XPUI_PAGE_CUSTOMFUNCTION SHOW
FunctionEnd

Function `un.XPUI.unc_NSIS.${XPUI_UNIQUEID}.leave`
!insertmacro XPUI_PAGE_CUSTOMFUNCTION LEAVE
FunctionEnd
!insertmacro XPUI_ENDPAGECHECKS
!macroEnd

; Page Command

!macro XPUI_PAGE pname
  !define `XPUI_PAGE_CHECK_${pname}`
    !ifdef `XPUI_PAGE_CHECK_Welcome`
    !insertmacro XPUI_PAGE_WELCOME
    !else ifdef `XPUI_PAGE_CHECK_Welcome2`
    !insertmacro XPUI_PAGE_WELCOME2
    !else ifdef `XPUI_PAGE_CHECK_Components`
    !insertmacro XPUI_PAGE_COMPONENTS
    !else ifdef `XPUI_PAGE_CHECK_Directory`
    !insertmacro XPUI_PAGE_DIRECTORY
    !else ifdef `XPUI_PAGE_CHECK_InstConfirm`
    !insertmacro XPUI_PAGE_INSTCONFIRM
    !else ifdef `XPUI_PAGE_CHECK_InstFiles`
    !insertmacro XPUI_PAGE_INSTFILES
    !else ifdef `XPUI_PAGE_CHECK_InstSuccess`
    !insertmacro XPUI_PAGE_INSTSUCCESS
    !else ifdef `XPUI_PAGE_CHECK_Finish`
    !insertmacro XPUI_PAGE_FINISH
    !else ifdef `XPUI_PAGE_CHECK_Abort`
    !insertmacro XPUI_PAGE_ABORT
    !else
    !verbose 4
    !define temp.TEXT {Page}
    !error "ExperienceUI: FATAL: Improper use of $${temp.TEXT} command.$\nUsage: $${temp.TEXT} (Welcome|Welcome2|Components|Directory|InstConfirm|InstFiles|Finish|InstSuccess|Abort)$\nNOTE: License and StartMenu pages must be inserted the old way."
    !endif
  !undef  `XPUI_PAGE_CHECK_${pname}`
!macroend

!macro XPUI_UNPAGE pname
  !insertmacro XPUI_PAGEMODE_PUSH
  !insertmacro XPUI_PAGEMODE_UNINST
  !define `XPUI_PAGE_CHECK_${pname}`
    !ifdef `XPUI_PAGE_CHECK_Welcome`
    !insertmacro XPUI_PAGE_WELCOME
    !else ifdef `XPUI_PAGE_CHECK_Welcome2`
    !insertmacro XPUI_PAGE_WELCOME2
    !else ifdef `XPUI_PAGE_CHECK_Components`
    !insertmacro XPUI_PAGE_COMPONENTS
    !else ifdef `XPUI_PAGE_CHECK_Directory`
    !insertmacro XPUI_PAGE_DIRECTORY
    !else ifdef `XPUI_PAGE_CHECK_InstConfirm`
    !insertmacro XPUI_PAGE_INSTCONFIRM
    !else ifdef `XPUI_PAGE_CHECK_InstFiles`
    !insertmacro XPUI_PAGE_INSTFILES
    !else ifdef `XPUI_PAGE_CHECK_InstSuccess`
    !insertmacro XPUI_PAGE_INSTSUCCESS
    !else ifdef `XPUI_PAGE_CHECK_Finish`
    !insertmacro XPUI_PAGE_FINISH
    !else ifdef `XPUI_PAGE_CHECK_Abort`
    !insertmacro XPUI_PAGE_ABORT
    !else ifdef `XPUI_PAGE_CHECK_UnConfirm`
    !insertmacro XPUI_PAGE_UNINSTCONFIRM_NSIS
    !else
    !verbose 4
    !define temp.TEXT {UnPage}
    !error "ExperienceUI: FATAL: Improper use of $${temp.TEXT} command.$\nUsage: $${temp.TEXT} (Welcome|Welcome2|Components|Directory|InstConfirm|InstFiles|Finish|InstSuccess|Abort)$\nNOTE: License and StartMenu pages must be inserted the old way."
    !endif
  !undef  `XPUI_PAGE_CHECK_${pname}`
  !insertmacro XPUI_PAGEMODE_POP
!macroend

!define Page "!insertmacro XPUI_PAGE"
!define UnPage "!insertmacro XPUI_UNPAGE"
!define StartMenuPage "!insertmacro XPUI_PAGE_STARTMENU"
!define LicensePage "!insertmacro XPUI_PAGE_LICENSE"

; SECTION DESCRIPTION CODE
; WRITTEN BY JOOST VERBURG

!macro XPUI_DESCRIPTION_BEGIN
FindWindow $XPUI_TEMP1 `#32770` `` $HWNDPARENT
GetDlgItem $XPUI_TEMP1 $XPUI_TEMP1 1043
StrCmp $0 -1 0 XPUI.description_begin_done
SendMessage $XPUI_TEMP1 0xC 0 `STR:$XPUI_HWND`
EnableWindow $XPUI_TEMP1 0

Goto XPUI.description_done
XPUI.description_begin_done:
!macroend

!macro XPUI_DESCRIPTION_TEXT VAR TEXT
!verbose push
  !verbose 4
  !ifndef XPUI_SILENT
    !echo `XPUI Section Description Text: Section ${VAR}, Text "${TEXT}"`
  !endif
  !verbose ${XPUI_VERBOSE}
StrCmp $0 ${VAR} 0 XPUI.description_${VAR}_done
SendMessage $XPUI_TEMP1 0xC 0 `STR:`
EnableWindow $XPUI_TEMP1 1
SendMessage $XPUI_TEMP1 0xC 0 `STR:${TEXT}`
Goto XPUI.description_done
XPUI.description_${VAR}_done:
!verbose pop
!macroend

!macro XPUI_DESCRIPTION_END
XPUI.description_done:
!macroend


!macro XPUI_FUNCTION_DESCRIPTION_BEGIN
!verbose push
  !verbose 4
  !ifndef XPUI_SILENT
    !echo `!insertmacro: XPUI_FUNCTION_DESCRIPTION_BEGIN (Start Description Function)`
  !endif
  !verbose ${XPUI_VERBOSE}
Function .onMouseOverSection
FindWindow $XPUI_TEMP1 `#32770` `` $HWNDPARENT
GetDlgItem $XPUI_TEMP1 $XPUI_TEMP1 1042
SendMessage $XPUI_TEMP1 0xC 0 `STR:$XPUI_TEMP2`
!insertmacro XPUI_DESCRIPTION_BEGIN
!verbose pop
!macroend

!macro XPUI_FUNCTION_DESCRIPTION_END
!verbose push
  !verbose 4
  !ifndef XPUI_SILENT
    !echo `!insertmacro: XPUI_FUNCTION_DESCRIPTION_END (End Description Function)`
  !endif
  !verbose ${XPUI_VERBOSE}
!insertmacro XPUI_DESCRIPTION_END
FunctionEnd
!verbose pop
!macroend

; END SECTION DESCRIPTION CODE

; Macros - Left Info Panel
!macro XPUI_LEFT_SETTIME M

  Push $XPUI_TEMP1
  
    !ifndef XPUI_BGIMAGE
    SetBrandingImage /IMGID=1302 "$PLUGINSDIR\LeftImg.bmp"
    !else
    SetBrandingImage /IMGID=1099 "$PLUGINSDIR\BgImage.bmp"
    !endif
  
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1100
    ShowWindow $XPUI_TEMP1 0
    SendMessage $XPUI_TEMP1 0xC 0 "STR:Setup will complete in approximately:"
    ShowWindow $XPUI_TEMP1 5
    
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1101
    ShowWindow $XPUI_TEMP1 0
    SendMessage $XPUI_TEMP1 0xC 0 "STR:${M}"
    ShowWindow $XPUI_TEMP1 5
    
  Pop $XPUI_TEMP1

!macroend

!macro XPUI_LEFT_STATUS T B

  Push $XPUI_TEMP1
  
    !ifndef XPUI_BGIMAGE
    SetBrandingImage /IMGID=1302 "$PLUGINSDIR\LeftImg.bmp"
    !else
    SetBrandingImage /IMGID=1099 "$PLUGINSDIR\BgImage.bmp"
    !endif
    
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1100
    ShowWindow $XPUI_TEMP1 0
    SendMessage $XPUI_TEMP1 0xC 0 "STR:${T}"
    ShowWindow $XPUI_TEMP1 5

    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1101
    ShowWindow $XPUI_TEMP1 0
    SendMessage $XPUI_TEMP1 0xC 0 "STR:${B}"
    ShowWindow $XPUI_TEMP1 5
    
  Pop $XPUI_TEMP1

!macroend

!macro XPUI_LEFT_BLANK

  Push $XPUI_TEMP1
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1100
    ShowWindow $XPUI_TEMP1 0

    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1101
    ShowWindow $XPUI_TEMP1 0
  Pop $XPUI_TEMP1

!macroend

!macro XPUI_LEFT_MESSAGE T M B

  !define XPUI_LMB_CHECK_${B}
  
  !ifdef XPUI_LMB_CHECK_1 | XPUI_LMB_CHECK_2 | XPUI_LMB_CHECK_3
  !else
    !error "XPUI_LEFT_MESSAGE: Syntax error$\nUsage: !insertmacro XPUI_LEFT_MESSAGE message_title message_text type(1|2|3)$\nType: 1 - OK button, 2 - OK and cancel buttons, 3 - Yes and No buttons"
  !endif
  
  !ifdef XPUI_BGIMAGE
    !insertmacro XPUI_DEFAULT XPUI_LMB_TRANSPARENT ""
  !endif
  
  StrCmp $XPUI_ABORTED 1 0 +2
    Abort
  
  !ifndef XPUI_LMB_TRANSPARENT
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1302
    ShowWindow $XPUI_TEMP1 0
  !endif
  
  SetOutPath $PLUGINSDIR
  File "${XPUI_SYSDIR}\INI\MBSide.ini"
  
  InstallOptions::initDialog /NOUNLOAD $PLUGINSDIR\MBSide.ini

    Pop $XPUI_HWND
    
    !ifdef XPUI_LMB_TRANSPARENT
      !insertmacro XPUI_CONTROL_SKIN_TRANS $XPUI_HWND
    !else
      !insertmacro XPUI_CONTROL_SKIN $XPUI_HWND
    !endif
    
    GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1203
    !insertmacro XPUI_CONTROL_SKIN_LIGHT_TRANS $XPUI_TEMP1
    CreateFont $XPUI_TEMP2 "Arial" 8 700
    SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 0
    SendMessage $XPUI_TEMP1 0xC 0 `STR:${T}`
    
    GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1204
    !insertmacro XPUI_CONTROL_SKIN_TRANS $XPUI_TEMP1
    CreateFont $XPUI_TEMP2 "Arial" 8 350
    SendMessage $XPUI_TEMP1 0x30 $XPUI_TEMP2 0
    SendMessage $XPUI_TEMP1 0xC 0 `STR:${M}`
    
    ; Buttons
    !ifdef XPUI_LMB_CHECK_1

      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1200
      ShowWindow $XPUI_TEMP1 5
      SendMessage $XPUI_TEMP1 0xC 0 STR:OK
      
      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1201
      ShowWindow $XPUI_TEMP1 0
      
      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1202
      ShowWindow $XPUI_TEMP1 0
      
    !else ifdef XPUI_LMB_CHECK_2

      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1200
      ShowWindow $XPUI_TEMP1 0

      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1201
      ShowWindow $XPUI_TEMP1 5
      SendMessage $XPUI_TEMP1 0xC 0 STR:OK

      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1202
      ShowWindow $XPUI_TEMP1 5
      SendMessage $XPUI_TEMP1 0xC 0 STR:Cancel

    !else ifdef XPUI_LMB_CHECK_3

      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1200
      ShowWindow $XPUI_TEMP1 0

      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1201
      ShowWindow $XPUI_TEMP1 5
      SendMessage $XPUI_TEMP1 0xC 0 STR:Yes

      GetDlgItem $XPUI_TEMP1 $XPUI_HWND 1202
      ShowWindow $XPUI_TEMP1 5
      SendMessage $XPUI_TEMP1 0xC 0 STR:No

    !endif
    
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1
    ShowWindow $XPUI_TEMP1 0
    
    LockWindow off
    
  InstallOptions::show
  
  !ifndef XPUI_LMB_TRANSPARENT
    GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1302
    ShowWindow $XPUI_TEMP1 5
  !endif
  GetDlgItem $XPUI_TEMP1 $HWNDPARENT 1
  ShowWindow $XPUI_TEMP1 5
  
  ReadINIStr $XPUI_TEMP2 $PLUGINSDIR\MBSide.ini Settings State
  
  !undef XPUI_LMB_CHECK_${B}

!macroend

; This include is the entire multi-language system.  Without it, you're lost.  This is
; really the only part from the old code that was completely spared.
!include "${XPUI_SYSDIR}\Lang.nsh"
!define Language "!insertmacro XPUI_LANGUAGE"
!define LangDialog "!insertmacro XPUI_LANGDLL_DISPLAY"
!define LangPage "!insertmacro XPUI_LANGPAGE_DISPLAY"

!insertmacro XPUI_PAGEMODE_INST

; Skin Includes
  !ifdef XPUI_SKIN
    !ifndef XPUI_SKIN_INCLUDED
    !define XPUI_SKIN_INCLUDED
    !verbose push
    !verbose 3 ; Allow errors to be exposed
    !include "${XPUI_SYSDIR}\Skins\${XPUI_SKIN}.xpuiskin"
    !verbose pop
    !endif
  !endif

!ifdef XPUI_FASTERSKINNING
  !insertmacro XPUI_DEFAULT XPUI_INTERNAL_INTERFACE_INSERTED ""
  !insertmacro XPUI_INTERFACE
!endif

!verbose 4
!ifndef XPUI_SILENT
!echo `XPUI Processing Complete.$\n$\n`
!endif ;XPUI_SILENT
!verbose pop
!endif ;XPUI_INCLUDED
