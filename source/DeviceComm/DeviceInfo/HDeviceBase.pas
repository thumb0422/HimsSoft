{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       ∞Ê»®À˘”– (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HDeviceBase;

interface
 uses
  System.Generics.Collections;
  type

  TDeviceBase =class
     procedure praseData(data: array of Byte; var json: TDictionary<string, string>);virtual;abstract;
  end;
implementation

end.
