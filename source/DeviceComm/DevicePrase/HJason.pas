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
    fRspData:TDataModel; //解析后成对象
//    fCommond: array of Byte;   //TODO:暂时用TdeviceInfo.dCommond 来替代。
    procedure SendRequest;
    procedure praseData(data: array of Byte; var rspData: TDataModel);
      virtual; abstract;
  private
    FfailCallBack: TDataFailCallBack;
    FsuccessCallBack: TSuccessCallBack;

    procedure dataFailBlock(Sender: TObject;error: TErrorMsg);
    procedure dataSuccessBlock(Sender: TObject;data:array of Byte);
  public
    property successCallBack:TSuccessCallBack read FsuccessCallBack write FsuccessCallBack; //---->UI
    property failCallBack:TDataFailCallBack read FfailCallBack write FfailCallBack;  //---->UI
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
  fCate.dataFailCallBack := dataFailBlock;
  fCate.dataSuccessCallBack := dataSuccessBlock;
end;

procedure TJason.dataSuccessBlock(Sender: TObject; data : array of Byte);
begin
   Self.praseData(data,fRspData);
end;

procedure TJason.dataFailBlock(Sender: TObject; error: TErrorMsg);
begin

end;

end.
