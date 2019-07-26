unit HDeviceDefine;

interface
uses HDataModel,System.Generics.Collections;
  //串口
  const Com32OpenError: string = '串口打开失败';
  const Com32ReciceError: string = '串口接收错误';
  const Com32HangUpError: string = '串口中断通信';

    // 网口
  const NetOpenError: string = '网口打开失败';
  const NetDisconnect: string = '网口断开连接';
  const NetError: string = '网络异常';
//  const LinkMap:TDic  todo:
  type
    DLinkType = (DLinkCom,DLinkNet,DLinkHDBox);//设备通信连接方式
    TErrorMsg = class;

    TFailedCallBackEvent = procedure(error: TErrorMsg) of object;
    TSuccessCallBackEvent = procedure(rspData: TDataModel) of object;

    TErrorMsg = class
    private
      FmDesc: string;
      FmType: string;
    public
      constructor Create(mType: string; mDesc: string);
      property mType: string read FmType write FmType;
      property mDesc: string read FmDesc write FmDesc;
    end;

  implementation

  { TErrorMsg }

  { TErrorMsg }

  constructor TErrorMsg.Create(mType:string;mDesc:string);
begin
  Self.mDesc := mDesc;
  Self.mType := mType;
end;

end.
