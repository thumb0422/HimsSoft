{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HDeviceInfo;

interface



type
  EDeviceLinkType = (dltUnKnow, dtlComm, dtlNet);

  TDeviceInfo = class
  private
  var
    FdType: string; // 设备类型简称 A  B  C  D 之类
    FdName: string; // com2、com3、192.168.1.1 之类的关键信息
    FdDesc: string; // 设备名称全称+型号
    FdCommond: string; // 设备命令
    FdLink: EDeviceLinkType; // 设备采集数据方式
    FdTag: Integer; // 设备标志  所有中的唯一  用来区分是哪个组件  在需要区分多个组件的情况下，必填
    FdPort: Integer; // 端口号
    FdBrand: string; // 设备品牌
    procedure SetdType(val: string);
    procedure SetdName(val: string);
    procedure SetdDesc(val: string);
    procedure SetdCommond(val: string);
    procedure SetdLink(val: EDeviceLinkType);
    procedure SetdTag(val: Integer);
    procedure SetdPort(val: Integer);
    procedure SetdBrand(const Value: string);
  public
    property dType: string read FdType write SetdType;
    property dBrand: string read FdBrand write SetdBrand;
    property dName: string read FdName write SetdName;
    property dDesc: string read FdDesc write SetdDesc;
    property dCommond: string read FdCommond write SetdCommond;
    property dLink: EDeviceLinkType read FdLink write SetdLink;
    property dTag: Integer read FdTag write SetdTag;
    property dPort: Integer read FdPort write SetdPort;
    constructor Create;
  protected
    destructor Destroy; override;
  end;

implementation

procedure TDeviceInfo.SetdType(val: string);
begin
  FdType := val;
  if val ='F' then
  begin
    FdCommond := '';
  end;
end;

procedure TDeviceInfo.SetdName(val: string);
begin
  FdName := val;
end;

procedure TDeviceInfo.SetdDesc(val: string);
begin
  FdDesc := val;
end;

procedure TDeviceInfo.SetdBrand(const Value: string);
begin
  FdBrand := Value;
end;

procedure TDeviceInfo.SetdCommond(val: string);
begin
  FdCommond := val;
end;

procedure TDeviceInfo.SetdLink(val: EDeviceLinkType);
begin
  FdLink := val;
end;

procedure TDeviceInfo.SetdTag(val: Integer);
begin
  FdTag := val;
end;

procedure TDeviceInfo.SetdPort(val: Integer);
begin
  FdPort := val;
end;

constructor TDeviceInfo.Create;
begin

end;

destructor TDeviceInfo.Destroy;
begin
end;

end.
