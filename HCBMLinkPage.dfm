object HCBMLinkPage: THCBMLinkPage
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #25968#25454#20851#32852
  ClientHeight = 500
  ClientWidth = 700
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
    Width = 700
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object generateBtn: TcxButton
      Left = 152
      Top = 8
      Width = 75
      Height = 25
      Caption = #29983#25104
      TabOrder = 0
      OnClick = generateBtnClick
    end
    object cancelBtn: TcxButton
      Left = 424
      Top = 8
      Width = 75
      Height = 25
      Caption = #36864#20986
      ModalResult = 2
      TabOrder = 1
    end
  end
  object custGrid: TDBGridEh
    Left = 0
    Top = 0
    Width = 120
    Height = 459
    Align = alLeft
    DataSource = custDS
    DynProps = <>
    TabOrder = 1
    OnCellClick = custGridCellClick
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MCustomerId'
        Footers = <>
        Title.Caption = #29992#25143'ID'
        Width = 50
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MCustomerName'
        Footers = <>
        Title.Caption = #21517#31216
        Width = 50
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object mechineGrid: TDBGridEh
    Left = 240
    Top = 0
    Width = 120
    Height = 459
    Align = alLeft
    DataSource = mechineDS
    DynProps = <>
    TabOrder = 2
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MId'
        Footers = <>
        Title.Caption = #35774#22791#21495
        Width = 40
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MDesc'
        Footers = <>
        Title.Caption = #35774#22791
        Width = 55
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object bedGrid: TDBGridEh
    Left = 120
    Top = 0
    Width = 120
    Height = 459
    Align = alLeft
    DataSource = bedDS
    DynProps = <>
    TabOrder = 3
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MBedId'
        Footers = <>
        Title.Caption = #24202
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object dataGrid: TDBGridEh
    Left = 360
    Top = 0
    Width = 340
    Height = 459
    Align = alClient
    DataSource = dataDS
    DynProps = <>
    TabOrder = 4
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MCustomerId'
        Footers = <>
        Title.Caption = #29992#25143'ID'
        Width = 50
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MCustomerName'
        Footers = <>
        Title.Caption = #21517#31216
        Width = 80
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MBedId'
        Footers = <>
        Title.Caption = #24202
        Width = 40
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MId'
        Footers = <>
        Title.Caption = #35774#22791#21495
        Width = 40
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MDesc'
        Footers = <>
        Title.Caption = #35774#22791#21517#31216
        Width = 80
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object custDS: TDataSource
    DataSet = custCDS
    Left = 40
    Top = 72
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
  object bedDS: TDataSource
    DataSet = bedCDS
    Left = 152
    Top = 72
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
  object mechineDS: TDataSource
    DataSet = mechineCDS
    Left = 272
    Top = 72
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
  object dataDS: TDataSource
    DataSet = dataCDS
    Left = 384
    Top = 72
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
end
