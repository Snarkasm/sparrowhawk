#define MyAppName "Sparrowhawk"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Sparrowhawk Project"
#define MyAppExeName "sparrowhawk.exe"

[Setup]
AppId={{D37B7B83-3F98-4B2D-9A65-75A6C4D2E89F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppCopyright=Copyright (C) 2026 Sparrowhawk Project
DefaultDirName={localappdata}\Sparrowhawk
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
OutputBaseFilename=Sparrowhawk-Setup
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
UninstallDisplayIcon={app}\{#MyAppExeName}

; PE VersionInfo Resource metadata for installer false-positive mitigation
VersionInfoVersion=1.0.0.0
VersionInfoCompany=Sparrowhawk Project
VersionInfoDescription=Sparrowhawk Installer
VersionInfoCopyright=Copyright (C) 2026 Sparrowhawk Project
VersionInfoProductName=Sparrowhawk Setup
VersionInfoProductVersion=1.0.0.0
VersionInfoOriginalFileName=Sparrowhawk-Setup.exe

; Target only Sparrowhawk executable for close applications prompt
CloseApplications=yes
CloseApplicationsFilter=*sparrowhawk.exe

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "autostart"; Description: "Automatically launch {#MyAppName} on login"

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"

[Files]
Source: "src\windhawk\Release\sparrowhawk.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "sparrowhawk.ini"; DestDir: "{app}"; Flags: ignoreversion
Source: "product_metadata.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "src\windhawk\Release\32\windhawk.dll"; DestDir: "{app}\32"; Flags: ignoreversion
Source: "src\windhawk\Release\64\windhawk.dll"; DestDir: "{app}\64"; Flags: ignoreversion
Source: "dist\AppData\*"; DestDir: "{app}\AppData"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "LICENSE"; DestDir: "{app}"; Flags: ignoreversion
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion

[Registry]
Root: HKCU; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "Sparrowhawk"; ValueData: """{app}\{#MyAppExeName}"""; Tasks: autostart; Flags: uninsdeletevalue

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch {#MyAppName}"; Flags: nowait postinstall skipifsilent

[UninstallRun]
Filename: "{app}\{#MyAppExeName}"; Parameters: "-exit"; Flags: runhidden
Filename: "cmd.exe"; Parameters: "/c ""timeout /t 2 /nobreak >nul & taskkill /F /IM {#MyAppExeName} 2>nul"""; Flags: runhidden

[UninstallDelete]
Type: filesandordirs; Name: "{app}\AppData"
Type: filesandordirs; Name: "{app}\32"
Type: filesandordirs; Name: "{app}\64"
Type: filesandordirs; Name: "{app}"
