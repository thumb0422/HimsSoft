unit HMenu;

interface
   type TMenu = class
  private
    FMDesc: string;
    FMParent: Integer;
    FMID: Integer;
    FMVisible: Integer;
    procedure SetMDesc(const Value: string);
    procedure SetMID(const Value: Integer);
    procedure SetMParent(const Value: Integer);
    procedure SetMVisible(const Value: Integer);
  published
     property MID:Integer read FMID write SetMID;//ID
     property MDesc:string read FMDesc write SetMDesc;//Caption
     property MParent:Integer read FMParent write SetMParent;//ParentId
     property MVisible:Integer read FMVisible write SetMVisible;//Visible
   end;
implementation

{ TMenu }

procedure TMenu.SetMDesc(const Value: string);
begin
  FMDesc := Value;
end;

procedure TMenu.SetMID(const Value: Integer);
begin
  FMID := Value;
end;

procedure TMenu.SetMParent(const Value: Integer);
begin
  FMParent := Value;
end;

procedure TMenu.SetMVisible(const Value: Integer);
begin
  FMVisible := Value;
end;

end.
