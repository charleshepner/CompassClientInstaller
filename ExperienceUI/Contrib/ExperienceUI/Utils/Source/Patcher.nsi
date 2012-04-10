; ExperienceUI Patch Installer
; Rewritten as of ExperienceUI 1.11
; Copyright © 2006 Dan Fuhry

; Licensed under the zlib/libpng license

; Written during Bush's State of the Union address on Jan 31, 2006 (also my birthday)

; Dependencies:
; * DcryptDll
; * ZipDLL
; * SigVerify.exe (closed-source application that does the actual signature verification)
; * ExperienceUI
; * System.dll

Name "ExperienceUI Patch/Skin Installer"
Caption "ExperienceUI Patch/Skin Installer"
OutFile ..\PatchInstaller.exe

SetCompressor /FINAL /SOLID lzma
Var TYPE
Var CURRENT
Var TOTAL
Var NAME
Var SILENT
Var SIGSTAT
Var APPEND
Var SRCFILE
Var BHWND

!define XPUI_ICON patcher.ico
!define XPUI_UNICON patcher.ico

!define XPUI_WELCOMEPAGE_TEXT_TOP "Welcome to the $(^Name)"
!define XPUI_WELCOMEPAGE_TEXT     "This wizard will guide you through the installation of the patch you opened.\r\n\r\nClick Next to start."
!define XPUI_WELCOMEPAGE_TITLE    "Welcome"
!define XPUI_WELCOMEPAGE_SUBTITLE "Welcome to the $(^Name)."

!define XPUI_INSTFILESPAGE_TITLE    "Installing"
!define XPUI_INSTFILESPAGE_SUBTITLE "Please wait while the $TYPE you opened is being installed."
!define XPUI_INSTFILESPAGE_DONE_SUBTITLE "The $TYPE you opened was installed successfully."

!define XPUI_INSTCONFIRMPAGE_TEXT_TOP "The $(^Name) is ready to install the $TYPE."

!define XPUI_FINISHPAGE_TITLE    "Installation Complete"
!define XPUI_FINISHPAGE_SUBTITLE "The $(^Name) has successfully applied the $TYPE to your ExperienceUI installation."
!define XPUI_FINISHPAGE_TEXT_TOP "Completing the ExperienceUI Patch/Skin installation wizard"
!define XPUI_FINISHPAGE_TEXT     "The $(^Name) has finished installing the $TYPE you opened.\r\n\r\nPlease click $(^CloseBtn) to exit the $(^Name)."

InstallDirRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\ExperienceUI for NSIS" UninstallString
SetPluginUnload alwaysoff
!include system.nsh

!define SOUND_DEFAULT "${MB_OK}"
!define SOUND_STOP "${MB_ICONHAND}"
!define SOUND_ASTERISK "${MB_ICONASTERISK}"
!define SOUND_ERROR "${MB_ICONEXCLAMATION}"
!define SOUND_QUESTION "${MB_ICONQUESTION}"

!macro AboutDlg
  System::Call '${sysMessageBeep} (${SOUND_ASTERISK})'
  !insertmacro smMessageBox '`$EXEDIR\XPUIRes.dll`' 'ExperienceUI for NSIS$\nPatch/Skin Installer (version ${VERSION})$\nCopyright © 2005 Dan Fuhry.$\n$\nTo install a skin or patch, double-click the file in Windows Explorer.$\nTo see this About dialog, run this program with the /ABOUT switch.$\n$\nThis program is a component of the ExperienceUI for NSIS.  Copyright © 2004-2005 Dan Fuhry.$\nThe ExperienceUI was written to provide a pretty alternative to the huge, slow InstallShield®* installers.  The default skin contains colors used by the NVidia® ForceWare™ Setup Program.$\n$\nMore information about the ExperienceUI can be found at http://forums.winamp.com/showthread.php?threadid=204836.$\n$\n*InstallShield is a registered trademark of MacroVision, Inc.  ForceWare is a registered trademark of NVidia, Inc.' 'About the ExperienceUI for NSIS Patch/Skin Installer' '${MB_OK}' 'i 5'
!macroend

!macro VERIFY FILE HASH
  Push $1
  Push $OUTDIR
  Push $0
    WriteINIStr $TEMP\Sigdata.ini SigVerify Append $APPEND
    ExecWait '"$PLUGINSDIR\SigVerify.exe" ${FILE} /Hash=${HASH}' $0
    StrCmp $0 0 +3
      StrCpy $1 "Bad"
      Goto +2
      StrCpy $1 "Good"
  Pop $0
  Pop $OUTDIR
  Exch $1
!macroend

!macro CLS
Push $9
FindWindow $9 "#32770" "" $HWNDPARENT
GetDlgItem $9 $9 1016
SendMessage $9 0x1009 0 0
Pop $9
!macroend

!macro ERROR TITLE MSG
  !insertmacro XPUI_HEADER_TEXT "Installation Failed" "The $TYPE installation failed."
  System::Call '${sysMessageBeep} (${SOUND_STOP})'
  !insertmacro smMessageBox `$\`$EXEDIR\XPUIRes.dll$\`` `${MSG}` `${TITLE}` `${MB_OK}` `i 1`
!macroend

!include XPUI.nsh

!insertmacro XPUI_PAGE_WELCOME
!insertmacro XPUI_PAGE_INSTCONFIRM
!insertmacro XPUI_PAGE_INSTFILES
!insertmacro XPUI_PAGE_FINISH

!insertmacro XPUI_LANGUAGE English

VIProductVersion "1.1.0.0"
VIAddVersionKey /LANG=1033 "FileVersion" "${VERSION}"
VIAddVersionKey /LANG=1033 "ProductVersion" "${VERSION}"
VIAddVersionKey /LANG=1033 "ProductName" "ExperienceUI for NSIS"
VIAddVersionKey /LANG=1033 "Comments" "This program was written by Dan Fuhry using Nullsoft Scriptable Install System (http://nsis.sourceforge.net)"
VIAddVersionKey /LANG=1033 "CompanyName" "Dan Fuhry a. k. a. dandaman32"
VIAddVersionKey /LANG=1033 "LegalTrademarks" "ExperienceUI for NSIS by Dan Fuhry. Copyright © 2004-2006 Dan Fuhry"
VIAddVersionKey /LANG=1033 "LegalCopyright" "Copyright © Dan Fuhry"
VIAddVersionKey /LANG=1033 "FileDescription" "ExperienceUI for NSIS Patch/Skin Installer"
VIAddVersionKey /LANG=1033 "SpecialBuild" "ExperienceUI for NSIS Patching/Skinning Engine, version ${VERSION}, built on ${__TIMESTAMP__}"

!macro DO_INSTALL
  BringToFront
  StrCpy $CURRENT 0
  StrCmp $SILENT 1 "" loop
  Banner::show /NOUNLOAD ""
  Banner::getWindow
  Pop $BHWND
  GetDlgItem $BHWND $BHWND 1030
  Loop:
    IntOp $CURRENT $CURRENT + 1
    ReadINIStr $2 $TEMP\EUI-Setup\Content.dat "EUI-$TYPE" "File$CURRENT"
    StrCmp $SILENT 1 0 +2
    SendMessage $BHWND 0xC 0 "STR:Installing $TYPE: $NAME$\nCurrent file: $2"
    ReadINIStr $SRCFILE $TEMP\EUI-Setup\Content.dat "EUI-$TYPE" "File$CURRENT SName"
      StrCmp $SRCFILE "" "" +2
      StrCpy $SRCFILE $2
    IfFileExists $TEMP\EUI-Setup\$SRCFILE FoundIt
      !insertmacro ERROR "Cannot find file" "The $TYPE was opened, extracted, and parsed successfully, but the file $2 could not be found in the archive.  Please contact the author of this $TYPE with the following error code:$\n$\nError: F-PI009 Cannot find source file $2"
      Call .onGUIend
      RMDir /r $TEMP\EUI-Setup
      SetErrorLevel 1
      Quit
    FoundIt:
    ReadINIStr $4 $TEMP\EUI-Setup\Content.dat EUI-$TYPE "File$CURRENT Sig"
    StrCmp $4 "" NoSig
      SetDetailsPrint none
      !insertmacro VERIFY $TEMP\EUI-Setup\$SRCFILE $4
      Pop $0
      StrCmp $0 Good NoSig
      StrCmp $SIGSTAT "Signed and verified" Forged
      !insertmacro ERROR "Invalid Signature" "The ExperienceUI Patch Installer has found a digital signature assigned to one of the patch files, but the signature was checked and found to be invalid.  This is a fatal error.  Please contact the author of this $TYPE with the following error code:$\n$\nError: F-PI010 Invalid signature hash for file $2$\nAdditional information:$\n    hash value: $4$\n    Return value: $0"
      Call .onGUIend
      RMDir /r $TEMP\EUI-Setup
      SetErrorLevel 1
      Quit
      Forged:
      !insertmacro ERROR "Unsigned file" "The patch installer has found that though the patch itself is signed, one of the files within it is not.  This is a fatal error.  Please contact the author of this patch with the following information:$\n$\nError: F-PI013 Unsigned file in signed patch$\nAdditional information:$\n    File name: $2"
      Call .onGUIend
      RMDir /r $TEMP\EUI-Setup
      SetErrorLevel 1
      Quit
    NoSig:
    StrCmp $4 "" 0 +2
      StrCmp $SIGSTAT "Signed and verified" Forged ; a backup check
    ReadINIStr $4 $TEMP\EUI-Setup\Content.dat EUI-$TYPE "File$CURRENT Desc"
    StrCmp $4 "" NoDesc
    SetDetailsPrint listonly
    DetailPrint "Install: $4 - $2 to $INSTDIR\$3"
    SetDetailsPrint textonly
    DetailPrint "Installing file: $2 ($4) to $INSTDIR\$3"
    SetDetailsPrint none
    Goto cont
    NoDesc:
    ReadINIStr $SRCFILE $TEMP\EUI-Setup\Content.dat "EUI-$TYPE" "File$CURRENT SName"
    StrCmp $SRCFILE "" 0 +2
      StrCpy $SRCFILE $2
    SetDetailsPrint listonly
    DetailPrint "Install: $2 to $3"
    SetDetailsPrint textonly
    DetailPrint "Installing file: $2 to $INSTDIR\$3"
    SetDetailsPrint none
    cont:
    ReadINIStr $3 $TEMP\EUI-Setup\Content.dat "EUI-$TYPE" "File$CURRENT Path"
    CreateDirectory $INSTDIR\$3
    CopyFiles $TEMP\EUI-Setup\$SRCFILE $INSTDIR\$3\$2
    IntCmp $CURRENT $TOTAL 0 Loop
  ; We are done
  StrCmp $SILENT 1 "" ns1
  Banner::destroy
  ns1:
  RMDir /r $TEMP\EUI-Setup
  SetAutoClose false
  SetDetailsPrint both
!macroend

Function .onInit
  ; Get rid of compiler warnings
  ;Goto +4
  ;  Call GetInstallerEXEName
  ;  Call systemGetFileSysTime
  ;  Call systemSplash
    
  Call GetParameters
  Pop $0
  StrCmp $0 "" 0 NotBlank
    !insertmacro ERROR "Invalid Command Line" "You need to specify the patch/skin file on the command line.$\n$\nError: F-PI001 No parameters on command line"
    RMDir /r $TEMP\EUI-Setup
    Quit
  NotBlank:
  StrCpy $SILENT 0
  Push $0
  Push "/Silent"
  Call StrStr
  Pop $1
  StrCmp $1 "/Silent" "" NoSilent
    StrCpy $SILENT 1
    StrLen $2 $1
    StrLen $3 $0
    IntOp $2 $3 - $2
    IntOp $2 $2 - 1
    StrCpy $0 $0 $2
  NoSilent:
  IfFileExists $0 FoundTarget
    !insertmacro ERROR "Missing File" "The file specified on the command line cannot be found.$\n$\nError: F-PI002 Missing file"
    RMDir /r $TEMP\EUI-Setup
    Quit
  FoundTarget:
  IfFileExists $INSTDIR\XPUI.nsh FoundXPUI
    !insertmacro ERROR "Corrupt XPUI Installation" "The ExperienceUI cannot be found on this computer.  It can be downloaded from http://xpui.sourceforge.net/.$\n$\nError: F-PI003 Cannot find XPUI installation"
    RMDir /r $TEMP\EUI-Setup
    Quit
  FoundXPUI:
  StrLen $1 $0
  IntOp $1 $1 - 3
  StrCpy $1 $0 3 $1
  StrCmp $1 "eup" validext-p
  StrCmp $1 "eus" validext-s
    !insertmacro ERROR "Invalid file extension" "The file '$0' was found and the command line was correct, but the extension is not EUP (ExperienceUI Patch) or EUS (ExperienceUI Skin).  Setup will treat this file as a patch.$\n$\nThis is a non-fatal error.$\n$\nError: N-PI004 Invalid file extension $1"
  validext-s:
  StrCpy $TYPE "skin"
  Goto valid
  validext-p:
  StrCpy $TYPE "patch"
  Goto valid
  valid:
  RMDir /r $TEMP\EUI-Setup
  CreateDirectory "$TEMP\EUI-Setup"
  ClearErrors
  ZipDLL::extractall "$0" "$TEMP\EUI-Setup"
  Pop $2
  StrCmp $2 "success" goodZip
    !insertmacro ERROR "Zip extract error" "The file '$0' was found and the command line was correct, but the ZIP file extraction module failed.$\n$\nThe following error string was returned by ZipDLL: $2$\n$\nError: F-PI005 ZIP file extraction error"
    RMDir /r $TEMP\EUI-Setup
    Quit
  goodZip:
  IfFileExists $TEMP\EUI-Setup\Content.dat FoundScript
    !insertmacro ERROR "Missing script" "The installation script could not be found in the patch/skin file's root directory.  This is a fatal error.  Please contact the author of this patch with the following error code.$\n$\nError: F-PI006 Cannot find installation script"
    RMDir /r $TEMP\EUI-Setup
    Quit
  FoundScript:
  ClearErrors
  ReadINIStr $TOTAL $TEMP\EUI-Setup\Content.dat "EUI-$TYPE" NumFiles
  IntCmp $TOTAL 1 FilesGood 0 FilesGood
    !insertmacro ERROR "Corrupt script" "The installation script in this patch file is corrupt.  Please redownload the patch file, or contact the author of this patch with the following error code:$\n$\nError: F-PI008 Cannot find INI key NumFiles under section EUI-$TYPE in $$TEMP\EUI-Setup\CONTENT.dat, or NumFiles !>=1"
    RMDir /r $TEMP\EUI-Setup
    Quit
  FilesGood:
  ; Check for a digital signature
  
  ; Extract the verification utility
  SetOutPath $PLUGINSDIR
    File SigVerify.exe
    
  IfFileExists $TEMP\EUI-Setup\content.sig "" Unsigned
  FileOpen $R1 $TEMP\EUI-Setup\content.sig r
    FileRead $R1 $R0 32
  FileClose $R1
  StrCmp $SILENT 1 nob1
  Banner::show /NOUNLOAD "Validating $TYPE digital signature..."
  nob1:
  StrCpy $SIGSTAT "Signed and verified"
  !insertmacro VERIFY $TEMP\EUI-Setup\content.dat $R0
  StrCmp $SILENT 1 nob2
  Banner::destroy
  nob2:
  Pop $R1
  StrCmp $R1 Good GoodSig
    !insertmacro ERROR "Corrupt Signature" "The author who packaged the $TYPE has specified that the file be signed with a digital signature, but after thorough testing, the patch's installation script was found to have an invalid signature.  This is a fatal error.  Please report the following information to the author of this patch:$\n$\nError: F-PI011 Master signature corrupt$\nAdditional information:$\n    BAD signature hash: $R0"
    RMDir /r $TEMP\EUI-Setup
    Quit
    Unsigned:
    StrCmp $SILENT 1 "" NoS1
      !insertmacro ERROR "Signature required for silent install" "The ExperienceUI patch installer does not allow silent installations of unsigned patch files.$\n$\nError: F-PI012 Signature required for silent install"
      RMDir /r $TEMP\EUI-Setup
      Quit
    NoS1:
    StrCpy $SIGSTAT "Unsigned"
    System::Call '${sysMessageBeep} (${SOUND_QUESTION})'
    !insertmacro smMessageBox `$\`$EXEDIR\XPUIRes.dll$\`` `The file you are opening is a valid $TYPE, but the Patch Installer has detected that it has not been signed with any digital signature.  While you may continue installing this $TYPE, it is important to remember that ExperienceUI $TYPE files are really just glorified ZIP files, and it is possible to put malicious code into them.  You should only continue if you trust the source of this $TYPE.$\n$\nDo you really want to continue?` `Unsigned $TYPE` `${MB_YESNO}` `i 1`
    StrCmp $R0 6 SigDone
    RMDir /r $TEMP\EUI-Setup
    Quit
  GoodSig:
    ReadINIStr $R0 $TEMP\EUI-Setup\Content.dat SigInfo PN
    ReadINIStr $R1 $TEMP\EUI-Setup\Content.dat SigInfo PE
    ReadINIStr $R2 $TEMP\EUI-Setup\Content.dat SigInfo CN
    ReadINIStr $R3 $TEMP\EUI-Setup\Content.dat SigInfo CE
    StrCmp $R0 "" SigDone
    StrCpy $APPEND ";PN=$R0;PE=$R1;CN=$R2;CE=$R3"
    StrCpy $SIGSTAT "$SIGSTAT$\n  Signed by: $R2$\n  Signer's E-mail: $R3"
  SigDone:
  ReadINIStr $NAME $TEMP\EUI-Setup\Content.dat "EUI-$TYPE" Name
  StrCmp $SILENT 1 "" NoS2
    !insertmacro DO_INSTALL
    SetErrorLevel 0
    Quit
  NoS2:
FunctionEnd

Section
  StrCmp $NAME "" NoName
    HideWindow
    System::Call '${sysMessageBeep} (${SOUND_QUESTION})'
    !insertmacro smMessageBox '`$EXEDIR\XPUIRes.dll`' 'You are about to install a $TYPE from the following location:$\n$\n  Name: $NAME$\n  File location: $0$\n  Signature status: $SIGSTAT$\n$\nContinue?' 'ExperienceUI Setup' '${MB_YESNO}' 'i 2'
    StrCmp $R0 7 0 NoName
    Call .onGUIEnd
    RMDir /r $TEMP\EUI-Setup
    Quit
  NoName:
  !insertmacro DO_INSTALL
SectionEnd

Function GetParameters
Push $R0
Push $R1
Push $R2
Push $R3
StrCpy $R2 1
StrLen $R3 $CMDLINE
;Check for quote or space
StrCpy $R0 $CMDLINE $R2
StrCmp $R0 '"' 0 +3
StrCpy $R1 '"'
Goto loop
StrCpy $R1 " "
loop:
IntOp $R2 $R2 + 1
StrCpy $R0 $CMDLINE 1 $R2
StrCmp $R0 $R1 get
StrCmp $R2 $R3 get
Goto loop
get:
IntOp $R2 $R2 + 1
StrCpy $R0 $CMDLINE 1 $R2
StrCmp $R0 " " get
StrCpy $R0 $CMDLINE "" $R2
Pop $R3
Pop $R2
Pop $R1
Exch $R0
FunctionEnd

 Function StrStr
   Exch $R1 ; st=haystack,old$R1, $R1=needle
   Exch    ; st=old$R1,haystack
   Exch $R2 ; st=old$R1,old$R2, $R2=haystack
   Push $R3
   Push $R4
   Push $R5
   StrLen $R3 $R1
   StrCpy $R4 0
   ; $R1=needle
   ; $R2=haystack
   ; $R3=len(needle)
   ; $R4=cnt
   ; $R5=tmp
   loop:
     StrCpy $R5 $R2 $R3 $R4
     StrCmp $R5 $R1 done
     StrCmp $R5 "" done
     IntOp $R4 $R4 + 1
     Goto loop
 done:
   StrCpy $R1 $R2 "" $R4
   Pop $R5
   Pop $R4
   Pop $R3
   Pop $R2
   Exch $R1
 FunctionEnd