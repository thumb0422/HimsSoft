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
  System.Generics.Collections,HDeviceBase;

type
  TBellco = class(TDeviceBase)
    procedure praseData(data: array of Byte; var json: TDictionary<string, string>);override;
  end;

implementation

{ TBellco }

procedure TBellco.praseData(data: array of Byte; var json: TDictionary<string, string>);
begin
  if not Assigned(json) then
    json := TDictionary<string, string>.Create(0);
  json.Clear;
  json.AddOrSetValue('A1', '100');
  json.AddOrSetValue('B1', '13');
  json.AddOrSetValue('C1', '0.98');
  json.AddOrSetValue('D1', '2');
  json.AddOrSetValue('E1', '-0.91');
  json.AddOrSetValue('F1', '1');
end;

end.

