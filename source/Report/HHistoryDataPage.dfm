object HistoryDataPage: THistoryDataPage
  Left = 0
  Top = 0
  Caption = #25968#25454#26597#35810
  ClientHeight = 468
  ClientWidth = 811
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 811
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 384
      Top = 19
      Width = 35
      Height = 13
      Caption = #29992#25143'ID'
    end
    object Label2: TLabel
      Left = 150
      Top = 16
      Width = 12
      Height = 19
      Alignment = taCenter
      Caption = '~'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object qryBtn: TButton
      Left = 632
      Top = 13
      Width = 75
      Height = 25
      Caption = #26597#35810
      TabOrder = 0
      OnClick = qryBtnClick
    end
    object custIdEdit: TEdit
      Left = 432
      Top = 15
      Width = 169
      Height = 21
      TabOrder = 1
    end
    object startDate: TDateTimePicker
      Left = 24
      Top = 15
      Width = 120
      Height = 21
      Date = 43670.682492638890000000
      Time = 43670.682492638890000000
      TabOrder = 2
    end
    object endDate: TDateTimePicker
      Left = 191
      Top = 15
      Width = 120
      Height = 21
      Date = 43670.682683611110000000
      Time = 43670.682683611110000000
      TabOrder = 3
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 49
    Width = 811
    Height = 419
    Align = alClient
    DataSource = DataSource1
    DynProps = <>
    TabOrder = 1
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 352
    Top = 184
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 440
    Top = 184
  end
end
