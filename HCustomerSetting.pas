unit HCustomerSetting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids;

type
  ThsCustomerSetting = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  hsCustomerSetting: ThsCustomerSetting;

implementation

{$R *.dfm}

procedure ThsCustomerSetting.Button1Click(Sender: TObject);
begin
  self.ModalResult := mrOk;
end;

procedure ThsCustomerSetting.Button2Click(Sender: TObject);
begin
  self.ModalResult := mrCancel;
end;

procedure ThsCustomerSetting.FormCreate(Sender: TObject);
var
  DataFile: string;
begin
  { ��ȡ CodeGear ����װ�������ļ�: country.xml ��·�� }
  DataFile := ExtractFilePath(paramstr(0));
  DataFile := DataFile + 'country.xml'; { country.cds Ҳ�� }

  DBGrid1.DataSource := DataSource1; { DBGrid ��Ҫ��������Դ }
  DataSource1.DataSet := ClientDataSet1; { ����Դ DataSource ��Ҫ�������ݼ� }
  ClientDataSet1.FileName := DataFile; { �����ݼ� ClientDataSet ����һ�������ļ� }

  { �����ݼ� }
  ClientDataSet1.Active := True; // �� ClientDataSet1.Open;
  ClientDataSet1.SaveToFile();
end;

end.
