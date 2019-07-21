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
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 88
    Top = 72
    Width = 75
    Height = 25
    Caption = 'ExecSql'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 88
    Top = 120
    Width = 161
    Height = 25
    Caption = 'TestDComNet'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 392
    Top = 64
  end
end
