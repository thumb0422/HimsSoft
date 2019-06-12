unit HNet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Win.ScktComp,
  HLog, HDeviceInfo;

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
    // procedure onReceive(Sender: TObject; Buffer: Pointer; BufferLength: Word);
    // procedure onReceiveError(Sender: TObject; EventMask: Cardinal);
    // procedure onRequestHangup(Sender: TObject);
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket1Lookup(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Write(Sender: TObject; Socket: TCustomWinSocket);
    procedure onNetWriteComm(Sender: TObject);
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
    netIPObj.Port := 6666;
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
    netIPObj.Port := 6666;
    netIPObj.OnConnect := OnConnect;
    netIPObj.OnDisconnect := OnDisconnect;
    netIPObj.OnError := OnError;
    netIPObj.OnRead := onReadData;
    netIPObj.OnWrite := onWriteData;
    try
      netIPObjDic.AddOrSetValue(indexStr, netIPObj);
      TLog.Instance.DDLogInfo('COM' + indexStr + ' open');
      netIPObj.Active :=False;
      netIPObj.Active :=True;
    except
      on E: Exception do
      begin
        rs232Obj.StopComm;
        netIPObjDic.Remove(indexStr);
        TLog.Instance.DDLogError('COM' + indexStr + ' openError');
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
    rs232Obj := netIPObjDic[keyTag];
    if Assigned(rs232Obj) then
    begin
      TLog.Instance.DDLogInfo('COM' + IntToStr(rs232Obj.tag) + ' stopComm');
      rs232Obj.StopComm;
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
  reqTimer.interval := 1000;
  reqTimer.OnTimer := onNetWriteComm;
  reqTimer.Enabled := False;
end;

destructor TNet.Destroy;
begin
  netIPObjDic.Free;
  netIPList.Free;
  if Assigned(reqTimer) then
    reqTimer.Free;
end;

procedure TNet.onNetWriteComm(Sender: TObject);
var
  keyTag: string;
begin
  for keyTag in netIPObjDic.Keys do
  begin
    netIPObj := netIPObjDic[keyTag];
    if Assigned(netIPObj) then
    begin
      TLog.Instance.DDLogInfo('COM' + IntToStr(rs232Obj.tag) + ' writeData: ' +
        sendData);
      netIPObj.WriteCommData(PAnsiChar(AnsiString(sendData)), Length(sendData));
    end;
  end;
end;

procedure TNet.ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
begin

end;

procedure TNet.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin

end;

procedure TNet.ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin

end;

procedure TNet.ClientSocket1Lookup(Sender: TObject; Socket: TCustomWinSocket);
begin

end;

procedure TNet.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
begin

end;

procedure TNet.ClientSocket1Write(Sender: TObject; Socket: TCustomWinSocket);
begin

end;

end.
