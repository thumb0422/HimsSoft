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
  object ComboBox1: TComboBox
    Left = 200
    Top = 248
    Width = 145
    Height = 21
    TabOrder = 6
    Text = 'ComboBox1'
  end
  object getComms: TButton
    Left = 64
    Top = 246
    Width = 75
    Height = 25
    Caption = 'getComms'
    TabOrder = 7
    OnClick = getCommsClick
  end
  object Memo1: TMemo
    Left = 456
    Top = 288
    Width = 241
    Height = 73
    TabOrder = 8
  end
  object Edit1: TEdit
    Left = 456
    Top = 246
    Width = 241
    Height = 21
    TabOrder = 9
  end
  object transBtn: TButton
    Left = 375
    Top = 304
    Width = 75
    Height = 25
    Caption = 'transBtn'
    TabOrder = 10
    OnClick = transBtnClick
  end
end
