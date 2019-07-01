object DataDetailView: TDataDetailView
  Left = 0
  Top = 0
  ClientHeight = 444
  ClientWidth = 262
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 97
    Height = 444
    Align = alLeft
    Alignment = taLeftJustify
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 8
    object SessionTimeLabel: TLabel
      Left = 8
      Top = 16
      Width = 61
      Height = 13
      Caption = 'Session Time'
      Color = clBlack
      ParentColor = False
    end
    object VenousPressureLabel: TLabel
      Left = 8
      Top = 48
      Width = 80
      Height = 13
      Caption = 'Venous Pressure'
      Color = clBlack
      ParentColor = False
    end
    object DialysisPressureLabel: TLabel
      Left = 8
      Top = 80
      Width = 80
      Height = 13
      Caption = 'Dialysis Pressure'
      Color = clBlack
      ParentColor = False
    end
    object TMPLabel: TLabel
      Left = 8
      Top = 112
      Width = 20
      Height = 13
      Caption = 'TMP'
      Color = clBlack
      ParentColor = False
    end
  end
  object Panel2: TPanel
    Left = 97
    Top = 0
    Width = 165
    Height = 444
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    ExplicitLeft = 94
  end
end
