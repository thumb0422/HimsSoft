unit HBedView;

interface

uses Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Graphics, System.Classes, System.SysUtils,
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
  protected
    procedure onClick(Sender: TObject);
    procedure onDblClick(Sender: TObject);
  end;

implementation

{ TBedView }

constructor TBedView.Create(AOwner: TComponent);
begin
  inherited;
  FImage := TImage.Create(Self);
  FImage.Parent := Self;
  FImage.Stretch := True;
  FImage.Left := 5;
  FImage.Top := 20;
  FImage.Width := 120;
  FImage.Height := 75;
  FImage.Stretch := True;
  ParentBackground := False;
  FImage.onClick := onClick;
  FImage.onDblClick := onDblClick;
end;

procedure TBedView.onClick(Sender: TObject);
begin
   
end;

procedure TBedView.onDblClick(Sender: TObject);
begin

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
