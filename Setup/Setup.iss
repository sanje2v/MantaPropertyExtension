; Script for installing 'MantaPropertyExtension'

#define AppName         "Manta Property Extension"
#define AppVersion      "1.0"
#define AppPublisher    "Sanjeev Sharma"
#define AppURL          "http://sanje2v.wordpress.com/"
#define COM_CLSID       "{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}}"


[Setup]
AppId={{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
CreateAppDir=no
Compression=lzma
SolidCompression=yes
ArchitecturesAllowed=x86 x64
ArchitecturesInstallIn64BitMode=x64
MinVersion=6.0.6000 

[Languages]
Name:"english"; MessagesFile:"compiler:Default.isl"

[Files]
Source:"C:\Users\Sanjeev\Documents\Visual Studio 2013\Projects\MantaPropertyExtension\x64\Release\MantaPropertyExtension.dll";DestDir:"{sys}";Check:IsWin64;Flags:regserver
Source:"C:\Users\Sanjeev\Documents\Visual Studio 2013\Projects\MantaPropertyExtension\Release\MantaPropertyExtension.dll";DestDir:"{sys}";Check:not IsWin64;Flags:regserver

[Registry]
; For .exe
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe"; Flags:uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"

Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.exe"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.exe"; Flags:createvalueifdoesntexist deletevalue; ValueType:string; ValueName:"InfoTip"; ValueData:"prop:System.Comment;System.FileDescription;System.Company;System.FileVersion;System.DateCreated;System.Size"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.exe"; Flags:createvalueifdoesntexist deletevalue; ValueType:string; ValueName:"PreviewDetails"; ValueData:"prop:System.FileDescription;System.FileVersion;System.DateCreated;System.Size;System.DateModified;System.Comment"

; For .dll
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.dll"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.dll"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"

Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.dll"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.dll"; Flags:createvalueifdoesntexist deletevalue; ValueType:string; ValueName:"InfoTip"; ValueData:"prop:System.Comment;System.FileDescription;System.Company;System.FileVersion;System.DateCreated;System.Size"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.dll"; Flags:createvalueifdoesntexist deletevalue; ValueType:string; ValueName:"PreviewDetails"; ValueData:"prop:System.FileDescription;System.FileVersion;System.DateCreated;System.Size;System.DateModified;System.Comment"

; For .obj
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.obj"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.obj"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"

Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.obj"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.obj"; Flags:createvalueifdoesntexist deletevalue; ValueType:string; ValueName:"InfoTip"; ValueData:"prop:System.Comment;System.FileDescription;System.Company;System.FileVersion;System.DateCreated;System.Size"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.obj"; Flags:createvalueifdoesntexist deletevalue; ValueType:string; ValueName:"PreviewDetails"; ValueData:"prop:System.FileDescription;System.FileVersion;System.DateCreated;System.Size;System.DateModified;System.Comment"

; For .o
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.o"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.o"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"

Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.o"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.o"; Flags:createvalueifdoesntexist deletevalue; ValueType:string; ValueName:"InfoTip"; ValueData:"prop:System.Comment;System.FileDescription;System.Company;System.FileVersion;System.DateCreated;System.Size"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.o"; Flags:createvalueifdoesntexist deletevalue; ValueType:string; ValueName:"PreviewDetails"; ValueData:"prop:System.FileDescription;System.FileVersion;System.DateCreated;System.Size;System.DateModified;System.Comment"

; For .lib
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.lib"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.lib"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"

Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.lib"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.lib"; Flags:createvalueifdoesntexist deletevalue; ValueType:string; ValueName:"InfoTip"; ValueData:"prop:System.Comment;System.FileDescription;System.Company;System.FileVersion;System.DateCreated;System.Size"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.lib"; Flags:createvalueifdoesntexist deletevalue; ValueType:string; ValueName:"PreviewDetails"; ValueData:"prop:System.FileDescription;System.FileVersion;System.DateCreated;System.Size;System.DateModified;System.Comment"

; For .a
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.a"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.a"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"

Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.a"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.a"; Flags:createvalueifdoesntexist; ValueType:string; ValueName:"InfoTip"; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.a"; Flags:createvalueifdoesntexist; ValueType:string; ValueName:"PreviewDetails"; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"