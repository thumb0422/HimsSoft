unit HDataDetailView;

interface

uses
  System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls,Vcl.Forms,
  HDataModel, HDataNotify;

type
  TDataDetailView = class(TPanel, IDataNotify)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  private
    bedIdLabel:TLabel;
    SessionTimeLabel: TLabel;
    VenousPressureLabel: TLabel;
    DialysisPressureLabel: TLabel;
    TMPLabel: TLabel;
    SessionTimeValueLabel: TLabel;
    VenousPressureValueLabel: TLabel;
    DialysisPressureValueLabel: TLabel;
    TMPValueLabel: TLabel;
    Fdata: TDataModel;
    procedure Setdata(const Value: TDataModel);
  public
    property data: TDataModel read Fdata write Setdata;
  public
    procedure sendSingleData(recData: TDataModel);
  end;

implementation

{ TDataDetailView }

constructor TDataDetailView.Create(AOwner: TComponent);
begin
  inherited;
  bedIdLabel := TLabel.Create(Self);
  bedIdLabel.Caption := 'Bed - ';
  bedIdLabel.Alignment := taLeftJustify;
  bedIdLabel.Left := 5;
  bedIdLabel.Top := 5;
  bedIdLabel.Width := 50;
  bedIdLabel.Height := 20;
  bedIdLabel.Transparent := True;
  bedIdLabel.Parent := Self;

  SessionTimeLabel := TLabel.Create(Self);
  SessionTimeLabel.Caption := 'Session Time';
  SessionTimeLabel.Alignment := taLeftJustify;
  SessionTimeLabel.Left := 5;
  SessionTimeLabel.Top := 30;
  SessionTimeLabel.Width := 50;
  SessionTimeLabel.Height := 20;
  SessionTimeLabel.Transparent := True;
  SessionTimeLabel.Parent := Self;

  SessionTimeValueLabel := TLabel.Create(Self);
  SessionTimeValueLabel.Caption := '--';
  SessionTimeValueLabel.Alignment := taRightJustify;
  SessionTimeValueLabel.Left := Self.Width - 110;
  SessionTimeValueLabel.Top := SessionTimeLabel.Top;
  SessionTimeValueLabel.Width := 100;
  SessionTimeValueLabel.Height := SessionTimeLabel.Height;
  SessionTimeValueLabel.Transparent := True;
  SessionTimeValueLabel.Parent := Self;

  VenousPressureLabel := TLabel.Create(Self);
  VenousPressureLabel.Caption := 'Venous Pressure';
  VenousPressureLabel.Alignment := taLeftJustify;
  VenousPressureLabel.Left := 5;
  VenousPressureLabel.Top := 55;
  VenousPressureLabel.Width := 50;
  VenousPressureLabel.Height := 20;
  VenousPressureLabel.Transparent := True;
  VenousPressureLabel.Parent := Self;

  VenousPressureValueLabel := TLabel.Create(Self);
  VenousPressureValueLabel.Caption := '--';
  VenousPressureValueLabel.Alignment := taRightJustify;
  VenousPressureValueLabel.Left := Self.Width - 110;
  VenousPressureValueLabel.Top := VenousPressureLabel.Top;
  VenousPressureValueLabel.Width := 100;
  VenousPressureValueLabel.Height := VenousPressureLabel.Height;
  VenousPressureValueLabel.Transparent := True;
  VenousPressureValueLabel.Parent := Self;

  DialysisPressureLabel := TLabel.Create(Self);
  DialysisPressureLabel.Caption := 'Dialysis Pressure';
  DialysisPressureLabel.Alignment := taLeftJustify;
  DialysisPressureLabel.Left := 5;
  DialysisPressureLabel.Top := 80;
  DialysisPressureLabel.Width := 50;
  DialysisPressureLabel.Height := 20;
  DialysisPressureLabel.Transparent := True;
  DialysisPressureLabel.Parent := Self;

  DialysisPressureValueLabel := TLabel.Create(Self);
  DialysisPressureValueLabel.Caption := '--';
  DialysisPressureValueLabel.Alignment := taRightJustify;
  DialysisPressureValueLabel.Left := Self.Width - 110;
  DialysisPressureValueLabel.Top := DialysisPressureLabel.Top;
  DialysisPressureValueLabel.Width := 100;
  DialysisPressureValueLabel.Height := DialysisPressureLabel.Height;
  DialysisPressureValueLabel.Transparent := True;
  DialysisPressureValueLabel.Parent := Self;

  TMPLabel := TLabel.Create(Self);
  TMPLabel.Caption := 'TMP';
  TMPLabel.Alignment := taLeftJustify;
  TMPLabel.Left := 5;
  TMPLabel.Top := 105;
  TMPLabel.Width := 50;
  TMPLabel.Height := 20;
  TMPLabel.Transparent := True;
  TMPLabel.Parent := Self;

  TMPValueLabel := TLabel.Create(Self);
  TMPValueLabel.Caption := '--';
  TMPValueLabel.Alignment := taRightJustify;
  TMPValueLabel.Left := Self.Width - 110;
  TMPValueLabel.Top := TMPLabel.Top;
  TMPValueLabel.Width := 100;
  TMPValueLabel.Height := TMPLabel.Height;
  TMPValueLabel.Transparent := True;
  TMPValueLabel.Parent := Self;

end;

destructor TDataDetailView.Destroy;
begin

  inherited;
end;

procedure TDataDetailView.sendSingleData(recData: TDataModel);
begin
  data := recData;
end;

procedure TDataDetailView.Setdata(const Value: TDataModel);
begin
  Fdata := Value;
  bedIdLabel.Caption := 'Bed - '+Fdata.BedId;
  SessionTimeValueLabel.Caption := Fdata.SessionTime;
  VenousPressureValueLabel.Caption := Fdata.VenousPressure;
  DialysisPressureValueLabel.Caption := Fdata.DialysisPressure;
  TMPValueLabel.Caption := Fdata.TMP;
end;

end.
