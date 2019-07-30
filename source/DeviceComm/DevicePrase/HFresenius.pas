{*******************************************************}
{                                                       }
{       HimsSoft 费森尤斯血透机数据解析                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HFresenius;

interface

uses
  HJason,HDataModel;

type
  TFresenius = class(TJason)
  protected
    procedure initCommond;override;
    procedure praseData(data: array of Byte; var rspData:TDataModel);override;
  end;

implementation

{ TFresenius }

procedure TFresenius.initCommond;
begin
  inherited;
  fDeviceInfo.dCommond := 'XXXXXXXX';
end;

procedure TFresenius.praseData(data: array of Byte; var rspData:TDataModel);
begin
  if not Assigned(rspData) then
    rspData := TDataModel.Create;
  rspData :=TDataModel.generateDataForTest;
end;

end.

