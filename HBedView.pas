unit HBedView;

interface

uses Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Graphics, System.Classes, System.SysUtils,
  Vcl.Forms, Winapi.Windows,Vcl.Controls,
  HDataNotify, HDataModel,
  HConst, HDataDetailView;

type
  TBedView = class(TPanel)
  private
    FbedStatus: EmBedStatus;
    procedure SetbedStatus(const Value: EmBedStatus);
  private
    FbedId: string;
    procedure SetbedId(const Value: string);
  private
    FnotifyComponent: TComponent;
    procedure SetnotifyComponent(const Value: TComponent);
  published
    property notifyComponent :TComponent read FnotifyComponent write SetnotifyComponent;
    property bedStatus: EmBedStatus read FbedStatus write SetbedStatus;
    property bedId:string read FbedId write SetbedId;
  private
    FImage: TImage;
    FLabel: TLabel;
    FBedIdLabel :TLabel;
    FTimer: TTimer;
    FDataDetailView: TDataDetailView;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
    procedure onClick(Sender: TObject);
    procedure onDblClick(Sender: TObject);
    procedure timerOnTimer(Sender: TObject);
    procedure resetData;
  end;

implementation

{ TBedView }

constructor TBedView.Create(AOwner: TComponent);
begin
  inherited;
  Color := clWhite;

  FTimer := TTimer.Create(Self);
  FTimer.Interval := 1000;
  FTimer.OnTimer := timerOnTimer;
  FTimer.Enabled := False;

  FLabel := TLabel.Create(Self);
  FLabel.Parent := Self;
  FLabel.Left := 0;
  FLabel.Top := 0;
  FLabel.Width := 120;
  FLabel.Height := 20;
  FLabel.Align := alTop;
  FLabel.Alignment := taCenter;
  FLabel.Layout := tlCenter;
  FLabel.Font.Color := clRed;
  FLabel.Transparent := True;

  FImage := TImage.Create(Self);
  FImage.Parent := Self;
  FImage.Stretch := True;
  FImage.Left := 5;
  FImage.Top := 20;
  FImage.Width := 120;
  FImage.Height := 75;
  FImage.Stretch := True;
  FImage.Align := alClient;
  FImage.onClick := onClick;
  FImage.onDblClick := onDblClick;
  bedStatus := EmBedNormal;

  FBedIdLabel := TLabel.Create(Self);
  FBedIdLabel.Caption := 'Bed - ';
  FBedIdLabel.Align := alBottom;
  FBedIdLabel.Alignment := taCenter;
  FBedIdLabel.Left := FImage.Left;
  FBedIdLabel.Top := FImage.Top + FImage.Height;
  FBedIdLabel.Width := 120;
  FBedIdLabel.Height := 10;
  FBedIdLabel.Transparent := True;
  FBedIdLabel.Parent := Self;
end;

destructor TBedView.Destroy;
begin
  if Assigned(FTimer) then
    FTimer.Free;
  if Assigned(FImage) then
    FImage.Free;
  if Assigned(FLabel) then
    FLabel.Free;
  inherited;
end;

procedure TBedView.onClick(Sender: TObject);
var
  lData: TDataModel;
  lDataNotify: IDataNotify;
begin
  // send message to TDataDetailView
  if Assigned(FDataDetailView) and (FbedStatus = EmBedUsed) then
  begin
    lData := TDataModel.Create;
    lData.generateDataForTest;
    lData.BedId := FbedId;

    lDataNotify := FDataDetailView;
    lDataNotify.sendSingleData(lData);
  end;

end;

procedure TBedView.onDblClick(Sender: TObject);
begin
  if FbedStatus = EmBedUsed then
  begin
    case Application.MessageBox('是否停止采集数据?', '提示',
      MB_OKCANCEL + MB_ICONQUESTION) of
      IDOK:
        begin
          bedStatus := EmBedNormal;
        end;
      IDCANCEL:
        begin

        end;
    end;
  end
  else if FbedStatus = EmBedAlarm then
  begin
    bedStatus := EmBedNormal;
  end
  else
  begin
    case Application.MessageBox('是否开启采集数据?', '提示',
      MB_OKCANCEL + MB_ICONQUESTION) of
      IDOK:
        begin
          bedStatus := EmBedUsed;
        end;
      IDCANCEL:
        begin

        end;
    end;
  end;
end;

procedure TBedView.resetData;
begin
  FLabel.Caption := '';
end;

procedure TBedView.SetbedId(const Value: string);
begin
  FbedId := Value;
  FBedIdLabel.Caption := 'Bed - '+ FbedId;
end;

procedure TBedView.SetbedStatus(const Value: EmBedStatus);
var
  fileStr: string;
begin
  FbedStatus := Value;
  fileStr := ExtractFilePath(paramstr(0))+'res/';
  FTimer.Enabled := False;
  case FbedStatus of
    EmBedNormal:
      begin
        fileStr := fileStr + 'bed_1.png';
        resetData;
      end;
    EmBedUsed:
      begin
        fileStr := fileStr + 'bed_2.png';
        FTimer.Enabled := True;
      end;
    EmBedAlarm:
      begin
        fileStr := fileStr + 'bed.png';
      end;
  end;
  FImage.Picture.LoadFromFile(fileStr);
end;

procedure TBedView.SetnotifyComponent(const Value: TComponent);
begin
  FnotifyComponent := Value;
  FDataDetailView := FnotifyComponent as TDataDetailView;
end;

procedure TBedView.timerOnTimer(Sender: TObject);
begin
  FLabel.Caption := 'UMP :' + IntToStr(Random(100)) + '%';
end;

end.
