;NSIS ExperienceUI - Language File
;Compatible with ExperienceUI 1.09ß

;Language: Spanish (1034)
;Par Matze <matze@gravure-hebdo.com>

;--------------------------------

!insertmacro XPUI_LANGUAGEFILE_BEGIN "Spanish"

; Use only ASCII characters (if this is not possible, use the English name)
!insertmacro XPUI_UNSET XPUI_LANGNAME
!insertmacro XPUI_DEFAULT XPUI_LANGNAME "Español"

; BUTTONS
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_NEXT   Siguiente
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_BACK   Atrás
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CANCEL Cancelar
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CLOSE  Cerrar

!insertmacro XPUI_DEFAULT XPUI_ABORTWARNING_TEXT "Usted está a punto de salir del setup.$\n$\nSi usted ahora sale, $(^Name) no será instalado.$\n$\n¿Está seguro de que desea salir de la instalación de $(^Name)?"

; +---------+
; | INSTALL |
; +---------+

; WELCOME PAGE
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT_TOP "Bienvenido al Asistente de Instalación de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT "Este programa instalará $(^Name) en su ordenador.\r\n\r\nSe recomienda que cierre todas las demás aplicaciones antes de iniciar la instalación. Esto hará posible actualizar archivos relacionados con el sistema sin tener que reiniciar su ordenador.\r\n\r\n"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TITLE "Bienvenido"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_SUBTITLE "Bienvenido al Instalación de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT_TOP "Bienvenido al Asistente de desinstalación de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT "Este programa desinstalará $(^Name) en su ordenador.\r\n\r\nSe recomienda que cierre todas las demás aplicaciones antes de iniciar la desinstalación. Esto hará posible actualizar archivos relacionados con el sistema sin tener que reiniciar su ordenador.\r\n\r\n"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TITLE "Bienvenido"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_SUBTITLE "Bienvenido al desinstalación de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_CAPTION " "

; WELCOME PAGE STYLE 2
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TEXT_TOP "Bienvenido al Asistente de Instalación NSIS de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TEXT "Bienvenido al Instalación de $(^Name). Este programa instalará $(^Name) en su ordenador"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TITLE "Bienvenido"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_SUBTITLE "Bienvenido al Instalación de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TEXT_TOP "Bienvenido al Asistente de Desinstalación NSIS de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TEXT "Bienvenido al Desinstalación de $(^Name). Este programa desinstalará $(^Name) en su ordenador"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TITLE "Bienvenido"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_SUBTITLE "Bienvenido al Desinstalación de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_CAPTION " "

; LICENSE PAGE
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_CAPTION ": Acuerdo de licencia"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "Acepto todos los términos del acuerdo"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "No acepto todos los términos del acuerdo"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_CHECKBOX "Acepto todos los términos del acuerdo"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_SUBTITLE "Por favor revise los términos de la licencia antes de instalar $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TITLE "Acuerdo de licencia"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_TOP "Presione Avanzar Página para ver el resto del acuerdo."
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Si acepta todos los términos del acuerdo, seleccione Acepto para continuar. Debe aceptar el acuerdo para instalar $(^Name)."
  !endif
!endif
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Si acepta los términos del acuerdo, marque abajo la casilla. Debe aceptar los términos para instalar $(^Name)."
  !endif
!endif
!ifdef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Si acepta los términos del acuerdo, seleccione abajo la primera opción. Debe aceptar los términos para instalar $(^Name)."
  !endif
!endif

!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_CAPTION ": Acuerdo de licencia"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "Acepto todos los términos del acuerdo"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "No acepto todos los términos del acuerdo"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_CHECKBOX "Acepto todos los términos del acuerdo"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_SUBTITLE "Por favor revise los términos de la licencia antes de desinstalar $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TITLE "Acuerdo de licencia"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_TOP "Presione Avanzar Página para ver el resto del acuerdo."
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Si acepta todos los términos del acuerdo, seleccione Acepto para continuar. Debe aceptar el acuerdo para desinstalar $(^Name)."
  !endif
!endif
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Si acepta los términos del acuerdo, marque abajo la casilla. Debe aceptar los términos para desinstalar $(^Name)."
  !endif
!endif
!ifdef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Si acepta los términos del acuerdo, seleccione abajo la primera opción. Debe aceptar los términos para desinstalar $(^Name)."
  !endif
!endif

; COMPONENTS PAGE
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_CAPTION ": Selección de componentes"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_SUBTITLE "Seleccione qué características de $(^Name) desea instalar."
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TITLE "Selección de componentes"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Descripción"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Sitúe el ratón encima de un componente para ver su descripción"

!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_CAPTION ": Selección de componentes"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_SUBTITLE "Seleccione qué características de $(^Name) desea desinstalar."
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TITLE "Selección de componentes"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Descripción"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Sitúe el ratón encima de un componente para ver su descripción"

; DIRECTORY PAGE
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_CAPTION ": Elegir lugar de instalación"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_TOP "El programa de instalación instalará $(^Name) en el siguiente directorio.$\r$\n$\r$\nPara instalar en un directorio diferente, presione Examinar y seleccione otro directorio. $_CLICK"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_DESTINATION "Repertorio de instalación"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSE "Examinar"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSEDIALOG "Elegir Repertorio:"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TITLE "Elegir lugar de instalación"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_SUBTITLE "Elija el directorio para instalar $(^Name)."

!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_CAPTION ": Elegir lugar de instalación"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_TOP "El programa de desinstalación desinstalará $(^Name) en el siguiente directorio.$\r$\n$\r$\nPara desinstalar en un directorio diferente, presione Examinar y seleccione otro directorio."
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_DESTINATION "Repertorio de instalación"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSE "Examinar"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSEDIALOG "Elegir Repertorio:"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TITLE "Elegir lugar de instalación"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_SUBTITLE "Elija el directorio para desinstalar $(^Name)."

; START MENU PAGE
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CAPTION    ": Carpeta del Menú Inicio"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TITLE      "Elegir Carpeta del Menú Inicio"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_SUBTITLE   "Elija una Carpeta del Menú Inicio para los accesos directos de $(^Name):"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TEXT       "Elija una Carpeta del Menú Inicio para los accesos directos de to $(^Name):"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CHECKBOX   "No crear accesos directos"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_FOLDER     "$(^Name)"

!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CAPTION    ": Carpeta del Menú Inicio"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TITLE      "Elegir Carpeta del Menú Inicio"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_SUBTITLE   "Elija una Carpeta del Menú Inicio para desinstalar los accesos directos de $(^Name):"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TEXT       "Elija una Carpeta del Menú Inicio para desinstalar los accesos directos de to $(^Name):"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CHECKBOX   "No desinstalar accesos directos"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_FOLDER     "$(^Name)"

; INSTALL CONFIRM PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_CAPTION ": Confirmar Instalación"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_SUBTITLE "Setup tiene bastante información y es listo instalar $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TITLE "Confirmar Instalación"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_TOP "Setup es listo instalar $(^Name) en su computadora."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_BOTTOM "$_CLICK"

!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_CAPTION ": Confirmar Instalación"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_SUBTITLE "Setup tiene bastante información y es listo desinstalar $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TITLE "Confirmar Instalación"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_TOP "Setup es listo desinstalar $(^Name) de su computadora."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_BOTTOM "Presione Siguiente para continuar."

; INSTFILES PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_CAPTION ": Copiar Archivos"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_SUBTITLE "Por favor espere mientras $(^Name) se instala."
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_TITLE "Instalando"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_TITLE "Instalación Completada"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_SUBTITLE "Todos los componentes de $(^Name) fueron copiados en su sistema."

!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_CAPTION ": Desinstalando Archivos"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_SUBTITLE "Por favor espere mientras $(^Name) se desinstala."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_TITLE "Desinstalando"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_DONE_TITLE "Desinstalación Completada"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_DONE_SUBTITLE "Todos los componentes de $(^Name) fueron quitados de su sistema."

!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_FAIL_TITLE "Instalación incompletada"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_FAIL_SUBTITLE "Instalación de $(^Name) no se completó correctamente."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_FAIL_TITLE "Desinstalación incompletada"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_FAIL_SUBTITLE "Desinstalación de $(^Name) no se completó correctamente."

; INSTALL SUCCESS PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_CAPTION ": Instalación Completada"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_SUBTITLE "La instalación de $(^Name) se ha completado correctamente"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TITLE "Instalación Completada"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_TOP    "$(^Name) ha sido instalado en su sistema."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_BOTTOM "Presione Terminar para cerrar este asistente."

!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_CAPTION ": Desinstalación Completada"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_SUBTITLE "La desinstalación de $(^Name) se ha completado correctamente"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TITLE "Desinstalación Completada"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_TOP    "$(^Name) ha sido desinstalado en su sistema."
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_BOTTOM "Presione Terminar para cerrar este asistente."

; FINISH PAGE

!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TITLE "Instalación Completada"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_SUBTITLE "La instalación de $(^Name) se ha completado correctamente."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CAPTION ": Instalación Completada"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP "Completando el Asistente de Instalación de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP_ALT "Completando el Asistente de Instalación NSIS"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_RUN "$(^Name) ha sido instalado de su sistema.\r\n\r\n¿Qué acciones usted desean realizarse?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_REBOOT "Instalación completando copiar archivos en su sistema.\r\n\r\nSu ordenador debe ser reiniciado para completar la instalación de $(^Name). ¿Desea reiniciar ahora?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT "$(^Name) ha sido instalado de su sistema.\r\n\r\nPresione $(XPUI_BUTTONTEXT_CLOSE) para cerrar este asistente."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_RUN "Iniciar $(^Name) ahora"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_DOCS "Leer la documentación de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_REBOOT "Si, reiniciar su ordenador ahora."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_NOREBOOT "No, reiniciar su ordenador más tarde."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_REBOOT_MESSAGEBOX "Setup está alrededor reiniciar su ordenador.$\r$\n$\r$\nPor favor excepto y cierre todos los archivos y los documentos abiertos, i presione OK para reiniciar su ordenador."

!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TITLE "Desinstalación Completada"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_SUBTITLE "La desinstalación de $(^Name) se ha completado correctamente."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_CAPTION ": Desinstalación Completada"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP "Completando el Asistente de Desinstalación de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP_ALT "Completando el Asistente de Desinstalación NSIS"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_REBOOT "Instalación completando copiar archivos en su sistema.\r\n\r\nSu ordenador debe ser reiniciado para completar la desinstalación de $(^Name). ¿Desea reiniciar ahora?"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_RUN "$(^Name) ha sido desinstalado de su sistema.\r\n\r\n¿Qué acciones usted desean realizarse?"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT "$(^Name) ha sido desinstalado de su sistema.\r\n\r\nPresione $(XPUI_BUTTONTEXT_CLOSE) para cerrar este asistente."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_REBOOT "Si, reiniciar su ordenador ahora."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_NOREBOOT "No, reiniciar su ordenador más tarde."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_REBOOT_MESSAGEBOX "${XPUI_FINISHPAGE_REBOOT_MESSAGEBOX}"

; ABORT PAGE
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT_TOP "Completando el Asistente de Instalación NSIS"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT "El Asistente fue interrumpido antes $(^Name) ha sido instalado en su sistema.\r\n\r\nSu sistema no se ha modificado.  Para instalar este programa más tarde, reinicia este\r\nassistente.\r\n\r\n\r\n\r\n\r\nPresione Terminar para cerrar este asistente."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TITLE "Instalación incompletada"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_SUBTITLE "Instalación de $(^Name) no se completó correctamente."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_CAPTION ": Instalación Anulada"

!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT_TOP "Completando el Asistente de Desinstalación NSIS"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT "El Asistente fue interrumpido antes $(^Name) ha sido desinstalado en su sistema.\r\n\r\nSu sistema no se ha modificado.  Para instalar este programa más tarde, reinicia este assistente.\r\n\r\n\r\n\r\n\r\nPresione Terminar para cerrar este asistente."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TITLE "Desinstalación incompletada"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_SUBTITLE "Desinstalación de $(^Name) no se completó correctamente."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_CAPTION ": Instalación Anulada"

; +-----------+
; | UNINSTALL |
; +-----------+

; MOST OF THE UNINSTALL PAGES ARE TAKEN CARE OF USING THE PAGE MODE SYSTEM
; THE XPUI CONFIRM, UNINSTFILES, AND SUCCESS PAGES USE THE PAGE MODE SYSTEM,
; BUT THE NSIS-STYLE UNINSTALL CONFIRM PAGE SIMPLY USES A NON-PAGE-MODE METHOD.

; UNINST CONFIRM PAGE (NSIS)
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_CAPTION ": Confirmar Desinstalación"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_SUBTITLE "Desinstalar $(^Name) de su sistema."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TITLE "Desinstalar $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_TOP "$(^Name) sea desinstalado de la carpeta siguiente.  Presione Desinstalar para iniciar la Desinstalación."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_FOLDER "Desinstalar de:"

!insertmacro XPUI_LANGUAGEFILE_END
