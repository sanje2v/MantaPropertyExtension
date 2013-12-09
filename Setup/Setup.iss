; Script for installing 'MantaPropertyExtension'

#define AppName         "Manta Property Extension"
;#define AppVersion      1.0
#define AppPublisher    "Sanjeev Sharma"
#define AppURL          "http://sanje2v.wordpress.com/"
#define AppComments     "Installer for Manta Property Extension v1.0"
#define COM_CLSID       "{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}}"
;#define DEBUG

;#define X86
#ifndef X86
#define X64
#endif


[Setup]
AppId={{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}}
AppName={#AppName}
AppVersion=1.0
VersionInfoVersion=1.0.0.0
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppComments={#AppComments}
CreateAppDir=no
Compression=lzma
SolidCompression=yes
; No sure whether the following applies to property handlers
ChangesAssociations=yes
; This setup requires administrative privileges
PrivilegesRequired=admin
; Minimum OS version is Windows Vista
MinVersion=6.0
; Only 32-bit and 64-bit architecture are supported, no Itanium support
ArchitecturesAllowed=x86 x64

#ifdef X86
OutputBaseFilename=MantaSetup_x86
#else
OutputBaseFilename=MantaSetup_x64
; Use full 64-bit mode when running in 64-bit systems
ArchitecturesInstallIn64BitMode=x64
#endif


[Languages]
Name:"english"; MessagesFile:"compiler:Default.isl"

[Files]
#ifdef X86

#ifdef DEBUG
Source:"C:\Users\Sanjeev\Documents\Visual Studio 2013\Projects\MantaPropertyExtension\Debug\MantaPropertyExtension.dll";DestDir:"{sys}";Flags:regserver
#else
Source:"C:\Users\Sanjeev\Documents\Visual Studio 2013\Projects\MantaPropertyExtension\Release\MantaPropertyExtension.dll";DestDir:"{sys}";Flags:regserver
#endif

#else
; X64

#ifdef DEBUG
Source:"C:\Users\Sanjeev\Documents\Visual Studio 2013\Projects\MantaPropertyExtension\x64\Debug\MantaPropertyExtension.dll";DestDir:"{sys}";Flags:regserver
Source:"C:\Users\Sanjeev\Documents\Visual Studio 2013\Projects\MantaPropertyExtension\Debug\MantaPropertyExtension.dll";DestDir:"{syswow64}";Flags:regserver
#else
Source:"C:\Users\Sanjeev\Documents\Visual Studio 2013\Projects\MantaPropertyExtension\x64\Release\MantaPropertyExtension.dll";DestDir:"{sys}";Flags:regserver
Source:"C:\Users\Sanjeev\Documents\Visual Studio 2013\Projects\MantaPropertyExtension\Release\MantaPropertyExtension.dll";DestDir:"{syswow64}";Flags:regserver
#endif

#endif


[Registry]
; For .exe
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe";
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"; Check:BackupPreviousHandler('SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe')

Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.exe"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.exe"; Flags:createvalueifdoesntexist; ValueType:string; ValueName:"InfoTip"; ValueData:"prop:System.Comment;System.FileDescription;System.Company;System.FileVersion;System.DateCreated;System.Size"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.exe"; Flags:createvalueifdoesntexist; ValueType:string; ValueName:"PreviewDetails"; ValueData:"prop:System.FileDescription;System.FileVersion;System.DateCreated;System.Size;System.DateModified;System.Comment"

; For .dll
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.dll";
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.dll"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"

Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.dll"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.dll"; Flags:createvalueifdoesntexist; ValueType:string; ValueName:"InfoTip"; ValueData:"prop:System.Comment;System.FileDescription;System.Company;System.FileVersion;System.DateCreated;System.Size"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.dll"; Flags:createvalueifdoesntexist; ValueType:string; ValueName:"PreviewDetails"; ValueData:"prop:System.FileDescription;System.FileVersion;System.DateCreated;System.Size;System.DateModified;System.Comment"

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
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.a"; Flags:createvalueifdoesntexist; ValueType:string; ValueName:"InfoTip"; ValueData:"prop:System.Comment;System.FileDescription;System.Company;System.FileVersion;System.DateCreated;System.Size"
Root: HKLM; Subkey: "SOFTWARE\Classes\SystemFileAssociations\.a"; Flags:createvalueifdoesntexist; ValueType:string; ValueName:"PreviewDetails"; ValueData:"prop:System.FileDescription;System.FileVersion;System.DateCreated;System.Size;System.DateModified;System.Comment"

#ifdef X64
; For .exe
Root: HKLM; Subkey: "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe";
Root: HKLM; Subkey: "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"; Check:BackupPreviousHandler('SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe')

; For .dll
Root: HKLM; Subkey: "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.dll";
Root: HKLM; Subkey: "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.dll"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"

; For .obj
Root: HKLM; Subkey: "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.obj"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.obj"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"

; For .o
Root: HKLM; Subkey: "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.o"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.o"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"

; For .lib
Root: HKLM; Subkey: "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.lib"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.lib"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"

; For .a
Root: HKLM; Subkey: "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.a"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.a"; ValueType:string; ValueName:""; ValueData:"{{4CC940B1-AB1B-40AA-99E3-B974FD2B0EC4}"

#endif


[Code]
function InitializeSetup(): Boolean;

var ErrorCode: Integer;
begin
  (*
    Check for Visual C++ 2013 redistributable dll libraries. They need to be installed
    before the setup begins installing because registering 'MantaPropertyExtension.dll' requires them. 
  *)
  Result := true;

#ifdef X86
  if IsWin64() then begin
    Msgbox('This installer is meant for 32-bit systems. Please download the installer meant for 64-bit architecture.', mbCriticalError, MB_OK);
    Result := false;
  end else
#else
  if not IsWin64() then begin
    Msgbox('This installer is meant for 64-bit systems. Please download the installer meant for 32-bit architecture.', mbCriticalError, MB_OK);
    Result := false;
  end else
#endif
  if IsWin64() then begin
    (* For 64-bit Windows, we need both x86 and x64 versions *)
    if not RegValueExists(HKLM, 'SOFTWARE\Wow6432Node\Microsoft\VisualStudio\12.0\VC\Runtimes\x64', 'Installed') then begin
        Result := false;
        MsgBox('Installation of both 32-bit & 64-bit Visual C++ 2013 dlls are required. Downloading the setups now. Please install them and try running this setup again.', mbInformation, MB_OK);
        ShellExec('open', 'http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe','','',SW_SHOWNORMAL, ewNoWait, ErrorCode);
    end

    if not RegValueExists(HKLM, 'SOFTWARE\Wow6432Node\Microsoft\VisualStudio\12.0\VC\Runtimes\x86', 'Installed') then begin
        Result := false;
        MsgBox('Installation of 32-bit Visual C++ 2013 dlls are required. Downloading the setup now. Please install them and try running this setup again.', mbInformation, MB_OK);
        ShellExec('open', 'http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x86.exe','','',SW_SHOWNORMAL, ewNoWait, ErrorCode);
    end 
  end else
    if not RegValueExists(HKLM, 'SOFTWARE\Microsoft\VisualStudio\12.0\VC\Runtimes\x86', 'Installed') then begin
        Result := false;
        MsgBox('Installation of 32-bit Visual C++ 2013 dlls are required. Downloading the setup now. Please install them and try running this setup again.', mbInformation, MB_OK);
        ShellExec('open', 'http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x86.exe','','',SW_SHOWNORMAL, ewNoWait, ErrorCode);
    end

end;

function BackupPreviousHandler(EXEKey : String) : Boolean;

var PrevHandlerCLSID : String;
begin
  (*
    The default property handler for Portable Executable files (i.e. exe, dll) is the same in Windows.
    This extension makes use of those handlers so make a value name called 'PreviousHandler' and save it
  *)

  Result := true;

  RegQueryStringValue(HKLM, EXEKey, '', PrevHandlerCLSID);
  if (PrevHandlerCLSID = '') then begin
    Msgbox('No previous property handler for .exe file was found. This is not right. Please uninstall this product', mbCriticalError, MB_OK);
  end else
    if not RegWriteStringValue(HKLM, EXEKey, 'PreviousHandler', PrevHandlerCLSID) then begin
      Msgbox('Failed to backup previous .exe file property handler. Continuing.', mbInformation, MB_OK);
    end
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then begin
    Msgbox('Windows Explorer and/or Windows Search service will need to be restarted for this extension to take over. Either restart them manually or restart your computer.', mbInformation, MB_OK);
  end
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);

var PrevHandlerCLSID : String;
begin
    (*
      Undo what 'BackupPreviousHandler()' did
    *)

    if CurUninstallStep = usPostUninstall then begin
      RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe', 'PreviousHandler', PrevHandlerCLSID);
      RegWriteStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe', '', PrevHandlerCLSID);
      RegWriteStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.dll', '', PrevHandlerCLSID);
      RegDeleteValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe', 'PreviousHandler');

#ifdef X64
      RegQueryStringValue(HKLM, 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe', 'PreviousHandler', PrevHandlerCLSID);
      RegWriteStringValue(HKLM, 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe', '', PrevHandlerCLSID);
      RegWriteStringValue(HKLM, 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.dll', '', PrevHandlerCLSID);
      RegDeleteValue(HKLM, 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.exe', 'PreviousHandler');
#endif
    end;
end;