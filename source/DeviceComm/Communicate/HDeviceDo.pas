{ ******************************************************* }
{ }
{ HimsSoft }
{ }
{ 版权所有 (C) 2019 thumb0422@163.com }
{ }
{ ******************************************************* }

unit HDeviceDo;

interface

uses
  SysUtils, Classes, HCate, HCom32, HNet, HDeviceInfo;

type
  TDeviceAct = class(TObject)
    class function GetInstance(): TDeviceAct;
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
  protected
    FComGroupList: TList;
    constructor Create;
  public
    procedure initTestData;
    procedure startTestData;
    procedure stopTestData;
  end;

implementation

var
  GlobalSingle: TDeviceAct;
  { TDeviceAct }

constructor TDeviceAct.Create;
begin
  FComGroupList := TList.Create;
end;

procedure TDeviceAct.FreeInstance;
begin
  inherited;
  GlobalSingle := nil;
end;

class function TDeviceAct.GetInstance: TDeviceAct;
begin
  if not Assigned(GlobalSingle) then
  begin
    GlobalSingle := TDeviceAct.Create();
  end;
  Result := GlobalSingle;
end;

class function TDeviceAct.NewInstance: TObject;
begin
  if not Assigned(GlobalSingle) then
    GlobalSingle := TDeviceAct(inherited NewInstance);
  Result := GlobalSingle;
end;

procedure TDeviceAct.initTestData;
var
  i, n: Integer;
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
    deviceInfo.dLink := dtlComm;
    deviceInfo.dName := 'COM' + IntToStr(i);
    deviceInfo.dPort := 9600;
    deviceInfo.dTag := 1 * 100 + i;
    com32 := THComm.Create(deviceInfo);
    com32.cInterval := 3000;
    com32.init;
    FComGroupList.Add(com32);
  end;

  for i := 20 to 28 do
  begin
    deviceInfo := TDeviceInfo.Create;
    deviceInfo.dType := 'F';
    deviceInfo.dBrand := 'Fresenius';
    deviceInfo.dDesc := '费森' + IntToStr(i);
    deviceInfo.dCommond := '0A 0B 0C ' + IntToStr(i);
    deviceInfo.dLink := dtlNet;
    deviceInfo.dName := '172.16.26.129';
    deviceInfo.dPort := 6666 + i;
    deviceInfo.dTag := 2 * 100 + i;
    net485 := TNet.Create(deviceInfo);
    net485.cInterval := 3000;
    net485.init;
    FComGroupList.Add(net485);
  end;

  n := FComGroupList.count;
end;

procedure TDeviceAct.startTestData;
var
  i: Integer;
  cat:TCate;
begin
  for i := 0 to FComGroupList.count - 1 do
  begin
    cat := FComGroupList.Items[i];
    cat.send;
  end;
end;

procedure TDeviceAct.stopTestData;
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

end.

