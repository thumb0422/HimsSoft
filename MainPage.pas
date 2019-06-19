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
    ComboBox1: TComboBox;
    getComms: TButton;
    Memo1: TMemo;
    Edit1: TEdit;
    hexTstrTransBtn: TButton;
    strToHexTransBtn: TButton;
    setBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure comtestClick(Sender: TObject);
    procedure comstopClick(Sender: TObject);
    procedure comstartClick(Sender: TObject);
    procedure getCommsClick(Sender: TObject);
    procedure hexTstrTransBtnClick(Sender: TObject);
    procedure strToHexTransBtnClick(Sender: TObject);
    procedure setBtnClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses HDeviceDo,HCustomerSetting;
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  ComboBox1.Clear;
end;

procedure TForm1.getCommsClick(Sender: TObject);
begin
  ComboBox1.Items.AddStrings(THComm.getAllCommPorts);
end;

procedure TForm1.comtestClick(Sender: TObject);
begin
  TDeviceAct.GetInstance.initTestData;
end;

procedure TForm1.setBtnClick(Sender: TObject);
var f:ThsCustomerSetting;
begin
   //弹窗到设置用户页面
  f:=ThsCustomerSetting.Create(nil);
  try
    if f.ShowModal = mrOk then
    begin
      Caption:='OK';
    end
    else
    begin
      Caption :='Cancle';
    end;
  finally
    f.Release;
  end;
end;

procedure TForm1.comstartClick(Sender: TObject);
begin
  TDeviceAct.GetInstance.startTestData;
end;

procedure TForm1.comstopClick(Sender: TObject);
begin

  TDeviceAct.GetInstance.stopTestData;
end;

procedure TForm1.strToHexTransBtnClick(Sender: TObject);
begin
  Memo1.Lines.Add(TTool.HexToString(Edit1.Text));
end;

procedure TForm1.hexTstrTransBtnClick(Sender: TObject);
begin
  Memo1.Lines.Add(TTool.StringToHex(Edit1.Text));
end;

procedure saveToJson(data: string);
begin

end;

end.
