{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HJason;

interface

uses
  HDataModel,
  HDeviceInfo,
  HDeviceDefine,
  HCate,HCom32,HNet;

type
  TJason = class(TObject)
  public
    constructor Create(deviceInfo: TDeviceInfo); virtual; abstract;
    destructor Destroy; override;
  protected
    fDeviceInfo: TDeviceInfo;
    fCate: TCate;
//    fCommond: array of Byte;   //TODO:暂时用TdeviceInfo.dCommond 来替代。
    procedure SendRequest;
    procedure praseData(data: array of Byte; var rspData: TDataModel);
      virtual; abstract;
  private
    procedure ErrorBlock(Sender: TObject;error: TErrorMsg);
    procedure successBlock(Sender: TObject;rspData: TDataModel);
  end;

implementation

{ TJason }

destructor TJason.Destroy;
begin
  if Assigned(fCate) then
  begin
    fCate.Free;
  end;
  inherited;
end;

procedure TJason.SendRequest;
begin
  if fDeviceInfo.dLink = DlinkCom then
  begin
    fCate := THComm.Create(fDeviceInfo);
  end
  else if fDeviceInfo.dLink = DLinkNet then
  begin
    fCate := TNet.Create(fDeviceInfo);
  end
  else
  begin

  end;
  fCate.callBackError := ErrorBlock;
  fCate.callBackSuccess := successBlock;
end;

procedure TJason.successBlock(Sender: TObject; rspData: TDataModel);
begin

end;

procedure TJason.ErrorBlock(Sender: TObject; error: TErrorMsg);
begin

end;

end.
