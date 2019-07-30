{*******************************************************}
{                                                       }
{       HimsSoft 日机装血透机数据解析                                         }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HNikkiso;

interface

uses
  HJason,HDataModel,HDeviceInfo;

type
  TNikkiso = class(TJason)
  public
    constructor Create(deviceInfo: TDeviceInfo);override;
  protected
    procedure praseData(data: array of Byte; var rspData:TDataModel);override;
  end;

implementation

{ TBellco }

constructor TNikkiso.Create(deviceInfo: TDeviceInfo);
begin
  inherited;
  fDeviceInfo := deviceInfo;
  fDeviceInfo.dCommond := 'XXXXXXX';
end;

procedure TNikkiso.praseData(data: array of Byte; var rspData:TDataModel);
begin
  if not Assigned(rspData) then
    rspData := TDataModel.Create;
  rspData :=TDataModel.generateDataForTest;
end;

end.
