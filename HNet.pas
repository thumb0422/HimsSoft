unit HNet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Generics.Collections, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, System.Win.ScktComp, HLog,
  HDeviceInfo;

type
  TNet = class
  public
    netPort: Integer; // net Port
    sendData: string;
    interval: Integer; // timer interval
    procedure init; overload; // startAllNet
    procedure init(tag: string); overload; // startNetX
    procedure send; // writeNetX or writeAllNet
    procedure close; // stopNetX or stopAllNet

    constructor Create(netList: TStringList); // 1、2、3、4、5、6、7等
  private
    reqTimer: TTimer;
    netIPList: TStringList; // netIp list
    netIPObjDic: TDictionary<string, TClientSocket>; // TClientSocket 对象集合
    procedure ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketWrite(Sender: TObject; Socket: TCustomWinSocket);
    procedure onNetWriteData(Sender: TObject);
  protected
    netIPObj: TClientSocket; // 临时对象
    Ftag: string; // 执行某个具体的net
    destructor Destroy; override;
  end;

implementation

procedure TNet.init;
var
  i: Integer;
  indexStr: string;
begin
  netIPObjDic.Clear;
  for i := 0 to netIPList.Count - 1 do
  begin
    indexStr := netIPList[i];
    netIPObj := TClientSocket.Create(nil);
    netIPObj.Address := indexStr;
    netIPObj.Port := netPort;
    netIPObj.OnConnect := ClientSocketConnect;
    netIPObj.OnDisconnect := ClientSocketDisconnect;
    netIPObj.OnError := ClientSocketError;
    netIPObj.OnRead := ClientSocketRead;
    netIPObj.OnWrite := ClientSocketWrite;
    try
      netIPObjDic.AddOrSetValue(indexStr, netIPObj);
      TLog.Instance.DDLogInfo('NET' + indexStr + ' open');
      netIPObj.Active := False;
      netIPObj.Active := True;
    except
      on E: Exception do
      begin
        netIPObjDic.Remove(indexStr);
        TLog.Instance.DDLogError('NET' + indexStr + ' openError');
        netIPObj.Active := False;
      end;
    end;
  end;
end;

procedure TNet.init(tag: string);
var
  i: Integer;
  indexStr: string;
begin
  Ftag := tag;
  netIPObjDic.Clear;
  begin
    indexStr := Ftag;
    netIPObj := TClientSocket.Create(nil);
    netIPObj.Address := indexStr;
    netIPObj.Port := netPort;
    netIPObj.OnConnect := ClientSocketConnect;
    netIPObj.OnDisconnect := ClientSocketDisconnect;
    netIPObj.OnError := ClientSocketError;
    netIPObj.OnRead := ClientSocketRead;
    netIPObj.OnWrite := ClientSocketWrite;
    try
      netIPObjDic.AddOrSetValue(indexStr, netIPObj);
      TLog.Instance.DDLogInfo('NET' + indexStr + ' open');
      netIPObj.Active := False;
      netIPObj.Active := True;
    except
      on E: Exception do
      begin
        netIPObj.Active := False;
        netIPObjDic.Remove(indexStr);
        TLog.Instance.DDLogError('NET' + indexStr + ' openError');
      end;
    end;
  end;
end;

procedure TNet.send;
begin
  if Assigned(reqTimer) then
  begin
    reqTimer.Enabled := False;
    reqTimer.Enabled := True;
  end;
end;

procedure TNet.close;
var
  keyTag: string;
begin
  if Assigned(reqTimer) then
    reqTimer.Enabled := False;
  for keyTag in netIPObjDic.Keys do
  begin
    netIPObj := netIPObjDic[keyTag];
    if Assigned(netIPObj) then
    begin
      TLog.Instance.DDLogInfo('NET' + IntToStr(netIPObj.tag) + ' stopNet');
      netIPObj.Active := False;
    end;
  end;
end;

constructor TNet.Create(netList: TStringList);
begin
  netIPList := netList;
  if netIPList = nil then
  begin
    netIPList := TStringList.Create;
  end;
  netIPObjDic := TDictionary<string, TClientSocket>.Create(0);
  reqTimer := TTimer.Create(nil);
  reqTimer.interval := interval;
  reqTimer.OnTimer := onNetWriteData;
  reqTimer.Enabled := False;
end;

destructor TNet.Destroy;
begin
  netIPObjDic.Free;
  netIPList.Free;
  if Assigned(reqTimer) then
    reqTimer.Free;
end;

procedure TNet.onNetWriteData(Sender: TObject);
var
  keyTag: string;
begin
  for keyTag in netIPObjDic.Keys do
  begin
    netIPObj := netIPObjDic[keyTag];
    if Assigned(netIPObj) then
    begin
      TLog.Instance.DDLogInfo('Net' + IntToStr(netIPObj.tag) + ' writeData: ' + sendData);
      netIPObj.Socket.SendText(sendData);
    end;
  end;
end;

procedure TNet.ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
begin

end;

procedure TNet.ClientSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin

end;

procedure TNet.ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin

end;

procedure TNet.ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
begin

end;

procedure TNet.ClientSocketWrite(Sender: TObject; Socket: TCustomWinSocket);
begin

end;

end.

