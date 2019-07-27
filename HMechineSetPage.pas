{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HMechineSetPage;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Data.DB, Datasnap.DBClient, cxButtons,
  Vcl.ExtCtrls, DBGridEh, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
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
  dxSkinWhiteprint, dxSkinXmas2008Blue, Vcl.StdCtrls, EhLibVCL, GridsEh,
  DBAxisGridsEh;

type
  TMechineSetPage = class(TForm)
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    saveBtn: TcxButton;
    cancelBtn: TcxButton;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1MMechineId: TStringField;
    ClientDataSet1MMechineDesc: TStringField;
    ClientDataSet1isValid: TBooleanField;
    ClientDataSet1MLink: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure saveBtnClick(Sender: TObject);
    procedure cancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MechineSetPage: TMechineSetPage;

implementation
uses HDBManager,superobject;
{$R *.dfm}

procedure TMechineSetPage.cancelBtnClick(Sender: TObject);
begin
//
end;

procedure TMechineSetPage.FormCreate(Sender: TObject);
var
  jsonData: ISuperObject;
  subData: ISuperObject;
  keyStrings,valuesStrings:TStrings;
begin
  inherited;
  ClientDataSet1.CreateDataSet;
  jsonData := TDBManager.Instance.getDataBySql('Select * From H_MechineInfo Order By MMechineId');
  with ClientDataSet1 do
  begin
    if jsonData.I['rowCount'] > 0 then
    begin
      for subData in jsonData['data'] do
      begin
        Append;
        ClientDataSet1.FieldByName('MMechineId').AsString := subData.S['MMechineId'];
        ClientDataSet1.FieldByName('MMechineDesc').AsString := subData['MMechineDesc'].AsString;
        ClientDataSet1.FieldByName('MLink').AsString := subData['MLink'].AsString;
        ClientDataSet1.FieldByName('isValid').AsBoolean := not (subData['isValid'].AsInteger = 0);
        Post;
      end;
    end;
  end;

  if ClientDataSet1.Active = False then
  begin
    ClientDataSet1.Open;
  end;
  keyStrings := TStringList.Create;
  keyStrings.CommaText :='10001001,10001002,10001003,10001004';

  valuesStrings := TStringList.Create;
  valuesStrings.CommaText :='串口,网口,HD-BOX,不支持';
  DBGridEh1.Columns[DBGridEh1.Columns.Count-1].KeyList:=keyStrings;
  DBGridEh1.Columns[DBGridEh1.Columns.Count-1].PickList:= valuesStrings;

end;

procedure TMechineSetPage.saveBtnClick(Sender: TObject);
var
  sql:string;
  sqlList:TStringList;
begin
  sqlList := TStringList.Create;
  sqlList.Add('Delete from H_MechineInfo;');
  with ClientDataSet1 do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
      sql := Format
        ('Insert Into H_MechineInfo (MMechineId,MMechineDesc,MLink,isValid) Values (%s,%s,%s,%d)',
        [QuotedStr(FieldByName('MMechineId').AsString),
        QuotedStr(FieldByName('MMechineDesc').AsString),
        QuotedStr(FieldByName('MLink').AsString),
        ord(FieldByName('isValid').AsBoolean)]);
      sqlList.Add(sql);
      Next;
    end;
  end;
  TDBManager.Instance.execSql(sqlList);
end;

end.
