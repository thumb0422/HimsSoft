object SecuritySetPage: TSecuritySetPage
  Left = 0
  Top = 0
  Caption = 'SecuritySetPage'
  ClientHeight = 518
  ClientWidth = 628
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
  object Button1: TButton
    Left = 88
    Top = 72
    Width = 129
    Height = 25
    Caption = #25191#34892#21021#22987#21270#33050#26412
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 88
    Top = 296
    Width = 161
    Height = 25
    Caption = 'TestDComNet'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 88
    Top = 128
    Width = 129
    Height = 25
    Caption = #25191#34892#40664#35748#20540#33050#26412
    TabOrder = 2
    OnClick = Button3Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 392
    Top = 64
  end
end
