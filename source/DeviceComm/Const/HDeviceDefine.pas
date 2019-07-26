unit HDeviceDefine;

interface
uses HDataModel,System.Generics.Collections;
  //����
  const Com32OpenError: string = '���ڴ�ʧ��';
  const Com32ReciceError: string = '���ڽ��մ���';
  const Com32HangUpError: string = '�����ж�ͨ��';

    // ����
  const NetOpenError: string = '���ڴ�ʧ��';
  const NetDisconnect: string = '���ڶϿ�����';
  const NetError: string = '�����쳣';
//  const LinkMap:TDic  todo:
  type
    DLinkType = (DLinkCom,DLinkNet,DLinkHDBox);//�豸ͨ�����ӷ�ʽ
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
