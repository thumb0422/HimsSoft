{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HCBMLinkPage;

interface

uses
  System.SysUtils, System.Classes,Winapi.Windows,
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
    dataCDSMLink: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure custGridCellClick(Column: TColumnEh);
    procedure addBtnClick(Sender: TObject);
    procedure delBtnClick(Sender: TObject);
    procedure cancelBtnClick(Sender: TObject);
  private
    { Private declarations }
    curDate:string;
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
  sql: string;
  sqlList: TStringList;
  jsonData: ISuperObject;
begin
  sql := Format
    ('SELECT M.* from H_Data_Main M LEFT JOIN H_CBMData D WHERE 1=1 AND M.MCustId = %s AND M.MCureDate = %s And M.MCustId = D.MCustId',
    [QuotedStr(dataCDS.FieldByName('MCustId').AsString), QuotedStr(curDate)]);
  jsonData := TDBManager.Instance.getDataBySql(sql);
  sqlList := TStringList.Create;
  if jsonData.I['rowCount'] > 0 then
  begin
    case Application.MessageBox('存在当天诊疗记录,是否继续删除?', '提示',
      MB_OKCANCEL + MB_ICONQUESTION) of
      IDOK:
        begin
          sql := Format('DELETE FROM H_Data_Detail  WHERE 1=1 ' +
            'AND DId in (SELECT D.DId FROM H_Data_Detail D LEFT JOIN H_Data_Main M '+
            'WHERE 1=1 AND M.MCustId = %s AND D.DId = M.DId AND M.MCureDate=%s)',
            [QuotedStr(dataCDS.FieldByName('MCustId').AsString),
            QuotedStr(curDate)]);
          sqlList.Add(sql);

          sql := Format
            ('DELETE FROM H_Data_Main WHERE 1=1 and MCustId = %s and MCureDate =%s ',
            [QuotedStr(dataCDS.FieldByName('MCustId').AsString),
            QuotedStr(curDate)]);
          sqlList.Add(sql);
        end;
      IDCANCEL:
        begin

        end;
    end;
  end;
  sql := Format
    ('Delete from H_Bed_States where 1=1 and MBedId = %s and MUsedDate =%s ',
    [QuotedStr(dataCDS.FieldByName('MBedId').AsString), QuotedStr(curDate)]);
  sqlList.Add(sql);

  sql := Format
    ('Delete from H_Mechine_States where 1=1 and MMechineId = %s and MUsedDate =%s ',
    [QuotedStr(dataCDS.FieldByName('MMechineId').AsString),
    QuotedStr(curDate)]);
  sqlList.Add(sql);

  sql := Format
    ('Delete from H_Customer_States where 1=1 and MCustId = %s and MUsedDate =%s ',
    [QuotedStr(dataCDS.FieldByName('MCustId').AsString), QuotedStr(curDate)]);
  sqlList.Add(sql);

  sql := Format('Delete from H_CBMData where MCustId =%s And MCureDate = %s',
    [QuotedStr(dataCDS.FieldByName('MCustId').AsString), QuotedStr(curDate)]);
  sqlList.Add(sql);

  TDBManager.Instance.execSql(sqlList);
  queryAllData;
end;

procedure THCBMLinkPage.FormCreate(Sender: TObject);
begin
  inherited;
  curDate := FormatDateTime('yyyy-mm-dd',Now);
  dataCDS.CreateDataSet;
  queryAllData;
end;

procedure THCBMLinkPage.queryAllData;
var
  jsonData: ISuperObject;
  subData: ISuperObject;
  sql :string;
  keyStrings,valuesStrings:TStrings;
begin
  dataCDS.Close;
  sql :=Format('SELECT C.MCustId,C.MCustName,B.MRoomId,B.MBedId,M.MMechineId,M.MMechineDesc,M.MLink ' +
               'from H_CBMData D LEFT JOIN H_CustomerInfo C LEFT JOIN H_BedInfo B LEFT JOIN H_MechineInfo M ' +
               'where D.MCureDate = %s And D.MCustId = C.MCustId AND D.MBedId = B.MBedId AND D.MMechineId = M.MMechineId',[QuotedStr(curDate)]);
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
        dataCDS.FieldByName('MLink').AsString := subData.S['MLink'];
        Post;
      end;
    end;
  end;
  delBtn.Enabled := dataCDS.RecordCount > 0 ;
    keyStrings := TStringList.Create;
  keyStrings.CommaText :='10001001,10001002,10001003,10001004';

  valuesStrings := TStringList.Create;
  valuesStrings.CommaText :='串口,网口,HD-BOX,不支持';
  dataGrid.Columns[dataGrid.Columns.Count-1].KeyList:=keyStrings;
  dataGrid.Columns[dataGrid.Columns.Count-1].PickList:= valuesStrings;
end;

end.
