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
  System.Generics.Collections,HDeviceBase;

type
  TToray = class(TDeviceBase)
    procedure praseData(data: array of Byte; var json: TDictionary<string, string>);override;
  end;

implementation

{ TToray }

procedure TToray.praseData(data: array of Byte; var json: TDictionary<string, string>);
begin
  if not Assigned(json) then
    json := TDictionary<string, string>.Create(0);
  json.Clear;
  json.AddOrSetValue('A1', '100');
  json.AddOrSetValue('G1', '2000');
end;

end.

