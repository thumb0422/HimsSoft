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
    cureDate:string;
    procedure reloadView;
    procedure InitView;
  public
    { Public declarations }
  protected
    cxScrollBoxCenter:TcxScrollBox;
    cxScrollBox1:TcxScrollBox;
    fDataDetaiView :TDataDetailView;
  end;

var
  RoomPage: TRoomPage;

implementation

uses superobject,HDBManager,HBedView,HCustomer,HDeviceDefine,HDeviceTool;
{$R *.dfm}

procedure TRoomPage.FormCreate(Sender: TObject);
begin
  inherited;
  cureDate := FormatDateTime('yyyy-mm-dd',Now);
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
    Align := alRight;
    Color := clWhite;
  end;

  fDataDetaiView := TDataDetailView.Create(Self);
  fDataDetaiView.Name := 'DataDetailView';
  fDataDetaiView.Caption := '';
  fDataDetaiView.Align := alClient;
  fDataDetaiView.Parent := cxScrollBox1;

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
  tmpCount :Integer;
begin
  customers := TList.Create;
  sql := Format('SELECT C.MCustId,C.MCustName,B.MRoomId,B.MBedId,M.MMechineId,M.MMechineDesc,M.MLink,M.MAddress,M.MPort '+
         'from H_CBMData D LEFT JOIN H_CustomerInfo C LEFT JOIN H_BedInfo B LEFT JOIN H_MechineInfo M '+
         'where 1=1 AND D.MCureDate = %s AND D.isValid = 1 AND D.MCustId = C.MCustId AND D.MBedId = B.MBedId AND D.MMechineId = M.MMechineId ',
         [QuotedStr(cureDate)]);
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
      customer.MLinkType := TDeviceTool.getLinkType(subData.S['MLink']);
      customer.MAddress := subData.S['MAddress'];
      customer.MPort := subData.S['MPort'];
      customers.Add(customer);
    end;
  end;

  fWidth := 130;
  fHeight := 120;
  fSeperateWidth := 20;
  fCol := Trunc((cxScrollBoxCenter.ClientWidth - fSeperateWidth) / (fWidth + fSeperateWidth)); //列数
  fRow := Ceil(dataCount / fCol);   //行数
  tmpCount := 0;
  for I := 0 to fRow - 1 do
  begin
    fTop := fSeperateWidth + I * (fHeight + fSeperateWidth);
    for J := 0 to fCol - 1 do
    begin
      if tmpCount >= dataCount then
      begin
        Break;
      end;
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
      bedView.notifyComponent := fDataDetaiView;
      bedView.customer := customers[tmpCount];

      tmpCount := tmpCount + 1;
    end;
  end;
end;

end.

