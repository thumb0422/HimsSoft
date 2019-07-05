object CustomerSetPage: TCustomerSetPage
  Left = 0
  Top = 0
  ClientHeight = 568
  ClientWidth = 1107
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 28
    Height = 13
    Caption = 'BedId'
  end
  object Label2: TLabel
    Left = 24
    Top = 77
    Width = 33
    Height = 13
    Caption = 'CustID'
  end
  object DBGrid1: TDBGrid
    Left = 857
    Top = 0
    Width = 250
    Height = 568
    Align = alRight
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'BedId'
        ReadOnly = True
        Title.Caption = #24202#20301
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CustId'
        ReadOnly = True
        Title.Caption = #29992#25143'ID'
        Width = 100
        Visible = True
      end>
  end
  object saveBtn: TButton
    Left = 168
    Top = 336
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 1
    OnClick = saveBtnClick
  end
  object DelBtn: TButton
    Left = 168
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 2
    OnClick = DelBtnClick
  end
  object BedIdEdit: TEdit
    Left = 120
    Top = 21
    Width = 209
    Height = 21
    TabOrder = 3
  end
  object custIdEdit: TEdit
    Left = 120
    Top = 74
    Width = 209
    Height = 21
    TabOrder = 4
  end
  object AddBtn: TButton
    Left = 168
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 5
    OnClick = AddBtnClick
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 408
    Top = 240
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 408
    Top = 320
    object ClientDataSet1BedId: TStringField
      FieldName = 'BedId'
      Size = 30
    end
    object ClientDataSet1CustId: TStringField
      FieldName = 'CustId'
      Size = 30
    end
  end
end
