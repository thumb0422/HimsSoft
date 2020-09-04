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
  Vcl.ExtCtrls, Data.DBXClassRegistry, CnRS232, HClientLog, HDeviceInfo, HCate,HDeviceDefine,HDataModel;

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
  HBellco,HToray,HBraun,HNikkiso,HGambro,HFresenius;

procedure THComm.init;
begin
  inherited;
  FisConnected := False;
  if Assigned(FDeviceInfo) and Assigned(rs232Obj) then
  begin
    try
      TClientLog.Instance.DDLogInfo(FDeviceInfo.MName + ' connect');
      FisConnected := True;
      rs232Obj.StopComm;
      rs232Obj.StartComm;
    except
      on E: Exception do
      begin
        FisConnected := False;
        if Assigned(FdataFailCallBack) then
          FdataFailCallBack(self,TErrorMsg.Create('-1',FDeviceInfo.MName + Com32OpenError));
        TClientLog.Instance.DDLogError(FDeviceInfo.MName + ' connectError');
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
    TClientLog.Instance.DDLogError(FDeviceInfo.MName + ' sendError,isConneted = False');
  end;
end;

procedure THComm.close;
begin
  inherited;
  FisConnected := False;
  if Assigned(rs232Obj) then
  begin
    TClientLog.Instance.DDLogInfo(rs232Obj.CommName + ' stopComm');
    rs232Obj.StopComm;
  end;
end;

constructor THComm.Create(deviceInfo: TDeviceInfo);
begin
  inherited;
  FDeviceInfo := deviceInfo;
  FisConnected := False;
  if Assigned(FDeviceInfo) then
  begin
    rs232Obj := TCnRS232.Create(nil);
    rs232Obj.Name := 'rs232Obj';
    rs232Obj.CommName := FDeviceInfo.MName;
    rs232Obj.tag := FDeviceInfo.MTag;
    rs232Obj.CommConfig.BaudRate := 9600;//FDeviceInfo.dPort;
    rs232Obj.OnReceiveData := onReceive;
    rs232Obj.onReceiveError := onReceiveError;
    rs232Obj.onRequestHangup := onRequestHangup;
  end;
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
  if Assigned(rs232Obj) and FisConnected and Assigned(FDeviceInfo) then
  begin
    TClientLog.Instance.DDLogInfo(rs232Obj.CommName + ' writeData: ' + FDeviceInfo.MCommond);
    rs232Obj.WriteCommData(PAnsiChar(AnsiString(FDeviceInfo.MCommond)), Length(FDeviceInfo.MCommond));
  end;
end;

procedure THComm.onReceive(Sender: TObject; Buffer: Pointer; BufferLength: Word);
var
  i: Integer;
  ss: string;
  rbuf: array of byte;
begin
  setlength(rbuf, BufferLength);
  move(Buffer^, pchar(rbuf)^, BufferLength);
  for i := 0 to BufferLength - 1 do
  begin
    ss := ss + IntToHex(rbuf[i], 2) + ' ';
  end;
  ss := rs232Obj.CommName + ' onReceive: ' + ss;
  TClientLog.Instance.DDLogInfo(ss);
  if Assigned(FdataSuccessCallBack) then
    FdataSuccessCallback(Self,rbuf);
end;

procedure THComm.onReceiveError(Sender: TObject; EventMask: Cardinal);
var
  ss: string;
begin
  if Assigned(FdataFailCallBack) then
    FdataFailCallBack(Self,TErrorMsg.Create('-1',FDeviceInfo.MName + Com32ReciceError));
  ss := rs232Obj.CommName + ' onReceiveError,EventMask = ' + IntToStr(EventMask);
  TClientLog.Instance.DDLogError(ss);
end;

procedure THComm.onRequestHangup(Sender: TObject);
var
  ss: string;
begin
  if Assigned(FdataFailCallBack) then
    FdataFailCallBack(Self,TErrorMsg.Create('-1',FDeviceInfo.MName + Com32HangUpError));
  ss := rs232Obj.CommName + ' onRequestHangup';
  TClientLog.Instance.DDLogError(ss);
end;

end.

