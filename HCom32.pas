unit HCom32;

interface

uses
  System.SysUtils, Winapi.Windows,
  System.Classes, System.Generics.Collections,
  CnRS232, HLog;

type
  THComm = class
  public
    commPort: Integer; // com232 Port
    sendData: string;
    procedure init(tag: string); // startComm,if tag=0,startAllComm
    procedure send(tag: string); // writeComm,if tag=0,sendAllComm
    procedure close(tag: string); // stopComm,if tag=0,stopAllComm

    constructor Create(commNameList: TStringList); // 1��2��3��4��5��6��7��
    Destructor Destroy; override;
  private
    rs232NameList: TStringList; // com232 list
    rs232ObjDic: TDictionary<string, TCnRS232>; // cnRS232 ���󼯺�
    procedure onReceive(Sender: TObject; Buffer: Pointer; BufferLength: Word);
  protected
    rs232Obj: TCnRS232; // ��ʱ����
  end;

implementation

procedure THComm.init(tag: string);
var
  i: Integer;
  indexStr: string;
begin
  rs232ObjDic.Clear;
  if (tag = '') or (tag = '0') then
  begin
    for i := 0 to rs232NameList.Count - 1 do
    begin
      indexStr := rs232NameList[i];
      rs232Obj := TCnRS232.Create(nil);
      rs232Obj.CommName := 'COM' + indexStr;
      rs232Obj.tag := StrToInt(indexStr);
      rs232Obj.CommConfig.BaudRate := 9600;
      rs232Obj.OnReceiveData := onReceive;
      try
        rs232Obj.StopComm;
        TLog.Instance.DDLogInfo('COM' + indexStr + ' open');
        rs232Obj.StartComm;
        rs232ObjDic.AddOrSetValue(indexStr, rs232Obj);
      except
        on E: Exception do
        begin
          rs232ObjDic.Remove(indexStr);
          TLog.Instance.DDLogError('COM' + indexStr + ' openError');
          rs232Obj.StopComm;
        end;
      end;
    end;
  end
  else
  begin
    indexStr := tag;
    rs232Obj := TCnRS232.Create(nil);
    rs232Obj.CommName := 'COM' + indexStr;
    rs232Obj.tag := StrToInt(indexStr);
    rs232Obj.CommConfig.BaudRate := 9600;
    rs232Obj.OnReceiveData := onReceive;
    try
      rs232Obj.StopComm;
      TLog.Instance.DDLogInfo('COM' + indexStr + ' open');
      rs232Obj.StartComm;
    except
      on E: Exception do
      begin
        rs232Obj.StopComm;
        rs232ObjDic.Remove(indexStr);
        TLog.Instance.DDLogError('COM' + indexStr + ' openError');
      end;
    end;
    rs232ObjDic.AddOrSetValue(indexStr, rs232Obj);
  end;
end;

procedure THComm.send(tag: string);
var
  keyTag: string;
begin
  if (tag = '') or (tag = '0') then
  begin
    for keyTag in rs232ObjDic.Keys do
    begin
      rs232Obj := rs232ObjDic[keyTag];
      if Assigned(rs232Obj) then
      begin
        TLog.Instance.DDLogInfo('COM' + IntToStr(rs232Obj.tag) + ' writeData: ' +
          sendData);
        rs232Obj.WriteCommData(PAnsiChar(AnsiString(sendData)),
          Length(sendData));
      end;
    end;
  end
  else
  begin
    rs232Obj := rs232ObjDic[tag];
    if Assigned(rs232Obj) then
    begin
      TLog.Instance.DDLogInfo('COM' + IntToStr(rs232Obj.tag) + ' writeData: ' +
        sendData);
      rs232Obj.WriteCommData(PAnsiChar(AnsiString(sendData)), Length(sendData));
    end;
  end;
end;

procedure THComm.close(tag: string);
var
  keyTag: string;
begin
  if (tag = '') or (tag = '0') then
  begin
    for keyTag in rs232ObjDic.Keys do
    begin
      rs232Obj := rs232ObjDic[keyTag];
      if Assigned(rs232Obj) then
      begin
        TLog.Instance.DDLogInfo('COM' + IntToStr(rs232Obj.tag) + ' stopComm');
        rs232Obj.StopComm;
      end;
    end;
  end
  else
  begin
    rs232Obj := rs232ObjDic[tag];
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
end;

Destructor THComm.Destroy;
begin
  rs232ObjDic.Free;
  rs232NameList.Free;
end;

procedure THComm.onReceive(Sender: TObject; Buffer: Pointer;
  BufferLength: Word);
var
  i: Integer;
  ss, ffnn: string;
  rbuf: array of byte;
  tag: Int8;
begin
  setlength(rbuf, BufferLength);
  move(Buffer^, pchar(rbuf)^, BufferLength);
  tag := TCnRS232(Sender).tag;
  for i := 0 to BufferLength - 1 do
  begin
    ss := ss + IntToHex(rbuf[i], 2) + ' '; // ��������
  end;
  ss := 'COM'+ IntToStr(tag)+' onReceive: '+ss;
  TLog.Instance.DDLogInfo(ss);
end;

end.
