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
  cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxNavBarCollns, cxClasses,
  dxNavBarBase, dxNavBar, dxNavBarGroupItems,
  Vcl.ExtCtrls, HCom32, HNet, HDeviceInfo, HTool;

type
  TFMainPage = class(TForm)
    setBtn: TButton;
    dxNavBar1: TdxNavBar;
    dxNavBar1Group1: TdxNavBarGroup;
    dxNavBar1Group2: TdxNavBarGroup;
    dxNavBar1Group3: TdxNavBarGroup;
    dxNavBar1Group4: TdxNavBarGroup;
    dxNavBar1Separator1: TdxNavBarSeparator;
    dxNavBar1Item1: TdxNavBarItem;
    dxNavBar1Item2: TdxNavBarItem;
    dxNavBar1Separator2: TdxNavBarSeparator;
    dxNavBar1Item3: TdxNavBarItem;
    dxNavBar1Item4: TdxNavBarItem;
    dxNavBar1Item5: TdxNavBarItem;
    dxNavBar1Item6: TdxNavBarItem;
    dxNavBar1Item7: TdxNavBarItem;
    dxNavBar1Separator3: TdxNavBarSeparator;
    dxNavBar1Item8: TdxNavBarItem;
    procedure setBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FMainPage: TFMainPage;

implementation
uses HDeviceDo,HCustomerSetting;
{$R *.dfm}

procedure TFMainPage.FormCreate(Sender: TObject);
begin
//
end;

procedure TFMainPage.setBtnClick(Sender: TObject);
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

procedure saveToJson(data: string);
begin

end;

end.
