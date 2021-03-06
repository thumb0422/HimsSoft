{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HNet;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.ExtCtrls,
  System.Win.ScktComp, System.Typinfo,HCate, HLog, HDeviceInfo,HDeviceDefine;

type
  TNet = class(TCate)
  public
    procedure init;override; // openNetX
    procedure send;override; // writeNetX
    procedure close;override; // stopNetX
    constructor Create(deviceInfo: TDeviceInfo);override;
    destructor Destroy; override;
  private
    procedure ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
//    procedure ClientSocketWrite(Sender: TObject; Socket: TCustomWinSocket);
    procedure onWriteData;
  protected
    netIPObj: TClientSocket;
  end;

implementation

procedure TNet.init;
begin
  inherited;
  FisConnected := False;
  if Assigned(FDeviceInfo) and Assigned(netIPObj) then
  begin
    TLog.Instance.DDLogInfo('NET ' + FDeviceInfo.MName + ':' + IntToStr(FDeviceInfo.MPort) + ' connecting');
    netIPObj.Active := False;
    netIPObj.Active := True;
  end;
end;

procedure TNet.send;
begin
  inherited;
  if FisConnected then
  begin
    onWriteData;
  end
  else
  begin
  //todo:是否需要重新init
    TLog.Instance.DDLogError(FDeviceInfo.MName + ' sendError,isConneted = False');
  end;
end;

procedure TNet.close;
begin
  inherited;
  FisConnected := False;
  if Assigned(netIPObj) and netIPObj.Socket.Connected then
  begin
    TLog.Instance.DDLogInfo('NET ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ' stopNet');
    netIPObj.Active := False;
  end;
end;

constructor TNet.Create(deviceInfo: TDeviceInfo);
begin
  inherited;
  FDeviceInfo := deviceInfo;
  FisConnected := False;
  if Assigned(FDeviceInfo) then
  begin
    netIPObj := TClientSocket.Create(nil);
    netIPObj.Address := FDeviceInfo.MName;
    netIPObj.Port := FDeviceInfo.MPort;
    netIPObj.tag := FDeviceInfo.MTag;
    netIPObj.OnConnect := ClientSocketConnect;
    netIPObj.OnDisconnect := ClientSocketDisconnect;
    netIPObj.OnError := ClientSocketError;
    netIPObj.OnRead := ClientSocketRead;
//    netIPObj.OnWrite := ClientSocketWrite;
  end;
end;

destructor TNet.Destroy;
begin
  FisConnected := False;
  if Assigned(netIPObj) then
    netIPObj.Free;
  if Assigned(FDeviceInfo) then
    FDeviceInfo.Free;
  inherited;
end;

procedure TNet.onWriteData;
begin
  inherited;
  if Assigned(netIPObj) and FisConnected and Assigned(FDeviceInfo)then
  begin
    TLog.Instance.DDLogInfo('Net ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ' writeData: ' + FDeviceInfo.MCommond);
    netIPObj.Socket.SendText(FDeviceInfo.MCommond);
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
    if Assigned(FdataFailCallBack) then
      FdataFailCallBack(Self, TErrorMsg.Create('-1', netIPObj.Address + ':' +
        IntToStr(netIPObj.Port) + NetDisconnect));
    TLog.Instance.DDLogInfo('Net ' + netIPObj.Address + ':' +
      IntToStr(netIPObj.Port) + ' Disconnect');
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
    if Assigned(FdataFailCallBack) then
      FdataFailCallBack(Self, TErrorMsg.Create('-1', netIPObj.Address + ':' +
        IntToStr(netIPObj.Port) + NetError));
    TLog.Instance.DDLogError('Net ' + netIPObj.Address + ':' +
      IntToStr(netIPObj.Port) + ',ErrorEvent =' +
      GetEnumName(TypeInfo(TErrorEvent), ord(ErrorEvent)) + ',errorCode = ' +
      IntToStr(originErrorCode));
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
