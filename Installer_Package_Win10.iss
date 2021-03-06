;.............................;
;   {EPITECH} -> Kit-Kat
;   Camille Villa [MPL-22]
;.............................;

; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{370FA8D2-AC39-412B-9E50-00F28B640877}
AppName=Pack for Win10
AppVersion=1
;AppVerName=Pack for Win10 1
AppPublisher=EPITECH
CreateAppDir=no
OutputDir=my_dir
OutputBaseFilename=Pack_Win10
SetupIconFile=C:\Icons\windows_icon.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Files]
Source: "KYT-CAT\ChromeSetup.exe"; DestDir: "{tmp}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "KYT-CAT\VlcSetup.exe"; DestDir: "{tmp}";Flags: ignoreversion recursesubdirs createallsubdirs
Source: "KYT-CAT\VSCodeSetup.exe"; DestDir: "{tmp}";Flags: ignoreversion recursesubdirs createallsubdirs


[Code]
var
  MyProgChecked: Boolean;
  MyProgCheckResult: Boolean;

const
  Chrome = '{pf32}\Google\Chrome\Application\chrome.exe';
  VSCode = '{userpf}\Microsoft VS Code\Code.exe';
  Vlc = '{userpf}\VideoLAN\VLC\vlc.exe';    
       

//////////////////////////////////////////////////////////////////////
/////////////////////////     CHROME     /////////////////////////////

function CheckforChrome(): Boolean;
var
  ChromeInstallerFileName: String;
  ResultCode: Integer;

begin
  if (FileExists(ExpandConstant(Chrome))) then
  begin
     MsgBox('Chrome already installed.', mbInformation, MB_OK);
     Result := False;
  end
  else
  begin  
     MsgBox('Installing Chrome.', mbInformation, MB_OK);
     ExtractTemporaryFile('ChromeSetup.exe');
     ChromeInstallerFileName :=  ExpandConstant('{tmp}\ChromeSetup.exe');
     Exec(ChromeInstallerFileName, '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
     Result := True;
  end
    
end;

//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
       

//////////////////////////////////////////////////////////////////////
/////////////////////////     VSCode     /////////////////////////////

function CheckforVSCode(): Boolean;
var
  VSCodeInstallerFileName: String;
  ResultCode: Integer;

begin
  if (FileExists(ExpandConstant(VSCode))) then
  begin
     MsgBox('VSCode already installed.', mbInformation, MB_OK);
     Result := False;
  end
  else
  begin  
     MsgBox('Installing VSCode.', mbInformation, MB_OK);
     ExtractTemporaryFile('VSCodeSetup.exe');
     VSCodeInstallerFileName :=  ExpandConstant('{tmp}\VSCodeSetup.exe');
     Exec(VSCodeInstallerFileName, '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
     Result := True;
  end
    
end;

//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
       

//////////////////////////////////////////////////////////////////////
/////////////////////////     Vlc     /////////////////////////////

function CheckforVlc(): Boolean;
var
  VlcInstallerFileName: String;
  ResultCode: Integer;

begin
  if (FileExists(ExpandConstant(Vlc))) then
  begin
     MsgBox('Vlc already installed.', mbInformation, MB_OK);
     Result := False;
  end
  else
  begin  
     MsgBox('Installing Vlc.', mbInformation, MB_OK);
     ExtractTemporaryFile('VlcSetup.exe');
     VlcInstallerFileName :=  ExpandConstant('{tmp}\VlcSetup.exe');
     Exec(VlcInstallerFileName, '', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);
     Result := True;
  end
    
end;

//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
                                                                           

function AskForInstallation(str:String) : Boolean;
begin
   Result := MsgBox('Do you want install ' + str +'.exe ?', mbConfirmation, MB_YESNO) = idYes;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then 
    begin    
      if (AskForInstallation('Chrome')) then
         begin CheckForChrome();end;
      if (AskForInstallation('Vlc')) then
         begin CheckForVlc();end;
      if (AskForInstallation('VSCode')) then
         begin CheckForVSCode();end;
    end;
 end;
