{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       ∞Ê»®À˘”– (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HCBMLinkAddPage;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, cxButtons, Vcl.ExtCtrls, Data.DB,
  Datasnap.DBClient,
  cxLabel,
  Vcl.DBCtrls, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue, cxControls, cxContainer, cxEdit,
  Vcl.StdCtrls;

type
  TCBMLinkAddPage = class(TForm)
    custCDS: TClientDataSet;
    custCDSMCustomerId: TStringField;
    custCDSMCustomerName: TStringField;
    bedCDS: TClientDataSet;
    bedCDSMBedId: TStringField;
    mechineCDS: TClientDataSet;
    mechineCDSMId: TStringField;
    mechineCDSMDesc: TStringField;
    dataCDS: TClientDataSet;
    dataCDSMCustomerId: TStringField;
    dataCDSMCustomerName: TStringField;
    dataCDSMBedId: TStringField;
    dataCDSMId: TStringField;
    dataCDSMDesc: TStringField;
    Panel1: TPanel;
    cxSave: TcxButton;
    cancelBtn: TcxButton;
    cxLabel1: TcxLabel;
    custDS: TDataSource;
    mechineDS: TDataSource;
    bedDS: TDataSource;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    custCombox: TDBLookupComboBox;
    bedCombox: TDBComboBox;
    mechineCombox: TDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure cxSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CBMLinkAddPage: TCBMLinkAddPage;

implementation

{$R *.dfm}

procedure TCBMLinkAddPage.cxSaveClick(Sender: TObject);
begin
  with dataCDS do
  begin
    Append;
    FieldByName('MCustomerId').AsString := custCDS.FieldByName('MCustomerId').AsString;
    FieldByName('MCustomerName').AsString := custCDS.FieldByName('MCustomerName').AsString;
    FieldByName('MBedId').AsString := bedCombox.Text;
    FieldByName('MId').AsString := mechineCDS.FieldByName('MId').AsString;
    FieldByName('MDesc').AsString := mechineCDS.FieldByName('MDesc').AsString;
    Post;
  end;
  ModalResult := mrOk;
end;

procedure TCBMLinkAddPage.FormCreate(Sender: TObject);
var
  lDtaFile: string;
begin
  inherited;
  dataCDS.CreateDataSet;
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

  with bedCDS do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
      bedCombox.Items.Add(bedCDS.FieldByName('MBedId').AsString);
      Next;
    end;
    EnableControls;
  end;

  mechineCDS.CreateDataSet;
  lDtaFile := ExtractFilePath(paramstr(0)) + 'mechine.xml';
  if FileExists(lDtaFile) then
  begin
    mechineCDS.LoadFromFile(lDtaFile);
  end;
end;

end.
