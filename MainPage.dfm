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
  object ComboBox1: TComboBox
    Left = 200
    Top = 248
    Width = 145
    Height = 21
    TabOrder = 3
    Text = 'ComboBox1'
  end
  object getComms: TButton
    Left = 64
    Top = 246
    Width = 75
    Height = 25
    Caption = 'getComms'
    TabOrder = 4
    OnClick = getCommsClick
  end
  object Memo1: TMemo
    Left = 456
    Top = 286
    Width = 241
    Height = 56
    TabOrder = 5
  end
  object Edit1: TEdit
    Left = 456
    Top = 246
    Width = 241
    Height = 21
    TabOrder = 6
  end
  object hexTstrTransBtn: TButton
    Left = 336
    Top = 286
    Width = 114
    Height = 25
    Caption = 'hexTstrTransBtn'
    TabOrder = 7
    OnClick = hexTstrTransBtnClick
  end
  object strToHexTransBtn: TButton
    Left = 336
    Top = 317
    Width = 114
    Height = 25
    Caption = 'strToHexTransBtn'
    TabOrder = 8
    OnClick = strToHexTransBtnClick
  end
  object setBtn: TButton
    Left = 544
    Top = 104
    Width = 75
    Height = 25
    Caption = #35774#32622
    TabOrder = 9
    OnClick = setBtnClick
  end
end
