{*******************************************************}
{                                                       }
{       HimsSoft �ջ�װѪ͸�����ݽ���                                         }
{                                                       }
{       ��Ȩ���� (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HNikkiso;

interface

uses
  HJason,HDataModel;

type
  TNikkiso = class(TJason)
  protected
    procedure initCommond;override;
    procedure praseData(data: array of Byte; var rspData:TDataModel);override;
  end;

implementation

{ TBellco }

procedure TNikkiso.initCommond;
begin
  inherited;
  fDeviceInfo.MCommond := 'XXXXXXXX';
end;

procedure TNikkiso.praseData(data: array of Byte; var rspData:TDataModel);
begin
  if not Assigned(rspData) then
    rspData := TDataModel.Create;
  rspData :=TDataModel.generateDataForTest;
end;

end.
