{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HRoom1;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Graphics, System.Math, Vcl.Controls, Vcl.Forms, HBizBasePage,
  Vcl.ExtCtrls,cxScrollBox,
  HDataDetailView;

type
  TRoomPage = class(TBizBasePage)
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    procedure reloadView;
    procedure InitView;
  public
    { Public declarations }
  protected
    centerPanel :TPanel;
    cxScrollBox1:TcxScrollBox;
    fDataDetaiView :TDataDetailView;
  end;

var
  RoomPage: TRoomPage;

implementation

uses
  HBedView;
{$R *.dfm}

procedure TRoomPage.FormCreate(Sender: TObject);
begin
  InitView;
  reloadView;
end;

procedure TRoomPage.FormResize(Sender: TObject);
begin
//  reloadView; //FrameSizeChange 好像有问题
end;

procedure TRoomPage.InitView;
begin
  cxScrollBox1 := TcxScrollBox.Create(Self);
  with cxScrollBox1 do
  begin
    Parent:=Self;
    Caption := '';
    Left := Self.Width - 200;;
    Top := 0;
    Width := 200;
    Height := Self.Height;
    Align := alRight;
    Color := clWhite;
  end;

  fDataDetaiView := TDataDetailView.Create(Self);
  fDataDetaiView.Name := 'DataDetailView';
  fDataDetaiView.Caption := '';
  fDataDetaiView.Align := alClient;
  fDataDetaiView.Parent := cxScrollBox1;

  centerPanel := TPanel.Create(Self);
  with centerPanel do
  begin
    Parent:=Self;
    Caption := '';
    Left := 0;
    Top := 0;
    Width := Self.Width - centerPanel.Left;
    Height := Self.Height;
    Align := alClient;
    Color := clWhite;
  end;
end;

procedure TRoomPage.reloadView;
var
  I: Integer;
  bedView: TBedView;
  fWidth, fHeight, fSeperateWidth: Integer;
  fCol, fRow, fMax: Integer;
  J: Integer;
  fLeft,fTop:Integer;
begin
  fMax := 20;
  fWidth := 130;
  fHeight := 120;
  fSeperateWidth := 20;
  fCol := ceil((centerPanel.Width - fSeperateWidth) / (fWidth + fSeperateWidth)); //列数
  fRow := ceil((centerPanel.Height - fSeperateWidth) / (fHeight + fSeperateWidth)); //行数
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
    if (fLeft + fWidth + fSeperateWidth) > centerPanel.Width then
    begin
      Continue;
    end;
    for J := 0 to fRow - 1 do
    begin
      fTop := fSeperateWidth + J * (fHeight + fSeperateWidth);
      if (fTop + fHeight + fSeperateWidth > centerPanel.Height) then
      begin
        Continue;
      end;
      bedView := TBedView.Create(nil);
      bedView.Name := 'bedView' + IntToStr(I) + IntToStr(J);
      bedView.Caption := '';
      bedView.Parent := centerPanel;
      bedView.Left := fLeft;
      bedView.Top := fTop;
      bedView.Width := fWidth;
      bedView.Height := fHeight;
      bedView.bedId := IntToStr(I)+IntToStr(J);
      bedView.notifyComponent := fDataDetaiView;
    end;
  end;
end;

end.

