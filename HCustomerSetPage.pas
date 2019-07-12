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
    ClientDataSet1MCustId: TStringField;
    ClientDataSet1MCustName: TStringField;
    ClientDataSet1isValid: TBooleanField;
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
uses HDBManager,superobject;
{$R *.dfm}

procedure TCustomerSetPage.FormCreate(Sender: TObject);
var
  jsonData: ISuperObject;
  subData: ISuperObject;
begin
  ClientDataSet1.CreateDataSet;
  jsonData := TDBManager.Instance.getDataBySql('Select * From H_CustomerInfo Order By MCustId');
  with ClientDataSet1 do
  begin
    if jsonData.I['rowCount'] > 0 then
    begin
      for subData in jsonData['data'] do
      begin
        Append;
        ClientDataSet1.FieldByName('MCustId').AsString := subData.S['MCustId'];
        ClientDataSet1.FieldByName('MCustName').AsString := subData['MCustName'].AsString;
        ClientDataSet1.FieldByName('isValid').AsBoolean := not (subData['isValid'].AsInteger = 0);
        Post;
      end;
    end;
  end;

  if ClientDataSet1.Active = False then
  begin
    ClientDataSet1.Open;
  end;
end;

procedure TCustomerSetPage.saveBtnClick(Sender: TObject);
var
  I: Integer;
  sql:string;
  sqlList:TStringList;
begin
  sqlList := TStringList.Create;
  sqlList.Add('Delete from H_CustomerInfo;');
  with ClientDataSet1 do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
        sql := Format('Insert Into H_CustomerInfo (MCustId,MCustName,MUsed,isValid) Values (%s,%S,%d,%d)',
           [QuotedStr(FieldByName('MCustId').AsString),QuotedStr(FieldByName('MCustName').AsString),1,ord(FieldByName('isValid').AsBoolean)]);
        sqlList.Add(sql);
        Next;
    end;
  end;
  TDBManager.Instance.execSql(sqlList);
end;

procedure TCustomerSetPage.cancelBtnClick(Sender: TObject);
begin
  inherited;
//
end;
end.
