unit Server;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Win.Registry,
  CnClasses, CnRS232,System.Win.ScktComp, Vcl.StdCtrls;

type
  THServer = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    CnRS2321: TCnRS232;
    ServerSocket1: TServerSocket;
    procedure CnRS2321ReceiveData(Sender: TObject; Buffer: Pointer;
      BufferLength: Word);
    procedure CnRS2321ReceiveError(Sender: TObject; EventMask: Cardinal);
    procedure CnRS2321RequestHangup(Sender: TObject);
    procedure CnRS2321SendDataEmpty(Sender: TObject);
    procedure ServerSocket1Accept(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientWrite(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1GetSocket(Sender: TObject; Socket: NativeInt;
      var ClientSocket: TServerClientWinSocket);
    procedure ServerSocket1Listen(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocket1ThreadEnd(Sender: TObject;
      Thread: TServerClientThread);
    procedure ServerSocket1ThreadStart(Sender: TObject;
      Thread: TServerClientThread);
    procedure ServerSocket1GetThread(Sender: TObject;
      ClientSocket: TServerClientWinSocket;
      var SocketThread: TServerClientThread);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FComConnected: Boolean;
    procedure SetComConnected(const Value: Boolean);
    { Private declarations }
    property ComConnected:Boolean read FComConnected write SetComConnected;
    function getAllCommPorts: TStringList; // 获取所有的串口
  public
    { Public declarations }
  end;

var
  HServer: THServer;

implementation

{$R *.dfm}

function THServer.getAllCommPorts: TStringList;
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

procedure THServer.Button1Click(Sender: TObject);
begin
  Self.Memo1.Lines.Clear;
  Self.CnRS2321.CommName := Self.ComboBox1.Text;
  Self.ComConnected := not Self.FComConnected;
  if not Self.FComConnected then
  begin
    Self.CnRS2321.StopComm;
  end
  else
  begin
    try
      Self.CnRS2321.StopComm;
      Self.CnRS2321.StartComm;
    except
      on E: Exception do
      begin
        Self.ComConnected := False;
        Self.Memo1.Lines.Add(Self.CnRS2321.CommName + '-OpenError');
        Self.CnRS2321.StopComm;
      end;
    end;
  end;
end;

procedure THServer.Button2Click(Sender: TObject);
begin
  Self.Memo1.Lines.Clear;
end;

procedure THServer.SetComConnected(const Value: Boolean);
begin
  FComConnected := Value;
  if FComConnected then
  begin
    Self.Button1.Caption := '服务开启';
  end
  else
  begin
    Self.Button1.Caption := '服务关闭';
  end;
end;

procedure THServer.CnRS2321ReceiveData(Sender: TObject; Buffer: Pointer;
  BufferLength: Word);
var
  i: Integer;
  ss: string;
  rbuf: array of byte;
  procedure sendData(str:string);
  begin
    Self.Memo1.Lines.Add(Self.CnRS2321.CommName +'-SendingData :'+ str);
    Self.CnRS2321.WriteCommData(PAnsiChar(AnsiString(str)), Length(str));
  end;
begin
  setlength(rbuf, BufferLength);
  move(Buffer^, pchar(rbuf)^, BufferLength);
  for i := 0 to BufferLength - 1 do
  begin
    ss := ss + IntToHex(rbuf[i], 2) + ' ';
  end;
  Self.Memo1.Lines.Add(Self.CnRS2321.CommName +'-ReceiveData :'+ ss);
  sendData(ss+ IntToStr(Random(100)));
end;

procedure THServer.CnRS2321ReceiveError(Sender: TObject; EventMask: Cardinal);
begin
  Self.ComConnected := False;
  Self.Memo1.Lines.Add(Self.CnRS2321.CommName +'-ReceiveError-'+ IntToStr(EventMask));
end;

procedure THServer.CnRS2321RequestHangup(Sender: TObject);
begin
  Self.Memo1.Lines.Add(Self.CnRS2321.CommName +'-RequestHangup');
end;

procedure THServer.CnRS2321SendDataEmpty(Sender: TObject);
begin
//  Self.Memo1.Lines.Add(Self.CnRS2321.CommName +'-SendDataEmpty');
end;

procedure THServer.FormShow(Sender: TObject);
begin
  Self.ComConnected := False;
  Self.Memo1.Lines.Clear;
  Self.ComboBox1.Items.AddStrings(Self.getAllCommPorts);
end;

procedure THServer.ServerSocket1Accept(Sender: TObject;
  Socket: TCustomWinSocket);
begin
//
end;

procedure THServer.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
//
end;

procedure THServer.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
//
end;

procedure THServer.ServerSocket1ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
//
end;

procedure THServer.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
//
end;

procedure THServer.ServerSocket1ClientWrite(Sender: TObject;
  Socket: TCustomWinSocket);
begin
//
end;

procedure THServer.ServerSocket1GetSocket(Sender: TObject; Socket: NativeInt;
  var ClientSocket: TServerClientWinSocket);
begin
//
end;

procedure THServer.ServerSocket1GetThread(Sender: TObject;
  ClientSocket: TServerClientWinSocket; var SocketThread: TServerClientThread);
begin
//
end;

procedure THServer.ServerSocket1Listen(Sender: TObject;
  Socket: TCustomWinSocket);
begin
//
end;

procedure THServer.ServerSocket1ThreadEnd(Sender: TObject;
  Thread: TServerClientThread);
begin
//
end;

procedure THServer.ServerSocket1ThreadStart(Sender: TObject;
  Thread: TServerClientThread);
begin
//
end;

end.
