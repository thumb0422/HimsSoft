unit HDataDetailView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TDataDetailView = class(TForm)
    SessionTimeLabel: TLabel;
    Panel1: TPanel;
    VenousPressureLabel: TLabel;
    DialysisPressureLabel: TLabel;
    TMPLabel: TLabel;
    Panel2: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataDetailView: TDataDetailView;

implementation

{$R *.dfm}

end.
