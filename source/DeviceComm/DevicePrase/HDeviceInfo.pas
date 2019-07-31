{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HDeviceInfo;

interface
uses HDeviceDefine;
type
  TDeviceInfo = class
  private
    FMDesc: string;// 设备名称全称+型号
    FMName: string;// com2、com3、192.168.1.1 之类的关键信息
    FMLink: DLinkType;// 设备采集数据方式
    FMCommond: string;// 设备命令
    FMPort: Integer;// 端口号
    FMTag: Integer;// 设备标志  所有中的唯一  用来区分是哪个组件  在需要区分多个组件的情况下，必填
    FMType: string;// 设备类型简称 A  B  C  D 之类
    FMBrand: string;// 设备类
    procedure SetMBrand(const Value: string);
    procedure SetMCommond(const Value: string);
    procedure SetMDesc(const Value: string);
    procedure SetMLink(const Value: DLinkType);
    procedure SetMName(const Value: string);
    procedure SetMPort(const Value: Integer);
    procedure SetMTag(const Value: Integer);
    procedure SetMType(const Value: string); // 设备品牌
  public
    property MType: string read FMType write SetMType;
    property MBrand: string read FMBrand write SetMBrand;
    property MName: string read FMName write SetMName;
    property MDesc: string read FMDesc write SetMDesc;
    property MCommond: string read FMCommond write SetMCommond;
    property MLink: DLinkType read FMLink write SetMLink;
    property MTag: Integer read FMTag write SetMTag;
    property MPort: Integer read FMPort write SetMPort;
  end;

implementation

{ TDeviceInfo }

procedure TDeviceInfo.SetMBrand(const Value: string);
begin
  FMBrand := Value;
end;

procedure TDeviceInfo.SetMCommond(const Value: string);
begin
  FMCommond := Value;
end;

procedure TDeviceInfo.SetMDesc(const Value: string);
begin
  FMDesc := Value;
end;

procedure TDeviceInfo.SetMLink(const Value: DLinkType);
begin
  FMLink := Value;
end;

procedure TDeviceInfo.SetMName(const Value: string);
begin
  FMName := Value;
end;

procedure TDeviceInfo.SetMPort(const Value: Integer);
begin
  FMPort := Value;
end;

procedure TDeviceInfo.SetMTag(const Value: Integer);
begin
  FMTag := Value;
end;

procedure TDeviceInfo.SetMType(const Value: string);
begin
  FMType := Value;
end;

end.
