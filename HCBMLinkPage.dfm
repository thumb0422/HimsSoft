object HCBMLinkPage: THCBMLinkPage
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #25968#25454#20851#32852
  ClientHeight = 493
  ClientWidth = 671
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
    Top = 452
    Width = 671
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 459
    ExplicitWidth = 554
    object cancelBtn: TcxButton
      Left = 476
      Top = 6
      Width = 75
      Height = 25
      Caption = #36864#20986
      ModalResult = 2
      TabOrder = 0
      OnClick = cancelBtnClick
    end
    object addBtn: TcxButton
      Left = 152
      Top = 6
      Width = 75
      Height = 25
      Caption = #26032#22686
      TabOrder = 1
      OnClick = addBtnClick
    end
    object editBtn: TcxButton
      Left = 257
      Top = 6
      Width = 75
      Height = 25
      Caption = #20462#25913
      TabOrder = 2
      OnClick = editBtnClick
    end
    object delBtn: TcxButton
      Left = 362
      Top = 6
      Width = 75
      Height = 25
      Caption = #21024#38500
      TabOrder = 3
      OnClick = delBtnClick
    end
  end
  object dataGrid: TDBGridEh
    Left = 0
    Top = 0
    Width = 671
    Height = 452
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
        FieldName = 'MCustId'
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
        FieldName = 'MCustName'
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
        FieldName = 'MRoomId'
        Footers = <>
        ReadOnly = True
        TextEditing = False
        Title.Caption = 'Room'
        Width = 50
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
        FieldName = 'MMechineId'
        Footers = <>
        ReadOnly = True
        TextEditing = False
        Title.Caption = #35774#22791#21495
        Width = 80
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MMechineDesc'
        Footers = <>
        Title.Caption = #35774#22791#25551#36848
        Width = 120
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MCom'
        Footers = <>
        Title.Caption = #20018#21475
        Width = 40
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MNet'
        Footers = <>
        Title.Caption = #32593#21475
        Width = 40
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MHDBox'
        Footers = <>
        Title.Caption = 'HDBox'
        Width = 40
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object dataCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 384
    Top = 144
    object dataCDSMCustId: TStringField
      FieldName = 'MCustId'
      Size = 10
    end
    object dataCDSMCustName: TStringField
      FieldName = 'MCustName'
      Size = 50
    end
    object dataCDSMRoomId: TStringField
      FieldName = 'MRoomId'
      Size = 10
    end
    object dataCDSMBedId: TStringField
      FieldName = 'MBedId'
      Size = 10
    end
    object dataCDSMMechineId: TStringField
      FieldName = 'MMechineId'
      Size = 10
    end
    object dataCDSMMechineDesc: TStringField
      FieldName = 'MMechineDesc'
      Size = 50
    end
    object dataCDSMCom: TBooleanField
      FieldName = 'MCom'
    end
    object dataCDSMNet: TBooleanField
      FieldName = 'MNet'
    end
    object dataCDSMHDBox: TBooleanField
      FieldName = 'MHDBox'
    end
  end
  object dataDS: TDataSource
    DataSet = dataCDS
    Left = 376
    Top = 74
  end
end
