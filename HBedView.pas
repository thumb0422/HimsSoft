unit HBedView;

interface

uses Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Graphics, System.Classes, System.SysUtils,
  Vcl.Forms, Winapi.Windows,
  HDataNotify, HDataModel,
  HConst, HDataDetailView;

type
  TBedView = class(TPanel)
  private
    FbedStatus: EmBedStatus;
    procedure SetbedStatus(const Value: EmBedStatus);
  published
    property bedStatus: EmBedStatus read FbedStatus write SetbedStatus;
  private
    FImage: TImage;
    FLabel: TLabel;
    FTimer: TTimer;
    // FPopMenu :TPopupMenu;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
    procedure onClick(Sender: TObject);
    procedure onDblClick(Sender: TObject);
    procedure timerOnTimer(Sender: TObject);
    function getDataDetailView: TDataDetailView;
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
  FLabel.Alignment := taCenter; // 为什么没居中
  // FLabel.Align := Align.alTop;
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
  ParentBackground := False;
  FImage.onClick := onClick;
  FImage.onDblClick := onDblClick;
  bedStatus := EmBedNormal;
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

function TBedView.getDataDetailView: TDataDetailView;
var
  Obj, detailObj: TObject;
  mainPage: TForm;
  dataDetailView: TDataDetailView;
  i: integer;
  J: integer;
begin
  for i := 0 to Application.ComponentCount - 1 do
  begin
    Obj := Application.Components[i];
    if Obj is TForm then
    begin
      mainPage := (Obj as TForm);
      if mainPage.Name = 'FMainPage' then
      begin
        for J := 0 to mainPage.ComponentCount - 1 do
        begin
          detailObj := mainPage.Components[J];
          if detailObj is TDataDetailView then
          begin
            dataDetailView := (detailObj as TDataDetailView);
            Result := dataDetailView;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TBedView.onClick(Sender: TObject);
var
  lData: TDataModel;
  lDataNotify: IDataNotify;
  lDataDetailView: TDataDetailView;
begin
  // send message to TDataDetailView
  lDataDetailView := getDataDetailView;
  if Assigned(lDataDetailView) then
  begin
    lData := TDataModel.Create;
    lData.generateDataForTest;

    lDataNotify := getDataDetailView;
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

procedure TBedView.SetbedStatus(const Value: EmBedStatus);
var
  fileStr: string;
begin
  FbedStatus := Value;
  fileStr := ExtractFilePath(paramstr(0));
  FTimer.Enabled := False;
  case FbedStatus of
    EmBedNormal:
      begin
        fileStr := fileStr + 'bed_1.png';
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

procedure TBedView.timerOnTimer(Sender: TObject);
begin
  FLabel.Caption := 'UMP :' + IntToStr(Random(100)) + '%';
end;

end.
