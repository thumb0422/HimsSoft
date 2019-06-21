object FMainPage: TFMainPage
  Left = 0
  Top = 0
  BorderWidth = 5
  Caption = 'HimsSoft'
  ClientHeight = 457
  ClientWidth = 729
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
  object setBtn: TButton
    Left = 544
    Top = 104
    Width = 75
    Height = 25
    Caption = #35774#32622
    TabOrder = 0
    OnClick = setBtnClick
  end
  object dxNavBar1: TdxNavBar
    Left = 0
    Top = 0
    Width = 200
    Height = 457
    Align = alLeft
    ActiveGroupIndex = 0
    TabOrder = 1
    View = 17
    ViewStyle.ColorSchemeName = 'Blue'
    object dxNavBar1Group1: TdxNavBarGroup
      Caption = 'dxNavBar1Group1'
      SelectedLinkIndex = -1
      TopVisibleLinkIndex = 0
      Links = <
        item
          Item = dxNavBar1Separator1
        end
        item
          Item = dxNavBar1Item1
        end>
    end
    object dxNavBar1Group2: TdxNavBarGroup
      Caption = 'dxNavBar1Group2'
      SelectedLinkIndex = -1
      TopVisibleLinkIndex = 0
      Links = <
        item
          Item = dxNavBar1Item7
        end
        item
          Item = dxNavBar1Separator2
        end
        item
          Item = dxNavBar1Item5
        end
        item
          Item = dxNavBar1Item4
        end
        item
          Item = dxNavBar1Item3
        end>
    end
    object dxNavBar1Group3: TdxNavBarGroup
      Caption = 'dxNavBar1Group3'
      SelectedLinkIndex = -1
      TopVisibleLinkIndex = 0
      Links = <
        item
          Item = dxNavBar1Item8
        end
        item
          Item = dxNavBar1Separator3
        end>
    end
    object dxNavBar1Group4: TdxNavBarGroup
      Caption = 'dxNavBar1Group4'
      SelectedLinkIndex = -1
      TopVisibleLinkIndex = 0
      Links = <>
    end
    object dxNavBar1Separator1: TdxNavBarSeparator
      Caption = 'dxNavBar1Separator1'
    end
    object dxNavBar1Item1: TdxNavBarItem
      Caption = 'dxNavBar1Item1'
    end
    object dxNavBar1Item2: TdxNavBarItem
      Caption = 'dxNavBar1Item2'
    end
    object dxNavBar1Separator2: TdxNavBarSeparator
      Caption = 'dxNavBar1Separator2'
    end
    object dxNavBar1Item3: TdxNavBarItem
      Caption = 'dxNavBar1Item3'
    end
    object dxNavBar1Item4: TdxNavBarItem
      Caption = 'dxNavBar1Item4'
    end
    object dxNavBar1Item5: TdxNavBarItem
      Caption = 'dxNavBar1Item5'
    end
    object dxNavBar1Item6: TdxNavBarItem
      Caption = 'dxNavBar1Item6'
    end
    object dxNavBar1Item7: TdxNavBarItem
      Caption = 'dxNavBar1Item7'
    end
    object dxNavBar1Separator3: TdxNavBarSeparator
      Caption = 'dxNavBar1Separator3'
    end
    object dxNavBar1Item8: TdxNavBarItem
      Caption = 'dxNavBar1Item8'
    end
  end
end
