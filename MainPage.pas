unit MainPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  HCom32, HDeviceInfo;

type
  TForm1 = class(TForm)
    test: TButton;
    start: TButton;
    stop: TButton;
    procedure FormCreate(Sender: TObject);
    procedure startClick(Sender: TObject);
    procedure testClick(Sender: TObject);
    procedure stopClick(Sender: TObject);
  private
    { Private declarations }
    FComGroupList: TList;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.testClick(Sender: TObject);
var
  FCom32: THComm;
  i: Integer;
begin
  for i := 0 to FComGroupList.Count-1 do
  begin
    FCom32 := FComGroupList.Items[i];
    FCom32.init;
  end;
end;

procedure TForm1.startClick(Sender: TObject);
var
  FCom32: THComm;
  i: Integer;
begin
  for i := 0 to FComGroupList.Count-1 do
  begin
    FCom32 := FComGroupList.Items[i];
    FCom32.send;
  end;
end;
procedure TForm1.stopClick(Sender: TObject);
var
  FCom32: THComm;
  i: Integer;
begin
  for i := 0 to FComGroupList.Count-1 do
  begin
    FCom32 := FComGroupList.Items[i];
    FCom32.close;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  comLista, comListb: TStringList;
  FCom32a, FCom32b: THComm;
  i: Integer;
  FDeviceInfo :TDeviceInfo;
begin
//  for i := 5 to 10 do
//  begin
//    FDeviceInfo := TDeviceInfo.Create;
//    FDeviceInfo.dType := 'Q';
//    FDeviceInfo.dName := '·ÑÉ­';
//    FDeviceInfo.dLink := i div 2;
//    FDeviceInfo.dCommond := '0A 0D 0F';
//  end;

  FComGroupList := TList.Create;

  comLista := TStringList.Create;
  comLista.Add('2');
  comLista.Add('3');
  FCom32a := THComm.Create(comLista);
  FCom32a.interval := 1000;
  FCom32a.sendData := '0A 0D 4B';
  FComGroupList.Add(FCom32a);

  comListb := TStringList.Create;
  comListb.Add('4');
  comListb.Add('5');
  comListb.Add('6');
  FCom32b := THComm.Create(comListb);
  FCom32b.interval := 1000;
  FCom32b.sendData := 'FA FB FC FD';
  FComGroupList.Add(FCom32b);
end;

procedure saveToJson(data: string);
begin

end;

end.
