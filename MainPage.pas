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
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxNavBarCollns, cxClasses,
  dxNavBar, dxNavBarGroupItems, Vcl.ExtCtrls, cxSplitter, dxBarBuiltInMenu,
  cxPC,
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
  dxSkinXmas2008Blue, MidasLib, cxScrollBox;

type
  TFMainPage = class(TForm)
    dxNavBar1: TdxNavBar;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxScrollBox1: TcxScrollBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure InitNavBar();
    procedure InitData;
    procedure InitRight;
    procedure itemClick(Sender: TObject);
  public
    { Public declarations }
  private
    fData: TClientdataset;
  end;

var
  FMainPage: TFMainPage;
  FLoadForm: TBizBasePage;
  FMenuList: TList;

implementation

uses HMenu,HDataDetailView;
{$R *.dfm}

procedure TFMainPage.FormCreate(Sender: TObject);
begin
  InitRight;
  InitData;
  InitNavBar;
end;

procedure TFMainPage.InitRight;
var rightView :TDataDetailView;
begin
  rightView := TDataDetailView.Create(Self);
  rightView.Name := 'DataDetailView';
  rightView.Caption :='';
  rightView.Align := alClient;
  rightView.Parent := cxScrollBox1;
end;

procedure TFMainPage.InitData;
var
  lMenu: TMenu;
  m: Integer;
begin
  fData := TClientdataset.Create(self);
  fData.FieldDefs.Clear;
  fData.FieldDefs.Add('MID', ftInteger, 0); // ID
  fData.FieldDefs.Add('MDesc', ftString, 30); // 显示Caption
  fData.FieldDefs.Add('MParent', ftInteger, 0); // 父类
  fData.FieldDefs.Add('MVisible', ftInteger, 0); // 是否显示
  fData.CreateDataSet;

  FMenuList := TList.Create;
  begin
    lMenu := TMenu.Create;
    lMenu.MID := 1000;
    lMenu.MDesc := '展示区域';
    lMenu.MParent := 0;
    lMenu.MVisible := 1;
    FMenuList.Add(lMenu);

    lMenu := TMenu.Create;
    lMenu.MID := 1001;
    lMenu.MDesc := '区域一';
    lMenu.MParent := 1000;
    lMenu.MVisible := 1;
    FMenuList.Add(lMenu);

    lMenu := TMenu.Create;
    lMenu.MID := 2000;
    lMenu.MDesc := '设置';
    lMenu.MParent := 0;
    lMenu.MVisible := 1;
    FMenuList.Add(lMenu);

    lMenu := TMenu.Create;
    lMenu.MID := 2001;
    lMenu.MDesc := '用户设置';
    lMenu.MParent := 2000;
    lMenu.MVisible := 1;
    FMenuList.Add(lMenu);
  end;

  with fData do
  begin
    DisableControls;
    for m := 0 to FMenuList.Count - 1 do
    begin
      lMenu := FMenuList[m];
      Append;
      FieldByName('MID').AsInteger := lMenu.MID;
      FieldByName('MDesc').AsString := lMenu.MDesc;
      FieldByName('MParent').AsInteger := lMenu.MParent;
      FieldByName('MVisible').AsInteger := lMenu.MVisible;
      Post;
    end;
    EnableControls;
  end;
end;

procedure TFMainPage.InitNavBar();
var
  tempitem: TdxnavbarItem;
  tempgroup: Tdxnavbargroup;
begin
  dxNavBar1.Items.Clear;

  if fData.Active = False then
  begin
    fData.Active := True;
  end;

  with fData do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
      if FieldByName('MParent').AsInteger = 0 then
      begin
        tempgroup := dxNavBar1.Groups.Add;
        tempgroup.Caption := FieldByName('MDesc').AsString;
      end
      else
      begin
        tempitem := dxNavBar1.Items.Add;
        tempitem.Caption := FieldByName('MDesc').AsString;
        tempitem.Tag := FieldByName('MID').AsInteger;
        tempitem.OnClick := itemClick;
        tempgroup.CreateLink(tempitem);
      end;
      Next;
    end;
    EnableControls;
  end;
end;

procedure TFMainPage.itemClick(Sender: TObject);
var
  Tag: Integer;
  tempitem: TdxnavbarItem;
begin
  tempitem := TdxnavbarItem(Sender);
  Tag := tempitem.Tag;
  cxPageControl1.ActivePage := cxTabSheet1;
  cxTabSheet1.Caption := tempitem.Caption;
  TRoomPage.loadSelf(FLoadForm, cxTabSheet1, alClient);
end;

end.
