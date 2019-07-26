object MechineSetPage: TMechineSetPage
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #35774#22791#31867#22411#35774#32622
  ClientHeight = 450
  ClientWidth = 386
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
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 386
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
        FieldName = 'MMechineId'
        Footers = <>
        Title.Caption = #20195#30721
        Width = 30
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MMechineDesc'
        Footers = <>
        Title.Caption = #21517#31216
        Width = 150
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'isValid'
        Footers = <>
        Title.Caption = #26377#25928
        Width = 40
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MLink'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 409
    Width = 386
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object saveBtn: TcxButton
      Left = 104
      Top = 6
      Width = 75
      Height = 25
      Caption = #20445#23384
      ModalResult = 1
      TabOrder = 0
      OnClick = saveBtnClick
    end
    object cancelBtn: TcxButton
      Left = 216
      Top = 6
      Width = 75
      Height = 25
      Caption = #21462#28040
      ModalResult = 2
      TabOrder = 1
      OnClick = cancelBtnClick
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 64
    Top = 72
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 80
    Top = 144
    object ClientDataSet1MMechineId: TStringField
      FieldName = 'MMechineId'
      Size = 10
    end
    object ClientDataSet1MMechineDesc: TStringField
      FieldName = 'MMechineDesc'
      Size = 50
    end
    object ClientDataSet1MLink: TStringField
      FieldName = 'MLink'
      Size = 8
    end
    object ClientDataSet1isValid: TBooleanField
      FieldName = 'isValid'
    end
  end
end
