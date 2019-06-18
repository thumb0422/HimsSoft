unit HCate;

interface

uses
  System.SysUtils, Winapi.Windows, System.Classes, System.Generics.Collections,
  Vcl.ExtCtrls,
  HDeviceInfo;

type
  TCate = class
  protected
    FcInterval: Integer;
    FisConnected: Boolean;
    procedure SetcInterval(const Value: Integer);
  published
    procedure init; virtual; abstract;
    procedure send; virtual; abstract;
    procedure close; virtual; abstract;
    property cInterval: Integer read FcInterval write SetcInterval;
    property isConnected: Boolean read FisConnected;
    constructor Create(deviceInfo: TDeviceInfo); virtual; abstract; // …Ë±∏
    procedure onWriteData(Sender: TObject);virtual; abstract;
  protected
    FDeviceInfo: TDeviceInfo;
    reqTimer: TTimer;
  end;

implementation

{ TCate }

procedure TCate.SetcInterval(const Value: Integer);
begin
  FcInterval := Value;
  if Assigned(reqTimer) then
  begin
    reqTimer.Enabled := False;
    reqTimer.interval := FcInterval;
  end;
end;

end.

