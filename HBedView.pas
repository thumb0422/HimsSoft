unit HBedView;

interface

uses Vcl.ExtCtrls, Vcl.StdCtrls,Vcl.Graphics,System.Classes,System.SysUtils,
     HConst;

type
  TBedView = class(TPanel)
  private
    FbedStatus: EmBedStatus;
    procedure SetbedStatus(const Value: EmBedStatus);
  published
    property bedStatus: EmBedStatus read FbedStatus write SetbedStatus;
  private
    FImage: TImage;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TBedView }

constructor TBedView.Create(AOwner: TComponent);
begin
  inherited;
  FImage := TImage.Create(Self);
  FImage.Parent := Self;
  FImage.Stretch := True;
  FImage.Left := 3;
  FImage.Top := 3;
  FImage.Width := 245;
  FImage.Height := 153;
  ParentBackground := False;
end;

procedure TBedView.SetbedStatus(const Value: EmBedStatus);
var
  fileStr: string;
begin
  FbedStatus := Value;
  fileStr := ExtractFilePath(paramstr(0));
  case FbedStatus of
    EmBedNormal:
      begin
        fileStr := fileStr + 'bed_1.png';
      end;
    EmBedUsed:
      begin
        fileStr := fileStr + 'bed_2.png';
      end;
    EmBedAlarm:
      begin
        fileStr := fileStr + 'bed.png';
      end;
  end;
  FImage.Picture.LoadFromFile(fileStr);
end;

end.
