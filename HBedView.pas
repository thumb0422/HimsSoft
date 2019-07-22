{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       版权所有 (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HBedView;

interface

uses Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Graphics, System.Classes, System.SysUtils,
  Vcl.Forms, Winapi.Windows,Vcl.Controls,
  HDataNotify, HDataModel,HCustomer,
  HConst, HDataDetailView;

type
  TBedView = class(TPanel)
  private
    FbedStatus: EmBedStatus;
    procedure SetbedStatus(const Value: EmBedStatus);
  private
    FnotifyComponent: TComponent;
    procedure SetnotifyComponent(const Value: TComponent);
  private
    Fcustomer: TCustomer;
    procedure Setcustomer(const Value: TCustomer);
  published
    property notifyComponent :TComponent read FnotifyComponent write SetnotifyComponent;
    property bedStatus: EmBedStatus read FbedStatus write SetbedStatus;
    property customer:TCustomer read Fcustomer write Setcustomer;
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
  private
    FDId:string;//H_Data_Main.DId (由custId加随机生成码)
    FRspData:TDataModel;
  end;

implementation
uses HDBManager,superobject;
{ TBedView }

constructor TBedView.Create(AOwner: TComponent);
begin
  inherited;
  Color := clWhite;

  FTimer := TTimer.Create(Self);
  FTimer.Interval := 5000;
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
//  bedStatus := EmBedNormal;

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
  if Assigned(FDataDetailView) and (FbedStatus = EmBedUsed) then
  begin
    lData := TDataModel.generateDataForTest;
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

procedure TBedView.SetbedStatus(const Value: EmBedStatus);
var
  fileStr: string;
  sql:string;
  sqls:TStringList;
  jsonData: ISuperObject;
begin
  FbedStatus := Value;
  sqls := TStringList.Create;
  fileStr := ExtractFilePath(paramstr(0)) + 'res/';
  FTimer.Enabled := False;

  sql := Format
    ('Select DId From H_Data_Main Where MCustId = %s And MCureDate = %s ORDER by createDate LIMIT 1',
    [QuotedStr(Fcustomer.MCustId),
    QuotedStr(FormatDateTime('yyyy-mm-dd', Now))]);
  jsonData := TDBManager.Instance.getDataBySql(sql);
  case FbedStatus of
    EmBedNormal:
      begin
        // 停止
        fileStr := fileStr + 'bed_1.png';
        sql := Format
          ('Update H_Data_Main set endTime =%s where DId =%s And MCustId = %s And MCureDate = %s',
          [QuotedStr(FormatDateTime('yyyy-mm-dd hh:mm:ss', Now)),
          QuotedStr(FDId), QuotedStr(Fcustomer.MCustId),
          QuotedStr(FormatDateTime('yyyy-mm-dd', Now))]);
        sqls.Add(sql);
        resetData;
      end;
    EmBedUsed:
      begin
        // 开启
        fileStr := fileStr + 'bed_2.png';
        FTimer.Enabled := True;
        if jsonData.I['rowCount'] = 0 then
        begin
          sql := Format
            ('Insert Into H_Data_Main (DId,MCustId,startTime,MCureDate)' +
            'Values (%s,%s,%s,%s)',
            [QuotedStr(FDId), QuotedStr(Fcustomer.MCustId),
            QuotedStr(FormatDateTime('yyyy-mm-dd hh:mm:ss', Now)),
            QuotedStr(FormatDateTime('yyyy-mm-dd', Now))]);
          sqls.Add(sql);
        end;
      end;
    EmBedAlarm:
      begin
        fileStr := fileStr + 'bed.png';
      end;
  end;
  TDBManager.Instance.execSql(sqls);
  if FileExists(fileStr) then
  begin
    FImage.Picture.LoadFromFile(fileStr);
  end;
end;

procedure TBedView.Setcustomer(const Value: TCustomer);
var
  sql: string;
  sqls:TStringList;
  jsonData: ISuperObject;
  subData: ISuperObject;
begin
  Fcustomer := Value;
  bedStatus := EmBedNormal;
  FBedIdLabel.Caption := 'Bed - '+ Fcustomer.MBedId + ':' + Fcustomer.MCustName;
  FDId := '';
  sql := Format('Select DId From H_Data_Main Where MCustId = %s And MCureDate = %s ORDER by createDate LIMIT 1',
                [QuotedStr(FCustomer.MCustId),QuotedStr(FormatDateTime('yyyy-mm-dd',Now))]);
  jsonData := TDBManager.Instance.getDataBySql(sql);
  if jsonData.I['rowCount'] > 0 then
  begin
    for subData in jsonData['data'] do
    begin
      FDId := subData.S['DId'];
    end;
  end
  else
  begin
    FDId := Fcustomer.MCustId +'|'+ FormatDateTime('yyyymmddhhmmss',Now);
  end;
end;

procedure TBedView.SetnotifyComponent(const Value: TComponent);
begin
  FnotifyComponent := Value;
  FDataDetailView := FnotifyComponent as TDataDetailView;
end;

procedure TBedView.timerOnTimer(Sender: TObject);
var sql:string;
    sqls:TStringList;
begin
  FRspData := TDataModel.generateDataForTest;
  FLabel.Caption := 'UMP :' + IntToStr(Random(100)) + '%';
  sqls := TStringList.Create;
  sql := Format('Update H_Data_Main set endTime = %s Where DId = %s And MCustId = %s And MCureDate = %s',
                [QuotedStr(FormatDateTime('yyyy-mm-dd hh:mm:ss',Now)),QuotedStr(FDId),QuotedStr(FCustomer.MCustId),QuotedStr(FormatDateTime('yyyymmdd',Now))]);
  sqls.Add(sql);
  sql := Format('Insert Into H_Data_Detail (DId,VenousPressure,DialysisPressure,TMP,BloodFlow,UFFlow,BloodPressure,TotalBlood,Temperature)' +
                'Values (%s,%s,%s,%s,%s,%s,%s,%s,%s)',
                [QuotedStr(FDId),QuotedStr(FRspData.VenousPressure),QuotedStr(FRspData.DialysisPressure),
                QuotedStr(FRspData.TMP),QuotedStr(FRspData.BloodFlow),QuotedStr(FRspData.UFFlow),
                QuotedStr(FRspData.BloodPressure),QuotedStr(FRspData.TotalBlood),QuotedStr(FRspData.Temperature)]);
  sqls.Add(sql);
  TDBManager.Instance.execSql(sqls);
end;

end.
