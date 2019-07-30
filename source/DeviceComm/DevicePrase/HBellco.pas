{*******************************************************}
{                                                       }
{       HimsSoft 贝尔克血透机数据解析                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HBellco;

interface

uses
  HJason,HDataModel,HDeviceInfo;

type
  TBellco = class(TJason)
  public
    constructor Create(deviceInfo: TDeviceInfo);override;
  protected
    procedure praseData(data: array of Byte; var rspData:TDataModel);override;
  end;

implementation

{ TBellco }

constructor TBellco.Create(deviceInfo: TDeviceInfo);
begin
  inherited;
  fDeviceInfo := deviceInfo;
  fDeviceInfo.dCommond := '4B 0D 0A';
//  Setlength(fCommond,3);
//  fCommond[0]:=byte($4B);
//  fCommond[1]:=byte($0D);
//  fCommond[2]:=byte($0A);
end;

procedure TBellco.praseData(data: array of Byte; var rspData:TDataModel);
begin
  if not Assigned(rspData) then
    rspData := TDataModel.Create;
  rspData :=TDataModel.generateDataForTest;
end;

end.

