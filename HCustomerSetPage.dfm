object CustomerSetPage: TCustomerSetPage
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  ClientHeight = 450
  ClientWidth = 300
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 409
    Width = 300
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 48
    ExplicitTop = 384
    ExplicitWidth = 185
    object saveBtn: TcxButton
      Left = 40
      Top = 8
      Width = 75
      Height = 25
      Caption = #20445#23384
      ModalResult = 1
      TabOrder = 0
      OnClick = saveBtnClick
    end
    object cancelBtn: TcxButton
      Left = 168
      Top = 8
      Width = 75
      Height = 25
      Caption = #21462#28040
      ModalResult = 2
      TabOrder = 1
      OnClick = cancelBtnClick
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 300
    Height = 409
    Align = alClient
    DataSource = DataSource1
    DynProps = <>
    TabOrder = 1
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MCustomerId'
        Footers = <>
        Title.Caption = 'ID'
        Width = 88
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MCustomerName'
        Footers = <>
        Title.Caption = #22995#21517
        Width = 130
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MSex'
        Footers = <>
        Title.Caption = #30007#24615
        Width = 40
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 80
    object ClientDataSet1MCustomerId: TStringField
      FieldName = 'MCustomerId'
      Size = 30
    end
    object ClientDataSet1MCustomerName: TStringField
      FieldName = 'MCustomerName'
      Size = 30
    end
    object ClientDataSet1MSex: TBooleanField
      FieldName = 'MSex'
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 104
    Top = 160
  end
end
