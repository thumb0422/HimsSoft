unit HCBMLinkPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkroom, dxSkinDarkSide,
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
  dxSkinXmas2008Blue, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh,
  DBGridEh, Data.DB, Datasnap.DBClient;

type
  THCBMLinkPage = class(TForm)
    Panel1: TPanel;
    generateBtn: TcxButton;
    cancelBtn: TcxButton;
    custGrid: TDBGridEh;
    mechineGrid: TDBGridEh;
    bedGrid: TDBGridEh;
    dataGrid: TDBGridEh;
    custDS: TDataSource;
    custCDS: TClientDataSet;
    bedDS: TDataSource;
    bedCDS: TClientDataSet;
    mechineDS: TDataSource;
    mechineCDS: TClientDataSet;
    dataDS: TDataSource;
    dataCDS: TClientDataSet;
    custCDSMCustomerId: TStringField;
    custCDSMCustomerName: TStringField;
    bedCDSMBedId: TStringField;
    mechineCDSMId: TStringField;
    mechineCDSMDesc: TStringField;
    dataCDSMCustomerId: TStringField;
    dataCDSMCustomerName: TStringField;
    dataCDSMBedId: TStringField;
    dataCDSMId: TStringField;
    dataCDSMDesc: TStringField;
    procedure generateBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure custGridCellClick(Column: TColumnEh);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HCBMLink: THCBMLinkPage;

implementation

{$R *.dfm}

procedure THCBMLinkPage.custGridCellClick(Column: TColumnEh);
begin
//
end;

procedure THCBMLinkPage.FormCreate(Sender: TObject);
var
  lDtaFile: string;
begin
  inherited;
  custCDS.CreateDataSet;
  lDtaFile := ExtractFilePath(paramstr(0)) + 'customer.xml';
  if FileExists(lDtaFile) then
  begin
    custCDS.LoadFromFile(lDtaFile);
  end;

  bedCDS.CreateDataSet;
  lDtaFile := ExtractFilePath(paramstr(0)) + 'bed.xml';
  if FileExists(lDtaFile) then
  begin
    bedCDS.LoadFromFile(lDtaFile);
  end;

  mechineCDS.CreateDataSet;
  lDtaFile := ExtractFilePath(paramstr(0)) + 'mechine.xml';
  if FileExists(lDtaFile) then
  begin
    mechineCDS.LoadFromFile(lDtaFile);
  end;

  dataCDS.CreateDataSet;
  lDtaFile := ExtractFilePath(paramstr(0)) + 'linkData.xml';
  if FileExists(lDtaFile) then
  begin
    dataCDS .LoadFromFile(lDtaFile);
  end;
end;

procedure THCBMLinkPage.generateBtnClick(Sender: TObject);
var
  lDtaFile: string;
begin
  lDtaFile := ExtractFilePath(paramstr(0)) + 'linkData.xml';
  if (dataCDS.State in [dsInsert,dsEdit]) then
    dataCDS.Post;
  if dataCDS.RecordCount > 0 then
  begin
    dataCDS.SaveToFile(lDtaFile);
  end;
end;

end.
