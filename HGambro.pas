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
  System.Generics.Collections,HDeviceBase;

type
  TGambro = class(TDeviceBase)
    procedure praseData(data: array of Byte; var json: TDictionary<string, string>);override;
  end;

implementation

{ TGambro }

procedure TGambro.praseData(data: array of Byte; var json: TDictionary<string, string>);
begin
  if not Assigned(json) then
    json := TDictionary<string, string>.Create(0);
  json.Clear;
//  json.AddOrSetValue('A1', '100');
//  json.AddOrSetValue('B1', '13');
//  json.AddOrSetValue('C1', '0.98');
//  json.AddOrSetValue('D1', '2');
//  json.AddOrSetValue('E1', '-0.91');
//  json.AddOrSetValue('F1', '1');
//  json.AddOrSetValue('G1', '2000');
end;

end.

