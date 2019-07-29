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
  System.Generics.Collections,HDeviceBase,HDataModel;
type
  TNikkiso = class(TDeviceBase)
    procedure praseData(data: array of Byte; var rspData:TDataModel);override;
  end;

implementation

{ TBellco }

procedure TNikkiso.praseData(data: array of Byte; var rspData:TDataModel);
begin
  if not Assigned(rspData) then
    rspData := TDataModel.Create;
  rspData :=TDataModel.generateDataForTest;
end;

end.
