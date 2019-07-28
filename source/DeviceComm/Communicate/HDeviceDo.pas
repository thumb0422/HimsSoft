{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HDeviceDo;

interface

uses
  SysUtils, Classes, HCate, HCom32, HNet, HDeviceInfo,HDeviceDefine,HDataModel;

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
    procedure successBlock(Sender: TObject;rspData: TDataModel);
  end;

implementation
uses HLog;
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
  i: Integer;
  deviceInfo: TDeviceInfo;
  com32: THComm;
  net485: TNet;
begin
  FComGroupList.Clear;
  for i := 2 to 5 do
  begin
    deviceInfo := TDeviceInfo.Create;
    deviceInfo.dType := 'B';
    deviceInfo.dBrand := 'Bellco';
    deviceInfo.dDesc := '贝尔克' + IntToStr(i);
    deviceInfo.dCommond := '4B 0D 0A';
    deviceInfo.dLink := DLinkCom;
    deviceInfo.dName := 'COM' + IntToStr(i);
    deviceInfo.dPort := 9600;
    deviceInfo.dTag := 1 * 100 + i;
    com32 := THComm.Create(deviceInfo);
    com32.callBackError := ErrorBlock;
    com32.callBackSuccess := successBlock;
    com32.init;
    FComGroupList.Add(com32);
  end;

  for i := 0 to 5 do
  begin
    deviceInfo := TDeviceInfo.Create;
    deviceInfo.dType := 'F';
    deviceInfo.dBrand := 'Fresenius';
    deviceInfo.dDesc := '费森' + IntToStr(i);
    deviceInfo.dCommond := '0A 0B 0C ' + IntToStr(i);
    deviceInfo.dLink := DLinkNet;
    deviceInfo.dName := '172.16.26.129';
    deviceInfo.dPort := 6666 + i;
    deviceInfo.dTag := 2 * 100 + i;
    net485 := TNet.Create(deviceInfo);
    net485.callBackError := ErrorBlock;
    net485.callBackSuccess := successBlock;
    net485.init;
    FComGroupList.Add(net485);
  end;
end;

procedure TDeviceDo.startTestData;
var
  i: Integer;
  cat:TCate;
begin
  if FComGroupList.Count < 1 then
  begin
    initTestData;
  end;
  for i := 0 to FComGroupList.count - 1 do
  begin
    cat := FComGroupList.Items[i];
    cat.send;
  end;
end;

procedure TDeviceDo.stopTestData;
var
  i: Integer;
  cat:TCate;
begin
  for i := 0 to FComGroupList.count - 1 do
  begin
    cat := FComGroupList.Items[i];
    cat.close;
  end;
end;

procedure TDeviceDo.successBlock(Sender: TObject;rspData: TDataModel);
begin
  TLog.Instance.DDLogInfo('success:' + rspData.SessionTime + '--' + rspData.VenousPressure);
end;

procedure TDeviceDo.ErrorBlock(Sender: TObject;error: TErrorMsg);
begin
  TLog.Instance.DDLogInfo('callBackError' + error.mType + error.mDesc);
end;

end.

