{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       °æÈ¨ËùÓÐ (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HMechineSetPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh,
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
  dxSkinXmas2008Blue, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxButtons,
  Vcl.ExtCtrls, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh;

type
  TMechineSetPage = class(TForm)
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    saveBtn: TcxButton;
    cancelBtn: TcxButton;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1MDesc: TStringField;
    ClientDataSet1MCom: TBooleanField;
    ClientDataSet1MNet: TBooleanField;
    ClientDataSet1MId: TStringField;
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

{$R *.dfm}

procedure TMechineSetPage.cancelBtnClick(Sender: TObject);
begin
//
end;

procedure TMechineSetPage.FormCreate(Sender: TObject);
var
  lDtaFile: string;
begin
  inherited;
  ClientDataSet1.CreateDataSet;
  lDtaFile := ExtractFilePath(paramstr(0)) + 'mechine.xml';
  if FileExists(lDtaFile) then
  begin
    ClientDataSet1.LoadFromFile(lDtaFile);
  end;
  if ClientDataSet1.Active = False then
  begin
    ClientDataSet1.Open;
  end;
end;

procedure TMechineSetPage.saveBtnClick(Sender: TObject);
var
  lDtaFile: string;
begin
  lDtaFile := ExtractFilePath(paramstr(0)) + 'mechine.xml';
  if (ClientDataSet1.State in [dsInsert,dsEdit]) then
    ClientDataSet1.Post;
  if ClientDataSet1.RecordCount > 0 then
  begin
    ClientDataSet1.SaveToFile(lDtaFile);
  end;
end;

end.
