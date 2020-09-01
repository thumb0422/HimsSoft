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
    FClosing: Boolean; //�Ƿ�ر�
    FProgmanOpen: Boolean;
    FFromService: Boolean;  //�Ƿ���ϵͳ����
    NT351: Boolean;  //�Ƿ��� NT3.51�汾
  protected
    procedure UIInitialize(var Message: TMessage); message UI_INITIALIZE;
    procedure WMMIDASIcon(var Message: TMessage); message WM_MIDASICON;
    procedure OnWM_ShowWinSysServer(var Message: TMessage); message WM_ShowWinSysServer;
    procedure AddIcon;
    procedure WndProc(var Message: TMessage); override;
  public
    procedure Initialize(FromService: Boolean);
  private
    FDMServerState: TDMServerState; //��ǰ״̬
    FDMServerICONState: Integer; //ͼ��״̬
    FICONFlickerCount: Integer; //ͼ����������
    FDMICON_WARNING, FDMICON_ERROR: TIcon; //����ʹ�����ʾͼ��

    procedure SetDMServerState(Value: TDMServerState);
    function GetDMServerState: TDMServerState;
    procedure Run;
    procedure Stop;
  public
  protected
    {ϵͳ״̬�仯��Ϣ ���� ֹͣ}
    procedure OnWM_DMServerState(var Message: TMessage); message WM_DMServerState;
    {ͼ��仯״̬}
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
  Caption := _SysServerMainTitle + ' ���������';
  lbl_RunTime.Caption := '����ʱ��: ' + FormatDateTime('yyyy-mm-dd hh:nn:ss ', FAppRunTime) + GetWeek(FAppRunTime);
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
      if Application.MessageBox(PChar(SErrClose), '�˳�ϵͳ', MB_YESNO + MB_ICONQUESTION) = idNo then
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
//ͼ��״̬  �仯
//���������󣬾���
  FDMServerICONState := Message.WParam;
  case FDMServerICONState of
    MB_OK:
      begin
        FIconData.hIcon := Forms.Application.Icon.Handle;
        StrCopy(FIconData.szTip, PChar(Caption + #13 + '״̬:��������'));
      end;
    MB_ICONWARNING:
      begin
        FIconData.hIcon := FDMICON_WARNING.Handle;
        StrCopy(FIconData.szTip, PChar(Caption + #13 + '״̬:����'));
      end;
    MB_ICONERROR:
      begin
        FIconData.hIcon := FDMICON_ERROR.Handle;
        StrCopy(FIconData.szTip, PChar(Caption + #13 + '״̬:����'));
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
    //������һ���ʼ��ʱ
    PostMessage(Self.Handle, WM_ShowWinSysServer, 0, 0);
  end;

  //��ͼ��״̬�� ����ʹ���ʱ����
  if FDMServerICONState in [MB_ICONWARNING, MB_ICONERROR] then
    if FICONFlickerCount >= 10 then //���棬����ͼ�������������ڵ���10��ֹͣ����
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

  {ϵͳ��������}
  FAppRunSecond := FAppRunSecond + 1;
  if Self.Active then //�ڴ�����ʾ��ʱ����ʾ����ʱ��
  begin
    if Now < FAppRunTime then
      lbl_RunTime.Font.Color := clRed
    else
      lbl_RunTime.Font.Color := clBlack;
    lbl_NowTime.Caption := '��ǰʱ��: ' + FormatDateTime('yyyy-mm-dd hh:nn:ss ', Now) + GetWeek(Now);

    ANow := IncSecond(FAppRunTime, FAppRunSecond);
    lbl_RunLength.Caption := 'ϵͳ����: ' + DateTimeBetweenStr(ANow, FAppRunTime);
  end;
end;

procedure Tfrm_SysServer.OnWM_ShowWinSysServer(var Message: TMessage);
begin
//�յ�������ʾ�����Ϣ
  //����ҵ��ִ��ģ��
  DMWinServerCreate(Self.Handle);
  chk_SysAutoRun.Checked := GetSysAutoRun;
  chk_SysAutoRun.Enabled := True;
  //����ҵ��
  if chk_SysAutoRun.Checked then
    btn_Run.Click
  else
    btn_Run.Enabled := True;
end;

procedure Tfrm_SysServer.OnWM_DMServerState(var Message: TMessage);
begin
  {ϵͳ״̬�仯��Ϣ}
  case Message.WParam of
    CO_DMServerState_Run:
      SetDMServerState(CO_DMServerState_Run); //ϵͳ����
    CO_DMServerState_Stop:
      SetDMServerState(CO_DMServerState_Stop); //ϵͳֹͣ

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
  {����}
  DMWinServerAbout;
end;

function Tfrm_SysServer.GetDMServerState: TDMServerState;
begin
{���ص�ǰ��ϵͳ״̬}
  Result := FDMServerState;
end;

procedure Tfrm_SysServer.Run;
begin
  //��ʼ����ϵͳҵ��
  SetDMServerState(CO_DMServerState_Runing);
  DMWinServerRun;
end;

procedure Tfrm_SysServer.Stop;
begin
  //��ʼֹͣϵͳҵ��
  if Application.MessageBox('ȷʵҪֹͣ������', PChar(Caption), MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    SetDMServerState(CO_DMServerState_Stoping);
    DMWinServerStop;
  end;
end;

procedure Tfrm_SysServer.SetDMServerState(Value: TDMServerState);
begin
  {����ϵͳ״̬}
  FDMServerState := Value;
  case FDMServerState of
    CO_DMServerState_Run:
      begin
        btn_Run.Enabled := False;
        btn_Stop.Enabled := True;
        stat1.Panels[0].Text := '�������� ' + _SysServerMainTitle + ' ' + _SysServerSubtitle;
      end;
    CO_DMServerState_Runing:
      begin
        btn_Run.Enabled := False;
        btn_Stop.Enabled := False;
        stat1.Panels[0].Text := '�������� ' + _SysServerMainTitle + ' ' + _SysServerSubtitle;
      end;

    CO_DMServerState_Stop:
      begin
        btn_Run.Enabled := True;
        btn_Stop.Enabled := False;
        stat1.Panels[0].Text := '��ֹͣ ' + _SysServerMainTitle + ' ' + _SysServerSubtitle;
      end;
    CO_DMServerState_Stoping:
      begin
        btn_Run.Enabled := False;
        btn_Stop.Enabled := False;
        stat1.Panels[0].Text := '����ֹͣ ' + _SysServerMainTitle + ' ' + _SysServerSubtitle;
      end;
    CO_DMServerState_Wait:
      begin

      end;
  end;
end;

procedure Tfrm_SysServer.chk_SysAutoRunClick(Sender: TObject);
begin
  {�Ƿ�����������Զ�����}
  SetSysAutoRun(chk_SysAutoRun.Checked);
end;

procedure Tfrm_SysServer.act_SetupExecute(Sender: TObject);
begin
  {��ʾ���ô���}
  DMWinServerSetup;
end;

procedure Tfrm_SysServer.btn_MonitorClick(Sender: TObject);
begin
  {��ʾ���ݼ�ⴰ��}
  DMWinServerDataMonitor;
end;

procedure Tfrm_SysServer.act_LogExecute(Sender: TObject);
begin
  {��ʾ��־����}
  DMWinServerLog;
end;

end.

//ϵͳ��״̬��
//
//��û������    Null
//������        Runing
//�����г���    RuningErr
//����          Run
//�����г���    RunErr
//�����о���    RunWarning
//ֹͣ��        Stoping
//ֹͣ����      StopErr
//��ֹͣ        Stop

