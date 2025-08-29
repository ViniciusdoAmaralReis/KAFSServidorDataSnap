object ServerContainer: TServerContainer
  Height = 92
  Width = 331
  object DSServer: TDSServer
    AutoStart = False
    Left = 40
    Top = 11
  end
  object DSTCPServerTransport: TDSTCPServerTransport
    Server = DSServer
    Filters = <>
    Left = 232
    Top = 9
  end
  object DSServerClass: TDSServerClass
    OnGetClass = DSServerClassGetClass
    Server = DSServer
    Left = 120
    Top = 11
  end
end
