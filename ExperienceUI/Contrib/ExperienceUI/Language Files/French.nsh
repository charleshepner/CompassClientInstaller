;NSIS ExperienceUI - Language File
;Compatible with ExperienceUI 1.11

;Language: French (1036)
;By [d]�volution

;--------------------------------

!insertmacro XPUI_LANGUAGEFILE_BEGIN "French"

; Use only ASCII characters (if this is not possible, use the English name)
!insertmacro XPUI_UNSET XPUI_LANGNAME
!insertmacro XPUI_DEFAULT XPUI_LANGNAME "Fran�ais"

; BUTTONS
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_NEXT   Suivant
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_BACK   Pr�c�dent
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CANCEL Annuler
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CLOSE  Fermer

!insertmacro XPUI_DEFAULT XPUI_ABORTWARNING_TEXT "L'installation n'est pas termin�e.$\n$\nSi vous quittez maintenant, $(^Name) ne sera pas install�.$\n$\nVoulez-vous vraiment quitter l'installation ?"

; +---------+
; | INSTALL |
; +---------+

; WELCOME PAGE
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT_TOP "Bienvenue au programme d'installation de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT "Cet programme va vous guider durant l'installation de $(^Name).\r\n\r\nIl est recommand� de fermer toutes les applications avant de poursuivre l'installation.  Ce qui va permettre la mise � jour de fichiers syst�mes importants sans avoir � red�marrer votre ordinateur.\r\n\r\n"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TITLE "Bienvenue"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_SUBTITLE "Bienvenue dans l'installation de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT_TOP "Bienvenue au programme de d�sinstallation de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT "Cet programme va vous guider dans la d�sinstallation de $(^Name).\r\n\r\nIl est recommand� de fermer toutes les applications avant de poursuivre l'installation.  Ce qui va permettre la mise � jour de fichiers syst�mes importants sans avoir � red�marrer votre ordinateur.\r\n\r\n"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TITLE "Bienvenue"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_SUBTITLE "Bienvenue dans le programme de d�sinstallation de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_CAPTION " "

; WELCOME PAGE STYLE 2
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TEXT_TOP "Bienvenue au programme d'installation NSIS de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TEXT "Bienvenue dans l'installation de $(^Name).  Ceci va installer $(^Name) sur votre ordinateur."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TITLE "Bienvenue"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_SUBTITLE "Bienvenue dans l'installation de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TEXT_TOP "Bienvenue au programme d'installation NSIS de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TEXT "Bienvenue dans l'installation de $(^Name).  Ceci va d�sinstaller $(^Name) de votre ordinateur."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TITLE "Bienvenue"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_SUBTITLE "Bienvenue dans le programme de d�sinstallation de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_CAPTION " "

; LICENSE PAGE
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_CAPTION ": Licence utilisateur"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "J'accepte les termes et conditions ci-dessus"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "J'accepte les termes et conditions ci-dessus"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_CHECKBOX "J'accepte les termes et conditions ci-dessus"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_SUBTITLE "Veuillez examiner les termes de la licence avant d'installer $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TITLE "Licence utilisateur"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_TOP "Appuyez sur Page Suivante pour lire le reste de la licence utilisateur."
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Si vous acceptez les termes de la licence utilisateur, cliquez sur J'accepte pour continuer.  Vous devez accepter la licence utilisateur pour installer $(^Name)."
  !endif
!endif
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Si vous acceptez les termes de la licence utilisateur, cochez la case ci-dessous.  Vous devez accepter la licence utilisateur pour installer $(^Name)."
  !endif
!endif
!ifdef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Si vous acceptez les termes de la licence utilisateur, s�lectionnez le premier choix ci-dessous.  Vous devez accepter la licence utilisateur pour installer $(^Name)."
  !endif
!endif

!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_CAPTION ": Licence utilisateur"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "J'accepte les termes et conditions ci-dessus"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "J'accepte les termes et conditions ci-dessus"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_CHECKBOX "J'accepte les termes et conditions ci-dessus"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_SUBTITLE "Veuillez examiner les termes de la licence avant de d�sinstaller $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TITLE "Licence utilisateur"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_TOP "Appuyez sur Page Suivante pour lire le reste de la licence utilisateur."
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Si vous acceptez les termes de la licence utilisateur, cliquez sur J'accepte pour continuer.  Vous devez accepter la licence utilisateur pour d�sinstaller $(^Name)."
  !endif
!endif
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Si vous acceptez les termes de la licence utilisateur, cochez la case ci-dessous.  Vous devez accepter la licence utilisateur pour d�sinstaller $(^Name)."
  !endif
!endif
!ifdef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Si vous acceptez les termes de la licence utilisateur, s�lectionnez le premier choix ci-dessous.  Vous devez accepter la licence utilisateur pour d�sinstaller $(^Name)."
  !endif
!endif

; COMPONENTS PAGE
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_CAPTION ": Choisissez les composants"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_SUBTITLE "Choisissez les composants de $(^Name) que vous souhaitez installer."
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TITLE "Choisissez les composants"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Description"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Passer le curseur de votre souris sur un composant pour voir sa description"

!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_CAPTION ": Choisissez les composants"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_SUBTITLE "Choisissez les composants de $(^Name) que vous souhaitez d�sinstaller."
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TITLE "Choisissez les composants"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Description"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Passer le curseur de votre souris sur un composant pour voir sa description"

; DIRECTORY PAGE
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_CAPTION ": Choisissez le dossier d'installation"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_TOP "L'assistant va installer $(^Name) dans le dossier suivant.$\r$\n$\r$\nPour l'installer dans le dossier par d�faut, laissez le champs ci-dessous tel quel.  Pour l'installer dans un dossier diff�rent, entrez un chemin ci-dessous, ou cliquez sur Parcourir. $_CLICK"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_DESTINATION "Dossier de Destination"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSE "Parcourir..."
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSEDIALOG "Veuillez s�lectionner un dossier :"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TITLE "Choisissez le dossier de destination"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_SUBTITLE "Choisissez le dossier dans lequel installer $(^Name)."

!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_CAPTION ": Choisissez le dossier d'installation"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_TOP "L'assistant va d�sinstaller $(^Name) du dossier suivant.$\r$\n$\r$\nPour d�sinstaller � partir de ce dossier, cliquez sur suivant.  Pour d�sinstaller � partir d'un dossier diff�rent, entrez un chemin ci-dessous, ou cliquez sur Parcourir."
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_DESTINATION "Dossier de Destination"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSE "Parcourir..."
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSEDIALOG "Veuillez s�lectionner un dossier :"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TITLE "Choisissez le dossier de destination"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_SUBTITLE "Choisissez le dossier dans lequel d�installer $(^Name)."

; START MENU PAGE
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CAPTION    ": Dossier du Menu D�marrer"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TITLE      "Choisissez un dossier dans le menu D�marrer"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_SUBTITLE   "Choisissez un dossier dans le menu D�marrer pour les raccourcis de $(^Name) :"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TEXT       "Choisissez le dossier du menu D�marrer dans lequel vous voulez placer les raccourcis de $(^Name) :"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CHECKBOX   "Ne pas cr�er de raccourcis"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_FOLDER     "$(^Name)"

!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CAPTION  ": Dossier du Menu D�marrer"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TITLE    "Choisissez un dossier dans le menu D�marrer"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_SUBTITLE "Choisissez un dossier dans le menu D�marrer dans lequel supprimer les raccourcis :"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TEXT     "Choisissez le dossier du menu D�marrer dans lequel vous voulez supprimer les raccourcis :"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CHECKBOX "Ne pas supprimer les raccourcis"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_FOLDER   "$(^Name)"

; INSTALL CONFIRM PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_CAPTION ": Confirmation de l'installation"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_SUBTITLE "Le programme a finit de rassembler les informations et est pr�t � installer $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TITLE "Confirmation de l'installation"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_TOP "L'assistant est pr�t � installer $(^Name) sur votre ordinateur."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_BOTTOM "$_CLICK"

!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_CAPTION ": Confirmation de l'installation"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_SUBTITLE "Le programme a finit de rassembler les informations et est pr�t � d�sinstaller $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TITLE "Confirmation de la d�sinstallation"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_TOP "L'assistant est pr�t � d�sinstaller $(^Name) de votre ordinateur."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_BOTTOM "Appuyez sur suivant pour continuer."

; INSTFILES PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_CAPTION ": Copie des fichiers"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_SUBTITLE "Veuillez patienter pendant l'installation de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_TITLE "Installation en cours..."
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_TITLE "Installation termin�e"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_SUBTITLE "Tous les components de $(^Name) ont �t�s install�s sur votre ordinateur."

!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_CAPTION ": Suppression des fichiers"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_SUBTITLE "Veuillez patienter pendant la d�sinstallation de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_TITLE "D�sinstallation en cours..."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_DONE_TITLE "D�sinstallation termin�e"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_DONE_SUBTITLE "Tous les components de $(^Name) ont �t�s supprim�s de votre ordinateur."

!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_FAIL_TITLE "Installation interrompue"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_FAIL_SUBTITLE "L'installation de $(^Name) n'a pas �t� termin�e."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_FAIL_TITLE "D�sinstallation interrompue"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_FAIL_SUBTITLE "La d�sinstallation de $(^Name) n'a pas �t� termin�e."

; INSTALL SUCCESS PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_CAPTION ": Installation r�ussie"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_SUBTITLE "L'assistant a termin� l'installation de $(^Name) sur votre ordinateur."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TITLE "Installation termin�e"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_TOP    "$(^Name) a �t� install� avec succ�s."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_BOTTOM "Cliquez sur suivant pour terminer."

!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_CAPTION ": D�sinstallation r�ussie"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_SUBTITLE "L'assistant a termin� la d�sinstallation de $(^Name) sur votre ordinateur."
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TITLE "D�sinstallation termin�e"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_TOP    "$(^Name) a �t� d�sinstall� avec succ�s."
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_BOTTOM "Cliquez sur suivant pour terminer."

; FINISH PAGE

!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TITLE "Installation termin�e"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_SUBTITLE "L'assistant a termin� l'installation de $(^Name) sur votre ordinateur est termin�e."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CAPTION ": Installation termin�e"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP "Finalisation de l'assistant d'installation de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP_ALT "Fin de l'assistant d'installation de NSIS"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_RUN "L�installation de $(^Name) sur votre ordinateur est termin�e.\r\n\r\nQue voulez-vous faire ?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_REBOOT "Le programme d'installation a termin� de copier les fichiers sur votre ordinateur.\r\n\r\nPour terminer l'installation, il faut red�marrer l'ordinateur.  Red�marrer l'ordinateur maintenant ?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT "L�installation de $(^Name) sur votre ordinateur est termin�e.\r\n\r\nCliquez sur $(XPUI_BUTTONTEXT_CLOSE) pour quitter le programme d'installation"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_RUN "Ex�cuter $(^Name) maintenant"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_DOCS "Afficher la documentation de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_REBOOT "Oui, red�marrer mon ordinateur maintenant."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_NOREBOOT "Non, je vais red�marrer moi-m�me mon ordinateur plus tard."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_REBOOT_MESSAGEBOX "L'assistant doit red�marrer votre ordinateur.$\r$\n$\r$\nFermez tous les documents et applications avant de continuer.  Cliquez sur Ok pour red�marrer votre ordinateur."

!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TITLE "D�sinstallation termin�e"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_SUBTITLE "L'assistant a termin� la d�sinstallation de $(^Name) sur votre ordinateur."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_CAPTION ": D�sinstallation termin�e"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP "Finalisation de l'assistant d'installation de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP_ALT "Fin de l'assistant d'installation de NSIS"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_REBOOT "$(^Name) a �t� supprim� de votre ordinateur.\r\n\r\nPour terminer la d�sinstallation, il faut red�marrer l'ordinateur.  Red�marrer l'ordinateur maintenant ?"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_RUN "$(^Name) a �t� supprim� de votre ordinateur.\r\n\r\nQue voulez-vous faire ?"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT "$(^Name) a �t� supprim� de votre ordinateur.\r\n\r\nCliquez sur $(XPUI_BUTTONTEXT_CLOSE) pour quitter le programme d'installation."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_REBOOT "Oui, red�marrer mon ordinateur maintenant."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_NOREBOOT "Non, je vais red�marrer moi-m�me mon ordinateur plus tard."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_REBOOT_MESSAGEBOX "${XPUI_FINISHPAGE_REBOOT_MESSAGEBOX}"

; ABORT PAGE
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT_TOP "Fin de l'assistant d'installation de NSIS"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT "L'assistant a �t� interrompu avant de pouvoir installer $(^Name).\r\n\r\nVotre syst�me est inchang�. Pour installer ce programme ult�rieurement, veuillez relancer le programme d'installation.\r\n\r\n\r\n\r\n\r\nCliquer sur Fermer pour terminer l'assistant d'installation."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TITLE "Installation interrompue"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_SUBTITLE "L'installation de $(^Name) n'a pas �t� termin�e."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_CAPTION ": Installation annul�e"

!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT_TOP "Fin de l'assistant de d�sinstallation de NSIS"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT "L'assistant a �t� interrompu avant de pouvoir d�sinstaller $(^Name).\r\n\r\nVotre syst�me est inchang�. Pour d�sinstaller ce programme ult�rieurement, veuillez relancer le programme d'installation.\r\n\r\n\r\n\r\n\r\nCliquer sur Fermer pour terminer l'assistant d'installation."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TITLE "D�sinstallation interrompue"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_SUBTITLE "La d�sinstallation de $(^Name) n'a pas �t� termin�e."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_CAPTION ": D�sinstallation annul�e"

; +-----------+
; | UNINSTALL |
; +-----------+

; MOST OF THE UNINSTALL PAGES ARE TAKEN CARE OF USING THE PAGE MODE SYSTEM
; THE XPUI CONFIRM, UNINSTFILES, AND SUCCESS PAGES USE THE PAGE MODE SYSTEM,
; BUT THE NSIS-STYLE UNINSTALL CONFIRM PAGE SIMPLY USES A NON-PAGE-MODE METHOD.

; UNINST CONFIRM PAGE (NSIS)
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_CAPTION ": Confirmation de la d�sinstallation"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_SUBTITLE "Supprimer $(^Name) de votre ordinateur"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TITLE "D�sinstallation de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_TOP "$(^Name) sera d�sinstall� � partir du dossier suivant.  Cliquez D�sinstaller pour lancer la d�sinstallation."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_FOLDER "D�sintaller � partir de :"

!insertmacro XPUI_LANGUAGEFILE_END
