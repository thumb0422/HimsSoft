{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       ��Ȩ���� (C) 2019 thumb0422@163.com             }
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
    cancelBtn: TcxButton;
    dataGrid: TDBGridEh;
    dataCDS: TClientDataSet;
    dataDS: TDataSource;
    addBtn: TcxButton;
    delBtn: TcxButton;
    dataCDSMCustId: TStringField;
    dataCDSMCustName: TStringField;
    dataCDSMRoomId: TStringField;
    dataCDSMBedId: TStringField;
    dataCDSMMechineId: TStringField;
    dataCDSMMechineDesc: TStringField;
    dataCDSMCom: TBooleanField;
    dataCDSMNet: TBooleanField;
    dataCDSMHDBox: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure custGridCellClick(Column: TColumnEh);
    procedure addBtnClick(Sender: TObject);
    procedure delBtnClick(Sender: TObject);
    procedure cancelBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure queryAllData;
  public
    { Public declarations }
  end;

var
  HCBMLink: THCBMLinkPage;

implementation
uses HCBMLinkAddPage,HDBManager,superobject;
{$R *.dfm}

procedure THCBMLinkPage.addBtnClick(Sender: TObject);
var form:TCBMLinkAddPage;
    data :TClientDataSet;
begin
  form := TCBMLinkAddPage.Create(nil);
  if form.ShowModal = mrOk then
  begin
    queryAllData;
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
var
  sql:string;
  sqlList:TStringList;
begin
  sqlList := TStringList.Create;
  sql := Format('Delete from H_CBMData where MCustId =%s',[QuotedStr(dataCDS.FieldByName('MCustId').AsString)]);
  sqlList.Add(sql);
  TDBManager.Instance.execSql(sqlList);
  queryAllData;
end;

procedure THCBMLinkPage.FormCreate(Sender: TObject);
begin
  inherited;
  dataCDS.CreateDataSet;
  queryAllData;
end;

procedure THCBMLinkPage.queryAllData;
var
  jsonData: ISuperObject;
  subData: ISuperObject;
  sql :string;
begin
  dataCDS.Close;
  sql :='SELECT C.MCustId,C.MCustName,B.MRoomId,B.MBedId,M.MMechineId,M.MMechineDesc,M.MCom,M.MNet,M.MHDBox ' +
        'from H_CBMData D LEFT JOIN H_CustomerInfo C LEFT JOIN H_BedInfo B LEFT JOIN H_MechineInfo M ' +
        'where D.MCustId = C.MCustId AND D.MBedId = B.MBedId AND D.MMechineId = M.MMechineId';
  jsonData := TDBManager.Instance.getDataBySql(sql);
  with dataCDS do
  begin
    Open;
    EmptyDataSet;
    if jsonData.I['rowCount'] > 0 then
    begin
      for subData in jsonData['data'] do
      begin
        Append;
        dataCDS.FieldByName('MCustId').AsString := subData.S['MCustId'];
        dataCDS.FieldByName('MCustName').AsString := subData.S['MCustName'];
        dataCDS.FieldByName('MRoomId').AsString := subData.S['MRoomId'];
        dataCDS.FieldByName('MBedId').AsString := subData.S['MBedId'];
        dataCDS.FieldByName('MMechineId').AsString := subData.S['MMechineId'];
        dataCDS.FieldByName('MMechineDesc').AsString := subData.S['MMechineDesc'];
        dataCDS.FieldByName('MCom').AsBoolean := not (subData['MCom'].AsInteger = 0);
        dataCDS.FieldByName('MNet').AsBoolean := not (subData['MNet'].AsInteger = 0);
        dataCDS.FieldByName('MHDBox').AsBoolean := not (subData['MHDBox'].AsInteger = 0);
        Post;
      end;
    end;
  end;
  delBtn.Enabled := dataCDS.RecordCount > 0 ;
end;

end.
