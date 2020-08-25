{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HCBMLinkAddPage;

interface

uses
  System.SysUtils, System.Classes,Winapi.Windows,
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
    bedCDS: TClientDataSet;
    bedCDSMBedId: TStringField;
    mechineCDS: TClientDataSet;
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
    custCDSMCustId: TStringField;
    custCDSMCustName: TStringField;
    mechineCDSMMechineId: TStringField;
    mechineCDSMMechineDesc: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure cxSaveClick(Sender: TObject);
  private
    curDate:string;
    function checkValidValue:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CBMLinkAddPage: TCBMLinkAddPage;

implementation
uses HDBManager,superobject;
{$R *.dfm}

function TCBMLinkAddPage.checkValidValue: Boolean;
var checkValue:Boolean;
begin
  checkValue := True;
  if bedCombox.Text = '' then
    checkValue := False;
  if custCombox.Text = '' then
    checkValue := False;
  if mechineCombox.Text = '' then
    checkValue := False;
  Result := checkValue;
end;

procedure TCBMLinkAddPage.cxSaveClick(Sender: TObject);
var
  sql:string;
  sqlList:TStringList;
begin
  if not checkValidValue then
  begin
    Application.MessageBox('请输入必填数据', '警告', MB_OK + MB_ICONWARNING);
    Exit;
  end;
  sqlList := TStringList.Create;
  sql := Format('Insert Into H_Bed_States (MBedId,MUsedDate) Values (%s,%s)',[QuotedStr(bedCDS.FieldByName('MBedId').AsString),QuotedStr(curDate)]);
  sqlList.Add(sql);

  sql := Format('Insert Into H_Mechine_States (MMechineId,MUsedDate) Values (%s,%s)',[QuotedStr(mechineCDS.FieldByName('MMechineId').AsString),QuotedStr(curDate)]);
  sqlList.Add(sql);

  sql := Format('Insert Into H_Customer_States (MCustId,MUsedDate) Values (%s,%s)',[QuotedStr(custCDS.FieldByName('MCustId').AsString),QuotedStr(curDate)]);
  sqlList.Add(sql);

  sql := Format('Delete from H_CBMData where MCustId =%s And MCureDate = %s',[QuotedStr(custCDS.FieldByName('MCustId').AsString),QuotedStr(curDate)]);
  sqlList.Add(sql);
  sql := Format('Insert Into H_CBMData (MCustId,MBedId,MMechineId,isValid,MCureDate) Values (%s,%s,%s,%d,%s)',
           [QuotedStr(custCDS.FieldByName('MCustId').AsString),
           QuotedStr(bedCDS.FieldByName('MBedId').AsString),
           QuotedStr(mechineCDS.FieldByName('MMechineId').AsString),1,
           QuotedStr(curDate)]);
  sqlList.Add(sql);
  TDBManager.Instance.execSql(sqlList);
  ModalResult := mrOk;
end;

procedure TCBMLinkAddPage.FormCreate(Sender: TObject);
var
  jsonData: ISuperObject;
  subData: ISuperObject;
  sql:string;
begin
  inherited;
  curDate := FormatDateTime('yyyy-mm-dd',Now);

  custCDS.CreateDataSet;
  sql := Format('Select C.MCustId,C.MCustName From H_CustomerInfo C Where 1 = 1 '+
                'AND C.isValid = 1 '+
                'AND C.MCustId NOT In (SELECT S.MCustId FROM H_Customer_States S WHERE S.MUsedDate = %s) '+
                'Order By C.MCustId',[QuotedStr(curDate)]);
  jsonData := TDBManager.Instance.getDataBySql(sql);
  with custCDS do
  begin
    if jsonData.I['rowCount'] > 0 then
    begin
      for subData in jsonData['data'] do
      begin
        Append;
        custCDS.FieldByName('MCustId').AsString := subData.S['MCustId'];
        custCDS.FieldByName('MCustName').AsString := subData['MCustName'].AsString;
        Post;
      end;
    end;
  end;
  if custCDS.Active = False then
  begin
    custCDS.Open;
  end;


  bedCDS.CreateDataSet;
  sql := Format('Select B.MBedId From H_BedInfo B Where 1 = 1 '+
                'AND B.isValid = 1 '+
                'AND B.MBedId NOT In (SELECT S.MBedId FROM H_Bed_States S WHERE S.MUsedDate = %s) ' +
                'Order By B.MBedId',[QuotedStr(curDate)]);
  jsonData := TDBManager.Instance.getDataBySql(sql);
  with bedCDS do
  begin
    if jsonData.I['rowCount'] > 0 then
    begin
      for subData in jsonData['data'] do
      begin
        Append;
        bedCDS.FieldByName('MBedId').AsString := subData.S['MBedId'];
        Post;
      end;
    end;
  end;
  if bedCDS.Active = False then
  begin
    bedCDS.Open;
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
  sql := Format('Select B.MMechineId,B.MMechineDesc From H_MechineInfo B Where 1=1 '+
                'AND B.isValid = 1 '+
                'AND B.MMechineId NOT In (SELECT S.MMechineId FROM H_Mechine_States S WHERE S.MUsedDate = %s) '+
                'Order By B.MMechineId',[QuotedStr(curDate)]);
  jsonData := TDBManager.Instance.getDataBySql(sql);
  with mechineCDS do
  begin
    if jsonData.I['rowCount'] > 0 then
    begin
      for subData in jsonData['data'] do
      begin
        Append;
        mechineCDS.FieldByName('MMechineId').AsString := subData.S['MMechineId'];
        mechineCDS.FieldByName('MMechineDesc').AsString := subData['MMechineDesc'].AsString;
        Post;
      end;
    end;
  end;
  if mechineCDS.Active = False then
  begin
    mechineCDS.Open;
  end;
end;

end.
