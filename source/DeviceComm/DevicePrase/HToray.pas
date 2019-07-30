{*******************************************************}
{                                                       }
{       HimsSoft 东丽血透机数据解析                                         }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HToray;

interface

uses
  HJason,HDataModel,HDeviceInfo;

type
  TToray = class(TJason)
  public
    constructor Create(deviceInfo: TDeviceInfo);override;
  protected
    procedure praseData(data: array of Byte; var rspData:TDataModel);override;
  end;

implementation

{ TToray }

constructor TToray.Create(deviceInfo: TDeviceInfo);
begin
  inherited;
  fDeviceInfo := deviceInfo;
  fDeviceInfo.dCommond := 'XXXXXXX';
end;

procedure TToray.praseData(data: array of Byte; var rspData:TDataModel);
begin
  if not Assigned(rspData) then
    rspData := TDataModel.Create;
  rspData :=TDataModel.generateDataForTest;
end;

end.

