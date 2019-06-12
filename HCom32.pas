unit HCom32;

interface

uses
  System.SysUtils, Winapi.Windows, System.Classes, System.Generics.Collections,
  Vcl.ExtCtrls, CnRS232, HLog;

type
  THComm = class
  public
    commPort: Integer; // com232 Port
    sendData: string;
    interval: Integer; // timer interval
    procedure init; overload; // startAllComm
    procedure init(tag: string); overload; // startCommX
    procedure send; // writeCommX or writeAllComm
    procedure close; // stopCommX or stopAllComm

    constructor Create(commNameList: TStringList); // 1、2、3、4、5、6、7等
  private
    reqTimer: TTimer;
    rs232NameList: TStringList; // com232 list
    rs232ObjDic: TDictionary<string, TCnRS232>; // cnRS232 对象集合
    procedure onReceive(Sender: TObject; Buffer: Pointer; BufferLength: Word);
    procedure onReceiveError(Sender: TObject; EventMask: Cardinal);
    procedure onRequestHangup(Sender: TObject);
    procedure onRs232WriteComm(Sender: TObject);
  protected
    rs232Obj: TCnRS232; // 临时对象
    Ftag: string; // 执行某个具体的comm
    destructor Destroy; override;
  end;

implementation

procedure THComm.init;
var
  i: Integer;
  indexStr: string;
begin
  rs232ObjDic.Clear;
  for i := 0 to rs232NameList.Count - 1 do
  begin
    indexStr := rs232NameList[i];
    rs232Obj := TCnRS232.Create(nil);
    rs232Obj.CommName := 'COM' + indexStr;
    rs232Obj.tag := StrToInt(indexStr);
    rs232Obj.CommConfig.BaudRate := 9600;
    rs232Obj.OnReceiveData := onReceive;
    rs232Obj.onReceiveError := onReceiveError;
    rs232Obj.onRequestHangup := onRequestHangup;
    try
      rs232ObjDic.AddOrSetValue(indexStr, rs232Obj);
      TLog.Instance.DDLogInfo('COM' + indexStr + ' open');
      rs232Obj.StopComm;
      rs232Obj.StartComm;
    except
      on E: Exception do
      begin
        rs232ObjDic.Remove(indexStr);
        TLog.Instance.DDLogError('COM' + indexStr + ' openError');
        rs232Obj.StopComm;
      end;
    end;
  end;
end;

procedure THComm.init(tag: string);
var
  i: Integer;
  indexStr: string;
begin
  Ftag := tag;
  rs232ObjDic.Clear;
  begin
    indexStr := Ftag;
    rs232Obj := TCnRS232.Create(nil);
    rs232Obj.CommName := 'COM' + indexStr;
    rs232Obj.tag := StrToInt(indexStr);
    rs232Obj.CommConfig.BaudRate := 9600;
    rs232Obj.OnReceiveData := onReceive;
    try
      rs232ObjDic.AddOrSetValue(indexStr, rs232Obj);
      TLog.Instance.DDLogInfo('COM' + indexStr + ' open');
      rs232Obj.StopComm;
      rs232Obj.StartComm;
    except
      on E: Exception do
      begin
        rs232Obj.StopComm;
        rs232ObjDic.Remove(indexStr);
        TLog.Instance.DDLogError('COM' + indexStr + ' openError');
      end;
    end;
  end;
end;

procedure THComm.send;
begin
  if Assigned(reqTimer) then
  begin
    reqTimer.Enabled := False;
    reqTimer.Enabled := True;
  end;
end;

procedure THComm.close;
var
  keyTag: string;
begin
  if Assigned(reqTimer) then
    reqTimer.Enabled := False;
  for keyTag in rs232ObjDic.Keys do
  begin
    rs232Obj := rs232ObjDic[keyTag];
    if Assigned(rs232Obj) then
    begin
      TLog.Instance.DDLogInfo('COM' + IntToStr(rs232Obj.tag) + ' stopComm');
      rs232Obj.StopComm;
    end;
  end;
end;

constructor THComm.Create(commNameList: TStringList);
begin
  rs232NameList := commNameList;
  if rs232NameList = nil then
  begin
    rs232NameList := TStringList.Create;
  end;
  rs232ObjDic := TDictionary<string, TCnRS232>.Create(0);
  reqTimer := TTimer.Create(nil);
  reqTimer.interval := 1000;
  reqTimer.OnTimer := onRs232WriteComm;
  reqTimer.Enabled := False;
end;

destructor THComm.Destroy;
begin
  rs232ObjDic.Free;
  rs232NameList.Free;
  if Assigned(reqTimer) then
    reqTimer.Free;
end;

procedure THComm.onReceive(Sender: TObject; Buffer: Pointer;
  BufferLength: Word);
var
  i: Integer;
  ss: string;
  rbuf: array of byte;
  tag: Integer;
begin
  setlength(rbuf, BufferLength);
  move(Buffer^, pchar(rbuf)^, BufferLength);
  tag := TCnRS232(Sender).tag;
  for i := 0 to BufferLength - 1 do
  begin
    ss := ss + IntToHex(rbuf[i], 2) + ' ';
  end;
  ss := 'COM' + IntToStr(tag) + ' onReceive: ' + ss;
  TLog.Instance.DDLogInfo(ss);
end;

procedure THComm.onReceiveError(Sender: TObject; EventMask: Cardinal);
var
  tag: Integer;
  ss: string;
begin
  tag := TCnRS232(Sender).tag;
  ss := 'COM' + IntToStr(tag) + ' onReceiveError,EventMask = ' +
    IntToStr(EventMask);
  TLog.Instance.DDLogError(ss);
end;

procedure THComm.onRequestHangup(Sender: TObject);
var
  tag: Integer;
  ss: string;
begin
  tag := TCnRS232(Sender).tag;
  ss := 'COM' + IntToStr(tag) + ' onRequestHangup';
  TLog.Instance.DDLogError(ss);
end;

procedure THComm.onRs232WriteComm(Sender: TObject);
var
  keyTag: string;
begin
  for keyTag in rs232ObjDic.Keys do
  begin
    rs232Obj := rs232ObjDic[keyTag];
    if Assigned(rs232Obj) then
    begin
      TLog.Instance.DDLogInfo('COM' + IntToStr(rs232Obj.tag) + ' writeData: ' +
        sendData);
      rs232Obj.WriteCommData(PAnsiChar(AnsiString(sendData)), Length(sendData));
    end;
  end;
end;

end.
