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
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxNavBarCollns, cxClasses,
  dxNavBar, dxNavBarGroupItems, Vcl.ExtCtrls, cxSplitter, dxBarBuiltInMenu, cxPC,
  HBizBasePage, HRoom1, Data.DB, Datasnap.DBClient, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkroom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  dxSkinXmas2008Blue, MidasLib;

type
  TFMainPage = class(TForm)
    dxNavBar1: TdxNavBar;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure InitNavBar();
    procedure InitData;
    procedure itemClick(Sender: TObject);
  public
    { Public declarations }
  private
    fData: TClientdataset;
  end;

var
  FMainPage: TFMainPage;
  FLoadForm: TBizBasePage;

implementation


{$R *.dfm}

procedure TFMainPage.FormCreate(Sender: TObject);
begin
  InitNavBar;
  InitData;
end;

procedure TFMainPage.InitData;
var
  i: Integer;
begin
  fData := TClientDataSet.Create(self);
  fData.FieldDefs.Clear;
  fData.FieldDefs.Add('Name', ftString, 10);
  fData.FieldDefs.Add('Age', ftInteger, 0);
  fData.CreateDataSet;
  with fData do
  begin
    DisableControls;
    for i := 1 to 1000 do
    begin
      Append;
      FieldByName('Name').AsString := 'User' + IntToStr(i);
      FieldByName('Age').AsInteger := Random(100);
      Post;
    end;
    EnableControls;
  end;
  fData.Open;
end;

procedure TFMainPage.InitNavBar();
var
  tempitem: TdxnavbarItem;
  tempgroup: Tdxnavbargroup;
begin
  dxNavBar1.Items.Clear;

  tempgroup := dxNavBar1.Groups.Add;
  tempgroup.Caption := '展示区域';

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '区域一';
  tempitem.Tag := 1001;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '区域二';
  tempitem.Tag := 1002;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '区域三';
  tempitem.Tag := 1003;
  tempitem.OnClick := itemClick;
  tempgroup.CreateLink(tempitem);

end;

procedure TFMainPage.itemClick(Sender: TObject);
var
  Tag: Integer;
  tempitem: TdxnavbarItem;
begin
  tempitem :=  TdxnavbarItem(Sender);
  Tag := tempitem.Tag;
  cxPageControl1.ActivePage := cxTabSheet1;
  cxTabSheet1.Caption := tempitem.Caption;
  TRoomPage.loadSelf(FLoadForm, cxTabSheet1, alClient);
end;

end.

