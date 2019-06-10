unit MainPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, CnClasses, CnRS232,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    rs232: TCnRS232;
    procedure onReceive(Sender: TObject; Buffer: Pointer; BufferLength: Word);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    rs232.StopComm;
    rs232.StartComm;
  except
    on E: Exception do
      ShowMessage('open rs232 Error');
  end;
end;

procedure TForm1.onReceive(Sender: TObject; Buffer: Pointer;
  BufferLength: Word);
var
  i: integer;
  ss, ffnn: string;
  rbuf: array of byte;
  tag: Int8;
begin
  setlength(rbuf, BufferLength);
  move(Buffer^, pchar(rbuf)^, BufferLength);
  ss := '接收：';
  tag := TCnRS232(Sender).tag;
  for i := 0 to BufferLength - 1 do
  begin
    ss := ss + inttohex(rbuf[i], 2) + ''; // 接受数据
  end;
  ss := ss + ' tag = ' + IntToStr(tag);
  OutputDebugString(pchar(ss));
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  tag: Int8;
begin
  tag := 2;
  rs232 := TCnRS232.Create(nil);
  rs232.CommName := 'COM' + IntToStr(tag);
  rs232.tag := tag;
  rs232.CommConfig.BaudRate := 9600;
  rs232.OnReceiveData := onReceive;
end;

procedure saveToJson(data: string);
begin

end;

end.
