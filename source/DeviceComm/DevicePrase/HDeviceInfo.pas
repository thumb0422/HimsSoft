{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       ��Ȩ���� (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HDeviceInfo;

interface
uses HDeviceDefine;
type
  TDeviceInfo = class
  private
    FMDesc: string;// �豸����ȫ��+�ͺ�
    FMName: string;// com2��com3��192.168.1.1 ֮��Ĺؼ���Ϣ
    FMLink: DLinkType;// �豸�ɼ����ݷ�ʽ
    FMCommond: string;// �豸����
    FMPort: Integer;// �˿ں�
    FMTag: Integer;// �豸��־  �����е�Ψһ  �����������ĸ����  ����Ҫ���ֶ�����������£�����
    FMType: string;// �豸���ͼ�� A  B  C  D ֮��
    FMBrand: string;// �豸��
    procedure SetMBrand(const Value: string);
    procedure SetMCommond(const Value: string);
    procedure SetMDesc(const Value: string);
    procedure SetMLink(const Value: DLinkType);
    procedure SetMName(const Value: string);
    procedure SetMPort(const Value: Integer);
    procedure SetMTag(const Value: Integer);
    procedure SetMType(const Value: string); // �豸Ʒ��
  public
    property MType: string read FMType write SetMType;
    property MBrand: string read FMBrand write SetMBrand;
    property MName: string read FMName write SetMName;
    property MDesc: string read FMDesc write SetMDesc;
    property MCommond: string read FMCommond write SetMCommond;
    property MLink: DLinkType read FMLink write SetMLink;
    property MTag: Integer read FMTag write SetMTag;
    property MPort: Integer read FMPort write SetMPort;
  end;

implementation

{ TDeviceInfo }

procedure TDeviceInfo.SetMBrand(const Value: string);
begin
  FMBrand := Value;
end;

procedure TDeviceInfo.SetMCommond(const Value: string);
begin
  FMCommond := Value;
end;

procedure TDeviceInfo.SetMDesc(const Value: string);
begin
  FMDesc := Value;
end;

procedure TDeviceInfo.SetMLink(const Value: DLinkType);
begin
  FMLink := Value;
end;

procedure TDeviceInfo.SetMName(const Value: string);
begin
  FMName := Value;
end;

procedure TDeviceInfo.SetMPort(const Value: Integer);
begin
  FMPort := Value;
end;

procedure TDeviceInfo.SetMTag(const Value: Integer);
begin
  FMTag := Value;
end;

procedure TDeviceInfo.SetMType(const Value: string);
begin
  FMType := Value;
end;

end.
