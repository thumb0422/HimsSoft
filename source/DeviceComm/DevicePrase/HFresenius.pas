{*******************************************************}
{                                                       }
{       HimsSoft ��ɭ��˹Ѫ͸�����ݽ���                                        }
{                                                       }
{       ��Ȩ���� (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HFresenius;

interface

uses
  HJason,HDataModel,HDeviceInfo;

type
  TFresenius = class(TJason)
  public
    constructor Create(deviceInfo: TDeviceInfo);override;
  protected
    procedure praseData(data: array of Byte; var rspData:TDataModel);override;
  end;

implementation

{ TFresenius }

constructor TFresenius.Create(deviceInfo: TDeviceInfo);
begin
  inherited;
  fDeviceInfo := deviceInfo;
  fDeviceInfo.dCommond := 'XXXXXXXX';
end;

procedure TFresenius.praseData(data: array of Byte; var rspData:TDataModel);
begin
  if not Assigned(rspData) then
    rspData := TDataModel.Create;
  rspData :=TDataModel.generateDataForTest;
end;

end.

