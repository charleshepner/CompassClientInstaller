;NSIS ExperienceUI - Language File
;Compatible with ExperienceUI 1.3.1

;Language: Portuguese (2070)
;By Adriano Pereira <adrianopt2@gmail.com>

;--------------------------------

!insertmacro XPUI_LANGUAGEFILE_BEGIN "Portuguese"

; Use only ASCII characters (if this is not possible, use the English name)
!insertmacro XPUI_UNSET XPUI_LANGNAME
!insertmacro XPUI_DEFAULT XPUI_LANGNAME "Português"

; BUTTONS
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_NEXT   Seguinte
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_BACK   Anterior
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CANCEL Cancelar
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CLOSE  Fechar

!insertmacro XPUI_DEFAULT XPUI_ABORTWARNING_TEXT "Se abandonar agora a instalação, o $(^Name) não será instalado.$\n$\nDeseja continuar?"

; +---------+
; | INSTALL |
; +---------+

; WELCOME PAGE
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT_TOP "Bem-vindo ao Assistente de Instalação do $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT "Este assistente irá guiá-lo ao longo da instalação do $(^Name).\r\n\r\nÉ recomendado que feche todas as outras aplicações antes da Instalação. Isto permitirá actualizar ficheiros importantes do sistema sem a necessidade de reiniciar o computador.\r\n\r\n"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TITLE "Bem-vindo"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_SUBTITLE "Bem-vindo ao Assistente de Instalação do $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT_TOP "Bem-vindo ao Assistente de Desinstalação do $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT "Este assistente irá guiá-lo ao longo da desinstalação do $(^Name).\r\n\r\nÉ recomendado que feche todas as outras aplicações antes da Desinstalação. Isto permitirá actualizar ficheiros importantes do sistema sem a necessidade de reiniciar o computador.\r\n\r\n"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TITLE "Bem-vindo"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_SUBTITLE "Bem-vindo ao Assistente de Desinstalação do $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_CAPTION " "

; WELCOME PAGE STYLE 2
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TEXT_TOP "Bem-vindo ao Assistente de Instalação do $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TEXT "Bem-vindo à Instalação do $(^Name).  O $(^Name) irá ser instalado no seu computador."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_TITLE "Bem-vindo"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_SUBTITLE "Bem-vindo à Instalação do $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE2_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TEXT_TOP "Bem-vindo ao Assistente de Desinstalação do $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TEXT "Bem-vindo à Desinstalação do $(^Name).  O $(^Name) irá ser desinstalado do seu computador."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_TITLE "Bem-vindo"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_SUBTITLE "Bem-vindo à Desinstalação do $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE2_CAPTION " "

; LICENSE PAGE
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_CAPTION ": Contrato de Licença"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "Eu concordo com os termos e as condições acima escritos"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "Eu não concordo com os termos e as condições acima escritos"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_CHECKBOX "Eu concordo com os termos e as condições acima escritos"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_SUBTITLE "Por favor verifique os termos da licença antes de instalar o $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TITLE "Contrato de Licença"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_TOP "Prima Page Down ou use a barra lateral para continuar a ver a licença."
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Se aceitar os termos da licença, clique em Aceito para continuar. Deve aceitar o contrato para instalar o $(^Name)."
  !endif
!endif
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Se aceitar os termos da licença, marque a caixa abaixo. Deve aceitar o contrato para instalar o $(^Name)."
  !endif
!endif
!ifdef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Se aceitar os termos da licença, seleccione a primeira opção acima. Deve aceitar o contrato para instalar o $(^Name)."
  !endif
!endif

!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_CAPTION ": Contrato de Licença"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "Eu concordo com os termos e as condições acima escritos"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "Eu não concordo com os termos e as condições acima escritos"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_CHECKBOX "Eu concordo com os termos e as condições acima escritos"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_SUBTITLE "Por favor verifique os termos da licença antes de desinstalar o $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TITLE "Contrato de Licença"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_TOP "Prima Page Down ou use a barra lateral para continuar a ver a licença."
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Se aceitar os termos da licença, clique em Aceito para continuar. Deve aceitar o contrato para desinstalar o $(^Name).."
  !endif
!endif
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Se aceitar os termos da licença, marque a caixa abaixo. Deve aceitar o contrato para desinstalar o $(^Name)."
  !endif
!endif
!ifdef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Se aceitar os termos da licença, seleccione a primeira opção acima. Deve aceitar o contrato para desinstalar o $(^Name)."
  !endif
!endif

; COMPONENTS PAGE
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_CAPTION ": Seleccione os Componentes"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_SUBTITLE "Escolha quais os componentes do $(^Name) devem ser instalados."
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TITLE "Escolha os Componentes"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Descrição"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Passe o rato sobre um componente para ver a sua descrição"

!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_CAPTION ": Seleccione os Componentes"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_SUBTITLE "Escolha quais os componentes do $(^Name) devem ser desinstalados."
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TITLE "Escolha os Componentes"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Descrição"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Passe o rato sobre um componente para ver a sua descrição"

; DIRECTORY PAGE
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_CAPTION ": Seleccione a Pasta de Instalação"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_TOP "O Assistente irá instalar o $(^Name) na seguinte pasta.$\r$\n$\r$\nPara instalar na pasta pré-definida, deixe a caixa de texto abaixo como está.  Para instalar numa pasta diferente, introduza uma abaixo, ou clique em Procurar. $_CLICK"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_DESTINATION "Pasta de Instalação"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSE "Procurar"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSEDIALOG "Por favor seleccione uma pasta:"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TITLE "Escolha o Local de Instalação"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_SUBTITLE "Escolha a pasta para instalar o $(^Name)."

!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_CAPTION ": Seleccione a Pasta de Instalação"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_TOP "O Assistente irá desinstalar o $(^Name) da seguinte pasta.$\r$\n$\r$\nPara desinstalar desta pasta, clique em Seguinte.  Para desinstalar de uma pasta diferete, introduza uma abaixo ou clique em Procurar."
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_DESTINATION "Pasta de Instalação"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSE "Procurar"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSEDIALOG "Por favor seleccione uma pasta:"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TITLE "Escolha o Local de Instalação"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_SUBTITLE "Escolha a pasta de onde deseja desinstalar o $(^Name)."

; START MENU PAGE
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CAPTION    ": Pasta do Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TITLE      "Seleccione a Pasta do Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_SUBTITLE   "Seleccione a pasta onde o Assistente irá criar os atalhos do Menu Iniciar para o $(^Name):"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TEXT       "Seleccione a pasta onde deseja criar os atalhos do Menu Iniciar para o $(^Name):"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CHECKBOX   "Não criar uma pasta no Menu Iniciar"

!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CAPTION  ": Pasta do Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TITLE    "Seleccione a Pasta do Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_SUBTITLE "Seleccione a pasta de onde o Assistente irá remover os atalhos do Menu Iniciar:"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TEXT     "Seleccione a pasta de onde deseja remover os atalhos do Menu Iniciar:"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CHECKBOX "Não remover a pasta do Menu Iniciar"

; INSTALL CONFIRM PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_CAPTION ": Confirmar Instalação"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_SUBTITLE "O Assistente acabou de recolher informação e está preparado para instalar o $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TITLE "Confirmar Instalação"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_TOP "O Assistente está preparado para instalar o $(^Name) no seu computador."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_BOTTOM "$_CLICK"

!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_CAPTION ": Confirmar Instalação"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_SUBTITLE "O Assistente acabou de recolher informação e está preparado para desinstalar o $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TITLE "Confirmar Desinstalação"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_TOP "O Assistente está preparado para desinstalar o $(^Name) do seu computador."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_BOTTOM "Clique em Seguinte para continuar."

; INSTFILES PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_CAPTION ": A Copiar Ficheiros"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_SUBTITLE "Por favor espere enquanto o $(^Name) está a ser instalado."
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_TITLE "A Instalar"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_TITLE "Instalação Completa"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_SUBTITLE "Todos os componentes do $(^Name) foram copiados com sucesso para o computador."

!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_CAPTION ": A Desinstalar Ficheiros"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_SUBTITLE "Por favor espere enquanto o $(^Name) está a ser desinstalado."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_TITLE "A Desinstalar"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_DONE_TITLE "Desinstalação Completa"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_DONE_SUBTITLE "Todos os componentes do $(^Name) foram removidos com sucesso do seu computador."

!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_FAIL_TITLE "Instalação Incompleta"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_FAIL_SUBTITLE "A Instalação do $(^Name) não foi efectuada com sucesso."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_FAIL_TITLE "Desinstalação Incompleta"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_FAIL_SUBTITLE "A Desinstalação do $(^Name) não foi efectuada com sucesso."

; INSTALL SUCCESS PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_CAPTION ":  Instalação Completa"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_SUBTITLE "O $(^Name) foi instalado com sucesso no seu computador."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TITLE "Instalação Completa"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_TOP    "O $(^Name) foi instalado com sucesso."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_BOTTOM "Clique em Fechar para sair."

!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_CAPTION ": Desinstalação Completa"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_SUBTITLE "O $(^Name) foi desinstalado com sucesso do seu computador."
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TITLE "Desinstalação Completa"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_TOP    "O $(^Name) foi desinstalado com sucesso."
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_BOTTOM "Clique em Fechar para sair."

; FINISH PAGE

!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TITLE "Instalação Completa"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_SUBTITLE "O Assistente instalou com sucesso o $(^Name) no seu computador."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CAPTION ": Instalação Completa"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP "A Finalizar o Assistente de Instalação do $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP_ALT "Assistente de Instalação NSIS Terminado"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_RUN "O Assistente instalou com sucesso o $(^Name) no seu computador.\r\n\r\nO que deseja fazer agora?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_REBOOT "O Assistente acabou de copiar os ficheiros para o seu computador.\r\n\r\nPara finalizar a instalação, deve reiniciar o computador.  Quer reiniciar o computador agora?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT "O Assistente instalou com sucesso o $(^Name) no seu computador.\r\n\r\nPor favor clique em $(XPUI_BUTTONTEXT_CLOSE) para sair do Assistente."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_RUN "Executar o $(^Name) agora"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_DOCS "Ver a documentação do $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_REBOOT "Sim, reiniciar o meu computador agora."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_NOREBOOT "Não, irei reiniciar o computador mais tarde."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_REBOOT_MESSAGEBOX "O Assistente irá reiniciar o seu computador.$\r$\n$\r$\npor favor guarde e feche todos os ficheiros e documentos abertos, e clique em OK para reiniciar o computador."

!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TITLE "Desinstalação Completa"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_SUBTITLE "O Assistente desinstalou com sucesso o $(^Name) do seu computador."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_CAPTION ": Desinstalação Completa"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP "A Finalizar o Assistente de Desinstalação do $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP_ALT "Assistente de Desinstalação NSIS Terminado"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_REBOOT "O Assistente acabou de apagar os ficheiros do computador.\r\n\r\nPara finalizar a desinstalação, deve reiniciar o computador.  Deseja reiniciar o computador agora?"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_RUN "O Assistente desinstalou com sucesso o $(^Name) do computador.\r\n\r\nO que deseja fazer agora?"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT "O Assistente desinstalou com sucesso o $(^Name) do computador.\r\n\r\nPor favor clique em $(XPUI_BUTTONTEXT_CLOSE) para sair."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_REBOOT "Sim, reiniciar o meu computador agora."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_NOREBOOT "Não, irei reiniciar o computador mais tarde."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_CHECKBOX_RUN "${XPUI_FINISHPAGE_CHECKBOX_RUN}"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_CHECKBOX_DOCS "${XPUI_FINISHPAGE_CHECKBOX_DOCS}"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_REBOOT_MESSAGEBOX "${XPUI_FINISHPAGE_REBOOT_MESSAGEBOX}"

; ABORT PAGE
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT_TOP "Assistente de Instalação NSIS Terminado"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT "O Assistente foi interrompido antes do $(^Name) ser completamente instalado.\r\n\r\nO sistema não foi modificado.  Para instalar este programa mais tarde, por favor execute\r\n o Assistente outra vez.\r\n\r\n\r\n\r\n\r\nPor favor clique em Fechar para sair do Assistente de Instalação."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TITLE "Instalação Inompleta"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_SUBTITLE "O Assistente de Instalação não foi completado."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_CAPTION ": Assistente Cancelado"

!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT_TOP "Assistente de Desinstalação NSIS Terminado"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT " Assistente foi interrompido antes do $(^Name) ser completamente desinstalado.\r\n\r\nO sistema não foi modificado.  Para desinstalar este programa mais tarde, por favor execute\r\n o Assistente outra vez.\r\n\r\n\r\n\r\n\r\nPor favor clique em Fechar para sair do Assistente de Desinstalação."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TITLE "Desinstalação Incompleta"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_SUBTITLE "O Assistente de Desinstalação não foi completado."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_CAPTION ": Assistente Cancelado"

; +-----------+
; | UNINSTALL |
; +-----------+

; MOST OF THE UNINSTALL PAGES ARE TAKEN CARE OF USING THE PAGE MODE SYSTEM
; THE XPUI CONFIRM, UNINSTFILES, AND SUCCESS PAGES USE THE PAGE MODE SYSTEM,
; BUT THE NSIS-STYLE UNINSTALL CONFIRM PAGE SIMPLY USES A NON-PAGE-MODE METHOD.

; UNINST CONFIRM PAGE (NSIS)
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_CAPTION ": Confirmar Desinstalação"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_SUBTITLE "Remover o $(^Name) do computador"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TITLE "Desinstalar o $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_TOP "O $(^Name) será desinstalado da pasta indicada.  Clique em Desinstalar para começar a desinstalação."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_FOLDER "A Desinstalar de:"

!insertmacro XPUI_LANGUAGEFILE_END
