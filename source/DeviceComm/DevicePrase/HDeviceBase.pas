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
  HDataModel;
  type

  TDeviceBase =class
     procedure praseData(data: array of Byte; var rspData: TDataModel);virtual;abstract;
  end;
implementation

end.
