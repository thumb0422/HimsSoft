object FMainPage: TFMainPage
  Left = 0
  Top = 0
  Caption = 'HimsSoft'
  ClientHeight = 402
  ClientWidth = 1096
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dxNavBar1: TdxNavBar
    Left = 0
    Top = 0
    Width = 193
    Height = 402
    Align = alLeft
    ActiveGroupIndex = -1
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    View = 8
  end
  object cxPageControl1: TcxPageControl
    Left = 193
    Top = 0
    Width = 903
    Height = 402
    Align = alClient
    TabOrder = 1
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 398
    ClientRectLeft = 4
    ClientRectRight = 899
    ClientRectTop = 24
    object cxTabSheet1: TcxTabSheet
      Caption = 'cxTabSheet1'
      Highlighted = True
      ImageIndex = 0
    end
  end
end
