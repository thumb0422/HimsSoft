object dmWinSysServer: TdmWinSysServer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 260
  Width = 317
  object tmr_Save: TTimer
    Enabled = False
    OnTimer = tmr_SaveTimer
    Left = 168
    Top = 16
  end
  object tmrKingConn: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmrKingConnTimer
    Left = 232
    Top = 72
  end
end
