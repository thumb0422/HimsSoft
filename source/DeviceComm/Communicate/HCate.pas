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
  protected
    FdataFailCallBack: TDataFailCallBack;
    FdataSuccessCallBack:TDataSuccessCallBack;
  protected
    FDeviceInfo: TDeviceInfo;
  public
    property dataSuccessCallBack:TDataSuccessCallBack read FdataSuccessCallBack write FdataSuccessCallBack;
    property dataFailCallBack: TDataFailCallBack read FdataFailCallBack write FdataFailCallBack;
  end;

implementation

{ TCate }

end.

