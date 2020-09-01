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
    FMySection: TRTLCriticalSection; //�ٽ���
  private //���壬��������������Ϣ
    FMainHandle: THandle;
    procedure WndProc(var Msg: TMessage);
  private
    FPrevReadSS_Time: TDateTime; //��һ�ζ�ȡ��ʱ��
    procedure RefreshConfig;
  public
    { Public declarations }
    {����ϵͳ��ҵ����}
    procedure Run;
    {ֹͣϵͳ��ҵ��}
    procedure Stop;
    {���õ�ǰ�Ƿ��д���򾯸�}
    procedure SetDMServerICONState(value: TDMServerICONState);
    procedure ShowAbout; //����
    procedure ShowSetup; //����
    procedure ShowWinDataMonitor; //���ݼ�ⴰ��
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
//����ϵͳ��ҵ����
  SetDMServerICONState(dsiOK);
  //ˢ�²���
  RefreshConfig;

 { begin  //����ʧ��
    SetDMServerICONState(dsiWarning);
    DMServerAddLog('����ʧ�ܡ� '+#13+Err);
      //���þ���
    SetDMServerICONState(dsiWarning);
    PostMessage(GetDMMainHandle,WM_DMServerState,CO_DMServerState_Stop,0);
  end }

  //֪ͨ���棬��������
  tmr_Save.Enabled := True;
  //֪ͨ��ҳ����������
  PostMessage(GetDMMainHandle, WM_DMServerState, CO_DMServerState_Run, 0);
  FIsRun := True;

end;

procedure TdmWinSysServer.Stop;
begin
  FIsRun := False;
//ֹͣϵͳ��ҵ����
  tmr_Save.Enabled := False;

  SetDMServerICONState(dsiOK);
  //֪ͨ��ҳ��ֹͣ���
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
  ShowMessage('���ô���');
  //if CreateWinSetup(TDBConfInfo. GetDBConfig) then
  //  RefreshConfig;
end;

procedure TdmWinSysServer.RefreshConfig;
var
  bo: Boolean;
begin
  ShowMessage('ˢ�µ�ǰ�Ĳ���');
//ˢ�µ�ǰ������
//  FLEDDataList.MaxShowCount:=TDBConfInfo.GetDBConfig.GeneralSetup.ShowMaxCount_SS;
  bo := tmr_Save.Enabled;
  tmr_Save.Enabled := False;
  tmr_Save.Interval := 10000; //  TDBConfInfo.GetDBConfig.GeneralSetup. Read_Interval*1000;
  tmr_Save.Enabled := bo;
end;

procedure TdmWinSysServer.tmr_SaveTimer(Sender: TObject);
begin
//��ʱ��������
  ShowMessage('��ʱ����');
  //SaveToDB;
end;

procedure TdmWinSysServer.SetDMServerICONState(value: TDMServerICONState);
begin
  {����ϵͳ����ͼ��״̬ ���������棬����}
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
  ShowMessage('���ݼ�ⴰ��');
  //if Assigned(FKvStationList) then
  //if FKvStationList.ActiveID>=0 then
  //  CreateWinDataMonitor(con_SQL, FKvStationList.Items[FKvStationList.ActiveID])
end;

procedure TdmWinSysServer.DataModuleDestroy(Sender: TObject);
var
  i: Integer;
begin
 //�ͷ�
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
  if tmrKingConn.Tag = 0 then  //��ֹͣ����
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
      DMServerAddLog('׼����������ʧ�ܣ����������...');
    end
    else
    begin
      tmrKingConn.Tag := tmrKingConn.Tag + 1;
      tmrKingConn.Enabled := True;
      DMServerAddLog('׼���������ӳɹ���');
    end;
  end;
end;

end.

