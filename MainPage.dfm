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
  object initBtn: TButton
    Left = 304
    Top = 72
    Width = 75
    Height = 25
    Caption = 'initBtn'
    TabOrder = 0
    OnClick = initBtnClick
  end
  object sendBtn: TButton
    Left = 304
    Top = 160
    Width = 75
    Height = 25
    Caption = 'sendBtn'
    TabOrder = 1
    OnClick = sendBtnClick
  end
end
