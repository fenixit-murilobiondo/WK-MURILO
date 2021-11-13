object frmBuscaPedido: TfrmBuscaPedido
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Buscar Pedido'
  ClientHeight = 400
  ClientWidth = 791
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
    Width = 791
    Height = 41
    Align = alTop
    Caption = 'Buscar Pedidos'
    Color = clGrayText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 638
  end
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 791
    Height = 48
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 638
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
    object cbFiltro: TComboBox
      Left = 9
      Top = 20
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 2
      TabOrder = 0
      Text = '2 - Nome Cliente'
      Items.Strings = (
        '0 - N'#250'mero Pedido'
        '1 - C'#243'digo Cliente'
        '2 - Nome Cliente'
        '3 - Nome da Cidade'
        '4 - Data de Emiss'#227'o')
    end
    object edtPesquisa: TEdit
      Left = 160
      Top = 20
      Width = 609
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      OnKeyUp = edtPesquisaKeyUp
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 354
    Width = 791
    Height = 46
    Align = alBottom
    Color = clGrayText
    ParentBackground = False
    TabOrder = 2
    ExplicitLeft = -64
    ExplicitTop = 378
    object BitBtn2: TBitBtn
      Left = 286
      Top = 6
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
      Left = 413
      Top = 6
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
    Width = 791
    Height = 265
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
