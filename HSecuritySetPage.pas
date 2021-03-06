unit HSecuritySetPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,HBasePage, Vcl.ExtCtrls;

type
  TSecuritySetPage = class(TBasePage)
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SecuritySetPage: TSecuritySetPage;

implementation
uses HDBManager,HDeviceDo;
{$R *.dfm}

procedure TSecuritySetPage.Button1Click(Sender: TObject);
begin
  TDBManager.Instance.execSqlByFromLocalFile;
end;

procedure TSecuritySetPage.Button2Click(Sender: TObject);
begin
  inherited;
  Timer1.Enabled := False;
  Timer1.Enabled := True;
end;

procedure TSecuritySetPage.Button3Click(Sender: TObject);
begin
  inherited;
  TDBManager.Instance.execSqlByFromLocalFile('hims.db.sql');
end;

procedure TSecuritySetPage.FormCreate(Sender: TObject);
begin
  inherited;
  Timer1.Enabled :=False;
end;

procedure TSecuritySetPage.FormDestroy(Sender: TObject);
begin
  inherited;
  TDeviceDo.GetInstance.stopTestData;
end;

procedure TSecuritySetPage.Timer1Timer(Sender: TObject);
begin
  inherited;
  TDeviceDo.GetInstance.startTestData;
end;

end.
