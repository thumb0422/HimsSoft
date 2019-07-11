{*******************************************************}
{                                                       }
{       HimsSoft                                        }
{                                                       }
{       ∞Ê»®À˘”– (C) 2019 thumb0422@163.com             }
{                                                       }
{*******************************************************}

unit HDataModel;

interface

uses System.SysUtils;

type
  TDataModel = class
  private
    FBedId: string;
    FTotalBlood: string;
    FBloodFlow: string;
    FBloodPressure: string;
    FSessionTime: string;
    FDialysisPressure: string;
    FVenousPressure: string;
    FTemperature: string;
    FUFFlow: string;
    FTMP: string;
    procedure SetBedId(const Value: string);
    procedure SetBloodFlow(const Value: string);
    procedure SetBloodPressure(const Value: string);
    procedure SetDialysisPressure(const Value: string);
    procedure SetSessionTime(const Value: string);
    procedure SetTemperature(const Value: string);
    procedure SetTMP(const Value: string);
    procedure SetTotalBlood(const Value: string);
    procedure SetUFFlow(const Value: string);
    procedure SetVenousPressure(const Value: string);
  published
    property BedId: string read FBedId write SetBedId;
    property SessionTime: string read FSessionTime write SetSessionTime;
    property VenousPressure: string read FVenousPressure
      write SetVenousPressure;
    property DialysisPressure: string read FDialysisPressure
      write SetDialysisPressure;
    property TMP: string read FTMP write SetTMP;
    property BloodFlow: string read FBloodFlow write SetBloodFlow;
    property UFFlow: string read FUFFlow write SetUFFlow;
    property BloodPressure: string read FBloodPressure write SetBloodPressure;
    property TotalBlood: string read FTotalBlood write SetTotalBlood;
    property Temperature: string read FTemperature write SetTemperature;
  public
    procedure generateDataForTest;
  end;

implementation

{ TDataModel }

procedure TDataModel.generateDataForTest;
begin
  FTotalBlood := IntToStr(Random(100));
  FBloodFlow := IntToStr(Random(100));
  FBloodPressure := IntToStr(Random(100));
  FSessionTime := IntToStr(Random(100));
  FDialysisPressure := IntToStr(Random(100));
  FVenousPressure := IntToStr(Random(100));
  FTemperature := IntToStr(Random(100));
  FUFFlow := IntToStr(Random(100));
  FTMP := IntToStr(Random(100));
end;

procedure TDataModel.SetBedId(const Value: string);
begin
  FBedId := Value;
end;

procedure TDataModel.SetBloodFlow(const Value: string);
begin
  FBloodFlow := Value;
end;

procedure TDataModel.SetBloodPressure(const Value: string);
begin
  FBloodPressure := Value;
end;

procedure TDataModel.SetDialysisPressure(const Value: string);
begin
  FDialysisPressure := Value;
end;

procedure TDataModel.SetSessionTime(const Value: string);
begin
  FSessionTime := Value;
end;

procedure TDataModel.SetTemperature(const Value: string);
begin
  FTemperature := Value;
end;

procedure TDataModel.SetTMP(const Value: string);
begin
  FTMP := Value;
end;

procedure TDataModel.SetTotalBlood(const Value: string);
begin
  FTotalBlood := Value;
end;

procedure TDataModel.SetUFFlow(const Value: string);
begin
  FUFFlow := Value;
end;

procedure TDataModel.SetVenousPressure(const Value: string);
begin
  FVenousPressure := Value;
end;

end.
