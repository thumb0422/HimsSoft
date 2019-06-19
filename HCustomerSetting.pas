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
  { 获取 CodeGear 共享安装的数据文件: country.xml 的路径 }
  DataFile := ExtractFilePath(paramstr(0));
  DataFile := DataFile + 'country.xml'; { country.cds 也可 }

  DBGrid1.DataSource := DataSource1; { DBGrid 需要连接数据源 }
  DataSource1.DataSet := ClientDataSet1; { 数据源 DataSource 需要连接数据集 }
  ClientDataSet1.FileName := DataFile; { 让数据集 ClientDataSet 关联一个数据文件 }

  { 打开数据集 }
  ClientDataSet1.Active := True; // 或 ClientDataSet1.Open;
  ClientDataSet1.SaveToFile();
end;

end.
