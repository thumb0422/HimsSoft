unit WinSysServer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, ComCtrls, ShellAPI, ActnList, DateUtils,
  DMWinServer, Buttons, ImgList, USysServer, OleCtrls, System.ImageList, System.Actions,
  SysCommDefine;

type
  Tfrm_SysServer = class(TForm)
    PopupMenu: TPopupMenu;
    minu_Close: TMenuItem;
    N_Separator: TMenuItem;
    minu_Show: TMenuItem;
    UpdateTimer: TTimer;
    MainMenu1: TMainMenu;
    actlst1: TActionList;
    act_Show: TAction;
    act_Close: TAction;
    act_Exit: TAction;
    H1: TMenuItem;
    A1: TMenuItem;
    tmr_RunTime: TTimer;
    grp1: TGroupBox;
    lbl_NowTime: TLabel;
    lbl_RunTime: TLabel;
    lbl_RunLength: TLabel;
    stat1: TStatusBar;
    chk_SysAutoRun: TCheckBox;
    btn_Run: TBitBtn;
    btn_Stop: TBitBtn;
    act_About: TAction;
    A2: TMenuItem;
    il1: TImageList;
    act_Setup: TAction;
    O1: TMenuItem;
    O2: TMenuItem;
    btn_Monitor: TBitBtn;
    act_Log: TAction;
    L1: TMenuItem;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure UpdateTimerTimer(Sender: TObject);
    procedure act_ShowExecute(Sender: TObject);
    procedure act_CloseExecute(Sender: TObject);
    procedure act_ExitExecute(Sender: TObject);
    procedure tmr_RunTimeTimer(Sender: TObject);
    procedure btn_RunClick(Sender: TObject);
    procedure btn_StopClick(Sender: TObject);
    procedure act_AboutExecute(Sender: TObject);
    procedure chk_SysAutoRunClick(Sender: TObject);
    procedure act_SetupExecute(Sender: TObject);
    procedure btn_MonitorClick(Sender: TObject);
    procedure act_LogExecute(Sender: TObject);
  private
    FTaskMessage: DWord;
    FIconData: TNotifyIconData;
    FClosing: Boolean; //是否关闭
    FProgmanOpen: Boolean;
    FFromService: Boolean;  //是否是系统服务
    NT351: Boolean;  //是否是 NT3.51版本
  protected
    procedure UIInitialize(var Message: TMessage); message UI_INITIALIZE;
    procedure WMMIDASIcon(var Message: TMessage); message WM_MIDASICON;
    procedure OnWM_ShowWinSysServer(var Message: TMessage); message WM_ShowWinSysServer;
    procedure AddIcon;
    procedure WndProc(var Message: TMessage); override;
  public
    procedure Initialize(FromService: Boolean);
  private
    FDMServerState: TDMServerState; //当前状态
    FDMServerICONState: Integer; //图标状态
    FICONFlickerCount: Integer; //图标闪动次数
    FDMICON_WARNING, FDMICON_ERROR: TIcon; //警告和错误提示图标

    procedure SetDMServerState(Value: TDMServerState);
    function GetDMServerState: TDMServerState;
    procedure Run;
    procedure Stop;
  public
  protected
    {系统状态变化消息 启动 停止}
    procedure OnWM_DMServerState(var Message: TMessage); message WM_DMServerState;
    {图标变化状态}
    procedure OnWM_DMServerICONState(var Message: TMessage); message WM_DMServerICONState;
  end;

var
  frm_SysServer: Tfrm_SysServer;

implementation

uses
  ActiveX, Math;


{$R *.dfm}

{ Tfrm_SysServer }

procedure Tfrm_SysServer.FormCreate(Sender: TObject);
begin
  FClosing := False;
  FDMICON_WARNING := TIcon.Create;
  il1.GetIcon(0, FDMICON_WARNING);
  FDMICON_ERROR := TIcon.Create;
  il1.GetIcon(1, FDMICON_ERROR);
  btn_Run.Enabled := False;
  btn_Stop.Enabled := False;
  chk_SysAutoRun.Enabled := False;
  Caption := _SysServerMainTitle + ' 服务管理器';
  lbl_RunTime.Caption := '启动时间: ' + FormatDateTime('yyyy-mm-dd hh:nn:ss ', FAppRunTime) + GetWeek(FAppRunTime);
  tmr_RunTime.Enabled := True;

end;

procedure Tfrm_SysServer.WndProc(var Message: TMessage);
begin
  if Message.Msg = FTaskMessage then
  begin
    AddIcon;
    Refresh;
  end;
  inherited WndProc(Message);
end;

procedure Tfrm_SysServer.UpdateTimerTimer(Sender: TObject);
var
  Found: Boolean;
begin
  Found := FindWindow('Progman', nil) <> 0;
  if Found <> FProgmanOpen then
  begin
    FProgmanOpen := Found;
    if Found then
      AddIcon;
    Refresh;
  end;
end;

procedure Tfrm_SysServer.UIInitialize(var Message: TMessage);
begin
  Initialize(Message.WParam <> 0);
end;

procedure Tfrm_SysServer.Initialize(FromService: Boolean);

  function IE4Installed: Boolean;
  var
    RegKey: HKEY;
  begin
    Result := False;
    if RegOpenKey(HKEY_LOCAL_MACHINE, KEY_IE, RegKey) = ERROR_SUCCESS then
    try
      Result := RegQueryValueEx(RegKey, 'Version', nil, nil, nil, nil) = ERROR_SUCCESS;
    finally
      RegCloseKey(RegKey);
    end;
  end;

begin
  FFromService := FromService;
  NT351 := (Win32MajorVersion <= 3) and (Win32Platform = VER_PLATFORM_WIN32_NT);
  if NT351 then
  begin
    if not FromService then
      raise Exception.CreateRes(@SServiceOnly);
    BorderIcons := BorderIcons + [biMinimize];
    BorderStyle := bsSingle;
  end;
//  ReadSettings;
  if FromService then
  begin
    act_Close.Visible := False;
    N_Separator.Visible := False;
  end;
//  UpdateStatus;
  AddIcon;
  if IE4Installed then
    FTaskMessage := RegisterWindowMessage('TaskbarCreated')
  else
    UpdateTimer.Enabled := True;
end;

procedure Tfrm_SysServer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  TimerEnabled: Boolean;
begin
  TimerEnabled := UpdateTimer.Enabled;
  UpdateTimer.Enabled := False;
  try
    CanClose := False;
    if FClosing and (False = FFromService) then
    begin
      if Application.MessageBox(PChar(SErrClose), '退出系统', MB_YESNO + MB_ICONQUESTION) = idNo then
      begin
        FClosing := False;
        Exit;
      end;
    end;
    CanClose := True;
  finally
    if TimerEnabled and (not CanClose) then
      UpdateTimer.Enabled := True;
  end;
end;

procedure Tfrm_SysServer.FormDestroy(Sender: TObject);
begin
  UpdateTimer.Enabled := False;
  if not NT351 then
    Shell_NotifyIcon(NIM_DELETE, @FIconData);
  FDMICON_WARNING.Free;
  FDMICON_ERROR.Free;
  DMWinServerFree;
end;

procedure Tfrm_SysServer.AddIcon;
begin
  if not NT351 then
  begin
    with FIconData do
    begin
      cbSize := SizeOf();
      Wnd := Self.Handle;
      uID := $DEDB;
      uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
      hIcon := Forms.Application.Icon.Handle;
      uCallbackMessage := WM_MIDASICON;
      StrCopy(szTip, PChar(Caption));
    end;
    Shell_NotifyIcon(NIM_Add, @FIconData);
  end;
end;

procedure Tfrm_SysServer.OnWM_DMServerICONState(var Message: TMessage);
begin
//图标状态  变化
//正常，错误，警告
  FDMServerICONState := Message.WParam;
  case FDMServerICONState of
    MB_OK:
      begin
        FIconData.hIcon := Forms.Application.Icon.Handle;
        StrCopy(FIconData.szTip, PChar(Caption + #13 + '状态:正在运行'));
      end;
    MB_ICONWARNING:
      begin
        FIconData.hIcon := FDMICON_WARNING.Handle;
        StrCopy(FIconData.szTip, PChar(Caption + #13 + '状态:警告'));
      end;
    MB_ICONERROR:
      begin
        FIconData.hIcon := FDMICON_ERROR.Handle;
        StrCopy(FIconData.szTip, PChar(Caption + #13 + '状态:错误'));
      end;
  end;
  Shell_NotifyIcon(NIM_MODIFY, @FIconData);
end;

procedure Tfrm_SysServer.WMMIDASIcon(var Message: TMessage);
var
  pt: TPoint;
begin
  case Message.LParam of
    WM_RBUTTONUP:
      begin
        if not Visible then
        begin
          SetForegroundWindow(Handle);
          GetCursorPos(pt);
          PopupMenu.Popup(pt.x, pt.y);
        end
        else
          SetForegroundWindow(Handle);
      end;
    WM_LBUTTONDBLCLK:
      if Visible then
      begin
        SetForegroundWindow(Handle);
        setwindowpos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
      end
      else
        act_Show.Execute;
  end;
end;

procedure Tfrm_SysServer.act_ShowExecute(Sender: TObject);
begin
  ShowModal;
end;

procedure Tfrm_SysServer.act_CloseExecute(Sender: TObject);
begin
  FClosing := True;
  Close;
end;

procedure Tfrm_SysServer.act_ExitExecute(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure Tfrm_SysServer.tmr_RunTimeTimer(Sender: TObject);
var
  ANow: TDateTime;
begin
  if FAppRunSecond = 1 then
  begin
    //运行了一秒后开始计时
    PostMessage(Self.Handle, WM_ShowWinSysServer, 0, 0);
  end;

  //当图标状态是 警告和错误时闪动
  if FDMServerICONState in [MB_ICONWARNING, MB_ICONERROR] then
    if FICONFlickerCount >= 10 then //警告，错误图标闪动次数大于等于10，停止闪动
    begin
      FIconData.hIcon := Forms.Application.Icon.Handle;
      Shell_NotifyIcon(NIM_MODIFY, @FIconData);
      FICONFlickerCount := 0;
    end
    else
    begin
      case FDMServerICONState of
        MB_ICONWARNING:
          begin
            if Odd(FAppRunSecond) then
              FIconData.hIcon := FDMICON_WARNING.Handle
            else
              FIconData.hIcon := Forms.Application.Icon.Handle;
            FICONFlickerCount := FICONFlickerCount + 1;
            Shell_NotifyIcon(NIM_MODIFY, @FIconData);
          end;
        MB_ICONERROR:
          begin
            if Odd(FAppRunSecond) then
              FIconData.hIcon := FDMICON_ERROR.Handle
            else
              FIconData.hIcon := Forms.Application.Icon.Handle;
            FICONFlickerCount := FICONFlickerCount + 1;
            Shell_NotifyIcon(NIM_MODIFY, @FIconData);
          end;
      end;
    end;

  {系统运行秒数}
  FAppRunSecond := FAppRunSecond + 1;
  if Self.Active then //在窗体显示的时候显示运行时间
  begin
    if Now < FAppRunTime then
      lbl_RunTime.Font.Color := clRed
    else
      lbl_RunTime.Font.Color := clBlack;
    lbl_NowTime.Caption := '当前时间: ' + FormatDateTime('yyyy-mm-dd hh:nn:ss ', Now) + GetWeek(Now);

    ANow := IncSecond(FAppRunTime, FAppRunSecond);
    lbl_RunLength.Caption := '系统运行: ' + DateTimeBetweenStr(ANow, FAppRunTime);
  end;
end;

procedure Tfrm_SysServer.OnWM_ShowWinSysServer(var Message: TMessage);
begin
//收到窗体显示后的消息
  //创建业务执行模块
  DMWinServerCreate(Self.Handle);
  chk_SysAutoRun.Checked := GetSysAutoRun;
  chk_SysAutoRun.Enabled := True;
  //启动业务
  if chk_SysAutoRun.Checked then
    btn_Run.Click
  else
    btn_Run.Enabled := True;
end;

procedure Tfrm_SysServer.OnWM_DMServerState(var Message: TMessage);
begin
  {系统状态变化消息}
  case Message.WParam of
    CO_DMServerState_Run:
      SetDMServerState(CO_DMServerState_Run); //系统运行
    CO_DMServerState_Stop:
      SetDMServerState(CO_DMServerState_Stop); //系统停止

  else
    SetDMServerState(CO_DMServerState_Wait);
  end;
end;

procedure Tfrm_SysServer.btn_RunClick(Sender: TObject);
begin

  Run;
end;

procedure Tfrm_SysServer.btn_StopClick(Sender: TObject);
begin

  Stop;
end;

procedure Tfrm_SysServer.act_AboutExecute(Sender: TObject);
begin
  {关于}
  DMWinServerAbout;
end;

function Tfrm_SysServer.GetDMServerState: TDMServerState;
begin
{返回当前的系统状态}
  Result := FDMServerState;
end;

procedure Tfrm_SysServer.Run;
begin
  //开始启动系统业务
  SetDMServerState(CO_DMServerState_Runing);
  DMWinServerRun;
end;

procedure Tfrm_SysServer.Stop;
begin
  //开始停止系统业务
  if Application.MessageBox('确实要停止运行吗？', PChar(Caption), MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    SetDMServerState(CO_DMServerState_Stoping);
    DMWinServerStop;
  end;
end;

procedure Tfrm_SysServer.SetDMServerState(Value: TDMServerState);
begin
  {设置系统状态}
  FDMServerState := Value;
  case FDMServerState of
    CO_DMServerState_Run:
      begin
        btn_Run.Enabled := False;
        btn_Stop.Enabled := True;
        stat1.Panels[0].Text := '正在运行 ' + _SysServerMainTitle + ' ' + _SysServerSubtitle;
      end;
    CO_DMServerState_Runing:
      begin
        btn_Run.Enabled := False;
        btn_Stop.Enabled := False;
        stat1.Panels[0].Text := '正在启动 ' + _SysServerMainTitle + ' ' + _SysServerSubtitle;
      end;

    CO_DMServerState_Stop:
      begin
        btn_Run.Enabled := True;
        btn_Stop.Enabled := False;
        stat1.Panels[0].Text := '已停止 ' + _SysServerMainTitle + ' ' + _SysServerSubtitle;
      end;
    CO_DMServerState_Stoping:
      begin
        btn_Run.Enabled := False;
        btn_Stop.Enabled := False;
        stat1.Panels[0].Text := '正在停止 ' + _SysServerMainTitle + ' ' + _SysServerSubtitle;
      end;
    CO_DMServerState_Wait:
      begin

      end;
  end;
end;

procedure Tfrm_SysServer.chk_SysAutoRunClick(Sender: TObject);
begin
  {是否程序启动后自动运行}
  SetSysAutoRun(chk_SysAutoRun.Checked);
end;

procedure Tfrm_SysServer.act_SetupExecute(Sender: TObject);
begin
  {显示设置窗体}
  DMWinServerSetup;
end;

procedure Tfrm_SysServer.btn_MonitorClick(Sender: TObject);
begin
  {显示数据监测窗体}
  DMWinServerDataMonitor;
end;

procedure Tfrm_SysServer.act_LogExecute(Sender: TObject);
begin
  {显示日志窗体}
  DMWinServerLog;
end;

end.

//系统的状态有
//
//还没有启动    Null
//启动中        Runing
//启动中出错    RuningErr
//运行          Run
//运行中出错    RunErr
//运行中警告    RunWarning
//停止中        Stoping
//停止出错      StopErr
//已停止        Stop

