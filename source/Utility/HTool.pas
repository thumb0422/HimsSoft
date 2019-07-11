{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HTool;

interface
uses System.SysUtils;
type
  TTool = class
    class function StringToHex(str: string): string;
    class function HexToString(str: string): string;
    class function TransChar(AChar: Char): Integer;
  end;

implementation

// -----------------------------------------------
// 字符串转16进制字符
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

// -----------------------------------------------
// 16进制字符转字符串
// -----------------------------------------------
class function TTool.HexToString(str: string): string;
var
  I,len : Integer;
  CharValue: Word;
  Tmp:string;
  s:char;
begin
  Tmp:='';
  len:=length(str);
  for i:=1 to len  do
  begin
    s:=str[i];
    if s <> ' ' then Tmp:=Tmp+ string(s);
  end;
  Result := '';
  For I := 1 to Trunc(Length(Tmp)/2) do
  begin
    Result := Result + ' ';
    CharValue := TransChar(Tmp[2*I-1])*16 + TransChar(Tmp[2*I]);
    if (charvalue < 32) or (charvalue > 126)  then Result[I] := '.'   //非可见字符填充
    else Result[I] := Char(CharValue);
  end;
end;

class function TTool.TransChar(AChar: Char): Integer;
begin
  if AChar in ['0'..'9'] then
  Result := Ord(AChar) - Ord('0')
  else
  Result := 10 + Ord(AChar) - Ord('A');
end;
end.
