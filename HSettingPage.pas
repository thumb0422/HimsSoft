{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HSettingPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls,HBizBasePage;

type
  TSettingPage = class(TBizBasePage)
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    procedure initBaseView;
    procedure onTouchInSide(Sender:TObject);
    procedure RoundControl(Control: TWinControl;arc1:Integer;arc2:Integer);
  public
    { Public declarations }
  end;

var
  SettingPage: TSettingPage;

implementation
uses HBedSetPage,HMechineSetPage,HCustomerSetPage,HCBMLinkPage;
{$R *.dfm}

procedure TSettingPage.FormCreate(Sender: TObject);
begin
  inherited;

  initBaseView;
end;

procedure TSettingPage.FormPaint(Sender: TObject);
var
  ps : array [0 .. 2] of TPoint;
  Rgn: HRGN;
begin
  ps[0] := Point(350, 100);
  ps[1] := Point(100, 500);
  ps[2] := Point(600, 500);

  { 建立多边形区域 }
  Rgn := CreatePolygonRgn(ps, Length(ps), WINDING);

  { 填充区域 }
  Canvas.Brush.Color := clYellow;
  Canvas.Brush.Style := bsSolid;
  FillRgn(Canvas.Handle, Rgn, Canvas.Brush.Handle);

  { 绘制区域边界 }
  Canvas.Brush.Color := clGreen;
  Canvas.Brush.Style := bsSolid;
  FrameRgn(Canvas.Handle, Rgn, Canvas.Brush.Handle, 1, 1);
  DeleteObject(Rgn);
end;

procedure TSettingPage.initBaseView;
var
  lBedButton, lMechineButton, lCustomerButton, lLinkButton: TButton;
begin
  lBedButton := TButton.Create(Self);
  lBedButton.Caption := '床位';
  lBedButton.Parent := Self;
  lBedButton.OnClick := onTouchInSide;
  lBedButton.Tag := 1000;
  lBedButton.Left := 320;
  lBedButton.Top := 80;
  lBedButton.Width := 60;
  lBedButton.Height := 40;
  RoundControl(lBedButton,30,30);

  lMechineButton := TButton.Create(Self);
  lMechineButton.Caption := '设备';
  lMechineButton.Parent := Self;
  lMechineButton.OnClick := onTouchInSide;
  lMechineButton.Tag := 1001;
  lMechineButton.Left := 570;
  lMechineButton.Top := 480;
  lMechineButton.Width := 60;
  lMechineButton.Height := 40;
  RoundControl(lMechineButton,45,45);

  lCustomerButton := TButton.Create(Self);
  lCustomerButton.Caption := '用户';
  lCustomerButton.Parent := Self;
  lCustomerButton.OnClick := onTouchInSide;
  lCustomerButton.Tag := 1002;
  lCustomerButton.Left := 70;
  lCustomerButton.Top := 480;
  lCustomerButton.Width := 60;
  lCustomerButton.Height := 40;
  RoundControl(lCustomerButton,60,60);

  lLinkButton := TButton.Create(Self);
  lLinkButton.Caption := '关联数据';
  lLinkButton.Parent := Self;
  lLinkButton.OnClick := onTouchInSide;
  lLinkButton.Tag := 1003;
  lLinkButton.Left := 320;
  lLinkButton.Top := 300;
  lLinkButton.Width := 60;
  lLinkButton.Height := 60;
  RoundControl(lLinkButton,190,190);
end;

procedure TSettingPage.onTouchInSide(Sender: TObject);
var
  lButton: TButton;
  lbedSetPage:TBedSetPage;
  lmechineSetPage :TMechineSetPage;
  lcustomerSetPage:TCustomerSetPage;
  llinkPage:THCBMLinkPage;
begin
  lButton := TButton(Sender);
  if not Assigned(lButton) then
    Exit;
  case lButton.Tag of
    1000:
      begin
        lbedSetPage := TBedSetPage.Create(nil);
        lbedSetPage.ShowModal;
      end;
    1001:
      begin
        lmechineSetPage := TMechineSetPage.Create(nil);
        lmechineSetPage.ShowModal;
      end;
    1002:
      begin
        lcustomerSetPage := TCustomerSetPage.Create(nil);
        lcustomerSetPage.ShowModal;
      end;
    1003:
      begin
        llinkPage := THCBMLinkPage.Create(nil);
        llinkPage.ShowModal;
      end;
  end;
end;

procedure TSettingPage.RoundControl(Control: TWinControl; arc1, arc2: Integer);
var
  R:TRect;
  Rgn:HRGN;
begin
  with Control do
  begin
    R := Control.ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, arc1, arc2);
    Perform(EM_GETRECT, 0, lParam(@R));
    InflateRect(R, -5, -5);
    Perform(EM_SETRECTNP, 0, LParam(@R));
    SetWindowRgn(Control.Handle, Rgn, True);
    Invalidate;
  end;
end;

end.
