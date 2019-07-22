unit HSecuritySetPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,HBizBasePage, Vcl.ExtCtrls;

type
  TSecuritySetPage = class(TBizBasePage)
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

procedure TSecuritySetPage.FormCreate(Sender: TObject);
begin
  inherited;
  Timer1.Enabled :=False;
end;

procedure TSecuritySetPage.Timer1Timer(Sender: TObject);
begin
  inherited;
  TDeviceDo.GetInstance.startTestData;
end;

end.
