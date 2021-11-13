object frmBusca: TfrmBusca
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Busca'
  ClientHeight = 379
  ClientWidth = 638
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 638
    Height = 41
    Align = alTop
    Caption = 'Busca'
    Color = clGrayText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 638
    Height = 48
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 9
      Top = 4
      Width = 56
      Height = 13
      Caption = 'Filtrar por'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtPesquisa: TEdit
      Left = 8
      Top = 21
      Width = 617
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      OnKeyUp = edtPesquisaKeyUp
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 333
    Width = 638
    Height = 46
    Align = alBottom
    Color = clGrayText
    ParentBackground = False
    TabOrder = 2
    object BitBtn2: TBitBtn
      Left = 197
      Top = 8
      Width = 121
      Height = 33
      Caption = 'OK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 324
      Top = 8
      Width = 121
      Height = 33
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn3Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 89
    Width = 638
    Height = 244
    Align = alClient
    DataSource = dsQry
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object fdQry: TFDQuery
    AfterOpen = fdQryAfterOpen
    Connection = DM.fdConn
    Left = 472
    Top = 8
  end
  object dsQry: TDataSource
    DataSet = fdQry
    Left = 528
    Top = 8
  end
end
