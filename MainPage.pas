{ ******************************************************* }
{ }
{ HimsSoft }
{ }
{ 版权所有 (C) 2019 thumb0422@163.com }
{ }
{ ******************************************************* }

unit MainPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls,
  cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxNavBarCollns, cxClasses,
  dxNavBarBase, dxNavBar, dxNavBarGroupItems,
  Vcl.ExtCtrls, HCom32, HNet, HDeviceInfo, HTool, cxSplitter,
  System.Generics.Collections;

type
  TFMainPage = class(TForm)
    leftPanel: TPanel;
    rightPanel: TPanel;
    cxSplitter1: TcxSplitter;
    dxNavBar1: TdxNavBar;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    procedure InitNavBar();

  public
    { Public declarations }
  end;

var
  FMainPage: TFMainPage;

implementation

uses HDeviceDo, HCustomerSetting;
{$R *.dfm}

procedure TFMainPage.FormCreate(Sender: TObject);
begin
  InitNavBar;
end;

procedure TFMainPage.FormResize(Sender: TObject);
begin
  inherited;
  leftPanel.Align := TAlign.alLeft;
  leftPanel.Left := 0;
  leftPanel.Top := 0;
  leftPanel.Width := 350;
  rightPanel.Align := TAlign.alRight;
  rightPanel.Left := leftPanel.Left + leftPanel.Width;
end;

procedure TFMainPage.InitNavBar();
var
  tempitem: TdxnavbarItem;
  tempgroup: Tdxnavbargroup;
begin
  dxNavBar1.Items.Clear;
  tempgroup := dxNavBar1.Groups.Add;
  tempgroup.Caption := '中国地盘';

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '钓鱼岛';
  // tempitem.OnClick := belongtochina;
  // tempitem.OnClick:= button1.OnClick; //绑定事件
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '台湾';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempgroup := dxNavBar1.Groups.Add;
  tempgroup.Caption := '一年四季';

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '春天';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '夏天';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '秋天';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '冬天';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempgroup := dxNavBar1.Groups.Add;
  tempgroup.Caption := '病人树';
  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '病人树';

  tempgroup.CreateLink(tempitem);
end;

end.
