{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       ∞Ê»®À˘”– (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HCustomer;

interface
uses HDeviceDefine;
type
  TCustomer = class
  private
    FMCustName: string;
    FMMechineId: string;
    FMLinkType: DLinkType;
    FMCustId: string;
    FMBedId: string;
    FMPort: string;
    FMAddress: string;
    FMBrand: string;
    procedure SetMBedId(const Value: string);
    procedure SetMCustId(const Value: string);
    procedure SetMCustName(const Value: string);
    procedure SetMLinkType(const Value: DLinkType);
    procedure SetMMechineId(const Value: string);
    procedure SetMAddress(const Value: string);
    procedure SetMPort(const Value: string);
    procedure SetMBrand(const Value: string);
  public
    property MCustId :string read FMCustId write SetMCustId;
    property MCustName :string read FMCustName write SetMCustName;
    property MBedId :string read FMBedId write SetMBedId;
    property MMechineId :string read FMMechineId write SetMMechineId;
    property MLinkType:DLinkType read FMLinkType write SetMLinkType;
    property MAddress:string read FMAddress write SetMAddress;
    property MPort :string read FMPort write SetMPort;
    property MBrand :string read FMBrand write SetMBrand;
  end;

implementation

{ TCustomer }

procedure TCustomer.SetMAddress(const Value: string);
begin
  FMAddress := Value;
end;

procedure TCustomer.SetMBedId(const Value: string);
begin
  FMBedId := Value;
end;

procedure TCustomer.SetMBrand(const Value: string);
begin
  FMBrand := Value;
end;

procedure TCustomer.SetMCustId(const Value: string);
begin
  FMCustId := Value;
end;

procedure TCustomer.SetMCustName(const Value: string);
begin
  FMCustName := Value;
end;

procedure TCustomer.SetMLinkType(const Value: DLinkType);
begin
  FMLinkType := Value;
end;

procedure TCustomer.SetMMechineId(const Value: string);
begin
  FMMechineId := Value;
end;

procedure TCustomer.SetMPort(const Value: string);
begin
  FMPort := Value;
end;

end.
