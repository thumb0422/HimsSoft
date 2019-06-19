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
    FbedId: string;
    FroomId: string;
    FcId: string;
    procedure SetbedId(const Value: string);
    procedure SetcId(const Value: string);
    procedure SetroomId(const Value: string);
  published
    property cId: string read FcId write SetcId; // �û�ΨһID
    property roomId: string read FroomId write SetroomId; // �����
    property bedId: string read FbedId write SetbedId; // ��λ��
  end;

implementation

{ TCustomer }

procedure TCustomer.SetbedId(const Value: string);
begin
  FbedId := Value;
end;

procedure TCustomer.SetcId(const Value: string);
begin
  FcId := Value;
end;

procedure TCustomer.SetroomId(const Value: string);
begin
  FroomId := Value;
end;

end.
