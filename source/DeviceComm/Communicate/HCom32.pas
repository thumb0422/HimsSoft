{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HCom32;

interface

uses
  System.SysUtils, Winapi.Windows, System.Classes, System.Generics.Collections,
  Vcl.ExtCtrls, Data.DBXClassRegistry, CnRS232, HLog, HDeviceInfo, HCate,HDeviceDefine,HDataModel;

type
  THComm = class(TCate)
  public
    procedure init; override; // startCommX
    procedure send; override; // writeCommX
    procedure close; override; // stopCommX
    constructor Create(deviceInfo: TDeviceInfo); override; // 设备
    destructor Destroy; override;
  private
    procedure onReceive(Sender: TObject; Buffer: Pointer; BufferLength: Word);
    procedure onReceiveError(Sender: TObject; EventMask: Cardinal);
    procedure onRequestHangup(Sender: TObject);
    procedure onWriteData;
  protected
    rs232Obj: TCnRS232;
  end;

implementation

uses
  HDeviceBase, HBellco, HToray,HBraun,HNikkiso,HGambro,HFresenius;

procedure THComm.init;
begin
  inherited;
  FisConnected := False;
  if Assigned(FDeviceInfo) and (FDeviceInfo.dLink = DLinkCom) then
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
        if Assigned(FdataFailCallBack) then
          FdataFailCallBack(self,TErrorMsg.Create('-1',Com32OpenError));
        TLog.Instance.DDLogError(FDeviceInfo.dName + ' connectError');
        rs232Obj.StopComm;
      end;
    end;
  end;
end;

procedure THComm.send;
begin
  inherited;
  if FisConnected then
  begin
    onWriteData;
  end
  else
  begin
  //todo:是否需要重新init
    TLog.Instance.DDLogError(FDeviceInfo.dName + ' sendError,isConneted = False');
  end;
end;

procedure THComm.close;
begin
  inherited;
  FisConnected := False;
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
end;

destructor THComm.Destroy;
begin
  FisConnected := False;
  if Assigned(rs232Obj) then
    rs232Obj.Free;
  if Assigned(FDeviceInfo) then
    FDeviceInfo.Free;
  inherited;
end;

procedure THComm.onWriteData;
begin
  if Assigned(rs232Obj) and FisConnected and Assigned(FDeviceInfo) and (FDeviceInfo.dLink = DLinkCom) then
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
  rspData:TDataModel;
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
//  classRegistry := TClassRegistry.GetClassRegistry;
//  if classRegistry.HasClass(fDeviceBrand) then
//  begin
//    fdeviceBaseObj := classRegistry.CreateInstance(fDeviceBrand) as TDeviceBase;
//    fdeviceBaseObj.praseData(rbuf, rspData);
//    fdeviceBaseObj.Free;
    if Assigned(FdataSuccessCallBack) then
//      FcallBackSuccess(Self,rspData);
      FdataSuccessCallback(Self,rbuf);
//  end
//  else
//  begin
//    TLog.Instance.DDLogError('Can not found ' + fDeviceBrand + ' class');
//  end;
end;

procedure THComm.onReceiveError(Sender: TObject; EventMask: Cardinal);
var
  ss: string;
begin
  if Assigned(FdataFailCallBack) then
    FdataFailCallBack(Self,TErrorMsg.Create('-1',Com32ReciceError));
  ss := rs232Obj.CommName + ' onReceiveError,EventMask = ' + IntToStr(EventMask);
  TLog.Instance.DDLogError(ss);
end;

procedure THComm.onRequestHangup(Sender: TObject);
var
  ss: string;
begin
  if Assigned(FdataFailCallBack) then
    FdataFailCallBack(Self,TErrorMsg.Create('-1',Com32HangUpError));
  ss := rs232Obj.CommName + ' onRequestHangup';
  TLog.Instance.DDLogError(ss);
end;

//initialization
//  TClassRegistry.GetClassRegistry.RegisterClass(TBellco.ClassName, TBellco);
//  TClassRegistry.GetClassRegistry.RegisterClass(TToray.ClassName, TToray);
//  TClassRegistry.GetClassRegistry.RegisterClass(TBraun.ClassName, TBraun);
//  TClassRegistry.GetClassRegistry.RegisterClass(TNikkiso.ClassName, TNikkiso);
//  TClassRegistry.GetClassRegistry.RegisterClass(TGambro.ClassName, TGambro);
//  TClassRegistry.GetClassRegistry.RegisterClass(TFresenius.ClassName, TFresenius);

end.

