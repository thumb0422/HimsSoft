unit USysServer;

interface

uses
  SvcMgr, SysUtils, Messages, Windows, Classes, DateUtils, Forms, StdCtrls,
  ComCtrls, ScktComp, ShellAPI, WinSvc, Registry, Dialogs, SysCommDefine;
type
  TDMServerState = Integer;

  TDMServerICONState = (dsiOK, dsiWarning, dsiError);
  {系统服务}

  TUserSysService = class(TService)
  protected
    procedure Start(Sender: TService; var Started: Boolean);
    procedure Stop(Sender: TService; var Stopped: Boolean);
  public
    function GetServiceController: TServiceController; override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
  end;
  {系统服务初始化}

function SysServer_Installing: Boolean;
  {系统服务启动}

function SysServer_StartService: Boolean;
  {获取是否自动启动}

function GetSysAutoRun: Boolean;
  {设置是否自动启动}

procedure SetSysAutoRun(Value: Boolean);
  {业务数据模块}

function DMWinServerCreate(AMainHandle: THandle): Boolean;
  {系统开始运行}

procedure DMWinServerRun;
  {系统停止运行}

procedure DMWinServerStop;
  {系统关于窗体}

procedure DMWinServerAbout;
  {系统设置窗体}

procedure DMWinServerSetup;
  {数据监测窗体}

procedure DMWinServerDataMonitor;
  {显示日志窗体}

procedure DMWinServerLog;
 // procedure DMWinKingEQU;

  {添加日志}

procedure DMServerAddLog(const S: string);

  {主窗体的  Handle}
function GetDMMainHandle: THandle;
  {程序关闭}

procedure DMWinServerFree;

function GetWeek(AData: TDateTime): string;

function DateTimeBetweenStr(const ANow, AThen: TDateTime): string;

var
  FAppRunTime: TDateTime; //系统启动时间
  FAppRunSecond: Int64; //启动到现在的秒数
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
  FAppRunTime := Now; //得到系统的启动时间
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
//返回系统启动是否自动运行

var
  reg: TRegistry;
  af: string;
begin
  Result := False;
  reg := TRegistry.Create; //创建实例
  reg.RootKey := HKEY_LOCAL_MACHINE; //指定需要操作的注册表的主键
  if reg.OpenKey(KEY_USERSYSSERVER + _SysServerMutexID, true) then//如果打开成功则进行以下操作
  begin
    if reg.ValueExists('AutoRun') then
      Result := reg.ReadBool('AutoRun'); //将需要保存的信息写入注册表
    WriteRegValue(reg, 'FileName', Application.ExeName);    {系统的位置}
    WriteRegValue(reg, 'ServerDisplayName', _SysServerDisplayName);  {服务显示名称}
    WriteRegValue(reg, 'ServerName', _SysServerName);         {服务名称}
    WriteRegValue(reg, 'ServerReadme', _SysServerReadme);       {服务的说明}
    WriteRegValue(reg, 'MainTitle', _SysServerMainTitle);    {系统的主标题}
    WriteRegValue(reg, 'Subtitle', _SysServerSubtitle);     {系统的副标题}
    reg.CloseKey; //关闭注册表
  end;
  reg.Free; //释放变量所占内存
end;

procedure SetSysAutoRun(Value: Boolean);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create; //创建实例
  reg.RootKey := HKEY_LOCAL_MACHINE; //指定需要操作的注册表的主键
  if reg.OpenKey(KEY_USERSYSSERVER + _SysServerMutexID, true) then//如果打开成功则进行以下操作
  begin
    reg.WriteBool('AutoRun', Value); //将需要保存的信息写入注册表
    reg.CloseKey; //关闭注册表
  end;
  reg.Free; //释放变量所占内存
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
  DisplayName := _SysServerDisplayName; //服务的显示名称
  Name := _SysServerName;  //服务名称
  OnStart := Start; //启动
  OnStop := Stop; //停止
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

{系统关于}
procedure DMWinServerAbout;
begin
  //显示关于窗体
  dmSysServer.ShowAbout;
end;

procedure DMWinServerFree;
begin
  FAppLogList.Free;
end;

{系统设置}
procedure DMWinServerSetup;
begin
  dmSysServer.ShowSetup;
end;

procedure DMWinServerDataMonitor;
begin
  {显示数据监测窗体}
  dmSysServer.ShowWinDataMonitor;
end;

procedure DMServerAddLog(const S: string);
begin
//添加日志
  //WinLog._DMServerAddLog(S);
end;

procedure DMWinServerLog;
begin
  Showmessage('显示日志窗体');
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
    Result := IntToStr(i) + '年';

  AD := IncYear(AD, i);
  i := MonthsBetween(ANow, AD);
  if i > 0 then
    Result := Result + IntToStr(i) + '月';

  AD := IncMonth(AD, i);
  i := DaysBetween(ANow, AD);
  if i > 0 then
    Result := Result + IntToStr(i) + '天';

  AD := IncDay(AD, i);
  i := HoursBetween(ANow, AD);
  if i > 0 then
    Result := Result + IntToStr(i) + '小时';

  AD := IncHour(AD, i);
  i := MinutesBetween(ANow, AD);
  if i > 0 then
    Result := Result + IntToStr(i) + '分钟';

  AD := IncMinute(AD, i);
  i := SecondsBetween(ANow, AD);
  if i > 0 then
    Result := Result + IntToStr(i) + '秒';
end;

function GetWeek(AData: TDateTime): string;
begin
  case DayOfWeek(AData) of
    1:
      Result := '星期天';
    2:
      Result := '星期一';
    3:
      Result := '星期二';
    4:
      Result := '星期三';
    5:
      Result := '星期四';
    6:
      Result := '星期五';
    7:
      Result := '星期六';
  end;
end;

end.

