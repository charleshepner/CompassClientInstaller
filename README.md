CompassClientInstaller
======================

This installer deploys the client-side components needed to launch and run Compass Pilot.

## What Gets Deployed?

* Ltbar7r15u.dll
* Ltbar7w15u.dll
* CompassPilot.ico
* CompassCapture.ico
* SelfScanKiosk.ico
* Compass Forms Printer
* Tifconvert Printer
* Desktop Shortcuts
* Start Menu Shortcuts
* Trusted sites
* Northwoods Website Start Menu Shortcut

## Features

* 64-bit detection for System32 vs. SysWOW64 and for Program Files vs. Program Files (x86)
* OS detection for paths that differ between Windowx XP and Windows Vista/7
* .NET detection (downloads and installs .NET 4.0 Extended Profile if not present)
* Uninstaller provided can be run from Add/Remove Programs or Programs and Features
* Silent install mode (/S on command-line)
* Answer file (answer.txt) to provide configuration (if run silently)
* Prompt to remove older version (remove silently) if a previous version is detected
* When running silently, automatically detects and removes a previous version

## Usage

This installer can be run interactively just by launching the executable.  It requires administrative privileges. Installation actions are logged to install.log in the installation directory.  If the installer detects that a copy of Compass Client Components is already installed, it will prompt the user to remove the previous version or else prevent the installer from continuing.  If the user chooses to remove the previous version it will be silently uninstalled.  If the installer is being run silently, any previous versions will be automatically removed before the installer runs.

**Components (Features) Page**

Choose which features will be installed.  Mousing over each feature shows a description below.  At least one feature must be selected to continue.

**Choose Install Location Page**

Installation files will be written by default to:

* C:\Program Files\Northwoods\Compass Client Components -- on 32-bit machines
* C:\Program Files (x86)\Northwoods\Compass Client Components -- on 64-bit machines

The files written to the installation location at this time are the Compass Pilot icon, the install log, and the uninstaller executable.

**Set Compass Client Components Settings Page**

Three customizable settings appear after the install location is chosen.

* The protocol used to download the Compass ClickOnce client (default http://)
* The URL used to download the Compass ClickOnce client (default [CompassClickOnceServer]/compassframework/compassapi.application)
* The network name of the print server for the Compass solution (default [CompassPrintServer])
* The network name of the application server for the Compass solution (default [CompassApplicationServer])

The Compass ClickOnce client can be delivered over http or https, selectable from a drop-down (the server must be configured appropriately for https).  For the URL used to download the Compass ClickOnce client, the text [CompassClickOnceServer] should be replaced by the network or DNS name of the server where the Compass ClickOnce Client will be deployed from (e.g. server01).  This URL is used for the Compass Client shortcuts placed on the desktop and in the Start Menu. Finally, the text [CompassPrintServer] should be replaced by the network or DNS name of the server where print jobs should be sent.  This server name is used when the local printers are created.

**Finish Page**

Click Finish.

## Silent/Unattended Install

This installer can be run silently just by adding the command-line parameter /S (case-sensitive).  An answer file can be provided so that the installer will know what values to use for the configurable areas in the wizard.  The installer will automatically detect the presence of answer.txt in the same folder as the installer executable and will draw configuration values from it.  Optionally /ANSWERFILE=path can be provide on the command-line to provide a path to an answer file.  If this command-line parameter is provided it will be used in preference to an answer file in the same directory as the installer executable.  If a value in the answer file is omitted or left blank, it will be left blank or defaulted to False.

Answer.txt is formatted in the INI file format.  It has two sections [Settings] and [Features].  Here are the possible key value pairs:

**Settings** controls what shows on the settings page of the wizard

* CompassClickOnceProtocol
  * Possible values: http:// or https://
  * e.g. http://
* CompassClickOnceURL
  * Possible values: the URL (without the protocal prefix) to the .application file of the Compass client
  * e.g. appserver01/compassframework/compassapi.application
* CompassPrintServer
  * Possible values: the network or DNS name of the print server (for virtual printing) where RPM is installed
  * e.g. printserver01
* CompassApplicationServer
  * Possible values: the network or DNS name of the application server where Compass Pilot is installed
  * e.g. appserver01  

**Features** controls which of the corresponding features are selected on the components page of the wizard

* InstallCompassClientSMIcon
  * Start menu shortcut for Pilot
  * Possible values: True or False
* InstallCompassClientIcon
  * Desktop shortcut for Pilot
  * Possible values: True or False
* InstallLEADTOOLSDLLs
  * Dll's required for barcoding engine in Forms
  * Possible values: True or False
* InstallFormsPrinter
  * Virtual printer for Forms
  * Possible values: True or False
* InstallTifconvertPrinter
  * Virtual printer for forms designers
  * Possible values: True or False
* InstallCaptureKioskSMIcon
  * Start menu shorcut for Capture Kiosk 
  * Possible values: True or False 
* InstallCaptureKioskIcon
  * Desktop shortcut for Capture Kiosk
  * Possible values: True or False
* InstallSelfScanKioskSMIcon
  * Start menu shortcut for Self Scan Kiosk
  * Possible values: True or False
* InstallSelfScanKioskIcon
  * Desktop shortcut for Self Scan Kiosk
  * Possible values: True or False
* InstallNorthwoodsIcon
  * Possible values: True or False
* InstallTrustedSites
  * Possible values: True or False  

**Options** controls optional behavior of the installer

* ClearClickOnceCache
  * If True, will clear the ClickOnce cache during the install, if False, leaves the cache intact
  * Possible values: True or False

Example answer file:

```
[Settings]
CompassClickOnceProtocol=https://
CompassClickOnceURL=appserver01/compassframework/compassapi.application
CompassPrintServer=printserver01
CompassApplicationServer=appserver01
[Features]
InstallCompassClientSMIcon=True
InstallCompassClientIcon=True
InstallLEADTOOLSDLLs=True
InstallFormsPrinter=True
InstallTifconvertPrinter=False
InstallCaptureKioskSMIcon=True
InstallCaptureKioskIcon=False
InstallSelfScanKioskSMIcon=True
InstallSelfScanKioskIcon=False
InstallNorthwoodsIcon=True
InstallTrustedSites=True
[Options]
ClearClickOnceCache=True
```
  
If the answer file is present and the installer is run interactively, the installer will use the values from the answer file in the wizard as the defaults instead of the compiled in default values (e.g. [CompassClickOnceServer]/compassframework/compassapi.application and [CompassPrintServer]).

## Screenshots

![Welcome Page](http://charleshepner.files.wordpress.com/2012/04/installer-welcome1.png)

![Features Page](http://charleshepner.files.wordpress.com/2012/04/installer-components.png)

![Directory Page](http://charleshepner.files.wordpress.com/2012/04/installer-directory1.png)

![Settings Page](http://charleshepner.files.wordpress.com/2012/04/installer-settings1.png)

![DotNet Prompt](http://charleshepner.files.wordpress.com/2012/04/installer-dotnet-prompt.png)

![DotNet Install](http://charleshepner.files.wordpress.com/2012/04/installer-dotnet.png)

![Complete Page](http://charleshepner.files.wordpress.com/2012/04/installer-complete.png)

![Finish Page](http://charleshepner.files.wordpress.com/2012/04/installer-finish.png)

![Parameters](http://charleshepner.files.wordpress.com/2012/04/installer-parameters1.png)

## Developing

In order to develop this installer, see the following pre-requisites:

* NSIS 2.46 (install from http://nsis.sourceforge.net/Download)
* A copy of the NSIS compiler (makensis.exe) with logging support (install from http://nsis.sourceforge.net/Special_Builds)

A NSIS editor is not required but helps a lot.  HM NIS Edit from HMSoft has worked well for me (http://hmne.sourceforge.net/).  Also note that Notepad++ has built-in syntax highlighting for .nsi and .nsh files (Language > N > NSIS).  Finally, NSIS Dialog Designer by Coolsoft has been invaluable for creating custom pages in the setup wizard (http://coolsoft.altervista.org/en/nsisdialogdesigner).

First steps:

* Get a copy of the code from github.com (https://github.com/charleshepner/CompassClientInstaller/)
  * `git clone git@github.com:charleshepner/CompassClientInstaller.git` or fork the code
  * Root folder contains a README (this file), a TODO list, and Compass Pilot.nsi (the script that compiles into the installer)
  * Include folder contains any header files not distributed with a default NSIS install
  * Installer folder contains the installer executable
  * Plugins folder contains any dll files not distributed with a default NSIS install
  * Resources folder contains files deployed by the installer
* Open Compass Pilot.nsi in HM NIS Edit and press Ctrl-F9
* You should be able to compile the installer at this point!

Developer notes:

* 64-bit detection is from the built in header x64.nsh

```
${If} ${RunningX64}
```

* OS version detection is from the built in header WinVer.nsh

```
${If} ${IsWinXP}
${If} ${IsWin7}
```

* LogicLib header is being used for conditionals and loops with a custom macro for file and directory testing

```
${If} ${FileExists} "C:\mysamplefile.txt"
${Else}
${EndIf}
```

* .NET version detection from a third-party header DotNetChecker.nsh providing download and install of the required version.  I made some custom changes to the DotNetChecker.nsh file to prevent the user from continuing with the install if they canceled out of the dialog prompting them to install .NET.

```
!insertmacro CheckNetFramework 40Full
```

* A macro is being used to create Internet shortcuts

```
!insertmacro CreateInternetShortcut "path_to_new_shortcut" "URL" "path_to_icon" "0"
```

* The custom page included was built using nsDialogs instead of the older InstallOptions ini files