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
