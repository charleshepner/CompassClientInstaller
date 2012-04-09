;NSIS ExperienceUI - Language File
;Compatible with ExperienceUI 1.10

;Language: Italiano (1040)
;By Henrik Sozzi - henriks@tin.it

;--------------------------------

!insertmacro XPUI_LANGUAGEFILE_BEGIN "Italian"

; Use only ASCII characters (if this is not possible, use the English name)
!insertmacro XPUI_UNSET XPUI_LANGNAME
!insertmacro XPUI_DEFAULT XPUI_LANGNAME "Italiano"

; BUTTONS
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_NEXT   Next
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_BACK   Back
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CANCEL Cancel
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CLOSE  Close

!insertmacro XPUI_DEFAULT XPUI_ABORTWARNING_TEXT "Stai per uscire dal setup.$\n$\nSe esci ora, $(^Name) non sarà installato.$\n$\nVuoi continuare?"

; +---------+
; | INSTALL |
; +---------+

; WELCOME PAGE
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT_TOP "Benvenuto nell'installazione di $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT "Questa procedura ti guiderà nell'installazione di $(^Name).\r\n\r\nE' consigliato chiudere tutte le applicazioni prima di iniziare l'installazione. In questo modo sarà possibile aggiornare file di sistema senza riavviare il computer."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TITLE "Benvenuto"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_SUBTITLE "Benvenuto nell'installazione di $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT_TOP "Benvenuto nella disinstallazione di $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT "Questa procedura ti guiderà nella disinstallazione di $(^Name).\r\n\r\nE' consigliato chiudere tutte le applicazioni prima di iniziare la disinstallazione. Questo renderà possibile aggiornare file di sistema senza riavviare il computer."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TITLE "Benvenuto"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_SUBTITLE "Benvenuto nella disinstallazione di $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_CAPTION " "

; WELCOME PAGE STYLE 2
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TEXT_TOP "Benvenuto nell'installazione di $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TEXT "Benvenuto nell'installazione di $(^Name). Verrà installato $(^Name) sul tuo computer."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TITLE "Benvenuto"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_SUBTITLE "Benvenuto nell'installazione di $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TEXT_TOP "Benvenuto nella procedura di disinstallazione di $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TEXT "Benvenuto nell'installazione di $(^Name).  Verrà disinstallato $(^Name) dal tuo computer."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TITLE "Benvenuto"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_SUBTITLE "Benvenuto nella disinstallazione di $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_CAPTION " "

; LICENSE PAGE
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_CAPTION ": Accordo di licenza"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "Sono daccordo a tutte le clausole e condizioni"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "Non sono daccordo a tutte le clausole e condizioni"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_CHECKBOX "Sono daccordo a tutte le clausole e condizioni"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_SUBTITLE "Leggi attentamente l'accordo di licenza prima di installare $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TITLE "Accordo di licenza"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_TOP "Premi Pagina Giù per vedere il resto dell'accordo."
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Se accetti tutte le clausole e condizioni dell'accordo, fai click su Accetto per continuare. E' necessario accettare l'accordo per installare  $(^Name)."
  !endif
!endif
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Se accetti tutte le clausole e condizioni dell'accordo, seleziona la casella sottostante. E' necessario accettare l'accordo per installare $(^Name)."
  !endif
!endif
!ifdef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Se accetti tutte le clausole e condizioni dell'accordo, seleziona la prima opzione sopra. E' necessario accettare l'accordo per installare $(^Name)."
  !endif
!endif

!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_CAPTION ": Accordo di licenza"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "Accetto tutte le clausole e condizioni di cui sopra"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "Non accetto tutte le clausole e condizioni di cui sopra"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_CHECKBOX "Accetto tutte le clausole e condizioni di cui sopra"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_SUBTITLE "Sei pregato di rileggere l'accordo di licenza prima di disinstallare $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TITLE "Accordo di licenza"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_TOP "Premi Pagina Giù per leggere il resto dell'accordo."
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Se accetti tutte le clausole e condizioni dell'accordo, fai click su Accetto per continuare. E' necessario accettare l'accordo per disinstallare  $(^Name)."
  !endif
!endif
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Se accetti tutte le clausole e condizioni dell'accordo, seleziona la casella sottostante. E' necessario accettare l'accordo per disinstallare $(^Name)."
  !endif
!endif
!ifdef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Se accetti tutte le clausole e condizioni dell'accordo, seleziona la prima opzione sopra. E' necessario accettare l'accordo per disinstallare $(^Name)."
  !endif
!endif

; COMPONENTS PAGE
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_CAPTION ": Seleziona i componenti"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_SUBTITLE "Seleziona quali componenti di $(^Name) vuoi installare."
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TITLE "Seleziona componenti"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Descrizione"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Muovi il mouse su un componente per vederne la descrizione"

!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_CAPTION ": Seleziona i componenti"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_SUBTITLE "Seleziona quali componenti di $(^Name) vuoi disinstallare."
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TITLE "Seleziona componenti"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Descrizione"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Muovi il mouse su un componente per vederne la descrizione"

; DIRECTORY PAGE
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_CAPTION ": Seleziona la cartella di installazione"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_TOP "L'installazione installerà $(^Name) nella seguente cartella.$\r$\n$\r$\nPer installare nella cartella di default lascia il testo sotto così com'è.  Per installare in una cartella differente inseriscila sotto oppure fai click su Sfoglia. $_CLICK"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_DESTINATION "Cartella di installazione"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSE "Sfoglia"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSEDIALOG "Seleziona una cartella:"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TITLE "Seleziona cartella di installazione"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_SUBTITLE "Seleziona la cartella in cui installare $(^Name)."

!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_CAPTION ": Seleziona la cartella di installazione"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_TOP "L'installazione disinstallerà $(^Name) dalla seguente cartella.$\r$\n$\r$\nPer disinstallare da questa cartella fai click su Avanti. Per disinstallare da una cartella differente inseriscila sotto oppure fai click su Sfoglia."
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_DESTINATION "Cartella di installazione"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSE "Sfoglia"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSEDIALOG "Seleziona una cartella:"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TITLE "Seleziona cartella di installazione"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_SUBTITLE "Seleziona la cartella da cui disinstallare $(^Name)."

; START MENU PAGE
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CAPTION    ": Cartella del menu di avvio"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TITLE      "Seleziona la cartella del menu di avvio"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_SUBTITLE   "Seleziona la cartella del menu di avvio nella quale creare i collegamenti di $(^Name):"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TEXT       "Seleziona la cartella del menu di avvio nella quale creare i collegamenti di $(^Name):"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CHECKBOX   "Non creare una cartella nel menu avvio"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_FOLDER     "$(^Name)"

!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CAPTION  ": Cartella del menu di avvio"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TITLE    "Seleziona la cartella del menu di avvio"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_SUBTITLE "Seleziona la cartella del menu di avvio dalla quale rimuovere i collegamenti:"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TEXT     "Seleziona la cartella del menu di avvio dalla quale rimuovere i collegamenti:"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CHECKBOX "Non rimuovere la cartella del menu avvio"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_FOLDER   "$(^Name)"

; INSTALL CONFIRM PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_CAPTION ": Conferma installazione"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_SUBTITLE "L'installazione ha terminato di acquisire informazioni ed è pronta per installare $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TITLE "Conferma l'installazione"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_TOP "L'installazione è pronta per installare $(^Name) nel tuo computer."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_BOTTOM "$_CLICK"

!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_CAPTION ": Conferma installazione"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_SUBTITLE "L'installazione ha terminato di acquisire informazioni ed è pronta per disinstallare $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TITLE "Conferma la disinstallazione"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_TOP "L'installazione è pronta per disinstallare $(^Name) nel tuo computer."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_BOTTOM "Premi Avanti per continuare."

; INSTFILES PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_CAPTION ": Copia files"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_SUBTITLE "Attendere mentre avviene l'installazione di $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_TITLE "Installazione"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_TITLE "Installazione completata"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_SUBTITLE "Tutti i componenti di $(^Name) sono stati copiati sul tuo computer."

!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_CAPTION ": Disinstallazione files"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_SUBTITLE "Attendere mentre avviene la disinstallazioen di $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_TITLE "Disinstallazione"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_DONE_TITLE "Disinstallazione completata"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_DONE_SUBTITLE "Tutti i componenti di $(^Name) sono stati rimossi dal tuo computer."

!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_FAIL_TITLE "Installazione completata"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_FAIL_SUBTITLE "Installazione di $(^Name) non completata."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_FAIL_TITLE "Disinstallazione completata"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_FAIL_SUBTITLE "Disinstallazione di $(^Name) non completata."

; INSTALL SUCCESS PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_CAPTION ": Installazione completata"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_SUBTITLE "L'installazione ha installato con successo $(^Name) sul tuo computer."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TITLE "Installazione completata"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_TOP    "$(^Name) è stato installato con successo."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_BOTTOM "Premi Chiudi per uscire."

!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_CAPTION ": Disinstallazione completata"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_SUBTITLE "L'installazione ha disinstallato con successo $(^Name) dal tuo computer."
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TITLE "Disinstallazione completata"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_TOP    "$(^Name) è stato disinstallato con successo."
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_BOTTOM "Premi Chiudi per uscire."

; FINISH PAGE

!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TITLE "Installazione completata"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_SUBTITLE "L'installazione ha installato con successo $(^Name) nel tuo computer."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CAPTION ": Installazione completata"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP "Completamento della procedura di installazione di $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP_ALT "Procedura di installazione completata"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_RUN "L'installazione ha installato con successo $(^Name) nel tuo computer.\r\n\r\nQuale azione vuoi eseguire?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_REBOOT "L'installazione ha finito di copiare files nel tuo computer.\r\n\r\nPer finire l'installazione devi riavviare il computer.  Vuoi riavviarlo ora?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT "L'installazione ha installato con successo $(^Name) nel tuo computer.\r\n\r\nPremi $(XPUI_BUTTONTEXT_CLOSE) per uscire dall'installazione."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_RUN "Esegui $(^Name) ora"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_DOCS "Vedi la documentazione di $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_REBOOT "Si, riavvia il computer ora."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_NOREBOOT "No, riavvierò il computer manualmente più tardi."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_REBOOT_MESSAGEBOX "L'installazione sta riavviando il computer.$\r$\n$\r$\nSalva e chiudi tutti i files e documenti aperti e fai click su OK per riavviare il computer."

!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TITLE "Disinstallazione completata"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_SUBTITLE "L'installazione ha rimosso con successo $(^Name) dal tuo computer."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_CAPTION ": Disinstallazione completata"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP "Completamento della procedura di disinstallazione di $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP_ALT "Procedura di disinstallazione completata"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_REBOOT "L'installazione ha finito di copiare files nel tuo computer.\r\n\r\nPer terminare la disinstallazione è necessario riavviare il computer.  Vuoi riavviarlo ora?"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_RUN "L'installazione ha rimosso con successo $(^Name) dal tuo computer.\r\n\r\nQuale azione vuoi eseguire?"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT "L'installazione ha rimosso con successo $(^Name) dal tuo computer.\r\n\r\nPremi $(XPUI_BUTTONTEXT_CLOSE) per uscire dall'installazione."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_REBOOT "Si, riavvia il computer ora."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_NOREBOOT "No, riavvierò il computer manualmente più tardi."

; ABORT PAGE
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT_TOP "Installazione annullata"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT "La procedura è stata interrotta prima che $(^Name) potesse essere installato.\r\n\r\nIl tuo sistema non è stato modificato.  Per installare questo software più avanti avvia questa \r\nprocedura di nuovo.\r\n\r\n\r\n\r\n\r\nPremi Chiudi per uscire dall'installazione."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TITLE "Installazione completata"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_SUBTITLE "Installazione di $(^Name) non completata."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_CAPTION ": Installazione annullata"

!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT_TOP "Disinstallazione annullata"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT "La procedura è stata interrotta prima che $(^Name) potesse essere disinstallato.\r\n\r\nYour system has not been modified.  Il tuo sistema non è stato modificato.  Per installare questo software più avanti avvia questa procedura di nuovo.\r\n\r\n\r\n\r\n\r\nPremi Chiudi per uscire dall'installazione."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TITLE "Disinstallazione completata"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_SUBTITLE "Disinstallazione di $(^Name) non completata."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_CAPTION ": Disinstallazione annullata"

; +-----------+
; | UNINSTALL |
; +-----------+

; MOST OF THE UNINSTALL PAGES ARE TAKEN CARE OF USING THE PAGE MODE SYSTEM
; THE XPUI CONFIRM, UNINSTFILES, AND SUCCESS PAGES USE THE PAGE MODE SYSTEM,
; BUT THE NSIS-STYLE UNINSTALL CONFIRM PAGE SIMPLY USES A NON-PAGE-MODE METHOD.

; UNINST CONFIRM PAGE (NSIS)
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_CAPTION ": Conferma disinstallazione"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_SUBTITLE "Rimuovi $(^Name) dal tuo computer"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TITLE "Disinstalla $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_TOP "$(^Name) sarà disinstallato dalla seguente cartella.  Premi Disinstalla per iniziare la disinstallazione."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_FOLDER "Disinstalla da:"

!insertmacro XPUI_LANGUAGEFILE_END
