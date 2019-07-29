object HServer: THServer
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Server'
  ClientHeight = 521
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 80
    Top = 40
    Width = 28
    Height = 13
    Caption = #20018#21475':'
  end
  object Label2: TLabel
    Left = 80
    Top = 96
    Width = 24
    Height = 13
    Caption = #32593#21475
  end
  object Label3: TLabel
    Left = 222
    Top = 96
    Width = 4
    Height = 13
    Caption = ':'
  end
  object ComboBox1: TComboBox
    Left = 128
    Top = 37
    Width = 161
    Height = 21
    Style = csDropDownList
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 128
    Top = 93
    Width = 89
    Height = 21
    TabOrder = 1
    Text = '192.168.1.1'
  end
  object Edit2: TEdit
    Left = 232
    Top = 93
    Width = 57
    Height = 21
    TabOrder = 2
    Text = '6667'
  end
  object Button1: TButton
    Left = 344
    Top = 35
    Width = 75
    Height = 25
    Caption = #24320#21551#26381#21153
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 344
    Top = 91
    Width = 75
    Height = 25
    Caption = #24320#21551#26381#21153
    TabOrder = 4
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 80
    Top = 136
    Width = 339
    Height = 353
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
  end
  object CnRS2321: TCnRS232
    CommName = 'COM2'
    OnReceiveData = CnRS2321ReceiveData
    OnReceiveError = CnRS2321ReceiveError
    OnRequestHangup = CnRS2321RequestHangup
    OnSendDataEmpty = CnRS2321SendDataEmpty
    Left = 32
    Top = 16
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnListen = ServerSocket1Listen
    OnAccept = ServerSocket1Accept
    OnGetThread = ServerSocket1GetThread
    OnGetSocket = ServerSocket1GetSocket
    OnThreadStart = ServerSocket1ThreadStart
    OnThreadEnd = ServerSocket1ThreadEnd
    OnClientConnect = ServerSocket1ClientConnect
    OnClientDisconnect = ServerSocket1ClientDisconnect
    OnClientRead = ServerSocket1ClientRead
    OnClientWrite = ServerSocket1ClientWrite
    OnClientError = ServerSocket1ClientError
    Left = 24
    Top = 192
  end
end
