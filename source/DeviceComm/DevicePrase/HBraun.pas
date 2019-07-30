{*******************************************************}
{                                                       }
{       HimsSoft 贝朗血透机数据解析                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HBraun;

interface

uses
  HJason,HDataModel,HDeviceInfo;

type
  TBraun = class(TJason)
  public
    constructor Create(deviceInfo: TDeviceInfo);override;
  protected
    procedure praseData(data: array of Byte; var rspData:TDataModel);override;
  end;

implementation

{ TBellco }

constructor TBraun.Create(deviceInfo: TDeviceInfo);
begin
  inherited;
  fDeviceInfo := deviceInfo;
  fDeviceInfo.dCommond := 'XXXXXXXX';
end;

procedure TBraun.praseData(data: array of Byte; var rspData:TDataModel);
begin
  if not Assigned(rspData) then
    rspData := TDataModel.Create;
  rspData :=TDataModel.generateDataForTest;
end;


end.
