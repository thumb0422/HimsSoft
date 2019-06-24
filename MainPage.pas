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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxNavBarCollns,
  cxClasses, dxNavBarBase, dxNavBar, dxNavBarGroupItems, Vcl.ExtCtrls, HCom32,
  HNet, HDeviceInfo, HTool, cxSplitter, System.Generics.Collections,
  HBizBasePage, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkroom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringtime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinTheBezier, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxBarBuiltInMenu, cxPC;

type
  TFMainPage = class(TForm)
    dxNavBar1: TdxNavBar;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure InitNavBar();
    procedure itemClick(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FMainPage: TFMainPage;
  FLoadForm: TBizBasePage;

implementation

uses
  HDeviceDo, HCustomerSetting, HForm1, HForm2;
{$R *.dfm}

procedure TFMainPage.FormCreate(Sender: TObject);
begin
  InitNavBar;
end;

procedure TFMainPage.InitNavBar();
var
  tempitem: TdxnavbarItem;
  tempgroup: Tdxnavbargroup;
begin
  dxNavBar1.Items.Clear;
  tempgroup := dxNavBar1.Groups.Add;
  tempgroup.Caption := '一线城市';

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '北京';
  tempitem.Tag := 1001;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '上海';
  tempitem.Tag := 1002;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '深圳';
  tempitem.Tag := 1003;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '广州';
  tempitem.Tag := 1004;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempgroup := dxNavBar1.Groups.Add;
  tempgroup.Caption := '二线城市';

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '杭州';
  tempitem.Tag := 2001;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '武汉';
  tempitem.Tag := 2002;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '南京';
  tempitem.Tag := 2003;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempgroup := dxNavBar1.Groups.Add;
  tempgroup.Caption := '三线城市';

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '无锡';
  tempitem.Tag := 3001;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '珠海';
  tempitem.Tag := 3002;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '呼和浩特';
  tempitem.Tag := 3003;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '湖州';
  tempitem.Tag := 3004;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '三亚';
  tempitem.Tag := 3005;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '莆田';
  tempitem.Tag := 3006;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);
end;

procedure TFMainPage.itemClick(Sender: TObject);
var
  tag: Integer;
begin
  cxPageControl1.ActivePage := cxTabSheet1;
  TForm1.loadSelf(FLoadForm, cxTabSheet1, alClient);

//  tag := TdxNavBarItem(Sender).tag;
//  if ((tag mod 2) = 0) then
//  begin
//    cxPageControl1.ActivePage := cxTabSheet1;
//    TForm1.loadSelf(FLoadForm, cxTabSheet1, alClient);
//  end
//  else
//  begin
//    cxPageControl1.ActivePage := cxTabSheet2;
//    TForm2.loadSelf(FLoadForm, cxTabSheet2, alClient);
//  end;
end;

end.

