object FMainPage: TFMainPage
  Left = 0
  Top = 0
  Caption = 'HimsSoft'
  ClientHeight = 611
  ClientWidth = 911
  Color = clWhite
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dxNavBar1: TdxNavBar
    Left = 0
    Top = 0
    Width = 193
    Height = 611
    Align = alLeft
    ActiveGroupIndex = -1
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    View = 8
  end
  object cxPageControl1: TcxPageControl
    Left = 193
    Top = 0
    Width = 718
    Height = 611
    Align = alClient
    Color = clWhite
    ParentBackground = False
    ParentColor = False
    TabOrder = 1
    Properties.CloseButtonMode = cbmEveryTab
    Properties.CustomButtons.Buttons = <>
    OnCanClose = cxPageControl1CanClose
    OnCanCloseEx = cxPageControl1CanCloseEx
    ClientRectBottom = 607
    ClientRectLeft = 4
    ClientRectRight = 714
    ClientRectTop = 4
  end
end
