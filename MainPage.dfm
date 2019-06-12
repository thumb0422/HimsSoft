object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 380
  ClientWidth = 722
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
  object test: TButton
    Left = 64
    Top = 72
    Width = 75
    Height = 25
    Caption = 'test'
    TabOrder = 0
    OnClick = testClick
  end
  object start: TButton
    Left = 176
    Top = 72
    Width = 75
    Height = 25
    Caption = 'start'
    TabOrder = 1
    OnClick = startClick
  end
  object stop: TButton
    Left = 304
    Top = 72
    Width = 75
    Height = 25
    Caption = 'stop'
    TabOrder = 2
    OnClick = stopClick
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnLookup = ClientSocket1Lookup
    OnConnect = ClientSocket1Connect
    OnDisconnect = ClientSocket1Disconnect
    OnRead = ClientSocket1Read
    OnWrite = ClientSocket1Write
    OnError = ClientSocket1Error
    Left = 496
    Top = 128
  end
end
