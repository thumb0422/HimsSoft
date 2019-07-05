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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Vcl.StdCtrls,HBizBasePage;

type
  TSettingPage = class(TBizBasePage)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure initBaseView;
    procedure onTouchInSide(Sender:TObject);
  public
    { Public declarations }
  end;

var
  SettingPage: TSettingPage;

implementation
uses HBedSetPage,HMechineSetPage;
{$R *.dfm}

procedure TSettingPage.FormCreate(Sender: TObject);
begin
  inherited;
  initBaseView;
end;

procedure TSettingPage.initBaseView;
var
  lBedButton, lMechineButton,lCustomerButton,lLinkButton: TButton;
begin
  lBedButton := TButton.Create(Self);
  lBedButton.Caption := '床位设置';
  lBedButton.Parent := Self;
  lBedButton.OnClick := onTouchInSide;
  lBedButton.Tag := 1000;
  lBedButton.Left := 30;
  lBedButton.Top := 30;
  lBedButton.Width := 120;
  lBedButton.Height := 40;

  lMechineButton := TButton.Create(Self);
  lMechineButton.Caption := '机器设置';
  lMechineButton.Parent := Self;
  lMechineButton.OnClick := onTouchInSide;
  lMechineButton.Tag := 1001;
  lMechineButton.Left := 30;
  lMechineButton.Top := 100;
  lMechineButton.Width := 120;
  lMechineButton.Height := 40;

  lCustomerButton := TButton.Create(Self);
  lCustomerButton.Caption := '用户设置';
  lCustomerButton.Parent := Self;
  lCustomerButton.OnClick := onTouchInSide;
  lCustomerButton.Tag := 1002;
  lCustomerButton.Left := 30;
  lCustomerButton.Top := 100;
  lCustomerButton.Width := 120;
  lCustomerButton.Height := 40;

  lLinkButton := TButton.Create(Self);
  lLinkButton.Caption := '关联数据生成';
  lLinkButton.Parent := Self;
  lLinkButton.OnClick := onTouchInSide;
  lLinkButton.Tag := 1003;
  lLinkButton.Left := 30;
  lLinkButton.Top := 100;
  lLinkButton.Width := 120;
  lLinkButton.Height := 40;
end;

procedure TSettingPage.onTouchInSide(Sender: TObject);
var lButton: TButton;
  lbedSetPage:TBedSetPage;
  lmechineSetPage :TMechineSetPage;
begin
  lButton := TButton(Sender);
  if not Assigned(lButton) then
    Exit;
  case lButton.Tag of
    1000:
      begin

      end;
    1001:
      begin
        lmechineSetPage := TMechineSetPage.Create(nil);
        lmechineSetPage.ShowModal;
      end;
    1002:
      begin

      end;
    1003:
      begin

      end;
  end;
end;

end.
