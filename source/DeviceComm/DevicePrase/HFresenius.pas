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
  HDeviceBase,HDataModel;

type
  TFresenius = class(TDeviceBase)
    procedure praseData(data: array of Byte; var rspData:TDataModel);override;
  end;

implementation

{ TFresenius }

procedure TFresenius.praseData(data: array of Byte; var rspData:TDataModel);
begin
  if not Assigned(rspData) then
    rspData := TDataModel.Create;
  rspData :=TDataModel.generateDataForTest;
end;

end.

