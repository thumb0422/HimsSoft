unit HDataDetailView;

interface

uses
  System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls,
  HDataModel;

type
  TDataDetailView = class(TPanel)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  private
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
    property data:TDataModel read Fdata write Setdata;
  end;

implementation
{ TDataDetailView }

constructor TDataDetailView.Create(AOwner: TComponent);
begin
  inherited;
  SessionTimeLabel := TLabel.Create(Self);
  SessionTimeLabel.Caption := 'Session Time';
  SessionTimeLabel.Alignment := taLeftJustify;
  SessionTimeLabel.Left := 5;
  SessionTimeLabel.Top := 5;
  SessionTimeLabel.Width := 50;
  SessionTimeLabel.Height := 20;
  SessionTimeLabel.Transparent := True;
  SessionTimeLabel.Parent := Self;

  SessionTimeValueLabel := TLabel.Create(Self);
  SessionTimeValueLabel.Caption := '--';
  SessionTimeValueLabel.Alignment := taRightJustify;
  SessionTimeValueLabel.Left := self.Width - 110;
  SessionTimeValueLabel.Top := 5;
  SessionTimeValueLabel.Width := 100;
  SessionTimeValueLabel.Height := 20;
  SessionTimeValueLabel.Transparent := True;
  SessionTimeValueLabel.Parent := Self;

  VenousPressureLabel := TLabel.Create(Self);
  VenousPressureLabel.Caption := 'Venous Pressure';
  VenousPressureLabel.Alignment := taLeftJustify;
  VenousPressureLabel.Left := 5;
  VenousPressureLabel.Top := 30;
  VenousPressureLabel.Width := 50;
  VenousPressureLabel.Height := 20;
  VenousPressureLabel.Transparent := True;
  VenousPressureLabel.Parent := Self;

  VenousPressureValueLabel := TLabel.Create(Self);
  VenousPressureValueLabel.Caption := '--';
  VenousPressureValueLabel.Alignment := taRightJustify;
  VenousPressureValueLabel.Left := self.Width - 110;
  VenousPressureValueLabel.Top := 30;
  VenousPressureValueLabel.Width := 100;
  VenousPressureValueLabel.Height := 20;
  VenousPressureValueLabel.Transparent := True;
  VenousPressureValueLabel.Parent := Self;

  DialysisPressureLabel := TLabel.Create(Self);
  DialysisPressureLabel.Caption := 'Dialysis Pressure';
  DialysisPressureLabel.Alignment := taLeftJustify;
  DialysisPressureLabel.Left := 5;
  DialysisPressureLabel.Top := 55;
  DialysisPressureLabel.Width := 50;
  DialysisPressureLabel.Height := 20;
  DialysisPressureLabel.Transparent := True;
  DialysisPressureLabel.Parent := Self;

  DialysisPressureValueLabel := TLabel.Create(Self);
  DialysisPressureValueLabel.Caption := '--';
  DialysisPressureValueLabel.Alignment := taRightJustify;
  DialysisPressureValueLabel.Left := self.Width - 110;
  DialysisPressureValueLabel.Top := 55;
  DialysisPressureValueLabel.Width := 100;
  DialysisPressureValueLabel.Height := 20;
  DialysisPressureValueLabel.Transparent := True;
  DialysisPressureValueLabel.Parent := Self;

  TMPLabel := TLabel.Create(Self);
  TMPLabel.Caption := 'TMP';
  TMPLabel.Alignment := taLeftJustify;
  TMPLabel.Left := 5;
  TMPLabel.Top := 80;
  TMPLabel.Width := 50;
  TMPLabel.Height := 20;
  TMPLabel.Transparent := True;
  TMPLabel.Parent := Self;

  TMPValueLabel := TLabel.Create(Self);
  TMPValueLabel.Caption := '--';
  TMPValueLabel.Alignment := taRightJustify;
  TMPValueLabel.Left := self.Width - 110;
  TMPValueLabel.Top := 80;
  TMPValueLabel.Width := 100;
  TMPValueLabel.Height := 20;
  TMPValueLabel.Transparent := True;
  TMPValueLabel.Parent := Self;
end;

destructor TDataDetailView.Destroy;
begin

  inherited;
end;

procedure TDataDetailView.Setdata(const Value: TDataModel);
begin
  Fdata := Value;
  SessionTimeValueLabel.Caption := Fdata.SessionTime;
  VenousPressureValueLabel.Caption := Fdata.VenousPressure;
  DialysisPressureValueLabel.Caption := Fdata.DialysisPressure;
  TMPValueLabel.Caption := Fdata.TMP;
end;

end.

