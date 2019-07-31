{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       ∞Ê»®À˘”– (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HDeviceDo;

interface

uses
  SysUtils, Classes, HDeviceInfo,HDeviceDefine,HDataModel;

type
  TDeviceDo = class(TObject)
    class function GetInstance(): TDeviceDo;
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
  protected
    FComGroupList: TList;
    constructor Create;
  public
    procedure initTestData;
    procedure startTestData;
    procedure stopTestData;
  private
    procedure ErrorBlock(Sender: TObject;error: TErrorMsg);
    procedure successBlock(Sender: TObject;rspData:TDataModel);
  end;

implementation
uses HLog,HJason,
     HBellco,HToray,HBraun,HNikkiso,HGambro,HFresenius;
var
  GlobalSingle: TDeviceDo;
  { TDeviceAct }

constructor TDeviceDo.Create;
begin
  FComGroupList := TList.Create;
end;

procedure TDeviceDo.FreeInstance;
begin
  inherited;
  GlobalSingle := nil;
end;

class function TDeviceDo.GetInstance: TDeviceDo;
begin
  if not Assigned(GlobalSingle) then
  begin
    GlobalSingle := TDeviceDo.Create();
  end;
  Result := GlobalSingle;
end;

class function TDeviceDo.NewInstance: TObject;
begin
  if not Assigned(GlobalSingle) then
    GlobalSingle := TDeviceDo(inherited NewInstance);
  Result := GlobalSingle;
end;

procedure TDeviceDo.initTestData;
var
  deviceInfo: TDeviceInfo;
  lJason:TJason;
begin
  FComGroupList.Clear;

  deviceInfo := TDeviceInfo.Create;
  deviceInfo.MType := 'B';
  deviceInfo.MBrand := 'Bellco';
  deviceInfo.MLink := DLinkCom;
  deviceInfo.MName := 'COM3';
  deviceInfo.MPort := 9600;
  lJason := TBellco.Create(deviceInfo);
  lJason.failCallBack := ErrorBlock;
  lJason.successCallBack := successBlock;
  lJason.init;
  FComGroupList.Add(lJason);

  deviceInfo := TDeviceInfo.Create;
  deviceInfo.MType := 'B';
  deviceInfo.MBrand := 'Nikkiso';
  deviceInfo.MLink := DLinkCom;
  deviceInfo.MName := 'COM4';
  deviceInfo.MPort := 9600;
  lJason := TNikkiso.Create(deviceInfo);
  lJason.failCallBack := ErrorBlock;
  lJason.successCallBack := successBlock;
  lJason.init;
  FComGroupList.Add(lJason);

  deviceInfo := TDeviceInfo.Create;
  deviceInfo.MType := 'B';
  deviceInfo.MBrand := 'Bellco';
  deviceInfo.MLink := DLinkNet;
  deviceInfo.MName := '192.168.1.1';
  deviceInfo.MPort := 6667;
  lJason := TBellco.Create(deviceInfo);
  lJason.failCallBack := ErrorBlock;
  lJason.successCallBack := successBlock;
  lJason.init;
  FComGroupList.Add(lJason);
end;

procedure TDeviceDo.startTestData;
var
  i: Integer;
  lJason:TJason;
begin
  if FComGroupList.Count < 1 then
  begin
    initTestData;
  end;
  for i := 0 to FComGroupList.count - 1 do
  begin
    lJason := FComGroupList.Items[i];
    lJason.send;
  end;
end;

procedure TDeviceDo.stopTestData;
var
  i: Integer;
  lJason:TJason;
begin
  for i := 0 to FComGroupList.count - 1 do
  begin
    lJason := FComGroupList.Items[i];
    lJason.close;
  end;
end;

procedure TDeviceDo.successBlock(Sender: TObject;rspData:TDataModel);
begin
  TLog.Instance.DDLogInfo('success:' + rspData.SessionTime + '--' + rspData.VenousPressure);
end;

procedure TDeviceDo.ErrorBlock(Sender: TObject;error: TErrorMsg);
begin
  TLog.Instance.DDLogInfo('callBackError' + error.mType + error.mDesc);
end;

end.

