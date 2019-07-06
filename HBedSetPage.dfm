object BedSetPage: TBedSetPage
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  ClientHeight = 450
  ClientWidth = 300
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
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 300
    Height = 409
    Align = alClient
    DataSource = DataSource1
    DynProps = <>
    TabOrder = 0
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MRoomId'
        Footers = <>
        Title.Caption = #25151#38388#21495
        Width = 45
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MBedId'
        Footers = <>
        Title.Caption = #24202#20301
        Width = 50
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'isValid'
        Footers = <>
        Title.Caption = #26377#25928
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 409
    Width = 300
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 528
    ExplicitWidth = 372
    object saveBtn: TcxButton
      Left = 48
      Top = 6
      Width = 75
      Height = 25
      Caption = #20445#23384
      ModalResult = 1
      TabOrder = 0
      OnClick = saveBtnClick
    end
    object cancleBtn: TcxButton
      Left = 184
      Top = 6
      Width = 75
      Height = 25
      Caption = #21462#28040
      ModalResult = 2
      TabOrder = 1
      OnClick = cancleBtnClick
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 136
    object ClientDataSet1MRoomId: TStringField
      FieldName = 'MRoomId'
      Size = 10
    end
    object ClientDataSet1MBedId: TStringField
      FieldName = 'MBedId'
      Size = 10
    end
    object ClientDataSet1isValid: TBooleanField
      FieldName = 'isValid'
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 240
    Top = 136
  end
end
