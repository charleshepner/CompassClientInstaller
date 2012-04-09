Name "ExperienceUI Patch Generator"
Caption "$(^Name)"
OutFile ..\PatchGen.exe
InstallDir $DESKTOP\PatchFiles

Var NAME
Var TYPE
Var START
Var SOURCE
Var TARGET
Var SALT
Var SIG
Var CN
Var CE
Var APPEND
Var IL
Var AP
Var FN

!include XPUI.nsh

!include RecFind.nsh

Page custom io iofin " "
!define XPUI_PAGE_CUSTOMFUNCTION_LEAVE DirWarn
!insertmacro XPUI_PAGE_DIRECTORY
!insertmacro XPUI_PAGE_INSTFILES

Section
  RMDir /r "$INSTDIR" ; don't worry, you're warned first
  StrCpy $3 0 ; NumFields count
  SetOutPath $INSTDIR
  WriteINIStr $INSTDIR\Content.dat "EUI-$TYPE" Name "$NAME"
  StrLen $IL $SOURCE
  IntOp $IL $IL + 1
  ${RecFindOpen} "$SOURCE" $0 $1
    StrCpy $4 $0
    StrCpy $2 $TARGET$0
    ${RecFindFirst}
    IntOp $3 $3 + 1
      SetDetailsPrint both
      StrCpy $AP $SOURCE$0 "" $IL
      DetailPrint "  $$AP: $AP"
      Push $AP
      Push "\"
      Push "_"
      Call StrReplace
      Pop $FN
      StrCpy $FN "$FN_$1"
      DetailPrint "  $$FN: $FN"
    WriteINIStr $INSTDIR\Content.dat "EUI-$TYPE" NumFiles $3
    WriteINIStr $INSTDIR\Content.dat "EUI-$TYPE" "File$START" $1
    WriteINIStr $INSTDIR\Content.dat "EUI-$TYPE" "File$START Path" $2
    WriteINIStr $INSTDIR\Content.dat "EUI-$TYPE" "File$START SName" $FN
    StrCmp $SIG 1 "" NoSig
      SetDetailsPrint none
      GetTempFileName $R0
      CopyFiles $SOURCE$0\$1 $R0
      FileOpen $R1 $R0 a
        FileSeek $R1 0 END
        FileWrite $R1 $SALT$APPEND
      FileClose $R1
      DCryptDll::MD5Hash "FS" $R0 "--End--"
      Delete $R0 ; Let's not leave 300 temporary files sitting on your computer...
      Pop $R2
        StrCmp $R2 OK GoodMD5
          DetailPrint "WARNING: An error ocurred while trying to get the signature hash"
          DetailPrint "DCryptDll returned: $R2"
          DetailPrint "The patch/skin will NOT be signed."
          StrCpy $SIG 0
          Goto NoSig
        GoodMD5:
      Pop $R2
      WriteINIStr $INSTDIR\Content.dat "EUI-$TYPE" "File$START Sig" $R2
      SetDetailsPrint Both
    NoSig:
    IntOp $START $START + 1
    SetDetailsPrint none ;TEMPORARY
    CopyFiles $SOURCE$0\$1 $INSTDIR\$FN
    ${RecFindNext}
  ${RecFindClose}
  ; Sign the content file
  StrCmp $SIG 1 "" NoSignScript
    StrCmp $CN "" NoCN
      WriteINIStr $INSTDIR\Content.dat SigInfo PN "Dan Fuhry"
      WriteINIStr $INSTDIR\Content.dat SigInfo PE "dandaman32@users.sourceforge.net"
      WriteINIStr $INSTDIR\Content.dat SigInfo CN "$CN"
      WriteINIStr $INSTDIR\Content.dat SigInfo CE "$CE"
    NoCN:
    GetTempFileName $R0
      CopyFiles $INSTDIR\Content.dat $R0
      FileOpen $R1 $R0 a
        FileSeek $R1 0 END
        FileWrite $R1 $SALT
      FileClose $R1
      DCryptDll::MD5Hash "FS" $R0 "--End--"
      Delete $R0
      Pop $R2
        StrCmp $R2 OK GoodMD5b
          DetailPrint "WARNING: An error ocurred while trying to get the signature hash"
          DetailPrint "DCryptDll returned: $R2"
          DetailPrint "The patch/skin will NOT be signed."
          StrCpy $SIG 0
          Goto NoSignScript
        GoodMD5b:
      Pop $R2
      FileOpen $R0 "$INSTDIR\content.sig" w
      FileWrite $R0 $R2
      FileClose $R0
  NoSignScript:
  SetAutoClose false
  SetDetailsPrint both
SectionEnd

Function io
  SetOutPath $PLUGINSDIR
  File patchgen.ini
  !insertmacro XPUI_INSTALLOPTIONS_INITDIALOG "patchgen.ini"
  !insertmacro XPUI_HEADER_TEXT "Patch Generator" "This program generates a recursive list of files and adds writes it to an ExperienceUI-compatible Content.dat."
    GetDlgItem $0 $XPUI_HWND 1214
    ShowWindow $0 0
    GetDlgItem $0 $XPUI_HWND 1215
    ShowWindow $0 0
    GetDlgItem $0 $XPUI_HWND 1216
    ShowWindow $0 0
    GetDlgItem $0 $XPUI_HWND 1217
    ShowWindow $0 0
    GetDlgItem $0 $XPUI_HWND 1218
    ShowWindow $0 0
    GetDlgItem $0 $XPUI_HWND 1219
    ShowWindow $0 0
  InstallOptions::show
FunctionEnd

Function iofin
  ReadINIStr $0 $PLUGINSDIR\patchgen.ini "Settings" State
  StrCmp $0 13 b
  ReadINIStr $0 $PLUGINSDIR\patchgen.ini "Field 1" State
  StrCmp $0 1 p
  StrCpy $TYPE skin
  goto c
  b:
    ReadINIStr $0 $PLUGINSDIR\patchgen.ini "Field 13" State
    StrCmp $0 1 Show
    GetDlgItem $0 $XPUI_HWND 1214
    ShowWindow $0 0
    GetDlgItem $0 $XPUI_HWND 1215
    ShowWindow $0 0
    GetDlgItem $0 $XPUI_HWND 1216
    ShowWindow $0 0
    GetDlgItem $0 $XPUI_HWND 1217
    ShowWindow $0 0
    GetDlgItem $0 $XPUI_HWND 1218
    ShowWindow $0 0
    GetDlgItem $0 $XPUI_HWND 1219
    ShowWindow $0 0
    Abort
    Show:
    GetDlgItem $0 $XPUI_HWND 1214
    ShowWindow $0 5
    GetDlgItem $0 $XPUI_HWND 1215
    ShowWindow $0 5
    GetDlgItem $0 $XPUI_HWND 1216
    ShowWindow $0 5
    GetDlgItem $0 $XPUI_HWND 1217
    ShowWindow $0 5
    GetDlgItem $0 $XPUI_HWND 1218
    ShowWindow $0 5
    GetDlgItem $0 $XPUI_HWND 1219
    ShowWindow $0 5
    Abort
  p:
  StrCpy $TYPE patch
  c:
  ReadINIStr $NAME $PLUGINSDIR\patchgen.ini "Field 3" State
  ReadINIStr $START $PLUGINSDIR\patchgen.ini "Field 10" State
  ReadINIStr $TARGET $PLUGINSDIR\patchgen.ini "Field 7" State
  ReadINIStr $SOURCE $PLUGINSDIR\patchgen.ini "Field 11" State
  ReadINIStr $SIG $PLUGINSDIR\patchgen.ini "Field 13" State
  ReadINIStr $SALT $PLUGINSDIR\patchgen.ini "Field 14" State
  ReadINIStr $CN $PLUGINSDIR\patchgen.ini "Field 17" State
  ReadINIStr $CE $PLUGINSDIR\patchgen.ini "Field 18" State
  StrCpy $APPEND ""
  StrCmp $CN "" +2
    StrCpy $APPEND ";PN=Dan Fuhry;PE=dandaman32@users.sourceforge.net;CN=$CN;CE=$CE"
FunctionEnd

Function DirWarn
  IfFileExists $INSTDIR 0 NoID
  MessageBox MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2 "Caution: the selected target folder already exists.  The entire target folder will be erased, recursively.  Do you REALLY want to continue?" IDYES +3
  LockWindow off
  Abort
  NoID:
FunctionEnd

Function GetParentPath
  Exch $0
  Push $1
  Push $2
    StrLen $1 $0
    loop:
      IntOp $1 $1 - 1
      StrCpy $2 $0 1 $1
      StrCmp $2 "" error
      StrCmp $2 "\" "" Loop
    StrCpy $0 $0 $1
    Goto good
    error:
    StrCpy $0 $0
    good:
  Pop $2
  Pop $1
  Exch $0
FunctionEnd

Var STR_REPLACE_VAR_0
Var STR_REPLACE_VAR_1
Var STR_REPLACE_VAR_2
Var STR_REPLACE_VAR_3
Var STR_REPLACE_VAR_4
Var STR_REPLACE_VAR_5
Var STR_REPLACE_VAR_6
Var STR_REPLACE_VAR_7
Var STR_REPLACE_VAR_8

Function StrReplace
  Exch $STR_REPLACE_VAR_2
  Exch 1
  Exch $STR_REPLACE_VAR_1
  Exch 2
  Exch $STR_REPLACE_VAR_0
    StrCpy $STR_REPLACE_VAR_3 -1
    StrLen $STR_REPLACE_VAR_4 $STR_REPLACE_VAR_1
    StrLen $STR_REPLACE_VAR_6 $STR_REPLACE_VAR_0
    loop:
      IntOp $STR_REPLACE_VAR_3 $STR_REPLACE_VAR_3 + 1
      StrCpy $STR_REPLACE_VAR_5 $STR_REPLACE_VAR_0 $STR_REPLACE_VAR_4 $STR_REPLACE_VAR_3
      StrCmp $STR_REPLACE_VAR_5 $STR_REPLACE_VAR_1 found
      StrCmp $STR_REPLACE_VAR_3 $STR_REPLACE_VAR_6 done
      Goto loop
    found:
      StrCpy $STR_REPLACE_VAR_5 $STR_REPLACE_VAR_0 $STR_REPLACE_VAR_3
      IntOp $STR_REPLACE_VAR_8 $STR_REPLACE_VAR_3 + $STR_REPLACE_VAR_4
      StrCpy $STR_REPLACE_VAR_7 $STR_REPLACE_VAR_0 "" $STR_REPLACE_VAR_8
      StrCpy $STR_REPLACE_VAR_0 $STR_REPLACE_VAR_5$STR_REPLACE_VAR_2$STR_REPLACE_VAR_7
      StrLen $STR_REPLACE_VAR_6 $STR_REPLACE_VAR_0
      Goto loop
    done:
  Pop $STR_REPLACE_VAR_1
  Pop $STR_REPLACE_VAR_1
  Exch $STR_REPLACE_VAR_0
FunctionEnd

!insertmacro XPUI_LANGUAGE English