{*******************************************************}
{                                                       }
{       HimsSoft 金宝血透机数据解析                                    }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HGambro;

interface

uses
  HJason,HDataModel,HDeviceInfo;

type
  TGambro = class(TJason)
  public
    constructor Create(deviceInfo: TDeviceInfo);override;
  protected
    procedure praseData(data: array of Byte;  var rspData:TDataModel);override;
  end;

implementation

{ TGambro }

constructor TGambro.Create(deviceInfo: TDeviceInfo);
begin
  inherited;
  fDeviceInfo := deviceInfo;
  fDeviceInfo.dCommond := 'XXXXXXXX';
end;

procedure TGambro.praseData(data: array of Byte; var rspData:TDataModel);
begin
  if not Assigned(rspData) then
    rspData := TDataModel.Create;
  rspData :=TDataModel.generateDataForTest;
end;

end.

