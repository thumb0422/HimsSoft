unit HLog;

interface

uses
  System.SysUtils, System.Threading;

type
  TLog = class
  private
    class var
      FInstance: TLog;
    class function GetInstance: TLog; static;
  public
    procedure DDLogInfo(str: string);
    procedure DDLogError(str: string);
    class property Instance: TLog read GetInstance;
  protected
    constructor Create;
    destructor Destroy; override;
    procedure writeToFile(str: string);
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

destructor TLog.Destroy;
begin
  FreeAndNil(FInstance);
end;

procedure TLog.DDLogInfo(str: string);
begin
  writeToFile('Info:' + str);
end;

procedure TLog.DDLogError(str: string);
begin
  writeToFile('Error: ' + str);
end;

procedure TLog.writeToFile(str: string);
var
  wLogFile: TextFile;
  DateTime: TDateTime;
  strTxtName, strContent: string;
begin
  DateTime := now;
  strTxtName := ExtractFilePath(paramstr(0)) + FormatdateTime('yyyy-mm-dd', DateTime) + '.log';
  AssignFile(wLogFile, strTxtName);
  if FileExists(strTxtName) then
    Append(wLogFile)
  else
  begin
    ReWrite(wLogFile);
  end;
  strContent := FormatdateTime('tt', DateTime) + ' ' + str;
  Writeln(wLogFile, strContent);
  CloseFile(wLogFile)
end;

end.

