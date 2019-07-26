{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HCate;

interface

uses
  System.SysUtils,
  Vcl.ExtCtrls,
  HDeviceInfo,
  HDeviceDefine;

type
  TCate = class
  protected
    FisConnected: Boolean;
  public
    procedure init; virtual; abstract;
    procedure send; virtual; abstract;
    procedure close; virtual; abstract;
    property isConnected: Boolean read FisConnected;
    constructor Create(deviceInfo: TDeviceInfo); virtual; abstract; // 设备
    procedure onWriteData(Sender: TObject);virtual; abstract;
  protected
    callBackMsg:TErrorMsg;
    FcallBackError: TFailedCallBackEvent;
  protected
    FDeviceInfo: TDeviceInfo;
  public
    property callBackError: TFailedCallBackEvent read FcallBackError write FcallBackError;
  end;

implementation

{ TCate }

end.

