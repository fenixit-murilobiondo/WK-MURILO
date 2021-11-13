object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 323
  Width = 570
  object fdConn: TFDConnection
    Params.Strings = (
      'Server=sql10.freemysqlhosting.net'
      'Database=sql10450262'
      'User_Name=sql10450262'
      'Password=WKwwAUxx18'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 56
    Top = 8
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\WK\Win32\Debug\libmysql.dll'
    Left = 54
    Top = 56
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 53
    Top = 104
  end
end
