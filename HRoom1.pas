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
  System.SysUtils, System.Classes,Vcl.Dialogs,
  Vcl.Graphics, System.Math, Vcl.Controls, Vcl.Forms, HBizBasePage,
  Vcl.ExtCtrls,cxScrollBox,
  HDataDetailView;

type
  TRoomPage = class(TBizBasePage)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure reloadView;
    procedure InitView;
  public
    { Public declarations }
  protected
//    centerPanel :TPanel;
    cxScrollBoxCenter:TcxScrollBox;
    cxScrollBox1:TcxScrollBox;
    fDataDetaiView :TDataDetailView;
  end;

var
  RoomPage: TRoomPage;

implementation

uses superobject,HDBManager,HBedView,HCustomer,HMConst;
{$R *.dfm}

procedure TRoomPage.FormCreate(Sender: TObject);
begin
  InitView;
end;

procedure TRoomPage.FormShow(Sender: TObject);
begin
  inherited;
  cxScrollBox1.Width := 200;
  reloadView;
end;

procedure TRoomPage.InitView;
begin
  cxScrollBox1 := TcxScrollBox.Create(Self);
  with cxScrollBox1 do
  begin
    Parent:= Self;
    Caption := '';
//    Width := 200;
    Align := alRight;
    Color := clWhite;
  end;

  fDataDetaiView := TDataDetailView.Create(Self);
  fDataDetaiView.Name := 'DataDetailView';
  fDataDetaiView.Caption := '';
  fDataDetaiView.Align := alClient;
  fDataDetaiView.Parent := cxScrollBox1;

//  centerPanel := TPanel.Create(Self);
//  with centerPanel do
//  begin
//    Parent:=Self;
//    Caption := '';
//    Align := alClient;
//    Color := clWhite;
//  end;
  cxScrollBoxCenter := TcxScrollBox.Create(Self);
  with cxScrollBoxCenter do
  begin
    Parent:= Self;
    Caption := '';
    Align := alClient;
    Color := clWhite;
  end;

end;

procedure TRoomPage.reloadView;
var
  I: Integer;
  bedView: TBedView;
  fWidth, fHeight, fSeperateWidth: Integer;
  fCol, fRow: Integer;
  J: Integer;
  fLeft,fTop:Integer;
  jsonData: ISuperObject;
  subData: ISuperObject;
  sql :string;
  customers :TList;
  customer :TCustomer;
  dataCount:Integer;
begin
  customers := TList.Create;
  sql := 'SELECT C.MCustId,C.MCustName,B.MRoomId,B.MBedId,M.MMechineId,M.MMechineDesc,M.MCom,M.MNet,M.MHDBox '+
         'from H_CBMData D LEFT JOIN H_CustomerInfo C LEFT JOIN H_BedInfo B LEFT JOIN H_MechineInfo M '+
         'where D.MCustId = C.MCustId AND D.MBedId = B.MBedId AND D.MMechineId = M.MMechineId AND D.isValid = 1 ';
  jsonData := TDBManager.Instance.getDataBySql(sql);
  dataCount := jsonData.I['rowCount'];
  if dataCount > 0 then
  begin
    for subData in jsonData['data'] do
    begin
      customer := TCustomer.Create;
      customer.MCustId := subData.S['MCustId'];
      customer.MCustName := subData.S['MCustName'];
      customer.MBedId := subData.S['MBedId'];
      customer.MMechineId := subData.S['MMechineId'];
      customer.MLinkType := DLinkCom;//TODO:
      customers.Add(customer);
    end;
  end;

  fWidth := 130;
  fHeight := 120;
  fSeperateWidth := 20;
//  dataCount := 50;
  fCol := Trunc((cxScrollBoxCenter.ClientWidth - fSeperateWidth) / (fWidth + fSeperateWidth)); //列数
  fRow := Ceil(dataCount div fCol);   //行数

  for I := 0 to fRow - 1 do
  begin
    fTop := fSeperateWidth + I * (fHeight + fSeperateWidth);
    for J := 0 to fCol - 1 do
    begin
      fLeft := fSeperateWidth + J * (fWidth + fSeperateWidth);
      if (fLeft + fWidth + fSeperateWidth) > cxScrollBoxCenter.Width then
      begin
        Continue;
      end;
      bedView := TBedView.Create(nil);
      bedView.Name := 'bedView' + IntToStr(I) + IntToStr(J);
      bedView.Caption := '';
      bedView.Parent := cxScrollBoxCenter;
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

