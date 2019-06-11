unit HLog;

interface

uses System.SysUtils;

type
  TLog = class
  private
    class var FInstance: TLog;
    class function GetInstance: TLog; static;
  public
    procedure DDLogInfo(str: string);
    procedure DDLogError(str: string);
    class property Instance: TLog read GetInstance;
  protected
    constructor Create;
    Destructor Destroy; override;
  end;

implementation

class function TLog.GetInstance: TLog;
begin
  if FInstance = nil then
    FInstance := TLog.Create;
  Result := FInstance;
end;

constructor TLog.Create;
begin

end;

Destructor TLog.Destroy;
begin
  FreeAndNil(FInstance);
end;

procedure TLog.DDLogInfo(str: string);
begin

end;

procedure TLog.DDLogError(str: string);
begin

end;

end.
