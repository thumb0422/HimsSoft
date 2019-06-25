unit HRoom1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,HBizBasePage, Vcl.ExtCtrls;

type
  TRoomPage = class(TBizBasePage)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RoomPage: TRoomPage;

implementation
uses HConst,HBedView;
{$R *.dfm}

procedure TRoomPage.FormCreate(Sender: TObject);
var bedView:TBedView;
begin
  bedView :=TBedView.Create(Self);
  bedView.Parent :=Self;
  bedView.bedStatus := EmBedUsed;
  bedView.Left := 20;
  bedView.Top := 20;
  bedView.Width := 400;
  bedView.Height := 500;
end;

end.
