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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Generics.Collections, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, System.Win.ScktComp,System.Typinfo, HLog,
  HDeviceInfo;

type
  TNet = class
  private
    FcInterval: Integer;
    procedure SetcInterval(val: Integer);
  public
    procedure init; overload; // startAllNet
    procedure init(deviceInfo: TDeviceInfo); overload; // startNetX
    procedure send; // writeNetX or writeAllNet
    procedure close; // stopNetX or stopAllNet
    property cInterval: Integer read FcInterval write SetcInterval; //
    constructor Create(deviceList: TList); // 设备列表
  private
    reqTimer: TTimer;
    netIPList: TList; // deviceInfo list
    netIPObjDic: TDictionary<string, TClientSocket>; // TClientSocket 对象集合

    procedure ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketWrite(Sender: TObject; Socket: TCustomWinSocket);
    procedure onNetWriteData(Sender: TObject);
    function getDeviceInfoFromNetObj(obj: TClientSocket): TDeviceInfo;
  protected
    destructor Destroy; override;
  end;

implementation

procedure TNet.init;
var
  i: Integer;
  fdeviceInfo: TDeviceInfo;
  fdeviceTag: string;
  netIPObj: TClientSocket;
begin
  netIPObjDic.Clear;
  if Assigned(reqTimer) then
    reqTimer.Enabled := False;
  for i := 0 to netIPList.Count - 1 do
  begin
    fdeviceInfo := netIPList[i];
    if fdeviceInfo.dLink = dtlNet then
    begin
      fdeviceTag := IntToStr(fdeviceInfo.dTag);
      netIPObj := TClientSocket.Create(nil);
      netIPObj.Address := fdeviceInfo.dName;
      netIPObj.Port := fdeviceInfo.dPort;
      netIPObj.tag := fdeviceInfo.dTag;
      netIPObj.OnConnect := ClientSocketConnect;
      netIPObj.OnDisconnect := ClientSocketDisconnect;
      netIPObj.OnError := ClientSocketError;
      netIPObj.OnRead := ClientSocketRead;
      netIPObj.OnWrite := ClientSocketWrite;
//      netIPObjDic.AddOrSetValue(fdeviceTag, netIPObj);
      TLog.Instance.DDLogInfo('NET ' + fdeviceInfo.dName + ':' + IntToStr(fdeviceInfo.dPort) + ' connecting');
      netIPObj.Active := False;
      netIPObj.Active := True;
    end;

  end;
end;

procedure TNet.init(deviceInfo: TDeviceInfo);
var
  fdeviceTag: string;
  netIPObj: TClientSocket;
begin
  netIPObjDic.Clear;
  if Assigned(reqTimer) then
    reqTimer.Enabled := False;
  begin
    if deviceInfo.dLink = dtlNet then
    begin
      fdeviceTag := IntToStr(deviceInfo.dTag);
      netIPObj := TClientSocket.Create(nil);
      netIPObj.Address := deviceInfo.dName;
      netIPObj.Port := deviceInfo.dPort;
      netIPObj.tag := deviceInfo.dTag;
      netIPObj.OnConnect := ClientSocketConnect;
      netIPObj.OnDisconnect := ClientSocketDisconnect;
      netIPObj.OnError := ClientSocketError;
      netIPObj.OnRead := ClientSocketRead;
      netIPObj.OnWrite := ClientSocketWrite;
//      netIPObjDic.AddOrSetValue(fdeviceTag, netIPObj);
      TLog.Instance.DDLogInfo('NET ' + deviceInfo.dName + ':' + IntToStr(deviceInfo.dPort) + ' connecting');
      netIPObj.Active := False;
      netIPObj.Active := True;
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
  netIPObj: TClientSocket;
begin
  if Assigned(reqTimer) then
    reqTimer.Enabled := False;
  for keyTag in netIPObjDic.Keys do
  begin
    netIPObj := netIPObjDic[keyTag];
    if Assigned(netIPObj) then
    begin
      netIPObjDic.Remove(IntToStr(netIPObj.tag));
      TLog.Instance.DDLogInfo('NET ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ' stopNet');
      netIPObj.Active := False;
    end;
  end;
end;

constructor TNet.Create(deviceList: TList);
begin
  netIPList := deviceList;
  if netIPList = nil then
  begin
    netIPList := TList.Create;
  end;
  netIPObjDic := TDictionary<string, TClientSocket>.Create(0);
  reqTimer := TTimer.Create(nil);
  reqTimer.interval := 1000; // default
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
  commonData: string;
  deviceInfo: TDeviceInfo;
  netIPObj: TClientSocket;
begin
  for keyTag in netIPObjDic.Keys do
  begin
    netIPObj := netIPObjDic[keyTag];
    if Assigned(netIPObj) then
    begin
      deviceInfo := getDeviceInfoFromNetObj(netIPObj);
      if Assigned(deviceInfo) then
      begin
        commonData := deviceInfo.dCommond;
        TLog.Instance.DDLogInfo('Net ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ' writeData: ' + commonData);
        netIPObj.Socket.SendText(commonData);
      end;
    end;
  end;
end;

procedure TNet.ClientSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
var
  deviceInfo: TDeviceInfo;
  netIPObj: TClientSocket;
begin
  netIPObj := TClientSocket(Sender);
  deviceInfo := getDeviceInfoFromNetObj(netIPObj);
  if Assigned(deviceInfo) then
  begin
    netIPObjDic.AddOrSetValue(IntToStr(deviceInfo.dTag),netIPObj);
    TLog.Instance.DDLogInfo('Net ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ' connected');
  end;

end;

procedure TNet.ClientSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
var
  deviceInfo: TDeviceInfo;
  netIPObj: TClientSocket;
begin
  netIPObj := TClientSocket(Sender);
  deviceInfo := getDeviceInfoFromNetObj(netIPObj);
  if Assigned(deviceInfo) then
  begin
    netIPObjDic.Remove(IntToStr(deviceInfo.dTag));
    TLog.Instance.DDLogInfo('Net ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ' Disconnect');
  end;
end;

procedure TNet.ClientSocketError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
var
  deviceInfo: TDeviceInfo;
  netIPObj: TClientSocket;
  originErrorCode :Integer;
begin
  originErrorCode :=ErrorCode;
  ErrorCode := 0;
  netIPObj := TClientSocket(Sender);
  deviceInfo := getDeviceInfoFromNetObj(netIPObj);
  if Assigned(deviceInfo) then
  begin
    netIPObjDic.Remove(IntToStr(deviceInfo.dTag));
    TLog.Instance.DDLogError('Net ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) +
    ',ErrorEvent =' + GetEnumName(TypeInfo(TErrorEvent), ord(ErrorEvent)) +',errorCode = ' + IntToStr(originErrorCode));
  end;
end;

procedure TNet.ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  keyTag: string;
  commonData: string;
  deviceInfo: TDeviceInfo;
  netIPObj: TClientSocket;
begin
  netIPObj := TClientSocket(Sender);
//  netIPObj.Socket.
  TLog.Instance.DDLogInfo('Net ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ' read');
end;

procedure TNet.ClientSocketWrite(Sender: TObject; Socket: TCustomWinSocket);
var
  keyTag: string;
  commonData: string;
  deviceInfo: TDeviceInfo;
  netIPObj: TClientSocket;
begin
  netIPObj := TClientSocket(Sender);
  TLog.Instance.DDLogInfo('Net ' + netIPObj.Address + ':' + IntToStr(netIPObj.Port) + ' write');
end;

function TNet.getDeviceInfoFromNetObj(obj: TClientSocket): TDeviceInfo;
var
  device: TDeviceInfo;
  i: Integer;
begin
  for i := 0 to netIPList.Count - 1 do
  begin
    device := netIPList.Items[i];
    if (device.dName = obj.Address) and (device.dPort = obj.Port) and (device.dTag = obj.tag) then
    begin
      Result := device;
      Break;
    end;
  end;
end;

procedure TNet.SetcInterval(val: Integer);
begin
  FcInterval := val;
  if Assigned(reqTimer) then
  begin
    reqTimer.Enabled := False;
    reqTimer.interval := FcInterval;
  end;

end;

end.

