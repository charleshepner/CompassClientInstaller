; EXPERIENCEUI DEFAULT LANGUAGE FILE
;Compatible with "Bryce" M1 and later

;Language: German (1031)
;Par Matze <matze@gravure-hebdo.com>

;--------------------------------

!insertmacro XPUI_LANGUAGEFILE_BEGIN "German"

; Use only ASCII characters (if this is not possible, use the English name)
!insertmacro XPUI_UNSET XPUI_LANGNAME
!insertmacro XPUI_DEFAULT XPUI_LANGNAME "Deutsch"

; BUTTONS
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_NEXT   Weiter
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_BACK   Zur�ck
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CANCEL Abbrechen
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CLOSE  schlie�en

!insertmacro XPUI_DEFAULT XPUI_ABORTWARNING_TEXT "Sie sind bereit die Installation zu abbrechen.$\n$\nWenn Sie jetzt abbrechen, wird $(^Name) nicht installiert sein.$\n$\nWollen Sie fortfahren?"

; +---------+
; | INSTALL |
; +---------+

; WELCOME PAGE
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT_TOP "Willkommen beim Installations-Assistenten f�r $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT "Dieser Assistent wird Sie durch die Installation von $(^Name) gegleiten.\r\n\r\nEs wird empfohlen vor der Installation alle anderen Programme zu schlie�en, damit bestimmte Systemdateien ohne Neustart ersetzt werden k�nnen.\r\n\r\n"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TITLE "Willkommen"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_SUBTITLE "Willkommen bei der Installation von $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT_TOP "Willkommen beim Deinstallations-Assistenten f�r $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT "Dieser Assistent wird Sie durch die Deinstallation von $(^Name) begleiten.\r\n\r\nEs wird empfohlen vor der Installation alle anderen Programme zu schlie�en, damit bestimmte Systemdateien ohne Neustart ersetzt werden k�nnen.\r\n\r\n"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TITLE "Willkommen"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_SUBTITLE "Willkommen bei der Deinstallation von $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_CAPTION " "

; WELCOME PAGE STYLE 2
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TEXT_TOP "Willkommen beim Installations-Assistenten f�r $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TEXT "Willkommen beim Installations-Assistenten f�r $(^Name). Er wird $(^Name) auf Ihrem Computer installieren."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TITLE "Willkommen "
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_SUBTITLE "Willkommen bei der Installation von $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TEXT_TOP "Willkommen beim NSIS Deinstallations-Assistenten f�r $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TEXT "Willkommen beim Installations-Assistenten f�r $(^Name). Er wird $(^Name) auf Ihrem Computer deinstallieren."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TITLE "Willkommen"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_SUBTITLE "Willkommen bei der Deinstallation von $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_CAPTION " "

; LICENSE PAGE
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_CAPTION ": Lizenzabkommen"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "J'accepte les termes et conditions de la licence ci-dessus"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "Ich akzeptiere nicht die Bedingungen des Abkommens und Lizenzbedingungen"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_CHECKBOX "Ich akzeptiere die Bedingungen des Abkommens und Lizenzbedingungen"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_SUBTITLE "Bitte lesen Sie die Lizenzbedingungen durch, bevor Sie $(^Name) installieren."
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TITLE "Lizenzabkommen"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_TOP "Dr�cken Sie die Bild-nach-unten Taste, um den Rest des Abkommens zu sehen."
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Falls Sie alle Bedingungen des Abkommens akzeptieren, klicken Sie auf Annehmen. Sie m�ssen die Lizenzvereinbarungen anerkennen, um $(^Name) installieren zu k�nnen."
  !endif
!endif
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Falls Sie alle Bedingungen des Abkommens akzeptieren, aktivieren Sie das K�stchen. Sie m�ssen die Lizenzvereinbarungen anerkennen, um $(^Name) installieren zu k�nnen."
  !endif
!endif
!ifdef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Falls Sie alle Bedingungen des Abkommens akzeptieren, w�hlen Sie die erste Option . Sie m�ssen die Lizenzvereinbarungen anerkennen, um $(^Name) installieren zu k�nnen."
  !endif
!endif

!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_CAPTION ": Lizenzabkommen"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "Ich akzeptiere die Bedingungen des Abkommens und Lizenzbedingungen"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "Ich akzeptiere nicht die Bedingungen des Abkommens und Lizenzbedingungen"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_CHECKBOX "Ich akzeptiere nicht die Bedingungen des Abkommens und Lizenzbedingungen"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_SUBTITLE "Bitte lesen Sie die Lizenzbedingungen durch, bevor Sie $(^Name) deinstallieren."
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TITLE "Lizenzabkommen"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_TOP "Dr�cken Sie die Bild-nach-unten Taste, um den Rest des Abkommens zu sehen."
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Falls Sie alle Bedingungen des Abkommens akzeptieren, klicken Sie auf Annehmen. Sie m�ssen die Lizenzvereinbarungen anerkennen, um $(^Name) deinstallieren zu k�nnen."
  !endif
!endif
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Falls Sie alle Bedingungen des Abkommens akzeptieren, aktivieren Sie das K�stchen. Sie m�ssen die Lizenzvereinbarungen anerkennen, um $(^Name) deinstallieren zu k�nnen."
  !endif
!endif
!ifdef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Falls Sie alle Bedingungen des Abkommens akzeptieren, w�hlen Sie  die erste Option. Sie m�ssen die Lizenzvereinbarungen anerkennen, um $(^Name) deinstallieren zu k�nnen."
  !endif
!endif

; COMPONENTS PAGE
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_CAPTION ": Komponenten ausw�hlen"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_SUBTITLE "W�hlen Sie welche Komponenten aus $(^Name) installieret werden sollen."
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TITLE "Komponenten ausw�hlen"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Beschreibung"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Bewegen Sie den Mauszeiger �ber eine Komponente, um ihre Beschreibung zu sehen."

!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_CAPTION ": Komponenten ausw�hlen"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_SUBTITLE "W�hlen Sie welche Komponenten aus $(^Name) deinstallieret werden sollen.."
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TITLE "Komponenten ausw�hlen"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Beschreibung"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Bewegen Sie den Mauszeiger �ber eine Komponente, um ihre Beschreibung zu sehen."

; DIRECTORY PAGE
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_CAPTION ": Zielverzeichnis ausw�hlen"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_TOP "Die Installation wird $(^Name) in das folgende verzeichnis installieren.$\r$\nUm in das unten angegebene Verzeichnis zu installieren, fahren Sie fort.  Um in ein anderes Verzeichnis zu installieren, dr�cken Sie die Taste Durchsuchen und w�hlen Sie ein anderes Verzeichnis aus. $_CLICK"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_DESTINATION "Zielverzeichnis"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSE "Durchsuchen"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSEDIALOG "W�lhen Sie ein Verzeichnis:"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TITLE "W�hlen Sie ein Installationsverzeichnis"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_SUBTITLE "W�hlen Sie das Verzeichnis aus, in das $(^Name) installiert werden soll."

!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_CAPTION ": W�hlen Sie ein Installationsverzeichnis"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_TOP "Die Installation wird $(^Name) von dem folgenden verzeichnis deinstallieren.$\r$\nUm von dem unten angegebenen Verzeichnis zu deinstallieren, fahren Sie fort.  Um von einem anderen Verzeichnis zu deinstallieren, dr�cken Sie die Taste Durchsuchen und w�hlen Sie ein anderes Verzeichnis aus."
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_DESTINATION "Zielverzeichnis"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSE "Durchsuchen"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSEDIALOG "W�lhen Sie ein Verzeichnis:"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TITLE "W�hlen Sie ein Installationsverzeichnis"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_SUBTITLE "W�hlen Sie das Verzeichnis aus, von dem $(^Name) deinstalliert werden soll."

; START MENU PAGE
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CAPTION  ": Startmen�-Ordner"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TITLE    "Bestimmen Sie einen Startmen�-Ordner f�r die Programmverkn�pfungen."
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_SUBTITLE "Bestimmen Sie einen Startmen�-Ordner in dem die Programmverkn�pfungen f�r $(^Name) erstellet werden:"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TEXT     "Bestimmen Sie einen Startmen�-Ordner f�r die Programmverkn�pfungen zu $(^Name):"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CHECKBOX "Keine Verkn�pfungen erstellen"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_FOLDER   "$(^Name)"

!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CAPTION  ": Startmen�-Ordner"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TITLE    "Bestimmen Sie einen Startmen�-Ordner f�r die Programmverkn�pfungen"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_SUBTITLE "Bestimmen Sie einen Startmen�-Ordner in dem Sie die Programmverkn�pfungen f�r $(^Name) entfernen wollen:"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TEXT     "Bestimmen Sie einen Startmen�-Ordner von dem Sie die Programmverkn�pfungen entfernen wollen:"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CHECKBOX "Keine Verkn�pfungen entfernen"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_FOLDER   "$(^Name)"

; INSTALL CONFIRM PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_CAPTION ": Installation best�tigen"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_SUBTITLE "Die Installation hat genug Informationen versammelt und ist bereit $(^Name) zu installieren."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TITLE "Installation best�tigen"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_TOP "Die Installation ist bereit $(^Name) auf Ihr Computer zu installieren."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_BOTTOM "$_CLICK"

!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_CAPTION ": Installation best�tigen"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_SUBTITLE "Die Installation hat genug Informationen versammelt und ist bereit $(^Name) zu deinstallieren."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TITLE "Deinstallation best�tigen"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_TOP "Die Installation ist bereit $(^Name) aus Ihr Computer zu deinstallieren."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_BOTTOM "Dr�cken Sie Weiter um fortzufahren."

; INSTFILES PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_CAPTION ": Kopie der Dateien"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_SUBTITLE "Bitte warten Sie, w�hrend $(^Name) installiert wird."
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_TITLE "Installiere..."
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_TITLE "Die Installation ist vollst�ndig"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_SUBTITLE "Alle Komponenten von $(^Name) wurden erfolgreich auf Ihr Computer kopiert."

!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_CAPTION ": Deinstallation der Dateien"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_SUBTITLE "Bitte warten Sie, w�hrend $(^Name) deinstalliert wird."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_TITLE "Deinstallation"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_DONE_TITLE "Deinstallation fertig"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_DONE_SUBTITLE "Alle Komponenten von $(^Name) wurden erfolgreich aus Ihr Computer entfernt."

!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_FAIL_TITLE "Installation Nicht fertig"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_FAIL_SUBTITLE "Die Installation von $(^Name) wurde nicht vollst�ndig abgeschlossen."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_FAIL_TITLE "Deinstallation Nicht fertig"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_FAIL_SUBTITLE "Die Installation von $(^Name) wurde nicht vollst�ndig abgeschlossen."

; INSTALL SUCCESS PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_CAPTION ": Installation erfolgreich abgeschlossen."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_SUBTITLE "Die Installation hat erfolgreich $(^Name) auf Ihrem Computer installiert."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TITLE "Die Installation ist vollst�ndig"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_TOP    "$(^Name) wurde erfolgreich installiert."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_BOTTOM "Klicken Sie auf Fertigstellen, um den Assistenten zu schlie�en."

!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_CAPTION ": Deinstallation erfolgreich abgeschlossen"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_SUBTITLE "Die Installation hat erfolgreich $(^Name) aus Ihrem Computer entfernt."
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TITLE "Deinstallation fertig"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_TOP    "$(^Name) ist erfolgreich entfernt worden."
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_BOTTOM "Klicken Sie auf Fertigstellen, um den Assistenten zu schlie�en."

; FINISH PAGE

!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TITLE "Installation fertig"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_SUBTITLE "Die Installation hat erfolgreich $(^Name) auf Ihrem Computer installiert."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CAPTION ": Installation fertig"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP "Ende des Installations-Assistenten von $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP_ALT "NSIS Installations-Assistent fertig"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_RUN "Die Installation hat erfolgreich $(^Name) auf Ihrem Computer installiert.\r\n\r\nWelche Aktionen wollen Sie tun?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_REBOOT "Die Installation hat die Dateien auf Ihr Computer kopiert.\r\n\r\nUm die Installation zu beenden, m�ssen Sie Irh Computer neu starten. M�chten Sie Windows jetzt neu starten?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT "Die Installation hat erfolgreich $(^Name) auf Ihrem Computer installiert.\r\n\r\n$_CLICK"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_RUN "$(^Name) jetzt starten"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_DOCS "Die Anleitungen von $(^Name) lesen"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_REBOOT "Ja, mein Computer jetzt neu starten."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_NOREBOOT "Nein, ich werde mein Computer sp�ter neu starten."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_REBOOT_MESSAGEBOX "Die Installation ist bereit Ihr Computer neu zu starten.$\r$\n$\r$\nSpeichern Sie und Schliessen Sie alle ge�ffnete Dateien, und klicken Sie auf OK um Ihr Computer neu zu starten."

!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TITLE "Deinstallation fertig"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_SUBTITLE "Die Installation hat erfolgreich $(^Name) aus Ihr Computer entfernt."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_CAPTION ": Deinstallation fertig"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP "Ende des Installations-Assistenten von $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP_ALT "NSIS Installations-Assistent fertig"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_REBOOT "Die Installation hat die Dateien auf Ihr Computer kopiert.\r\n\r\nUm die Deinstallation zu beenden, m�ssen Sie Irh Computer neu starten. M�chten Sie Windows jetzt neu starten?"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_RUN "Die Installation hat erfolgreich $(^Name) aus Ihr Computer entfernt.\r\n\r\nWelche Aktionen wollen Sie tun?"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT "Die Installation hat erfolgreich $(^Name) aus Ihr Computer entfernt.\r\n\r\nKlicken Sie auf $(XPUI_BUTTONTEXT_CLOSE) um di Installation zu verlassen."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_REBOOT "Ja, mein Computer jetzt neu starten."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_NOREBOOT "Nein, ich werde mein Computer sp�ter neu starten."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_REBOOT_MESSAGEBOX "${XPUI_FINISHPAGE_REBOOT_MESSAGEBOX}"

; ABORT PAGE
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT_TOP "NSIS Installations-Assistent fertig"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT "Der Assistent ist abgebrochen worden bevor $(^Name) vollig installiert wurde.\r\n\r\nIhr system wurde niche ge�ndert.  Um dises Programm sp�ter zu installieren, starten Sie disen\r\nassistenten wieder.\r\n\r\n\r\n\r\n\r\nKlicken Sie auf schlie�en um der Assistent zu verlassen."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TITLE "Installation Nicht fertig"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_SUBTITLE "Die Installation von $(^Name) wurde nicht vollst�ndig abgeschlossen."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_CAPTION ": Abbruch der Installation"

!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT_TOP "NSIS Deinstallations-Assistent fertig"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT "Der Assistent ist abgebrochen worden bevor $(^Name) vollig deinstalliert wurde.\r\n\r\nIhr system wurde niche ge�ndert.  Um dises Programm sp�ter zu deinstallieren, starten Sie disen\r\nassistenten wieder.\r\n\r\n\r\n\r\n\r\nKlicken Sie auf schlie�en um der Assistent zu verlassen."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TITLE "Deinstallation Nicht fertig"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_SUBTITLE "Die Installation von $(^Name) wurde nicht vollst�ndig abgeschlossen."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_CAPTION ": Abbruch der Installation"

; +-----------+
; | UNINSTALL |
; +-----------+

; MOST OF THE UNINSTALL PAGES ARE TAKEN CARE OF USING THE PAGE MODE SYSTEM
; THE XPUI CONFIRM, UNINSTFILES, AND SUCCESS PAGES USE THE PAGE MODE SYSTEM,
; BUT THE NSIS-STYLE UNINSTALL CONFIRM PAGE SIMPLY USES A NON-PAGE-MODE METHOD.

; UNINST CONFIRM PAGE (NSIS)
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_CAPTION ": Deinstallation best�tigen"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_SUBTITLE "$(^Name) aus Ihrem Computer entfernen"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TITLE "D�sinstaller $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_TOP "$(^Name) wird von dem folgenden Verzeichnis deinstalliert werden.  Klicken Sie auf Deinstallieren um die Deinstallation zu starten."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_FOLDER "Deinstallieren aus:"

!insertmacro XPUI_LANGUAGEFILE_END