{ ******************************************************* }
{ }
{ HimsSoft }
{ }
{ 版权所有 (C) 2019 thumb0422@163.com }
{ }
{ ******************************************************* }

unit MainPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls, HCom32, HNet, HDeviceInfo, HTool;

type
  TForm1 = class(TForm)
    comtest: TButton;
    comstart: TButton;
    comstop: TButton;
    netTest: TButton;
    netStart: TButton;
    netStop: TButton;
    ComboBox1: TComboBox;
    getComms: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    hexTstrTransBtn: TButton;
    strToHexTransBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure comtestClick(Sender: TObject);
    procedure comstopClick(Sender: TObject);
    procedure netTestClick(Sender: TObject);
    procedure netStopClick(Sender: TObject);
    procedure netStartClick(Sender: TObject);
    procedure comstartClick(Sender: TObject);
    procedure getCommsClick(Sender: TObject);
    procedure hexTstrTransBtnClick(Sender: TObject);
    procedure strToHexTransBtnClick(Sender: TObject);
  private
    { Private declarations }
    FComGroupList: TList;
    FCom32: THComm;
    FNet: TNet;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  i, n: Integer;
  deviceInfo: TDeviceInfo;
begin
  FComGroupList := TList.Create;

  for i := 2 to 5 do
  begin
    deviceInfo := TDeviceInfo.Create;
    deviceInfo.dType := 'B';
    deviceInfo.dBrand := 'Bellco';
    deviceInfo.dDesc := '贝尔克' + IntToStr(i);
    deviceInfo.dCommond := '4B 0D 0A';
    deviceInfo.dLink := dtlComm;
    deviceInfo.dName := 'COM' + IntToStr(i);
    deviceInfo.dPort := 9600;
    deviceInfo.dTag := 1 * 100 + i;
    FComGroupList.Add(deviceInfo);
  end;

  for i := 0 to 1 do
  begin
    deviceInfo := TDeviceInfo.Create;
    deviceInfo.dType := 'F';
    deviceInfo.dBrand := 'Fresenius';
    deviceInfo.dDesc := '费森' + IntToStr(i);
    deviceInfo.dCommond := '0A 0B 0C ' + IntToStr(i);
    deviceInfo.dLink := dtlNet;
    deviceInfo.dName := '172.16.26.129';
    deviceInfo.dPort := 6666 + i;
    deviceInfo.dTag := 2 * 100 + i;
    FComGroupList.Add(deviceInfo);
  end;
  n := FComGroupList.Count;

  ComboBox1.Clear;
end;

procedure TForm1.getCommsClick(Sender: TObject);
begin
  ComboBox1.Items.AddStrings(THComm.getAllCommPorts);
end;

procedure TForm1.comtestClick(Sender: TObject);
begin
  FCom32 := THComm.Create(FComGroupList);
  FCom32.cInterval := 4000;
  FCom32.init;
end;

procedure TForm1.comstartClick(Sender: TObject);
begin
  FCom32.send;
end;

procedure TForm1.comstopClick(Sender: TObject);
begin
  FCom32.close;
end;

procedure TForm1.netTestClick(Sender: TObject);
begin
  FNet := TNet.Create(FComGroupList);
  FNet.cInterval := 1000;
  FNet.init;
end;

procedure TForm1.strToHexTransBtnClick(Sender: TObject);
begin
  Memo1.Lines.Add(TTool.HexToString(Edit1.Text));
end;

procedure TForm1.hexTstrTransBtnClick(Sender: TObject);
begin
  Memo1.Lines.Add(TTool.StringToHex(Edit1.Text));
end;

procedure TForm1.netStartClick(Sender: TObject);
begin
  FNet.send;
end;

procedure TForm1.netStopClick(Sender: TObject);
begin
  FNet.close;
end;

procedure saveToJson(data: string);
begin

end;

end.
