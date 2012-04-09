;NSIS ExperienceUI - Language File
;Compatible with ExperienceUI 1.3.1

;Language: Portuguese (2070)
;By Adriano Pereira <adrianopt2@gmail.com>

;--------------------------------

!insertmacro XPUI_LANGUAGEFILE_BEGIN "Portuguese"

; Use only ASCII characters (if this is not possible, use the English name)
!insertmacro XPUI_UNSET XPUI_LANGNAME
!insertmacro XPUI_DEFAULT XPUI_LANGNAME "Portugu�s"

; BUTTONS
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_NEXT   Seguinte
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_BACK   Anterior
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CANCEL Cancelar
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CLOSE  Fechar

!insertmacro XPUI_DEFAULT XPUI_ABORTWARNING_TEXT "Se abandonar agora a instala��o, o $(^Name) n�o ser� instalado.$\n$\nDeseja continuar?"

; +---------+
; | INSTALL |
; +---------+

; WELCOME PAGE
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT_TOP "Bem-vindo ao Assistente de Instala��o do $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT "Este assistente ir� gui�-lo ao longo da instala��o do $(^Name).\r\n\r\n� recomendado que feche todas as outras aplica��es antes da Instala��o. Isto permitir� actualizar ficheiros importantes do sistema sem a necessidade de reiniciar o computador.\r\n\r\n"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TITLE "Bem-vindo"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_SUBTITLE "Bem-vindo ao Assistente de Instala��o do $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT_TOP "Bem-vindo ao Assistente de Desinstala��o do $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT "Este assistente ir� gui�-lo ao longo da desinstala��o do $(^Name).\r\n\r\n� recomendado que feche todas as outras aplica��es antes da Desinstala��o. Isto permitir� actualizar ficheiros importantes do sistema sem a necessidade de reiniciar o computador.\r\n\r\n"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TITLE "Bem-vindo"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_SUBTITLE "Bem-vindo ao Assistente de Desinstala��o do $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_CAPTION " "

; WELCOME PAGE STYLE 2
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TEXT_TOP "Bem-vindo ao Assistente de Instala��o do $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TEXT "Bem-vindo � Instala��o do $(^Name).  O $(^Name) ir� ser instalado no seu computador."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TITLE "Bem-vindo"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_SUBTITLE "Bem-vindo � Instala��o do $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TEXT_TOP "Bem-vindo ao Assistente de Desinstala��o do $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TEXT "Bem-vindo � Desinstala��o do $(^Name).  O $(^Name) ir� ser desinstalado do seu computador."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TITLE "Bem-vindo"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_SUBTITLE "Bem-vindo � Desinstala��o do $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_CAPTION " "

; LICENSE PAGE
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_CAPTION ": Contrato de Licen�a"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "Eu concordo com os termos e as condi��es acima escritos"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "Eu n�o concordo com os termos e as condi��es acima escritos"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_CHECKBOX "Eu concordo com os termos e as condi��es acima escritos"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_SUBTITLE "Por favor verifique os termos da licen�a antes de instalar o $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TITLE "Contrato de Licen�a"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_TOP "Prima Page Down ou use a barra lateral para continuar a ver a licen�a."
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Se aceitar os termos da licen�a, clique em Aceito para continuar. Deve aceitar o contrato para instalar o $(^Name)."
  !endif
!endif
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Se aceitar os termos da licen�a, marque a caixa abaixo. Deve aceitar o contrato para instalar o $(^Name)."
  !endif
!endif
!ifdef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Se aceitar os termos da licen�a, seleccione a primeira op��o acima. Deve aceitar o contrato para instalar o $(^Name)."
  !endif
!endif

!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_CAPTION ": Contrato de Licen�a"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "Eu concordo com os termos e as condi��es acima escritos"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "Eu n�o concordo com os termos e as condi��es acima escritos"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_CHECKBOX "Eu concordo com os termos e as condi��es acima escritos"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_SUBTITLE "Por favor verifique os termos da licen�a antes de desinstalar o $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TITLE "Contrato de Licen�a"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_TOP "Prima Page Down ou use a barra lateral para continuar a ver a licen�a."
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Se aceitar os termos da licen�a, clique em Aceito para continuar. Deve aceitar o contrato para desinstalar o $(^Name).."
  !endif
!endif
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Se aceitar os termos da licen�a, marque a caixa abaixo. Deve aceitar o contrato para desinstalar o $(^Name)."
  !endif
!endif
!ifdef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Se aceitar os termos da licen�a, seleccione a primeira op��o acima. Deve aceitar o contrato para desinstalar o $(^Name)."
  !endif
!endif

; COMPONENTS PAGE
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_CAPTION ": Seleccione os Componentes"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_SUBTITLE "Escolha quais os componentes do $(^Name) devem ser instalados."
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TITLE "Escolha os Componentes"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Descri��o"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Passe o rato sobre um componente para ver a sua descri��o"

!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_CAPTION ": Seleccione os Componentes"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_SUBTITLE "Escolha quais os componentes do $(^Name) devem ser desinstalados."
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TITLE "Escolha os Componentes"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Descri��o"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Passe o rato sobre um componente para ver a sua descri��o"

; DIRECTORY PAGE
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_CAPTION ": Seleccione a Pasta de Instala��o"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_TOP "O Assistente ir� instalar o $(^Name) na seguinte pasta.$\r$\n$\r$\nPara instalar na pasta pr�-definida, deixe a caixa de texto abaixo como est�.  Para instalar numa pasta diferente, introduza uma abaixo, ou clique em Procurar. $_CLICK"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_DESTINATION "Pasta de Instala��o"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSE "Procurar"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSEDIALOG "Por favor seleccione uma pasta:"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TITLE "Escolha o Local de Instala��o"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_SUBTITLE "Escolha a pasta para instalar o $(^Name)."

!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_CAPTION ": Seleccione a Pasta de Instala��o"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_TOP "O Assistente ir� desinstalar o $(^Name) da seguinte pasta.$\r$\n$\r$\nPara desinstalar desta pasta, clique em Seguinte.  Para desinstalar de uma pasta diferete, introduza uma abaixo ou clique em Procurar."
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_DESTINATION "Pasta de Instala��o"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSE "Procurar"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSEDIALOG "Por favor seleccione uma pasta:"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TITLE "Escolha o Local de Instala��o"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_SUBTITLE "Escolha a pasta de onde deseja desinstalar o $(^Name)."

; START MENU PAGE
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CAPTION    ": Pasta do Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TITLE      "Seleccione a Pasta do Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_SUBTITLE   "Seleccione a pasta onde o Assistente ir� criar os atalhos do Menu Iniciar para o $(^Name):"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TEXT       "Seleccione a pasta onde deseja criar os atalhos do Menu Iniciar para o $(^Name):"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CHECKBOX   "N�o criar uma pasta no Menu Iniciar"

!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CAPTION  ": Pasta do Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TITLE    "Seleccione a Pasta do Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_SUBTITLE "Seleccione a pasta de onde o Assistente ir� remover os atalhos do Menu Iniciar:"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TEXT     "Seleccione a pasta de onde deseja remover os atalhos do Menu Iniciar:"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CHECKBOX "N�o remover a pasta do Menu Iniciar"

; INSTALL CONFIRM PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_CAPTION ": Confirmar Instala��o"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_SUBTITLE "O Assistente acabou de recolher informa��o e est� preparado para instalar o $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TITLE "Confirmar Instala��o"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_TOP "O Assistente est� preparado para instalar o $(^Name) no seu computador."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_BOTTOM "$_CLICK"

!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_CAPTION ": Confirmar Instala��o"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_SUBTITLE "O Assistente acabou de recolher informa��o e est� preparado para desinstalar o $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TITLE "Confirmar Desinstala��o"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_TOP "O Assistente est� preparado para desinstalar o $(^Name) do seu computador."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_BOTTOM "Clique em Seguinte para continuar."

; INSTFILES PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_CAPTION ": A Copiar Ficheiros"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_SUBTITLE "Por favor espere enquanto o $(^Name) est� a ser instalado."
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_TITLE "A Instalar"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_TITLE "Instala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_SUBTITLE "Todos os componentes do $(^Name) foram copiados com sucesso para o computador."

!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_CAPTION ": A Desinstalar Ficheiros"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_SUBTITLE "Por favor espere enquanto o $(^Name) est� a ser desinstalado."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_TITLE "A Desinstalar"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_DONE_TITLE "Desinstala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_DONE_SUBTITLE "Todos os componentes do $(^Name) foram removidos com sucesso do seu computador."

!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_FAIL_TITLE "Instala��o Incompleta"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_FAIL_SUBTITLE "A Instala��o do $(^Name) n�o foi efectuada com sucesso."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_FAIL_TITLE "Desinstala��o Incompleta"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_FAIL_SUBTITLE "A Desinstala��o do $(^Name) n�o foi efectuada com sucesso."

; INSTALL SUCCESS PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_CAPTION ":  Instala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_SUBTITLE "O $(^Name) foi instalado com sucesso no seu computador."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TITLE "Instala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_TOP    "O $(^Name) foi instalado com sucesso."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_BOTTOM "Clique em Fechar para sair."

!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_CAPTION ": Desinstala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_SUBTITLE "O $(^Name) foi desinstalado com sucesso do seu computador."
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TITLE "Desinstala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_TOP    "O $(^Name) foi desinstalado com sucesso."
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_BOTTOM "Clique em Fechar para sair."

; FINISH PAGE

!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TITLE "Instala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_SUBTITLE "O Assistente instalou com sucesso o $(^Name) no seu computador."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CAPTION ": Instala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP "A Finalizar o Assistente de Instala��o do $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP_ALT "Assistente de Instala��o NSIS Terminado"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_RUN "O Assistente instalou com sucesso o $(^Name) no seu computador.\r\n\r\nO que deseja fazer agora?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_REBOOT "O Assistente acabou de copiar os ficheiros para o seu computador.\r\n\r\nPara finalizar a instala��o, deve reiniciar o computador.  Quer reiniciar o computador agora?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT "O Assistente instalou com sucesso o $(^Name) no seu computador.\r\n\r\nPor favor clique em $(XPUI_BUTTONTEXT_CLOSE) para sair do Assistente."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_RUN "Executar o $(^Name) agora"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_DOCS "Ver a documenta��o do $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_REBOOT "Sim, reiniciar o meu computador agora."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_NOREBOOT "N�o, irei reiniciar o computador mais tarde."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_REBOOT_MESSAGEBOX "O Assistente ir� reiniciar o seu computador.$\r$\n$\r$\npor favor guarde e feche todos os ficheiros e documentos abertos, e clique em OK para reiniciar o computador."

!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TITLE "Desinstala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_SUBTITLE "O Assistente desinstalou com sucesso o $(^Name) do seu computador."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_CAPTION ": Desinstala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP "A Finalizar o Assistente de Desinstala��o do $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP_ALT "Assistente de Desinstala��o NSIS Terminado"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_REBOOT "O Assistente acabou de apagar os ficheiros do computador.\r\n\r\nPara finalizar a desinstala��o, deve reiniciar o computador.  Deseja reiniciar o computador agora?"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_RUN "O Assistente desinstalou com sucesso o $(^Name) do computador.\r\n\r\nO que deseja fazer agora?"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT "O Assistente desinstalou com sucesso o $(^Name) do computador.\r\n\r\nPor favor clique em $(XPUI_BUTTONTEXT_CLOSE) para sair."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_REBOOT "Sim, reiniciar o meu computador agora."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_NOREBOOT "N�o, irei reiniciar o computador mais tarde."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_CHECKBOX_RUN "${XPUI_FINISHPAGE_CHECKBOX_RUN}"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_CHECKBOX_DOCS "${XPUI_FINISHPAGE_CHECKBOX_DOCS}"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_REBOOT_MESSAGEBOX "${XPUI_FINISHPAGE_REBOOT_MESSAGEBOX}"

; ABORT PAGE
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT_TOP "Assistente de Instala��o NSIS Terminado"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT "O Assistente foi interrompido antes do $(^Name) ser completamente instalado.\r\n\r\nO sistema n�o foi modificado.  Para instalar este programa mais tarde, por favor execute\r\n o Assistente outra vez.\r\n\r\n\r\n\r\n\r\nPor favor clique em Fechar para sair do Assistente de Instala��o."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TITLE "Instala��o Inompleta"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_SUBTITLE "O Assistente de Instala��o n�o foi completado."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_CAPTION ": Assistente Cancelado"

!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT_TOP "Assistente de Desinstala��o NSIS Terminado"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT " Assistente foi interrompido antes do $(^Name) ser completamente desinstalado.\r\n\r\nO sistema n�o foi modificado.  Para desinstalar este programa mais tarde, por favor execute\r\n o Assistente outra vez.\r\n\r\n\r\n\r\n\r\nPor favor clique em Fechar para sair do Assistente de Desinstala��o."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TITLE "Desinstala��o Incompleta"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_SUBTITLE "O Assistente de Desinstala��o n�o foi completado."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_CAPTION ": Assistente Cancelado"

; +-----------+
; | UNINSTALL |
; +-----------+

; MOST OF THE UNINSTALL PAGES ARE TAKEN CARE OF USING THE PAGE MODE SYSTEM
; THE XPUI CONFIRM, UNINSTFILES, AND SUCCESS PAGES USE THE PAGE MODE SYSTEM,
; BUT THE NSIS-STYLE UNINSTALL CONFIRM PAGE SIMPLY USES A NON-PAGE-MODE METHOD.

; UNINST CONFIRM PAGE (NSIS)
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_CAPTION ": Confirmar Desinstala��o"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_SUBTITLE "Remover o $(^Name) do computador"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TITLE "Desinstalar o $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_TOP "O $(^Name) ser� desinstalado da pasta indicada.  Clique em Desinstalar para come�ar a desinstala��o."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_FOLDER "A Desinstalar de:"

!insertmacro XPUI_LANGUAGEFILE_END
