﻿{ ******************************************************* }
{ }
{ HimsSoft }
{ }
{ 版权所有 (C) 2019 thumb0422@163.com }
{ }
{ ******************************************************* }

unit HCom32;

interface

uses
  System.SysUtils, Winapi.Windows, System.Classes, System.Generics.Collections,
  Vcl.ExtCtrls, System.Win.Registry, CnRS232, HLog, HDeviceInfo, HCate;

type
  THComm = class(TCate)
  public
    procedure init; override; // startCommX
    procedure send; override; // writeCommX
    procedure close; override; // stopCommX
    constructor Create(deviceInfo: TDeviceInfo); override; // 设备
  public
    class function getAllCommPorts: TStringList; // 获取所有的串口
  private
    FDeviceInfo: TDeviceInfo;
    procedure onReceive(Sender: TObject; Buffer: Pointer; BufferLength: Word);
    procedure onReceiveError(Sender: TObject; EventMask: Cardinal);
    procedure onRequestHangup(Sender: TObject);
    procedure onWriteData(Sender: TObject);
  protected
    rs232Obj: TCnRS232;
    destructor Destroy; override;
  end;

implementation

uses
  Data.DBXClassRegistry, HDeviceBase, HBellco, HToray;

procedure THComm.init;
begin
  if Assigned(reqTimer) then
    reqTimer.Enabled := False;
  if Assigned(FDeviceInfo) and (FDeviceInfo.dLink = dtlComm) then
  begin
    rs232Obj := TCnRS232.Create(nil);
    rs232Obj.CommName := FDeviceInfo.dName;
    rs232Obj.tag := FDeviceInfo.dTag;
    rs232Obj.CommConfig.BaudRate := FDeviceInfo.dPort;
    rs232Obj.OnReceiveData := onReceive;
    rs232Obj.onReceiveError := onReceiveError;
    rs232Obj.onRequestHangup := onRequestHangup;
    try
      TLog.Instance.DDLogInfo(FDeviceInfo.dName + ' connect');
      FisConnected := True;
      rs232Obj.StopComm;
      rs232Obj.StartComm;
    except
      on E: Exception do
      begin
        FisConnected := False;
        TLog.Instance.DDLogError(FDeviceInfo.dName + ' connectError');
        rs232Obj.StopComm;
      end;
    end;
  end;
end;

procedure THComm.send;
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

procedure THComm.close;
begin
  FisConnected := False;
  if Assigned(reqTimer) then
    reqTimer.Enabled := False;
  if Assigned(rs232Obj) then
  begin
    TLog.Instance.DDLogInfo(rs232Obj.CommName + ' stopComm');
    rs232Obj.StopComm;
  end;
end;

constructor THComm.Create(deviceInfo: TDeviceInfo);
begin
  FDeviceInfo := deviceInfo;
  FisConnected := False;
  reqTimer := TTimer.Create(nil);
  reqTimer.interval := 1000; // default
  reqTimer.OnTimer := onWriteData;
  reqTimer.Enabled := False;
end;

destructor THComm.Destroy;
begin
  if Assigned(rs232Obj) then
    rs232Obj.Free;
  if Assigned(FDeviceInfo) then
    FDeviceInfo.Free;
  if Assigned(reqTimer) then
    reqTimer.Free;
end;

procedure THComm.onWriteData(Sender: TObject);
begin
  if Assigned(rs232Obj) and FisConnected and Assigned(FDeviceInfo) and (FDeviceInfo.dLink = dtlComm) then
  begin
    TLog.Instance.DDLogInfo(rs232Obj.CommName + ' writeData: ' + FDeviceInfo.dCommond);
    rs232Obj.WriteCommData(PAnsiChar(AnsiString(FDeviceInfo.dCommond)), Length(FDeviceInfo.dCommond));
  end;
end;

procedure THComm.onReceive(Sender: TObject; Buffer: Pointer; BufferLength: Word);
var
  i: Integer;
  ss: string;
  rbuf: array of byte;
  classRegistry: TClassRegistry;
  fdeviceBaseObj: TDeviceBase;
  fDic: TDictionary<string, string>;
  fDeviceBrand: string;
begin
  setlength(rbuf, BufferLength);
  move(Buffer^, pchar(rbuf)^, BufferLength);
  fDeviceBrand := FDeviceInfo.dBrand;
  fDeviceBrand := 'T' + fDeviceBrand;
  for i := 0 to BufferLength - 1 do
  begin
    ss := ss + IntToHex(rbuf[i], 2) + ' ';
  end;
  ss := rs232Obj.CommName + ' onReceive: ' + ss;
  TLog.Instance.DDLogInfo(ss);
  classRegistry := TClassRegistry.GetClassRegistry;
  if classRegistry.HasClass(fDeviceBrand) then
  begin
    fdeviceBaseObj := classRegistry.CreateInstance(fDeviceBrand) as TDeviceBase;
    fDic := TDictionary<string, string>.Create(0);
    fdeviceBaseObj.praseData(rbuf, fDic);
    fdeviceBaseObj.Free;
  end
  else
  begin
    TLog.Instance.DDLogError('Can not found ' + fDeviceBrand + ' class');
  end;
end;

procedure THComm.onReceiveError(Sender: TObject; EventMask: Cardinal);
var
  ss: string;
  rspCNRs232Obj: TCnRS232;
begin
  rspCNRs232Obj := TCnRS232(Sender);
  ss := rspCNRs232Obj.CommName + ' onReceiveError,EventMask = ' + IntToStr(EventMask);
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

class function THComm.getAllCommPorts: TStringList;
var
  reg: TRegistry;
  ts: TStrings;
  i: Integer;
  commports: TStringList;
begin
  commports := TStringList.Create;
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  reg.OpenKey('hardware\devicemap\serialcomm', False);
  ts := TStringList.Create;
  reg.GetValueNames(ts);
  for i := 0 to ts.Count - 1 do
  begin
    commports.Add(reg.ReadString(ts.Strings[i]));
  end;
  ts.Free;
  reg.CloseKey;
  reg.Free;
  Result := commports;
end;

initialization
  TClassRegistry.GetClassRegistry.RegisterClass(TBellco.ClassName, TBellco);
  TClassRegistry.GetClassRegistry.RegisterClass(TToray.ClassName, TToray);

end.
