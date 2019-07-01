{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
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
    property cId: string read FcId write SetcId; // 用户唯一ID
    property cRoomId: string read FcRoomId write SetcRoomId; // 房间号
    property cBedId: string read FcBedId write SetcBedId; // 床位号
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
