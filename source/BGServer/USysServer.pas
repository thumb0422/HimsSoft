unit USysServer;

interface

uses
  SvcMgr, SysUtils, Messages, Windows, Classes, DateUtils, Forms, StdCtrls,
  ComCtrls, ScktComp, ShellAPI, WinSvc, Registry, Dialogs, SysCommDefine;
type
  TDMServerState = Integer;

  TDMServerICONState = (dsiOK, dsiWarning, dsiError);
  {ϵͳ����}

  TUserSysService = class(TService)
  protected
    procedure Start(Sender: TService; var Started: Boolean);
    procedure Stop(Sender: TService; var Stopped: Boolean);
  public
    function GetServiceController: TServiceController; override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
  end;
  {ϵͳ�����ʼ��}

function SysServer_Installing: Boolean;
  {ϵͳ��������}

function SysServer_StartService: Boolean;
  {��ȡ�Ƿ��Զ�����}

function GetSysAutoRun: Boolean;
  {�����Ƿ��Զ�����}

procedure SetSysAutoRun(Value: Boolean);
  {ҵ������ģ��}

function DMWinServerCreate(AMainHandle: THandle): Boolean;
  {ϵͳ��ʼ����}

procedure DMWinServerRun;
  {ϵͳֹͣ����}

procedure DMWinServerStop;
  {ϵͳ���ڴ���}

procedure DMWinServerAbout;
  {ϵͳ���ô���}

procedure DMWinServerSetup;
  {���ݼ�ⴰ��}

procedure DMWinServerDataMonitor;
  {��ʾ��־����}

procedure DMWinServerLog;
 // procedure DMWinKingEQU;

  {�����־}

procedure DMServerAddLog(const S: string);

  {�������  Handle}
function GetDMMainHandle: THandle;
  {����ر�}

procedure DMWinServerFree;

function GetWeek(AData: TDateTime): string;

function DateTimeBetweenStr(const ANow, AThen: TDateTime): string;

var
  FAppRunTime: TDateTime; //ϵͳ����ʱ��
  FAppRunSecond: Int64; //���������ڵ�����
  UserSysService: TUserSysService;
  FAppLogList: TStringList;

implementation

uses
  ActiveX, Math, DMWinServer;

var
  dmSysServer: TdmWinSysServer;
  FMainHandle: THandle;

//****************************************************************************//
function SysServer_Installing: Boolean;
begin
  FAppRunSecond := 0;
  FAppRunTime := Now; //�õ�ϵͳ������ʱ��
  Result := FindCmdLineSwitch('INSTALL', ['-', '\', '/'], True) or FindCmdLineSwitch('UNINSTALL', ['-', '\', '/'], True);
end;

function SysServer_StartService: Boolean;
var
  Mgr, Svc: Integer;
  UserName, ServiceStartName: string;
  Config: Pointer;
  Size: DWord;
begin
  Result := False;
  Mgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if Mgr <> 0 then
  begin
    Svc := OpenService(Mgr, PChar(_SysServerName), SERVICE_ALL_ACCESS);
    Result := Svc <> 0;
    if Result then
    begin
      QueryServiceConfig(Svc, nil, 0, Size);
      Config := AllocMem(Size);
      try
        QueryServiceConfig(Svc, Config, Size, Size);
        ServiceStartName := PQueryServiceConfig(Config)^.lpServiceStartName;
        if CompareText(ServiceStartName, 'LocalSystem') = 0 then
          ServiceStartName := 'SYSTEM';
      finally
        Dispose(Config);
      end;
      CloseServiceHandle(Svc);
    end;
    CloseServiceHandle(Mgr);
  end;
  if Result then
  begin
    Size := 256;
    SetLength(UserName, Size);
    GetUserName(PChar(UserName), Size);
    SetLength(UserName, StrLen(PChar(UserName)));
    Result := CompareText(UserName, ServiceStartName) = 0;
  end;
end;

function GetSysAutoRun: Boolean;

  procedure WriteRegValue(reg: TRegistry; Name, Value: string);
  var
    s: string;
  begin
    s := '';
    if reg.ValueExists(Name) then
      s := reg.ReadString(Name);
    if False = SameText(s, Value) then
      reg.WriteString(Name, Value);

  end;
//����ϵͳ�����Ƿ��Զ�����

var
  reg: TRegistry;
  af: string;
begin
  Result := False;
  reg := TRegistry.Create; //����ʵ��
  reg.RootKey := HKEY_LOCAL_MACHINE; //ָ����Ҫ������ע��������
  if reg.OpenKey(KEY_USERSYSSERVER + _SysServerMutexID, true) then//����򿪳ɹ���������²���
  begin
    if reg.ValueExists('AutoRun') then
      Result := reg.ReadBool('AutoRun'); //����Ҫ�������Ϣд��ע���
    WriteRegValue(reg, 'FileName', Application.ExeName);    {ϵͳ��λ��}
    WriteRegValue(reg, 'ServerDisplayName', _SysServerDisplayName);  {������ʾ����}
    WriteRegValue(reg, 'ServerName', _SysServerName);         {��������}
    WriteRegValue(reg, 'ServerReadme', _SysServerReadme);       {�����˵��}
    WriteRegValue(reg, 'MainTitle', _SysServerMainTitle);    {ϵͳ��������}
    WriteRegValue(reg, 'Subtitle', _SysServerSubtitle);     {ϵͳ�ĸ�����}
    reg.CloseKey; //�ر�ע���
  end;
  reg.Free; //�ͷű�����ռ�ڴ�
end;

procedure SetSysAutoRun(Value: Boolean);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create; //����ʵ��
  reg.RootKey := HKEY_LOCAL_MACHINE; //ָ����Ҫ������ע��������
  if reg.OpenKey(KEY_USERSYSSERVER + _SysServerMutexID, true) then//����򿪳ɹ���������²���
  begin
    reg.WriteBool('AutoRun', Value); //����Ҫ�������Ϣд��ע���
    reg.CloseKey; //�ر�ע���
  end;
  reg.Free; //�ͷű�����ռ�ڴ�
end;

{ TUserSysService }

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  UserSysService.Controller(CtrlCode);
end;

function TUserSysService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

constructor TUserSysService.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);
  AllowPause := False;
  Interactive := True;
  DisplayName := _SysServerDisplayName; //�������ʾ����
  Name := _SysServerName;  //��������
  OnStart := Start; //����
  OnStop := Stop; //ֹͣ
end;

procedure TUserSysService.Start(Sender: TService; var Started: Boolean);
begin
  PostMessage(FMainHandle, UI_INITIALIZE, 1, 0);
  Started := True;
end;

procedure TUserSysService.Stop(Sender: TService; var Stopped: Boolean);
begin
  PostMessage(FMainHandle, WM_QUIT, 0, 0);
  Stopped := True;
end;

function DMWinServerCreate(AMainHandle: THandle): Boolean;
begin
  if False = Assigned(dmSysServer) then
    dmSysServer := TdmWinSysServer.Create(Application);
  FMainHandle := AMainHandle;
  Result := True;
end;

function DMWinSysServer: TdmWinSysServer;
begin
  Result := dmSysServer;
end;

procedure DMWinServerRun;
begin
  dmSysServer.Run;
end;

procedure DMWinServerStop;
begin
  dmSysServer.Stop;
end;

function GetDMMainHandle: THandle;
begin
  Result := FMainHandle;
end;

{ϵͳ����}
procedure DMWinServerAbout;
begin
  //��ʾ���ڴ���
  dmSysServer.ShowAbout;
end;

procedure DMWinServerFree;
begin
  FAppLogList.Free;
end;

{ϵͳ����}
procedure DMWinServerSetup;
begin
  dmSysServer.ShowSetup;
end;

procedure DMWinServerDataMonitor;
begin
  {��ʾ���ݼ�ⴰ��}
  dmSysServer.ShowWinDataMonitor;
end;

procedure DMServerAddLog(const S: string);
begin
//�����־
  //WinLog._DMServerAddLog(S);
end;

procedure DMWinServerLog;
begin
  Showmessage('��ʾ��־����');
  //CreateWinSysServerLog;
end;
     {
procedure DMWinKingEQU;
begin
  dmSysServer.ShowWinKingEQU;
end;  }

function DateTimeBetweenStr(const ANow, AThen: TDateTime): string;
var
  i: Integer;
  AD: TDateTime;
  AYear, AMonth, ADay: Word;
  AHour, AMin, ASec, AMSec: Word;
begin
  AD := AThen;
  DecodeDateTime(AD, AYear, AMonth, ADay, AHour, AMin, ASec, AMSec);

  i := YearsBetween(ANow, AD);
  if i > 0 then
    Result := IntToStr(i) + '��';

  AD := IncYear(AD, i);
  i := MonthsBetween(ANow, AD);
  if i > 0 then
    Result := Result + IntToStr(i) + '��';

  AD := IncMonth(AD, i);
  i := DaysBetween(ANow, AD);
  if i > 0 then
    Result := Result + IntToStr(i) + '��';

  AD := IncDay(AD, i);
  i := HoursBetween(ANow, AD);
  if i > 0 then
    Result := Result + IntToStr(i) + 'Сʱ';

  AD := IncHour(AD, i);
  i := MinutesBetween(ANow, AD);
  if i > 0 then
    Result := Result + IntToStr(i) + '����';

  AD := IncMinute(AD, i);
  i := SecondsBetween(ANow, AD);
  if i > 0 then
    Result := Result + IntToStr(i) + '��';
end;

function GetWeek(AData: TDateTime): string;
begin
  case DayOfWeek(AData) of
    1:
      Result := '������';
    2:
      Result := '����һ';
    3:
      Result := '���ڶ�';
    4:
      Result := '������';
    5:
      Result := '������';
    6:
      Result := '������';
    7:
      Result := '������';
  end;
end;

end.

