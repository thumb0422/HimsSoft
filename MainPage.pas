unit MainPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  HCom32, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    initBtn: TButton;
    sendBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure sendBtnClick(Sender: TObject);
    procedure initBtnClick(Sender: TObject);
  private
    { Private declarations }
    FCom32: THComm;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.initBtnClick(Sender: TObject);
var
  ss: string;
begin
  FCom32.init;
end;

procedure TForm1.sendBtnClick(Sender: TObject);
var
  ss: string;
begin
  FCom32.send;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  comList: TStringList;
begin
  comList := TStringList.Create;
  comList.Add('2');
  comList.Add('3');
  comList.Add('4');
  FCom32 := THComm.Create(comList);
  FCom32.interval := 1000;
  FCom32.sendData := '0A 0D 4B';
end;

procedure saveToJson(data: string);
begin

end;

end.

