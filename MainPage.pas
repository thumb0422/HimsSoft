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
  System.Classes,Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,Data.DB, Datasnap.DBClient,MidasLib,
  cxGraphics,cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxNavBarCollns, cxClasses,
  dxNavBar, dxNavBarGroupItems, Vcl.ExtCtrls, cxSplitter, dxBarBuiltInMenu,
  cxPC,dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkroom,
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
  dxSkinXmas2008Blue, cxScrollBox, Vcl.StdCtrls,
  HBizBasePage, HRoom1,HSettingPage;

type
  TFMainPage = class(TForm)
    dxNavBar1: TdxNavBar;
    cxPageControl1: TcxPageControl;
    procedure FormCreate(Sender: TObject);
    procedure cxPageControl1CanClose(Sender: TObject; var ACanClose: Boolean);
    procedure cxPageControl1CanCloseEx(Sender: TObject; ATabIndex: Integer;
      var ACanClose: Boolean);
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
  FMenuList: TList;

implementation

uses HMenu, HDataDetailView;
{$R *.dfm}

procedure TFMainPage.cxPageControl1CanClose(Sender: TObject;
  var ACanClose: Boolean);
begin
  ACanClose := True;
end;

procedure TFMainPage.cxPageControl1CanCloseEx(Sender: TObject;
  ATabIndex: Integer; var ACanClose: Boolean);
begin
  // Writeln('-----'+IntToStr(ATabIndex));
  ACanClose := True;
end;

procedure TFMainPage.FormCreate(Sender: TObject);
begin
  InitData;
  InitNavBar;
end;

procedure TFMainPage.InitData;
var
  lMenu: TMenu;
  m: Integer;
begin
  fData := TClientdataset.Create(Self);
  fData.FieldDefs.Clear;
  fData.FieldDefs.Add('MID', ftInteger, 0); // ID
  fData.FieldDefs.Add('MDesc', ftString, 30); // 显示Caption
  fData.FieldDefs.Add('MParent', ftInteger, 0); // 父类
  fData.FieldDefs.Add('MVisible', ftInteger, 0); // 是否显示
  fData.FieldDefs.Add('MClass', ftString, 100); // 显示的className
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
    lMenu.MClass := 'TRoomPage';
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
    lMenu.MClass := 'TSettingPage';
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
      FieldByName('MClass').AsString := lMenu.MClass;
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
        tempitem.Name := FieldByName('MClass').AsString;
        tempgroup.CreateLink(tempitem);
      end;
      Next;
    end;
    EnableControls;
  end;
end;

procedure TFMainPage.itemClick(Sender: TObject);
var
  litem: TdxnavbarItem;
  I: Integer;
  lTabSheet :TcxTabSheet;
  tabSheetCaption,itemCaption:string;
begin
  litem := TdxnavbarItem(Sender);
  lTabSheet := nil;
  for I := 0 to cxPageControl1.TabCount-1 do
  begin
    tabSheetCaption := cxPageControl1.Pages[I].Name;
    itemCaption := litem.Name;
    if tabSheetCaption.Contains(itemCaption) then
    begin
      lTabSheet := cxPageControl1.Pages[I];
      Break;
    end;
  end;
  if not Assigned(lTabSheet) then
  begin
    lTabSheet := TcxTabSheet.Create(Self);
    with lTabSheet do
    begin
      Visible := True;
      Caption := litem.Caption;
      Name := litem.Name + 'sheet';
      PageControl := cxPageControl1;
    end;
  end;
  cxPageControl1.ActivePage := lTabSheet;
  if litem.Tag < 2000 then
  begin
    TRoomPage.loadSelf(lTabSheet, alClient);
  end
  else
  begin
    TSettingPage.loadSelf(lTabSheet, alClient);
  end;
end;

end.
