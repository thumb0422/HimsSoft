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
    ExplicitHeight = 506
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
    Properties.ActivePage = cxTabSheet1
    Properties.CloseButtonMode = cbmEveryTab
    Properties.CustomButtons.Buttons = <>
    OnCanClose = cxPageControl1CanClose
    OnCanCloseEx = cxPageControl1CanCloseEx
    ExplicitWidth = 550
    ExplicitHeight = 509
    ClientRectBottom = 607
    ClientRectLeft = 4
    ClientRectRight = 714
    ClientRectTop = 24
    object cxTabSheet1: TcxTabSheet
      Caption = 'Hims'
      Color = clWhite
      Highlighted = True
      ImageIndex = 0
      ParentColor = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 542
      ExplicitHeight = 481
      object bgLabel: TLabel
        Left = 0
        Top = 0
        Width = 294
        Height = 77
        Align = alClient
        Alignment = taCenter
        Caption = 'HimsSoft'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -64
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        Layout = tlCenter
      end
    end
  end
end
