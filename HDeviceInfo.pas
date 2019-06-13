unit HDeviceInfo;

interface

uses System.Classes;

type
  EDeviceLinkType = (dltUnKnow, dtlComm, dtlNet);

  TDeviceInfo = class
  private
  var
    FdType: string; // �豸����
    FdName: string; // com2��com3��192.168.1.1 ֮��Ĺؼ���Ϣ
    FdDesc: string; // �豸����
    FdCommond: string; // �豸����
    FdLink: EDeviceLinkType; // �豸�ɼ����ݷ�ʽ
    FdTag: Integer; // �豸��־  �����е�Ψһ  �����������ĸ����  ����Ҫ���ֶ�����������£�����
    FdPort: Integer; // �˿ں�
    procedure SetdType(val: string);
    procedure SetdName(val: string);
    procedure SetdDesc(val: string);
    procedure SetdCommond(val: string);
    procedure SetdLink(val: EDeviceLinkType);
    procedure SetdTag(val: Integer);
    procedure SetdPort(val: Integer);
  public
    property dType: string read FdType write SetdType;
    property dName: string read FdName write SetdName;
    property dDesc: string read FdDesc write SetdDesc;
    property dCommond: string read FdCommond write SetdCommond;
    property dLink: EDeviceLinkType read FdLink write SetdLink;
    property dTag: Integer read FdTag write SetdTag;
    property dPort: Integer read FdPort write SetdPort;
    constructor Create;
  protected
    destructor Destroy; override;
  end;

implementation

procedure TDeviceInfo.SetdType(val: string);
begin
  FdType := val;
end;

procedure TDeviceInfo.SetdName(val: string);
begin
  FdName := val;
end;

procedure TDeviceInfo.SetdDesc(val: string);
begin
  FdDesc := val;
end;

procedure TDeviceInfo.SetdCommond(val: string);
begin
  FdCommond := val;
end;

procedure TDeviceInfo.SetdLink(val: EDeviceLinkType);
begin
  FdLink := val;
end;

procedure TDeviceInfo.SetdTag(val: Integer);
begin
  FdTag := val;
end;

procedure TDeviceInfo.SetdPort(val: Integer);
begin
  FdPort := val;
end;

constructor TDeviceInfo.Create;
begin

end;

destructor TDeviceInfo.Destroy;
begin
end;

end.
