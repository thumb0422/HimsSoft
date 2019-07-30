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
    procedure init;
    procedure send;
    procedure close;
    constructor Create(deviceInfo: TDeviceInfo);
    destructor Destroy; override;
  protected
    fDeviceInfo: TDeviceInfo;
    fCate: TCate;
    fRspData:TDataModel; //解析后成对象
//    fCommond: array of Byte;   //TODO:暂时用TdeviceInfo.dCommond 来替代。
    procedure initCommond;virtual;abstract;//初始化命令
    procedure praseData(data: array of Byte; var rspData: TDataModel);virtual; abstract;
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
constructor TJason.Create(deviceInfo: TDeviceInfo);
begin
  fDeviceInfo := deviceInfo;
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
  Self.initCommond;
end;

destructor TJason.Destroy;
begin
  if Assigned(fCate) then
  begin
    fCate.Free;
  end;
  inherited;
end;

procedure TJason.init;
begin
  if Assigned(fCate) then
  begin
    fCate.init;
  end;
end;

procedure TJason.send;
begin
  if Assigned(fCate) then
  begin
    fCate.send;
  end;
end;

procedure TJason.close;
begin
  if Assigned(fCate) then
  begin
    fCate.close;
    fCate.Free;
  end;
end;

procedure TJason.dataSuccessBlock(Sender: TObject; data : array of Byte);
begin
   Self.praseData(data,fRspData);
   if Assigned(successCallBack) then
   begin
     successCallBack(Self,fRspData);
   end;
end;

procedure TJason.dataFailBlock(Sender: TObject; error: TErrorMsg);
begin
  if Assigned(failCallBack) then
   begin
     failCallBack(Self,error);
   end;
end;

end.
