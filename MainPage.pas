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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxNavBarCollns,
  cxClasses, dxNavBarBase, dxNavBar, dxNavBarGroupItems, Vcl.ExtCtrls, HCom32,
  HNet, HDeviceInfo, HTool, cxSplitter, System.Generics.Collections,
  dxBarBuiltInMenu, cxPC,
  HBizBasePage;

type
  TFMainPage = class(TForm)
    dxNavBar1: TdxNavBar;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure cxPageControl1Change(Sender: TObject);
  private
    { Private declarations }
    procedure InitNavBar();
  public
    { Public declarations }
  end;

var
  FMainPage: TFMainPage;
//  FLoadForm: TBizBasePage;

implementation

uses
  HDeviceDo, HCustomerSetting;
{$R *.dfm}

procedure TFMainPage.cxPageControl1Change(Sender: TObject);
begin
//  case cxPageControl1.ActivePageIndex of
//    0:
//      TForm1.loadSelf(FLoadForm, cxTabSheet1, alClient);
//    1:
//      TForm2.loadSelf(FLoadForm, cxTabSheet2, alClient);
//  end;
end;

procedure TFMainPage.FormCreate(Sender: TObject);
begin
  InitNavBar;
end;

procedure TFMainPage.InitNavBar();
var
  tempitem: TdxnavbarItem;
  tempgroup: Tdxnavbargroup;
begin
  dxNavBar1.Items.Clear;
  tempgroup := dxNavBar1.Groups.Add;
  tempgroup.Caption := '一线城市';

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '北京';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '上海';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '深圳';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '广州';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempgroup := dxNavBar1.Groups.Add;
  tempgroup.Caption := '二线城市';

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '杭州';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '武汉';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '南京';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempgroup := dxNavBar1.Groups.Add;
  tempgroup.Caption := '三线城市';

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '无锡';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '珠海';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '呼和浩特';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '湖州';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '三亚';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '莆田';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);
end;

end.

