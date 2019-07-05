unit HCustomerSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, HBizBasePage, Data.DB, Vcl.StdCtrls,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Datasnap.Provider;

type
  TCustomerSetPage = class(TBizBasePage)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Label1: TLabel;
    Label2: TLabel;
    saveBtn: TButton;
    DelBtn: TButton;
    BedIdEdit: TEdit;
    custIdEdit: TEdit;
    ClientDataSet1BedId: TStringField;
    ClientDataSet1CustId: TStringField;
    AddBtn: TButton;
    procedure saveBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CustomerSetPage: TCustomerSetPage;

implementation

{$R *.dfm}

procedure TCustomerSetPage.AddBtnClick(Sender: TObject);
begin
  inherited;
  if not ClientDataSet1.Active then
  begin
    ClientDataSet1.Open;
  end;
  ClientDataSet1.Append;
  ClientDataSet1.FieldByName('BedId').AsString := BedIdEdit.Text;
  ClientDataSet1.FieldByName('CustId').AsString := custIdEdit.Text;
  ClientDataSet1.Post;
end;

procedure TCustomerSetPage.DelBtnClick(Sender: TObject);
begin
  if ClientDataSet1.Active = True then
  begin
//    ClientDataSet1.DeleteIndex(DBGrid1.SelectedIndex);
    ClientDataSet1.Delete;
//    ClientDataSet1.Post;
  end;
end;

procedure TCustomerSetPage.FormCreate(Sender: TObject);
var
  lDtaFile: string;
begin
  inherited;
  ClientDataSet1.CreateDataSet;
  lDtaFile := ExtractFilePath(paramstr(0));
  lDtaFile := lDtaFile + 'data.xml';
  if FileExists(lDtaFile) then
  begin
    ClientDataSet1.LoadFromFile(lDtaFile);
  end
  else
  begin

  end;
  if ClientDataSet1.Active = False then
  begin
    ClientDataSet1.Open;
  end;
end;

procedure TCustomerSetPage.saveBtnClick(Sender: TObject);
var
  lDtaFile: string;
begin
  lDtaFile := ExtractFilePath(paramstr(0));
  lDtaFile := lDtaFile + 'data.xml';
  if (ClientDataSet1.State in [dsInsert,dsEdit]) then
    ClientDataSet1.Post;
  if ClientDataSet1.RecordCount > 0 then
  begin
    ClientDataSet1.SaveToFile(lDtaFile);
  end;
end;

end.
