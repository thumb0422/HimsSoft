{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       °æÈ¨ËùÓÐ (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HCustomerSetPage;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Controls, Vcl.Forms, HBizBasePage, Data.DB,
  Datasnap.DBClient,
  cxButtons, Vcl.ExtCtrls,
  DBGridEh, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkroom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringtime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinTheBezier,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVisualStudio2013Blue,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh, Vcl.StdCtrls;

type
  TCustomerSetPage = class(TBizBasePage)
    Panel1: TPanel;
    saveBtn: TcxButton;
    cancelBtn: TcxButton;
    DBGridEh1: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    ClientDataSet1MCustomerId: TStringField;
    ClientDataSet1MCustomerName: TStringField;
    ClientDataSet1MSex: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure cancelBtnClick(Sender: TObject);
    procedure saveBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CustomerSetPage: TCustomerSetPage;

implementation

{$R *.dfm}

procedure TCustomerSetPage.FormCreate(Sender: TObject);
var
  lDtaFile: string;
  lMDataFile :string;
begin
  inherited;
  ClientDataSet1.CreateDataSet;
  lDtaFile := ExtractFilePath(paramstr(0)) + 'customer.xml';
  if FileExists(lDtaFile) then
  begin
    ClientDataSet1.LoadFromFile(lDtaFile);
  end;

  if ClientDataSet1.Active = False then
  begin
    ClientDataSet1.Open;
  end;
end;

procedure TCustomerSetPage.saveBtnClick(Sender: TObject);
var
  lDtaFile: string;
begin
  lDtaFile := ExtractFilePath(paramstr(0)) + 'customer.xml';
  if (ClientDataSet1.State in [dsInsert,dsEdit]) then
    ClientDataSet1.Post;
  if ClientDataSet1.RecordCount > 0 then
  begin
    ClientDataSet1.SaveToFile(lDtaFile);
  end;
end;

procedure TCustomerSetPage.cancelBtnClick(Sender: TObject);
begin
  inherited;
//
end;
end.
