object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 380
  ClientWidth = 722
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object comtest: TButton
    Left = 64
    Top = 72
    Width = 75
    Height = 25
    Caption = 'comtest'
    TabOrder = 0
    OnClick = comtestClick
  end
  object comstart: TButton
    Left = 176
    Top = 72
    Width = 75
    Height = 25
    Caption = 'comstart'
    TabOrder = 1
    OnClick = comstartClick
  end
  object comstop: TButton
    Left = 304
    Top = 72
    Width = 75
    Height = 25
    Caption = 'comstop'
    TabOrder = 2
    OnClick = comstopClick
  end
  object netTest: TButton
    Left = 64
    Top = 160
    Width = 75
    Height = 25
    Caption = 'netTest'
    TabOrder = 3
    OnClick = netTestClick
  end
  object netStart: TButton
    Left = 177
    Top = 160
    Width = 75
    Height = 25
    Caption = 'netStart'
    TabOrder = 4
    OnClick = netStartClick
  end
  object netStop: TButton
    Left = 304
    Top = 160
    Width = 75
    Height = 25
    Caption = 'netStop'
    TabOrder = 5
    OnClick = netStopClick
  end
end
