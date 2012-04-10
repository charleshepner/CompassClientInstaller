;SetCompress off
SetCompressor /FINAL lzma
OutFile MultiLang.exe
Name "ExperienceUI Multi-Language Test"
;Name /LANG=10332 "ExperienceUI Multi-Language Test, Weelah!"
;Name /LANG=10331 "ExperienceUI Multi-Language Test2"
installdir $PROGRAMFILES

;!define XPUI_SKIN "Windows XP"
!define XPUI_WANSIS
!define XPUI_ABORTWARNING
!define XPUI_WANSIS_SKIN LCD
!define XPUI_WANSIS_HEADERIMAGE
!define XPUI_DISABLEBG
!define XPUI_BOTTOMIMAGE
;!define XPUI_LANGDLL_REGISTRY_ROOT HKCU
;!define XPUI_LANGDLL_REGISTRY_KEY Software\XPUIMultiLangTest
;!define XPUI_LANGDLL_REGISTRY_VALUENAME Language
!define XPUI_LICENSEBKCOLOR 566878
!define XPUI_LICENSEPAGE_RADIOBUTTONS
!include XPUI.nsh
!verbose 4

!insertmacro XPUI_PAGE_WELCOME
!insertmacro XPUI_PAGE_WELCOME2
!insertmacro XPUI_PAGE_LICENSE "${XPUI_SYSDIR}\License.rtf"
!insertmacro XPUI_PAGE_COMPONENTS
!insertmacro XPUI_PAGE_DIRECTORY
!insertmacro XPUI_PAGE_INSTCONFIRM
!insertmacro XPUI_PAGE_INSTFILES
!insertmacro XPUI_PAGE_INSTSUCCESS
!insertmacro XPUI_PAGE_FINISH
!insertmacro XPUI_PAGE_ABORT

!insertmacro XPUI_PAGEMODE_UNINST
!insertmacro XPUI_PAGE_WELCOME
!insertmacro XPUI_PAGE_WELCOME2
!insertmacro XPUI_PAGE_LICENSE "${XPUI_SYSDIR}\License.rtf"
!insertmacro XPUI_PAGE_COMPONENTS
!insertmacro XPUI_PAGE_DIRECTORY
!insertmacro XPUI_PAGE_UNINSTCONFIRM_NSIS
!insertmacro XPUI_PAGE_INSTCONFIRM
!insertmacro XPUI_PAGE_INSTFILES
!insertmacro XPUI_PAGE_INSTSUCCESS
!insertmacro XPUI_PAGE_FINISH
!insertmacro XPUI_PAGE_ABORT

!insertmacro XPUI_LANGUAGE "English"
!insertmacro XPUI_LANGUAGE "French"
!insertmacro XPUI_LANGUAGE "German"
!insertmacro XPUI_LANGUAGE "PortugueseBR"
!insertmacro XPUI_LANGUAGE "Spanish"

Function .onInit
!insertmacro XPUI_LANGPAGE_DISPLAY
WriteUninstaller $DESKTOP\MultiLangUninst.exe
FunctionEnd

Function un.onInit
!insertmacro XPUI_UNGETLANGUAGE
FunctionEnd

Section "[There is no data to install]" Sec
SectionIn RO
SectionEnd

!insertmacro XPUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro XPUI_DESCRIPTION_TEXT ${Sec} "Description text goes here."
!insertmacro XPUI_FUNCTION_DESCRIPTION_END

Section Uninstall
DeleteRegKey HKCU Software\XpuiMultiLangTest
SectionEnd

!verbose 4
