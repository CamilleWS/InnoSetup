;.............................;
;   {EPITECH} -> Kit-Kat
;   Camille Villa [MPL-22]
;.............................;

#define MyAppName "Install_Package_Win10"
#define MyAppVersion "0"

[Setup]
;AlwaysRestart=yes
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
DefaultDirName=C:/{#MyAppName}
DisableDirPage=yes
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir=My_exe
OutputBaseFilename=Install_Package_Win10
PrivilegesRequired=admin
SetupIconFile=C:/Icons\CuteCreature.ico
Compression=lzma
SolidCompression=yes


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"


[Files]
Source: "KIT-KAT\ChromeSetup.exe"; DestDir: "{tmp}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "KIT-KAT\vlc-3.0.6-win64.exe"; DestDir: "{tmp}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "KIT-KAT\VSCodeSetup-ia32-1.31.1.exe"; DestDir: "{tmp}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Code]

var
  MyProgChecked: Boolean;
  MyProgCheckResult: Boolean;

const
  Chrome = '{pf32}\Google\Chrome\Application\chrome.exe';
  VSCode = '{userpf}\Microsoft VS Code\Code.exe';
  Vlc = '{userpf}\VideoLAN\VLC\vlc.exe';
  
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

function CheckForChrome(): Boolean;
var
ChromeInstallerFileName: String;
ResultCode: Integer;
begin
  if (FileExists(Chrome)) then
  begin
    MsgBox('File exists, install continues', mbInformation, MB_OK);
    Result := False;
  end
  else
  begin
    MsgBox('Installing Chrome', mbInformation, MB_OK);
    ExtractTemporaryFile('ChromeSetup.exe');
    ChromeInstallerFileName := ExpandConstant('{tmp}\ChromeSetup.exe');
    Exec(ChromeInstallerFileName, '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
    MsgBox('Installed Chrome', mbInformation, MB_OK);
    Result := True;
  end; 
end;

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

function CheckForVLC(): Boolean;
var
VLCInstallerFileName: String;
ResultCode: Integer;
begin
  if (FileExists(Vlc)) then
  begin
    MsgBox('File exists, install continues', mbInformation, MB_OK);
    Result := False;
  end
  else
  begin
    MsgBox('Installing VLC', mbInformation, MB_OK);
    ExtractTemporaryFile('vlc-3.0.6-win64.exe');
    VLCInstallerFileName := ExpandConstant('{tmp}\vlc-3.0.6-win64.exe');
    Exec(VLCInstallerFileName, '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
    MsgBox('Installed VLC', mbInformation, MB_OK);
    Result := True;
  end; 
end;

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

function CheckForVSCode(): Boolean;
var
VSCodeInstallerFileName: String;
ResultCode: Integer;
begin
  if (FileExists(VSCode)) then
  begin
    MsgBox('File exists, install continues', mbInformation, MB_OK);
    Result := False;
  end
  else
  begin
      MsgBox('Installing VSCode', mbInformation, MB_OK);
      ExtractTemporaryFile('VSCodeSetup-ia32-1.31.1.exe');
      VSCodeInstallerFileName := ExpandConstant('{tmp}\VSCodeSetup-ia32-1.31.1.exe');
      Exec(VSCodeInstallerFileName, '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
      MsgBox('Installed VSCode', mbInformation, MB_OK);
      Result := True;
  end; 
end;

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

function MyProgCheck(str: String): Boolean;
begin
  if not MyProgChecked then begin
    MyProgCheckResult := MsgBox('Do you want to install ' + str + '.exe ?', mbConfirmation, MB_YESNO) = idYes;
    MyProgChecked := True;
  end;
  MyProgChecked := False;
  Result := MyProgCheckResult;
end;

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then 
  begin
    if MyProgCheck('Chrome') then
     begin CheckForChrome(); end;
    if MyProgCheck('VLC') then
     begin CheckForVLC(); end;
    if MyProgCheck('VSCode') then
     begin CheckForVSCode(); end;
  end;
 end;
