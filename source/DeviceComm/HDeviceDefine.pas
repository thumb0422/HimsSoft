unit HDeviceDefine;

interface

type
  TErrorMsg = class;

  TFailedCallBackEvent = procedure(error: TErrorMsg) of object;

  TErrorMsg = class
  private
    FmDesc: string;
    FmType: string;
  published
    property mType: string read FmType write FmType;
    property mDesc: string read FmDesc write FmDesc;
  end;
implementation

{ TErrorMsg }

end.
