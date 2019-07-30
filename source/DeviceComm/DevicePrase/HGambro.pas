{*******************************************************}
{                                                       }
{       HimsSoft ��Ѫ͸�����ݽ���                                    }
{                                                       }
{       ��Ȩ���� (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HGambro;

interface

uses
  HJason,HDataModel;

type
  TGambro = class(TJason)
  protected
    procedure initCommond;override;
    procedure praseData(data: array of Byte;  var rspData:TDataModel);override;
  end;

implementation

{ TGambro }

procedure TGambro.initCommond;
begin
  inherited;
  fDeviceInfo.dCommond := 'XXXXXXXX';
end;

procedure TGambro.praseData(data: array of Byte; var rspData:TDataModel);
begin
  if not Assigned(rspData) then
    rspData := TDataModel.Create;
  rspData :=TDataModel.generateDataForTest;
end;

end.

