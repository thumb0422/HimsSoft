unit HDeviceInfo;

interface

uses System.Classes;

type
  TDeviceInfo = class
  private
    FdType: string; // �豸����
    FdName: string; // �豸����
    FdCommond: string; // �豸����
    FdLink: Integer; // �豸�ɼ����ݷ�ʽ
    procedure SetdType(val: string);
    procedure SetdName(val: string);
    procedure SetdCommond(val: string);
    procedure SetdLink(val: Integer);
  public
    property dType: string read FdType write SetdType;
    property dName: string read FdName write SetdName;
    property dCommond: string read FdCommond write SetdCommond;
    property dLink: Integer read FdLink write SetdLink;
    constructor Create;
  protected
    destructor Destroy; override;
  end;

implementation

procedure TDeviceInfo.SetdType(val: string);
begin
end;

procedure TDeviceInfo.SetdName(val: string);
begin
end;

procedure TDeviceInfo.SetdCommond(val: string);
begin
end;

procedure TDeviceInfo.SetdLink(val: Integer);
begin
end;

constructor TDeviceInfo.Create;
begin

end;

destructor TDeviceInfo.Destroy;
begin

end;

end.
