unit HTool;

interface
uses Winapi.Windows,System.Math,System.SysUtils;
type
  TTool = class
    class function StringToHex(str: string): string;
  end;

implementation

// -----------------------------------------------
// ×Ö·û´®×ª16½øÖÆ×Ö·û
// -----------------------------------------------
class function TTool.StringToHex(str: string): string;
var
  i: integer;
  s: string;
begin
  for i := 1 to length(str) do
  begin
    s := s + IntToHex(integer(str[i]), 2)+ ' ';
  end;
  Result := s;
end;

end.
