{*******************************************************}
{                                                       }
{       HimsSoft ������Ѫ͸�����ݽ���                                        }
{                                                       }
{       ��Ȩ���� (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HBellco;

interface

uses
  System.Generics.Collections,HDeviceBase,HDataModel;

type
  TBellco = class(TDeviceBase)
    procedure praseData(data: array of Byte; var rspData:TDataModel);override;
  end;

implementation

{ TBellco }

procedure TBellco.praseData(data: array of Byte; var rspData:TDataModel);
begin
  if not Assigned(rspData) then
    rspData := TDataModel.Create;
  rspData :=TDataModel.generateDataForTest;
end;

end.

