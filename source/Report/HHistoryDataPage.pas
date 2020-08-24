unit HHistoryDataPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, Data.DB,
  Datasnap.DBClient, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, Vcl.ComCtrls,HBasePage;

type
  THistoryDataPage = class(TBasePage)
    Panel1: TPanel;
    qryBtn: TButton;
    Label1: TLabel;
    custIdEdit: TEdit;
    DBGridEh1: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    startDate: TDateTimePicker;
    endDate: TDateTimePicker;
    Label2: TLabel;
    procedure qryBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HistoryDataPage: THistoryDataPage;

implementation

uses HDBManager, superobject;
{$R *.dfm}

procedure THistoryDataPage.FormCreate(Sender: TObject);
begin
  inherited;
  with ClientDataSet1 do
  begin
    FieldDefs.Clear;
    FieldDefs.Add('curDate',ftString,20);
    FieldDefs.Add('curTime',ftString,20);
    FieldDefs.Add('MCustId', ftString, 10);
    FieldDefs.Add('MCustName', ftString, 50);
    FieldDefs.Add('MId', ftInteger, 0);
    FieldDefs.Add('DId', ftString, 50);
    FieldDefs.Add('VenousPressure', ftFloat, 0);
    FieldDefs.Add('DialysisPressure', ftFloat, 0);
    FieldDefs.Add('TMP', ftFloat, 0);
    FieldDefs.Add('BloodFlow', ftFloat, 0);
    FieldDefs.Add('UFFlow', ftFloat, 0);
    FieldDefs.Add('BloodPressure', ftFloat, 0);
    FieldDefs.Add('TotalBlood', ftFloat, 0);
    FieldDefs.Add('Temperature', ftFloat, 0);
    CreateDataSet;
  end;
end;

procedure THistoryDataPage.qryBtnClick(Sender: TObject);
var
  sql: string;
  jsonData: ISuperObject;
  subData: ISuperObject;
begin
  sql := Format
    ('SELECT date(D.createDate) as curDate,time(D.createDate) as curTime,M.MCustId,C.MCustName,D.* FROM H_Data_Detail D LEFT JOIN H_Data_Main M '
    + 'LEFT JOIN H_CustomerInfo C WHERE 1=1 '
    + 'AND D.DId = M.DId AND M.MCustId = C.MCustId  AND C.MCustId = %s AND M.MCureDate BETWEEN %s AND %s',
    [QuotedStr(custIdEdit.Text), QuotedStr(FormatDateTime('yyyy-mm-dd',
    startDate.Date)), QuotedStr(FormatDateTime('yyyy-mm-dd', endDate.Date))]);
  jsonData := TDBManager.Instance.getDataBySql(sql);
  with ClientDataSet1 do
  begin
    Open;
    EmptyDataSet;
    if jsonData.I['rowCount'] > 0 then
    begin
      for subData in jsonData['data'] do
      begin
        Append;
        FieldByName('curDate').AsString := subData.S['curDate'];
        FieldByName('curTime').AsString := subData.S['curTime'];
        FieldByName('MCustId').AsString := subData.S['MCustId'];
        FieldByName('MCustName').AsString := subData.S['MCustName'];
        FieldByName('MId').AsString := subData.S['MId'];
        FieldByName('DId').AsString := subData.S['DId'];
        FieldByName('VenousPressure').AsString := subData.S['VenousPressure'];
        FieldByName('DialysisPressure').AsString := subData.S['DialysisPressure'];
        FieldByName('TMP').AsString := subData.S['TMP'];
        FieldByName('BloodFlow').AsString := subData.S['BloodFlow'];
        FieldByName('UFFlow').AsString := subData.S['UFFlow'];
        FieldByName('BloodPressure').AsString := subData.S['BloodPressure'];
        FieldByName('TotalBlood').AsString := subData.S['TotalBlood'];
        FieldByName('Temperature').AsString := subData.S['Temperature'];
        Post;
      end;
    end;
  end;
end;

end.
