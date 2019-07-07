object HCBMLinkPage: THCBMLinkPage
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #25968#25454#20851#32852
  ClientHeight = 500
  ClientWidth = 554
  Color = clBtnFace
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
    Top = 459
    Width = 554
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 465
    ExplicitWidth = 700
    object saveBtn: TcxButton
      Left = 339
      Top = 6
      Width = 75
      Height = 25
      Caption = #20445#23384
      ModalResult = 1
      TabOrder = 0
      OnClick = saveBtnClick
    end
    object cancelBtn: TcxButton
      Left = 444
      Top = 6
      Width = 75
      Height = 25
      Caption = #36864#20986
      ModalResult = 2
      TabOrder = 1
      OnClick = cancelBtnClick
    end
    object addBtn: TcxButton
      Left = 24
      Top = 6
      Width = 75
      Height = 25
      Caption = #26032#22686
      TabOrder = 2
      OnClick = addBtnClick
    end
    object editBtn: TcxButton
      Left = 129
      Top = 6
      Width = 75
      Height = 25
      Caption = #20462#25913
      TabOrder = 3
      OnClick = editBtnClick
    end
    object delBtn: TcxButton
      Left = 234
      Top = 6
      Width = 75
      Height = 25
      Caption = #21024#38500
      TabOrder = 4
      OnClick = delBtnClick
    end
  end
  object dataGrid: TDBGridEh
    Left = 0
    Top = 0
    Width = 554
    Height = 459
    Align = alClient
    DataSource = dataDS
    DynProps = <>
    TabOrder = 1
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButton.Enabled = False
        EditButtons = <>
        FieldName = 'MCustomerId'
        Footers = <>
        ReadOnly = True
        TextEditing = False
        Title.Caption = #29992#25143'ID'
        Width = 80
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButton.Enabled = False
        EditButtons = <>
        FieldName = 'MCustomerName'
        Footers = <>
        ReadOnly = True
        TextEditing = False
        Title.Caption = #21517#31216
        Width = 120
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButton.Enabled = False
        EditButtons = <>
        FieldName = 'MBedId'
        Footers = <>
        ReadOnly = True
        TextEditing = False
        Title.Caption = #24202
        Width = 50
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButton.Enabled = False
        EditButtons = <>
        FieldName = 'MId'
        Footers = <>
        ReadOnly = True
        TextEditing = False
        Title.Caption = #35774#22791#21495
        Width = 50
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButton.Enabled = False
        EditButtons = <>
        FieldName = 'MDesc'
        Footers = <>
        ReadOnly = True
        TextEditing = False
        Title.Caption = #35774#22791#21517#31216
        Width = 120
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object custCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 144
    object custCDSMCustomerId: TStringField
      FieldName = 'MCustomerId'
      Size = 30
    end
    object custCDSMCustomerName: TStringField
      FieldName = 'MCustomerName'
      Size = 30
    end
  end
  object bedCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 144
    object bedCDSMBedId: TStringField
      FieldName = 'MBedId'
      Size = 10
    end
  end
  object mechineCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 144
    object mechineCDSMId: TStringField
      FieldName = 'MId'
      Size = 10
    end
    object mechineCDSMDesc: TStringField
      FieldName = 'MDesc'
      Size = 30
    end
  end
  object dataCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 384
    Top = 144
    object dataCDSMCustomerId: TStringField
      FieldName = 'MCustomerId'
      Size = 10
    end
    object dataCDSMCustomerName: TStringField
      FieldName = 'MCustomerName'
      Size = 30
    end
    object dataCDSMBedId: TStringField
      FieldName = 'MBedId'
      Size = 10
    end
    object dataCDSMId: TStringField
      FieldName = 'MId'
      Size = 10
    end
    object dataCDSMDesc: TStringField
      FieldName = 'MDesc'
      Size = 30
    end
  end
  object dataDS: TDataSource
    DataSet = dataCDS
    Left = 376
    Top = 74
  end
end
