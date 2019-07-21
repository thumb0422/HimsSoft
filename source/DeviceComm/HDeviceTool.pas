{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HDeviceTool;

interface
uses
  System.SysUtils, Winapi.Windows, System.Classes,
  Vcl.ExtCtrls, System.Win.Registry;

type
  TDeviceTool = class
    class function getAllCommPorts: TStringList; // 获取所有的串口
  end;
implementation

{ TDeviceTool }

class function TDeviceTool.getAllCommPorts: TStringList;
var
  reg: TRegistry;
  ts: TStrings;
  i: Integer;
  commports: TStringList;
begin
  commports := TStringList.Create;
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  reg.OpenKey('hardware\devicemap\serialcomm', False);
  ts := TStringList.Create;
  reg.GetValueNames(ts);
  for i := 0 to ts.Count - 1 do
  begin
    commports.Add(reg.ReadString(ts.Strings[i]));
  end;
  ts.Free;
  reg.CloseKey;
  reg.Free;
  Result := commports;
end;

end.
