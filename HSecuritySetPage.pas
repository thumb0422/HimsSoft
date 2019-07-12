unit HSecuritySetPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,HBizBasePage;

type
  TSecuritySetPage = class(TBizBasePage)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SecuritySetPage: TSecuritySetPage;

implementation
uses HDBManager;
{$R *.dfm}

procedure TSecuritySetPage.Button1Click(Sender: TObject);
begin
  TDBManager.Instance.execSqlByFromLocalFile;
end;

end.
