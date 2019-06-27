unit HRoom1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, HBizBasePage, Vcl.ExtCtrls;

type
  TRoomPage = class(TBizBasePage)
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    procedure reloadView;
  public
    { Public declarations }
  end;

var
  RoomPage: TRoomPage;

implementation

uses HConst, HBedView;
{$R *.dfm}

procedure TRoomPage.FormCreate(Sender: TObject);
begin
  reloadView;
end;

procedure TRoomPage.FormResize(Sender: TObject);
begin
  reloadView;
end;

procedure TRoomPage.reloadView;
var
  I: Integer;
  bedView: TBedView;
  fWidth, fHeight, fSeperateWidth: Integer;
  fCol, fRow, fMax: Integer;
  J: Integer;
begin
  fMax := 20;
  fWidth := 130;
  fHeight := 100;
  fSeperateWidth := 20;
  fCol := (Self.Height - fSeperateWidth) div (fHeight + fSeperateWidth);
  fRow := (Self.Width - fSeperateWidth) div (fWidth + fSeperateWidth);
  if (fCol * fRow) > fMax then
  begin
    fRow := fMax div fCol;
  end;

  for I := 0 to fCol - 1 do
  begin
    for J := 0 to fRow - 1 do
    begin
      bedView := TBedView.Create(Self);
      bedView.Parent := Self;
      bedView.bedStatus := EmBedUsed;
      bedView.Left := fSeperateWidth + I * (fWidth + fSeperateWidth);
      bedView.Top := fSeperateWidth + J * (fWidth + fSeperateWidth);
      bedView.Width := fWidth;
      bedView.Height := fHeight;
    end;
  end;

end;

end.
