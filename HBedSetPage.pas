{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       °æÈ¨ËùÓÐ (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HBedSetPage;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,cxButtons, Vcl.ExtCtrls,
  DBGridEh, Data.DB, Datasnap.DBClient, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, cxGraphics, cxLookAndFeels,
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
  dxSkinXmas2008Blue, Vcl.StdCtrls, EhLibVCL, GridsEh, DBAxisGridsEh;

type
  TBedSetPage = class(TForm)
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    saveBtn: TcxButton;
    cancleBtn: TcxButton;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    ClientDataSet1MRoomId: TStringField;
    ClientDataSet1MBedId: TStringField;
    ClientDataSet1isValid: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure saveBtnClick(Sender: TObject);
    procedure cancleBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BedSetPage: TBedSetPage;

implementation
uses HDBManager,superobject;
{$R *.dfm}

procedure TBedSetPage.cancleBtnClick(Sender: TObject);
begin
//
end;

procedure TBedSetPage.FormCreate(Sender: TObject);
var
  jsonData: ISuperObject;
  subData: ISuperObject;
begin
  inherited;
  ClientDataSet1.CreateDataSet;
  jsonData := TDBManager.Instance.getDataBySql('Select * From H_BedInfo Order By MBedId');
  with ClientDataSet1 do
  begin
    if jsonData.I['rowCount'] > 0 then
    begin
      for subData in jsonData['data'] do
      begin
        Append;
        ClientDataSet1.FieldByName('MBedId').AsString := subData.S['MBedId'];
        ClientDataSet1.FieldByName('MRoomId').AsString := subData['MRoomId'].AsString;
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

procedure TBedSetPage.saveBtnClick(Sender: TObject);
var
  I: Integer;
  sql:string;
  sqlList:TStringList;
begin
  sqlList := TStringList.Create;
  sqlList.Add('Delete from H_BedInfo;');
  with ClientDataSet1 do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
        sql := Format('Insert Into H_BedInfo (MBedId,MRoomId,MUsed,isValid) Values (%s,%S,%d,%d)',
           [QuotedStr(FieldByName('MBedId').AsString),QuotedStr(FieldByName('MRoomId').AsString),1,ord(FieldByName('isValid').AsBoolean)]);
        sqlList.Add(sql);
        Next;
    end;
  end;
  TDBManager.Instance.execSql(sqlList);
end;

end.
