CompassClientInstaller
======================

This installer deploys the client-side components needed to launch and run Compass Pilot.

## What Gets Deployed?

* Ltbar7r15u.dll
* Ltbar7w15u.dll
* CompassPilot.ico
* Tifconvert Printer
* Desktop Shortcut
* Start Menu Shortcut

## Features

* 64-bit detection for System32 vs. SysWOW64 and for Program Files vs. Program Files (x86)
* OS detection for paths that differ between Windowx XP and Windows Vista/7
* .NET detection (downloads and installs .NET 4.0 Extended Profile if not present)
* Uninstaller provided can be run from Add/Remove Programs or Programs and Features
* Silent install mode (/S on command-line)
* Answer file (answer.txt) to provide configuration (if run silently)

## Usage

This installer can be run interactively just by launching the executable.  It requires administrative privileges. 

_Choose Install Location Page_

Installation files will be written by default to:

* C:\Program Files\Northwoods\Compass Client Components -- on 32-bit machines
* C:\Program Files (x86)\Northwoods\Compass Client Components -- on 64-bit machines

The files written to the installation location at this time are the Compass Pilot icon, the install log, and the uninstaller executable.

_Set Compass Client Components Settings Page_

Three customizable settings appear after the install location is chosen.


## Developing

The installer is built using NSIS 2.46.  In order to enable logging support, the advanced logging build was used (located here http://nsis.sourceforge.net/Special_Builds).