{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       ��Ȩ���� (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HCustomer;

interface

type
  TCustomer = class
  private
    FcId: string;
    FcBedId: string;
    FcRoomId: string;
    procedure SetcBedId(const Value: string);
    procedure SetcId(const Value: string);
    procedure SetcRoomId(const Value: string);
  published
    property cId: string read FcId write SetcId; // �û�ΨһID
    property cRoomId: string read FcRoomId write SetcRoomId; // �����
    property cBedId: string read FcBedId write SetcBedId; // ��λ��
  end;

implementation

{ TCustomer }

procedure TCustomer.SetcBedId(const Value: string);
begin
  FcBedId := Value;
end;

procedure TCustomer.SetcId(const Value: string);
begin
  FcId := Value;
end;

procedure TCustomer.SetcRoomId(const Value: string);
begin
  FcRoomId := Value;
end;

end.
