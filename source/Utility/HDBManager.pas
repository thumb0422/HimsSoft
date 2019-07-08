unit HDBManager;

interface
uses System.SysUtils, System.SyncObjs,SQLite3,SQLiteTable3;
  type
  TDBManager = class
  private
    class var FInstance: TDBManager;
    class function GetInstance: TDBManager; static;
  public
    class property Instance: TDBManager read GetInstance;
    class procedure ReleaseInstance;
  protected
    constructor Create;
    destructor Destroy; override;
  private
    sldb: TSQLiteDatabase;
    sltb: TSQLIteTable;
  end;

implementation
var dbPath :string;
{ TDBManager }

constructor TDBManager.Create;
var
  sSQL: String;
begin
  dbPath := ExtractFilePath(paramstr(0)) + 'data.db';
  if FileExists(dbPath) then
  begin
    DeleteFile(dbPath);
  end;
  sldb := TSQLiteDatabase.Create(dbPath);
  try
    if sldb.TableExists('H_Bed') then
    begin
      sSQL := 'DROP TABLE H_Bed';
      sldb.execsql(sSQL);
    end;

    sSQL := 'CREATE TABLE H_Bed ([ID] INTEGER PRIMARY KEY,[OtherID] INTEGER NULL,';
    sSQL := sSQL + '[Name] VARCHAR (255),[Number] FLOAT, [notes] BLOB, [picture] BLOB COLLATE NOCASE);';

    sldb.execsql(sSQL);

    sldb.execsql('CREATE INDEX TestTableName ON [H_Bed]([Name]);');
  finally
    sldb.Free;
  end;
end;

destructor TDBManager.Destroy;
begin

  inherited;
end;

class function TDBManager.GetInstance: TDBManager;
begin
  if FInstance = nil then
    FInstance := TDBManager.Create;
  Result := FInstance;
end;

class procedure TDBManager.ReleaseInstance;
begin
  FreeAndNil(FInstance);
end;

end.
