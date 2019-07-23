object CBMLinkAddPage: TCBMLinkAddPage
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  ClientHeight = 200
  ClientWidth = 280
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
    Top = 159
    Width = 280
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object cxSave: TcxButton
      Left = 48
      Top = 8
      Width = 75
      Height = 25
      Caption = #20445#23384
      TabOrder = 0
      OnClick = cxSaveClick
    end
    object cancelBtn: TcxButton
      Left = 152
      Top = 8
      Width = 75
      Height = 25
      Caption = #21462#28040
      ModalResult = 2
      TabOrder = 1
    end
  end
  object cxLabel1: TcxLabel
    Left = 24
    Top = 24
    Caption = #29992#25143
  end
  object cxLabel2: TcxLabel
    Left = 24
    Top = 75
    Caption = #24202#20301
  end
  object cxLabel3: TcxLabel
    Left = 24
    Top = 126
    Caption = #35774#22791
  end
  object custCombox: TDBLookupComboBox
    Left = 58
    Top = 24
    Width = 145
    Height = 21
    KeyField = 'MCustId'
    ListField = 'MCustName'
    ListSource = custDS
    TabOrder = 4
  end
  object bedCombox: TDBComboBox
    Left = 58
    Top = 75
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    DataField = 'MBedId'
    DataSource = bedDS
    TabOrder = 5
  end
  object mechineCombox: TDBLookupComboBox
    Left = 58
    Top = 126
    Width = 145
    Height = 21
    KeyField = 'MMechineId'
    ListField = 'MMechineDesc'
    ListSource = mechineDS
    TabOrder = 6
  end
  object custCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 88
    Top = 16
    object custCDSMCustId: TStringField
      FieldName = 'MCustId'
      Size = 10
    end
    object custCDSMCustName: TStringField
      FieldName = 'MCustName'
      Size = 50
    end
  end
  object bedCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 64
    object bedCDSMBedId: TStringField
      FieldName = 'MBedId'
      Size = 10
    end
  end
  object mechineCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 92
    Top = 120
    object mechineCDSMMechineId: TStringField
      FieldName = 'MMechineId'
      Size = 10
    end
    object mechineCDSMMechineDesc: TStringField
      FieldName = 'MMechineDesc'
      Size = 50
    end
  end
  object custDS: TDataSource
    DataSet = custCDS
    Left = 136
    Top = 16
  end
  object mechineDS: TDataSource
    DataSet = mechineCDS
    Left = 136
    Top = 120
  end
  object bedDS: TDataSource
    DataSet = bedCDS
    Left = 144
    Top = 72
  end
end
