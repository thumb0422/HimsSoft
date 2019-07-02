unit HDataNotify;

interface

uses HDataModel;

type
  IDataNotify = interface
    ['{7653C505-D510-49D3-A271-1950C14E7206}']
    procedure sendSingleData(recData: TDataModel);
  end;

implementation

end.
