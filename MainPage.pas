{ ******************************************************* }
{ }
{ HimsSoft }
{ }
{ ��Ȩ���� (C) 2019 thumb0422@163.com }
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
  tempgroup.Caption := 'һ�߳���';

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '����';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '�Ϻ�';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '����';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '����';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempgroup := dxNavBar1.Groups.Add;
  tempgroup.Caption := '���߳���';

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '����';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '�人';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '�Ͼ�';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempgroup := dxNavBar1.Groups.Add;
  tempgroup.Caption := '���߳���';

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '����';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '�麣';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '���ͺ���';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '����';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '����';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);

  tempitem := dxNavBar1.Items.Add;
  tempitem.Caption := '����';
  // tempitem.OnClick := belongtochina;
  tempgroup.CreateLink(tempitem);
end;

end.

