unit DMWinServer;

interface

uses
  SysUtils, Messages, Windows, Classes, Forms, DB, ADODB, ExtCtrls, USysServer,
  Dialogs, SysCommDefine;

type
  TdmWinSysServer = class(TDataModule)
    tmr_Save: TTimer;
    tmrKingConn: TTimer;
    procedure DataModuleCreate(Sender: TObject);
    procedure tmr_SaveTimer(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure tmrKingConnTimer(Sender: TObject);
  private
    { Private declarations }
    FWindowHandle: HWND;
    FIsRun: Boolean;
  private
    FMySection: TRTLCriticalSection; //临界区
  private //窗体，可以用来处理消息
    FMainHandle: THandle;
    procedure WndProc(var Msg: TMessage);
  private
    FPrevReadSS_Time: TDateTime; //上一次读取的时间
    procedure RefreshConfig;
  public
    { Public declarations }
    {启动系统的业务功能}
    procedure Run;
    {停止系统的业务}
    procedure Stop;
    {设置当前是否有错误或警告}
    procedure SetDMServerICONState(value: TDMServerICONState);
    procedure ShowAbout; //关于
    procedure ShowSetup; //设置
    procedure ShowWinDataMonitor; //数据监测窗体
//    procedure ShowWinKingEQU;
  public
  end;

implementation

uses
  DateUtils, Contnrs, StrUtils, Controls, WinAbout, Math;

{$R *.dfm}


{ TdmWinSysServer }

procedure TdmWinSysServer.Run;
var
  i: Integer;
  Err: string;
begin
  FIsRun := False;
//启动系统的业务功能
  SetDMServerICONState(dsiOK);
  //刷新参数
  RefreshConfig;

 { begin  //启动失败
    SetDMServerICONState(dsiWarning);
    DMServerAddLog('启动失败。 '+#13+Err);
      //设置警告
    SetDMServerICONState(dsiWarning);
    PostMessage(GetDMMainHandle,WM_DMServerState,CO_DMServerState_Stop,0);
  end }

  //通知界面，程序启动
  tmr_Save.Enabled := True;
  //通知首页，程序启动
  PostMessage(GetDMMainHandle, WM_DMServerState, CO_DMServerState_Run, 0);
  FIsRun := True;

end;

procedure TdmWinSysServer.Stop;
begin
  FIsRun := False;
//停止系统的业务功能
  tmr_Save.Enabled := False;

  SetDMServerICONState(dsiOK);
  //通知首页，停止完成
  PostMessage(GetDMMainHandle, WM_DMServerState, CO_DMServerState_Stop, 0);
end;

procedure TdmWinSysServer.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
  FWindowHandle := Classes.AllocateHWnd(WndProc);
  InitializeCriticalSection(FMySection);
end;

procedure TdmWinSysServer.ShowSetup;
begin
  ShowMessage('设置窗体');
  //if CreateWinSetup(TDBConfInfo. GetDBConfig) then
  //  RefreshConfig;
end;

procedure TdmWinSysServer.RefreshConfig;
var
  bo: Boolean;
begin
  ShowMessage('刷新当前的参数');
//刷新当前的设置
//  FLEDDataList.MaxShowCount:=TDBConfInfo.GetDBConfig.GeneralSetup.ShowMaxCount_SS;
  bo := tmr_Save.Enabled;
  tmr_Save.Enabled := False;
  tmr_Save.Interval := 10000; //  TDBConfInfo.GetDBConfig.GeneralSetup. Read_Interval*1000;
  tmr_Save.Enabled := bo;
end;

procedure TdmWinSysServer.tmr_SaveTimer(Sender: TObject);
begin
//定时保存数据
  ShowMessage('定时保存');
  //SaveToDB;
end;

procedure TdmWinSysServer.SetDMServerICONState(value: TDMServerICONState);
begin
  {设置系统运行图标状态 正常，警告，错误}
  case value of
    dsiOK:
      PostMessage(GetDMMainHandle, WM_DMServerICONState, MB_OK, 0);
    dsiWarning:
      PostMessage(GetDMMainHandle, WM_DMServerICONState, MB_ICONWARNING, 0);
    dsiError:
      PostMessage(GetDMMainHandle, WM_DMServerICONState, MB_ICONERROR, 0);
  end;
end;

procedure TdmWinSysServer.ShowAbout;
begin
  CreateWinAbout;
end;

procedure TdmWinSysServer.ShowWinDataMonitor;
begin
  ShowMessage('数据监测窗体');
  //if Assigned(FKvStationList) then
  //if FKvStationList.ActiveID>=0 then
  //  CreateWinDataMonitor(con_SQL, FKvStationList.Items[FKvStationList.ActiveID])
end;

procedure TdmWinSysServer.DataModuleDestroy(Sender: TObject);
var
  i: Integer;
begin
 //释放
  DeleteCriticalSection(FMySection);
 // MSComm_HZ.Free;
end;

procedure TdmWinSysServer.WndProc(var Msg: TMessage);
begin
   { if Msg.Msg = WM_DTCKReceive then
      try
       // DTCKReceive(WParam,LParam);
      except
        Application.HandleException(Self);
      end
    else    }

  Msg.Result := DefWindowProc(FWindowHandle, Msg.Msg, Msg.wParam, Msg.lParam);
end;

procedure TdmWinSysServer.tmrKingConnTimer(Sender: TObject);
begin
  tmrKingConn.Enabled := False;
  if tmrKingConn.Tag = 0 then  //先停止运行
  begin
    Stop;
    tmrKingConn.Tag := 1;
    tmrKingConn.Enabled := True;
  end
  else if tmrKingConn.Tag > 0 then
  begin
    Run;
    if FIsRun then
    begin
      tmrKingConn.Tag := -1;
      DMServerAddLog('准备重新连接失败，五秒后重试...');
    end
    else
    begin
      tmrKingConn.Tag := tmrKingConn.Tag + 1;
      tmrKingConn.Enabled := True;
      DMServerAddLog('准备重新连接成功。');
    end;
  end;
end;

end.

