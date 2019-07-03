unit HRoom1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, System.Math, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, HBizBasePage,
  Vcl.ExtCtrls;

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

uses
  HConst, HBedView;
{$R *.dfm}

procedure TRoomPage.FormCreate(Sender: TObject);
begin
  reloadView;
end;

procedure TRoomPage.FormResize(Sender: TObject);
begin
//  reloadView; //FrameSizeChange 好像有问题
end;

procedure TRoomPage.reloadView;
var
  I: Integer;
  bedView: TBedView;
  fWidth, fHeight, fSeperateWidth: Integer;
  fCol, fRow, fMax: Integer;
  J: Integer;
  M: Integer;
  TempCom: TComponent;
  aaa:string;
  fLeft,fTop:Integer;
begin
  for M := 0 to Self.ComponentCount - 1 do
  begin
    TempCom := Self.Components[M];
    if Pos('bedView', TempCom.Name) > 0 then
    begin
      TempCom.Free;
    end;

  end;
  fMax := 20;
  fWidth := 130;
  fHeight := 120;
  fSeperateWidth := 20;
  fCol := ceil((Self.Width - fSeperateWidth) / (fWidth + fSeperateWidth)); //列数
  fRow := ceil((Self.Height - fSeperateWidth) / (fHeight + fSeperateWidth)); //行数
  if (fCol * fRow) > fMax then
  begin
    fRow := fMax div fCol;
  end;

  //For test  循环数组好像有问题
  fRow := 2;
  fCol := 3;

  for I := 0 to fCol - 1 do
  begin
    fLeft := fSeperateWidth + I * (fWidth + fSeperateWidth);
    if (fLeft + fWidth + fSeperateWidth) > self.Width then
    begin
      Continue;
    end;
    for J := 0 to fRow - 1 do
    begin
      fTop := fSeperateWidth + J * (fHeight + fSeperateWidth);
      if (fTop + fHeight + fSeperateWidth > self.Height) then
      begin
        Continue;
      end;
      bedView := TBedView.Create(nil);
      bedView.Name := 'bedView' + IntToStr(I) + IntToStr(J);
      bedView.Parent := Self;
      bedView.Left := fLeft;
      bedView.Top := fTop;
      bedView.Width := fWidth;
      bedView.Height := fHeight;
      bedView.bedId := IntToStr(I)+IntToStr(J);
    end;
  end;
end;

end.

