{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       ∞Ê»®À˘”– (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HNet;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.ExtCtrls,
  System.Win.ScktComp, System.Typinfo,HCate, HLog, HDeviceInfo;

type
  TNet = class(TCate)
  public
    procedure init;override; // openNetX
    procedure send;override; // writeNetX
    procedure close;override; // stopNetX
    constructor Create(deviceInfo: TDeviceInfo);override;
  private
    FDeviceInfo: TDeviceInfo;
    procedure ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
//    procedure ClientSocketWrite(Sender: TObject; Socket: TCustomWinSocket);
    procedure onWriteData(Sender: TObject);
  protected
    netIPObj: TClientSocket;
    destructor Destroy; override;
  end;

implementation

procedure TNet.init;
begin
  FisConnected := False;
  if Assigned(reqTimer) then
    reqTimer.Enabled := False;
  if Assigned(FDeviceInfo) and (FDeviceInfo.dLink = dtlNet) then
  begin
    netIPObj := TClientSocket.Create(nil);
    netIPObj.Address := FDeviceInfo.dName;
    netIPObj.Port := FDeviceInfo.dPort;
    netIPObj.tag := FDeviceInfo.dTag;
    netIPObj.OnConnect := ClientSocketConnect;
    netIPObj.OnDisconnect := ClientSocketDisconnect;
    netIPObj.OnError := ClientSocketError;
    netIPObj.OnRead := ClientSocketRead;
//    netIPObj.OnWrite := ClientSocketWrite;
    TLog.Instance.DDLogInfo('NET ' + FDeviceInfo.dName + ':' + IntToStr(FDeviceInfo.dPort) + ' connecting');
    netIPObj.Active := False;
    netIPObj.Active := True;
  end;
end;

procedure TNet.send;
begin
  if FisConnected then
  begin
    if Assigned(reqTimer) then
    begin
      reqTimer.Enabled := False;
      reqTimer.Enabled := True;
    end
  end
  else
  begin
    TLog.Instance.DDLogError(FDeviceInfo.dName + ' sendError,isConneted = False');
  end;
end;

procedure TNet.close;
begin
  FisConnected := False;
  if Assigned(reqTimer) then
    reqTimer.Enabled := False;
  if Assigned(netIPObj) and netIPObj.Socket.Connected then
  begin
    TLog.Instance.DDLogInfo('NET ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ' stopNet');
    netIPObj.Active := False;
  end;
end;

constructor TNet.Create(deviceInfo: TDeviceInfo);
begin
  FDeviceInfo := deviceInfo;
  FisConnected := False;
  reqTimer := TTimer.Create(nil);
  reqTimer.interval := 1000; // default
  reqTimer.OnTimer := onWriteData;
  reqTimer.Enabled := False;
end;

destructor TNet.Destroy;
begin
  FisConnected := False;
  if Assigned(netIPObj) then
    netIPObj.Free;
  if Assigned(FDeviceInfo) then
    FDeviceInfo.Free;
  if Assigned(reqTimer) then
    reqTimer.Free;
end;

procedure TNet.onWriteData(Sender: TObject);
begin
  if Assigned(netIPObj) and FisConnected and Assigned(FDeviceInfo) and (FDeviceInfo.dLink = dtlNet) then
  begin
    TLog.Instance.DDLogInfo('Net ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ' writeData: ' + FDeviceInfo.dCommond);
    netIPObj.Socket.SendText(FDeviceInfo.dCommond);
  end;
end;

procedure TNet.ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  FisConnected := True;
  if Assigned(FDeviceInfo) and Assigned(netIPObj) then
  begin
    TLog.Instance.DDLogInfo('Net ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ' connected');
  end;
end;

procedure TNet.ClientSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  FisConnected := False;
  if Assigned(FDeviceInfo) and Assigned(netIPObj) then
  begin
    TLog.Instance.DDLogInfo('Net ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ' Disconnect');
  end;
end;

procedure TNet.ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
var
  originErrorCode: Integer;
begin
  FisConnected := False;
  originErrorCode := ErrorCode;
  ErrorCode := 0;
  if Assigned(FDeviceInfo) and Assigned(netIPObj) then
  begin
    TLog.Instance.DDLogError('Net ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ',ErrorEvent =' + GetEnumName(TypeInfo(TErrorEvent), ord(ErrorEvent)) + ',errorCode = ' + IntToStr(originErrorCode));
  end;
end;

procedure TNet.ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
begin
  TLog.Instance.DDLogInfo('Net ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ' read');
  // TODO: receiveData
end;

//procedure TNet.ClientSocketWrite(Sender: TObject; Socket: TCustomWinSocket);
//begin
//
//end;

end.

