{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       ∞Ê»®À˘”– (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HDBManager;

interface
uses System.Classes,System.SysUtils, SQLiteTable3,superobject;
  type
  TDBManager = class
  private
    class var FInstance: TDBManager;
    class function GetInstance: TDBManager; static;
  public
    class property Instance: TDBManager read GetInstance;
    class procedure ReleaseInstance;
    procedure execSql(sqls:TStringList);
    function getDataBySql(sql:string):ISuperObject;
    procedure execSqlByFromLocalFile;
  protected
    constructor Create;
    destructor Destroy; override;
  private
    fDB: TSQLiteDatabase;
    fTB: TSQLIteTable;
  end;

implementation
{ TDBManager }

constructor TDBManager.Create;
var
  slDBpath: string;
//  sSQL: String;
//  ts: TStringStream;
//  sltb: TSQLIteTable;
begin
  slDBpath := ExtractFilePath(paramstr(0)) + 'hims.db';
  fDB := TSQLiteDatabase.Create(slDBpath);

  {
  //for test
  try
    if fDB.TableExists('testTable') then
    begin
      sSQL := 'DROP TABLE testtable';
      fDB.execSql(sSQL);
    end;

    sSQL := 'CREATE TABLE testtable ([ID] INTEGER PRIMARY KEY,[OtherID] INTEGER NULL,';
    sSQL := sSQL +
      '[Name] VARCHAR (255),[Number] FLOAT, [notes] BLOB, [picture] BLOB COLLATE NOCASE);';

    fDB.execSql(sSQL);

    fDB.execSql('CREATE INDEX TestTableName ON [testtable]([Name]);');

    // begin a transaction
    fDB.BeginTransaction;

    sSQL := 'INSERT INTO testtable(Name,OtherID,Number) VALUES ("Some Name",4,587.6594);';
    // do the insert
    fDB.execSql(sSQL);

    sSQL := 'INSERT INTO testtable(Name,OtherID,Number,Notes) VALUES ("Another Name",12,4758.3265,"More notes");';
    // do the insert
    fDB.execSql(sSQL);

    // end the transaction
    fDB.Commit;

    // add the notes using a parameter
    ts := TStringStream.Create('Here are some notes with a unicode smiley: ' +
      char($263A), TEncoding.UTF8);
    try
      // insert the text into the db
      fDB.UpdateBlob('UPDATE testtable set notes = ? WHERE OtherID = 4', ts);
    finally
      ts.Free;
    end;
    if sltb <> nil then
      sltb.Free;
  finally

  end;
}
end;

destructor TDBManager.Destroy;
begin
  fDB.Free;
  fTB.Free;
  inherited;
end;

procedure TDBManager.execSql(sqls: TStringList);
var
  I: Integer;
begin
  if Assigned(fDB) then
  begin
    fDB.BeginTransaction;
    for I := 0 to sqls.Count - 1 do
    begin
      fDB.ExecSQL(sqls[I]);
    end;
    fDB.Commit;
  end;
end;

procedure TDBManager.execSqlByFromLocalFile;
var sourceScript,destScript:TStringList;
    lscriptStr1,lscriptStr2:string;
    sqlPath :string;
    I: Integer;
begin
  sqlPath := ExtractFilePath(paramstr(0)) + 'sql/himsSoft.sql';
  if FileExists(sqlPath) then
  begin
    destScript := TStringList.Create;
    sourceScript := TStringList.Create;
    sourceScript.LoadFromFile(sqlPath);
    lscriptStr1 := '';
    for I := 0 to sourceScript.Count-1 do
    begin
       lscriptStr2 := sourceScript[I];
       if lscriptStr2.IsEmpty then
       begin
         Continue;
       end;
       if Pos(';',lscriptStr2) = 0  then
       begin
         lscriptStr1 := lscriptStr1 + lscriptStr2;
       end
       else
       begin
         lscriptStr1 := lscriptStr1 + lscriptStr2;
         destScript.Add(lscriptStr1);
         lscriptStr1 := '';
       end;
    end;
    execSql(destScript);
  end;
end;

function TDBManager.getDataBySql(sql: string):ISuperObject;
var
  lTB: TSQLIteTable;
  lColStr, lRowStr: string;
  J: Integer;
  lJson,arrayJson, subJson: ISuperObject;
begin
  lJson := SO;
  if Assigned(fDB) then
  begin
    lTB := fDB.GetTable(sql);
    try
      if lTB.Count > 0 then
      begin
        lColStr := '';
        lRowStr := '';
        lJson.S['rowCount'] := IntToStr(lTB.Count);
        lJson.S['colCount'] := IntToStr(lTB.ColCount);
        arrayJson:= SA([]);
        with lTB do
        begin
          MoveFirst;
          while not EOF do
          begin
            subJson := SO;
            for J := 0 to lTB.ColCount - 1 do
            begin
              lColStr := lTB.Columns[J];
              lRowStr := lTB.FieldAsString(J);
              subJson.S[lColStr] := lRowStr;
            end;
            arrayJson.AsArray.Add(subJson);
            Next;
          end;
        end;
        lJson.O['data'] :=arrayJson;
      end
      else
      begin

      end;
    finally
      lTB.Free;
    end;
  end;
  Result := lJson;
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
