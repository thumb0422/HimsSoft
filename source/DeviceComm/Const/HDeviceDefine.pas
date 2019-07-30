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

  type
    DLinkType = (DLinkCom,DLinkNet,DLinkHDBox,DLinkNone);//�豸ͨ�����ӷ�ʽ
    EmBedStatus = (EmBedNormal,EmBedUsed,EmBedAlarm,EmBedError);//��λ״̬
    TErrorMsg = class;

    TDataFailCallBack    = procedure(Sender: TObject;error: TErrorMsg) of object;
    TDataSuccessCallBack = procedure(Sender: TObject;data:array of Byte) of object;//rs232 ->TJason

    TSuccessCallBack = procedure(Sender: TObject;rspData: TDataModel) of object;//TJason ->UI

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
