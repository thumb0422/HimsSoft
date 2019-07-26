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
  System.Generics.Collections,HDeviceBase,HDataModel;

type
  TToray = class(TDeviceBase)
    procedure praseData(data: array of Byte; var rspData:TDataModel);override;
  end;

implementation

{ TToray }

procedure TToray.praseData(data: array of Byte; var rspData:TDataModel);
begin
  if not Assigned(rspData) then
    rspData := TDataModel.Create;
  rspData :=TDataModel.generateDataForTest;
//  rspData.VenousPressure := '';
end;

end.

