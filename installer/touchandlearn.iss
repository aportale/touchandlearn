#define COOLTITLE="Touch'n'learn"

[Setup]
InternalCompressLevel=ultra
OutputBaseFilename=touchandlearn-1.0-setup
SolidCompression=true
VersionInfoVersion=1.0
VersionInfoCompany=CasaPortale.de
VersionInfoDescription=Ein Lernprogram fuer koerperlich behinderte Kinder
VersionInfoTextVersion={#COOLTITLE} 1.0
VersionInfoCopyright=Copyright (C) Alessandro Portale 1998, 2007
Compression=lzma/ultra
AppCopyright=Alessandro Portale 1998, 2007
AppName={#COOLTITLE}
AppVerName={#COOLTITLE} 1.0
ShowLanguageDialog=auto
AppPublisher=CasaPortale.de
AppPublisherURL=http://www.casaportale.de/
AppSupportURL=http://www.casaportale.de/
AppUpdatesURL=http://www.casaportale.de/
AppVersion=1.0
UninstallDisplayIcon={app}\touchandlearn.exe
UninstallDisplayName={#COOLTITLE}
DefaultDirName={pf}\{#COOLTITLE}
DisableProgramGroupPage=true
DisableReadyPage=true
LicenseFile=license.rtf
OutputDir=.
DefaultGroupName={#COOLTITLE}
WizardImageFile=compiler:WizModernImage-IS.bmp
WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp

[Files]
Source: ..\src\LERNPROG.exe; DestDir: {app}; DestName: touchandlearn.exe
Source: ..\src\AUFGABEN.TXT; DestDir: {app}
Source: readme.html; DestDir: {app}
Source: license.rtf; DestDir: {app}
Source: ..\src\GRAFIK\*; DestDir: {app}\GRAFIK; Excludes: .svn; Flags: recursesubdirs sortfilesbyextension
Source: ..\src\SOUND\*; DestDir: {app}\SOUND; Excludes: .svn; Flags: recursesubdirs sortfilesbyextension

[Icons]
Name: {group}\Touch 'n learn; Filename: {app}\touchandlearn.exe; WorkingDir: {app}; IconFilename: {app}\touchandlearn.exe
Name: {group}\Deinstallieren; Filename: {uninstallexe}; WorkingDir: {app}
Name: {group}\Liesmich; Filename: {app}\readme.html
Name: {group}\Lizenz; Filename: {app}\license.rtf

[Run]
Filename: {app}\touchandlearn.exe; WorkingDir: {app}; Flags: postinstall

[Languages]
Name: German; MessagesFile: compiler:languages\German.isl
