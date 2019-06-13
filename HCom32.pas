unit HCom32;

interface

uses
  System.SysUtils, Winapi.Windows, System.Classes, System.Generics.Collections,
  Vcl.ExtCtrls, CnRS232, HLog, HDeviceInfo;

type
  THComm = class
  private
    FcInterval: Integer;
    procedure SetcInterval(val: Integer);
  public
    procedure init; overload; // startAllComm
    procedure init(deviceInfo: TDeviceInfo); overload; // startCommX
    procedure send; // writeCommX or writeAllComm
    procedure close; // stopCommX or stopAllComm
    constructor Create(deviceList: TList); // 设备列表
    property cInterval: Integer read FcInterval write SetcInterval; //
  private
    reqTimer: TTimer;
    rs232DeviceList: TList; // deviceInfo list
    rs232ObjDic: TDictionary<string, TCnRS232>; // cnRS232 可连接对象集合 tag作为key
    procedure onReceive(Sender: TObject; Buffer: Pointer; BufferLength: Word);
    procedure onReceiveError(Sender: TObject; EventMask: Cardinal);
    procedure onRequestHangup(Sender: TObject);
    procedure onRs232WriteComm(Sender: TObject);
    function getDeviceInfoFromRs232Obj(obj: TCnRS232): TDeviceInfo;
  protected
    destructor Destroy; override;
  end;

implementation

procedure THComm.init;
var
  i: Integer;
  fdeviceInfo: TDeviceInfo;
  fdeviceTag: string;
  rs232Obj: TCnRS232;
begin
  rs232ObjDic.Clear;
  if Assigned(reqTimer) then
    reqTimer.Enabled := False;
  for i := 0 to rs232DeviceList.Count - 1 do
  begin
    fdeviceInfo := rs232DeviceList[i];
    if fdeviceInfo.dLink = dtlComm then
    begin
      fdeviceTag := IntToStr(fdeviceInfo.dTag);
      rs232Obj := TCnRS232.Create(nil);
      rs232Obj.CommName := fdeviceInfo.dName;
      rs232Obj.tag := fdeviceInfo.dTag;
      rs232Obj.CommConfig.BaudRate := fdeviceInfo.dPort;
      rs232Obj.OnReceiveData := onReceive;
      rs232Obj.onReceiveError := onReceiveError;
      rs232Obj.onRequestHangup := onRequestHangup;
      try
        rs232ObjDic.AddOrSetValue(fdeviceTag, rs232Obj);
        TLog.Instance.DDLogInfo(fdeviceInfo.dName + ' open');
        rs232Obj.StopComm;
        rs232Obj.StartComm;
      except
        on E: Exception do
        begin
          rs232ObjDic.Remove(fdeviceTag);
          TLog.Instance.DDLogError(fdeviceInfo.dName + ' openError');
          rs232Obj.StopComm;
        end;
      end;
    end;
  end;
end;

procedure THComm.init(deviceInfo: TDeviceInfo);
var
  fdeviceTag: string;
  rs232Obj: TCnRS232;
begin
  rs232ObjDic.Clear;
  if Assigned(reqTimer) then
    reqTimer.Enabled := False;
  if deviceInfo.dLink = dtlComm then
  begin
    fdeviceTag := IntToStr(deviceInfo.dTag);
    rs232Obj := TCnRS232.Create(nil);
    rs232Obj.CommName := deviceInfo.dName;
    rs232Obj.tag := deviceInfo.dTag;
    rs232Obj.CommConfig.BaudRate := deviceInfo.dPort;

    rs232Obj.OnReceiveData := onReceive;
    try
      rs232ObjDic.AddOrSetValue(fdeviceTag, rs232Obj);
      TLog.Instance.DDLogInfo(deviceInfo.dName + ' open');
      rs232Obj.StopComm;
      rs232Obj.StartComm;
    except
      on E: Exception do
      begin
        rs232Obj.StopComm;
        rs232ObjDic.Remove(fdeviceTag);
        TLog.Instance.DDLogError(deviceInfo.dName + ' openError');
      end;
    end;
  end;
end;

procedure THComm.send;
begin
  TLog.Instance.DDLogInfo('count = ' + IntToStr(rs232ObjDic.Count));
  if Assigned(reqTimer) then
  begin
    reqTimer.Enabled := False;
    reqTimer.Enabled := True;
  end;
end;

procedure THComm.close;
var
  keyTag: string;
  rs232Obj: TCnRS232;
begin
  if Assigned(reqTimer) then
    reqTimer.Enabled := False;
  for keyTag in rs232ObjDic.Keys do
  begin
    rs232Obj := rs232ObjDic[keyTag];
    if Assigned(rs232Obj) then
    begin
      TLog.Instance.DDLogInfo(rs232Obj.CommName + ' stopComm');
      rs232Obj.StopComm;
    end;
  end;
end;

constructor THComm.Create(deviceList: TList);
begin
  rs232DeviceList := deviceList;
  if rs232DeviceList = nil then
  begin
    rs232DeviceList := TList.Create;
  end;
  rs232ObjDic := TDictionary<string, TCnRS232>.Create(0);
  reqTimer := TTimer.Create(nil);
  reqTimer.interval := 1000; //default
  reqTimer.OnTimer := onRs232WriteComm;
  reqTimer.Enabled := False;
end;

destructor THComm.Destroy;
begin
  rs232ObjDic.Free;
  rs232DeviceList.Free;
  if Assigned(reqTimer) then
    reqTimer.Free;
end;

procedure THComm.onReceive(Sender: TObject; Buffer: Pointer;
  BufferLength: Word);
var
  i: Integer;
  ss: string;
  rbuf: array of byte;
  rspCNRs232Obj: TCnRS232;
begin
  setlength(rbuf, BufferLength);
  move(Buffer^, pchar(rbuf)^, BufferLength);
  rspCNRs232Obj := TCnRS232(Sender);
  for i := 0 to BufferLength - 1 do
  begin
    ss := ss + IntToHex(rbuf[i], 2) + ' ';
  end;
  ss := rspCNRs232Obj.CommName + ' onReceive: ' + ss;
  TLog.Instance.DDLogInfo(ss);
end;

procedure THComm.onReceiveError(Sender: TObject; EventMask: Cardinal);
var
  ss: string;
  rspCNRs232Obj: TCnRS232;
begin
  rspCNRs232Obj := TCnRS232(Sender);
  ss := rspCNRs232Obj.CommName + ' onReceiveError,EventMask = ' +
    IntToStr(EventMask);
  TLog.Instance.DDLogError(ss);
end;

procedure THComm.onRequestHangup(Sender: TObject);
var
  ss: string;
  rspCNRs232Obj: TCnRS232;
begin
  rspCNRs232Obj := TCnRS232(Sender);
  ss := rspCNRs232Obj.CommName + ' onRequestHangup';
  TLog.Instance.DDLogError(ss);
end;

procedure THComm.onRs232WriteComm(Sender: TObject);
var
  keyTag: string;
  commonData: string;
  deviceInfo: TDeviceInfo;
  rs232Obj: TCnRS232;
begin
  for keyTag in rs232ObjDic.Keys do
  begin
    rs232Obj := rs232ObjDic[keyTag];
    if Assigned(rs232Obj) then
    begin
      deviceInfo := getDeviceInfoFromRs232Obj(rs232Obj);
      if Assigned(deviceInfo) then
      begin
        commonData := deviceInfo.dCommond;
        TLog.Instance.DDLogInfo(rs232Obj.CommName + ' writeData: ' +
          commonData);
        rs232Obj.WriteCommData(PAnsiChar(AnsiString(commonData)),
          Length(commonData));
      end;

    end;
  end;
end;

function THComm.getDeviceInfoFromRs232Obj(obj: TCnRS232): TDeviceInfo;
var
  device: TDeviceInfo;
  i: Integer;
begin
  for i := 0 to rs232DeviceList.Count - 1 do
  begin
    device := rs232DeviceList.Items[i];
    if (device.dName = obj.CommName) and (device.dTag = obj.tag) then
    begin
      Result := device;
      Break;
    end;
  end;
end;

procedure THComm.SetcInterval(val: Integer);
begin
  FcInterval := val;
  if Assigned(reqTimer) then
  begin
    reqTimer.Enabled :=False;
    reqTimer.Interval :=FcInterval;
  end;

end;

end.
