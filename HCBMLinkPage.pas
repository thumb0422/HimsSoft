{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       °æÈ¨ËùÓÐ (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HCBMLinkPage;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms,cxButtons, Vcl.ExtCtrls,
  DBGridEh, Data.DB, Datasnap.DBClient, cxGraphics, cxLookAndFeels,
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
  dxSkinXmas2008Blue, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh, Vcl.StdCtrls;

type
  THCBMLinkPage = class(TForm)
    Panel1: TPanel;
    saveBtn: TcxButton;
    cancelBtn: TcxButton;
    dataGrid: TDBGridEh;
    custCDS: TClientDataSet;
    bedCDS: TClientDataSet;
    mechineCDS: TClientDataSet;
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
    dataDS: TDataSource;
    addBtn: TcxButton;
    editBtn: TcxButton;
    delBtn: TcxButton;
    procedure saveBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure custGridCellClick(Column: TColumnEh);
    procedure addBtnClick(Sender: TObject);
    procedure editBtnClick(Sender: TObject);
    procedure delBtnClick(Sender: TObject);
    procedure cancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HCBMLink: THCBMLinkPage;

implementation
uses HCBMLinkAddPage;
{$R *.dfm}

procedure THCBMLinkPage.addBtnClick(Sender: TObject);
var form:TCBMLinkAddPage;
    data :TClientDataSet;
begin
  form := TCBMLinkAddPage.Create(nil);
  if form.ShowModal = mrOk then
  begin
    with dataCDS do
    begin
      Append;
      FieldByName('MCustomerId').AsString := form.dataCDS.FieldByName('MCustomerId').AsString;
      FieldByName('MCustomerName').AsString := form.dataCDS.FieldByName('MCustomerName').AsString;
      FieldByName('MBedId').AsString := form.dataCDS.FieldByName('MBedId').AsString;
      FieldByName('MId').AsString := form.dataCDS.FieldByName('MId').AsString;
      FieldByName('MDesc').AsString := form.dataCDS.FieldByName('MDesc').AsString;
      Post;
    end;
  end;
end;

procedure THCBMLinkPage.cancelBtnClick(Sender: TObject);
begin
//
end;

procedure THCBMLinkPage.custGridCellClick(Column: TColumnEh);
begin
//
end;

procedure THCBMLinkPage.delBtnClick(Sender: TObject);
begin
//
end;

procedure THCBMLinkPage.editBtnClick(Sender: TObject);
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

  delBtn.Enabled := dataCDS.RecordCount >0 ;
  editBtn.Enabled := dataCDS.RecordCount >0 ;
end;

procedure THCBMLinkPage.saveBtnClick(Sender: TObject);
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
