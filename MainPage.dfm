object FMainPage: TFMainPage
  Left = 0
  Top = 0
  Caption = 'HimsSoft'
  ClientHeight = 467
  ClientWidth = 739
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
    Height = 467
    Align = alLeft
    ActiveGroupIndex = -1
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    View = 8
  end
  object cxPageControl1: TcxPageControl
    Left = 193
    Top = 0
    Width = 546
    Height = 467
    Align = alClient
    TabOrder = 1
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 463
    ClientRectLeft = 4
    ClientRectRight = 542
    ClientRectTop = 24
    object cxTabSheet1: TcxTabSheet
      Caption = 'cxTabSheet1'
      Highlighted = True
      ImageIndex = 0
      object Panel1: TPanel
        Left = 240
        Top = 128
        Width = 185
        Height = 41
        Caption = 'Panel1'
        TabOrder = 0
      end
    end
  end
end
