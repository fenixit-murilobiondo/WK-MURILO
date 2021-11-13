object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  Caption = 'Pedido de Venda'
  ClientHeight = 474
  ClientWidth = 837
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTitulo: TPanel
    Left = 0
    Top = 0
    Width = 837
    Height = 41
    Align = alTop
    Caption = 'Pedido de Venda'
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
  object Panel2: TPanel
    Left = 0
    Top = 384
    Width = 837
    Height = 38
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      837
      38)
    object Label5: TLabel
      Left = 578
      Top = 10
      Width = 127
      Height = 18
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'TOTAL PEDIDO R$'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtVlrTotal: TEdit
      Left = 712
      Top = 3
      Width = 121
      Height = 31
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '0,00'
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 837
    Height = 175
    ActivePage = tbGeral
    Align = alTop
    TabOrder = 2
    object tbGeral: TTabSheet
      Caption = 'Gerais'
      object Label1: TLabel
        Left = 10
        Top = 53
        Width = 39
        Height = 13
        Caption = 'Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 10
        Top = 6
        Width = 54
        Height = 13
        Caption = 'N'#186' Pedido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 10
        Top = 103
        Width = 38
        Height = 13
        Caption = 'Cidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 375
        Top = 103
        Width = 14
        Height = 13
        Caption = 'UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 110
        Top = 6
        Width = 65
        Height = 13
        Caption = 'Dt. Emiss'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCliCodigo: TEdit
        Left = 10
        Top = 70
        Width = 68
        Height = 21
        CharCase = ecUpperCase
        NumbersOnly = True
        TabOrder = 3
        OnExit = edtCliCodigoExit
      end
      object edtCliNome: TEdit
        Left = 110
        Top = 70
        Width = 306
        Height = 21
        TabStop = False
        CharCase = ecUpperCase
        Color = clGradientInactiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
      end
      object btnBuscaCliente: TBitBtn
        Left = 77
        Top = 68
        Width = 27
        Height = 25
        Caption = '...'
        TabOrder = 4
        OnClick = btnBuscaClienteClick
      end
      object edtPedido: TEdit
        Left = 10
        Top = 23
        Width = 68
        Height = 21
        CharCase = ecUpperCase
        NumbersOnly = True
        TabOrder = 0
        OnExit = edtPedidoExit
      end
      object edtCliCidade: TEdit
        Left = 10
        Top = 120
        Width = 359
        Height = 21
        TabStop = False
        CharCase = ecUpperCase
        Color = clGradientInactiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
      end
      object edtCliUF: TEdit
        Left = 375
        Top = 120
        Width = 41
        Height = 21
        TabStop = False
        CharCase = ecUpperCase
        Color = clGradientInactiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
      end
      object btnBuscaPedido: TBitBtn
        Left = 77
        Top = 21
        Width = 27
        Height = 25
        Caption = '...'
        TabOrder = 1
        OnClick = btnBuscaPedidoClick
      end
      object edtEmissao: TDateTimePicker
        Left = 110
        Top = 23
        Width = 75
        Height = 21
        Date = 44512.493425416670000000
        Time = 44512.493425416670000000
        TabOrder = 2
      end
    end
  end
  object pnlBotoesItem: TPanel
    Left = 0
    Top = 216
    Width = 837
    Height = 43
    Align = alTop
    TabOrder = 3
    object btnInserirProduto: TBitBtn
      Left = 14
      Top = 9
      Width = 155
      Height = 25
      Caption = 'Inserir Produto'
      TabOrder = 0
      OnClick = btnInserirProdutoClick
    end
    object btnEditarProduto: TBitBtn
      Left = 175
      Top = 9
      Width = 155
      Height = 25
      Caption = 'Editar Produto'
      TabOrder = 1
      OnClick = btnEditarProdutoClick
    end
    object btnExcluirProduto: TBitBtn
      Left = 336
      Top = 9
      Width = 155
      Height = 25
      Caption = 'Excluir Produto'
      TabOrder = 2
      OnClick = btnExcluirProdutoClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 259
    Width = 837
    Height = 125
    Align = alClient
    DataSource = dsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
  end
  object Panel3: TPanel
    Left = 0
    Top = 422
    Width = 837
    Height = 52
    Align = alBottom
    Color = clGrayText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 5
    object btnInserir: TBitBtn
      Left = 8
      Top = 8
      Width = 121
      Height = 37
      Caption = 'Inserir'
      TabOrder = 0
      OnClick = btnInserirClick
    end
    object btnEditar: TBitBtn
      Left = 144
      Top = 8
      Width = 121
      Height = 37
      Caption = 'Editar'
      TabOrder = 1
      OnClick = btnEditarClick
    end
    object btnGravar: TBitBtn
      Left = 280
      Top = 8
      Width = 121
      Height = 37
      Caption = 'Gravar'
      TabOrder = 2
      OnClick = btnGravarClick
    end
    object btnCancelar: TBitBtn
      Left = 416
      Top = 8
      Width = 121
      Height = 37
      Caption = 'Cancelar'
      TabOrder = 3
      OnClick = btnCancelarClick
    end
    object btnExcluir: TBitBtn
      Left = 552
      Top = 8
      Width = 121
      Height = 37
      Caption = 'Excluir'
      TabOrder = 4
      OnClick = btnExcluirClick
    end
    object btnFechar: TBitBtn
      Left = 704
      Top = 8
      Width = 121
      Height = 37
      Caption = 'Fechar'
      TabOrder = 5
      OnClick = btnFecharClick
    end
  end
  object cdsItens: TClientDataSet
    PersistDataPacket.Data = {
      9B0000009619E0BD0100000018000000060000000000030000009B0003534551
      010049000000010005574944544802000200040006434F4449474F0100490000
      000100055749445448020002000A000944455343524943414F01004900000001
      000557494454480200020064000C564C525F554E49544152494F080004000000
      00000451544445080004000000000005544F54414C08000400000000000000}
    Active = True
    Aggregates = <>
    IndexFieldNames = 'SEQ'
    Params = <>
    Left = 56
    Top = 328
    object cdsItensSEQ: TStringField
      DisplayWidth = 5
      FieldName = 'SEQ'
      Size = 4
    end
    object cdsItensCODIGO: TStringField
      DisplayWidth = 12
      FieldName = 'CODIGO'
      Size = 10
    end
    object cdsItensDESCRICAO: TStringField
      DisplayWidth = 98
      FieldName = 'DESCRICAO'
      Size = 100
    end
    object cdsItensVLR_UNITARIO: TFloatField
      DisplayWidth = 15
      FieldName = 'VLR_UNITARIO'
      DisplayFormat = '0.00'
    end
    object cdsItensQTDE: TFloatField
      DisplayWidth = 12
      FieldName = 'QTDE'
      DisplayFormat = '0.00'
    end
    object cdsItensTOTAL: TFloatField
      DisplayWidth = 12
      FieldName = 'TOTAL'
      DisplayFormat = '0.00'
    end
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 112
    Top = 328
  end
  object qItens: TFDQuery
    Connection = DM.fdConn
    SQL.Strings = (
      'SELECT * FROM PEDITE')
    Left = 168
    Top = 328
    object qItensPI_ID: TFDAutoIncField
      FieldName = 'PI_ID'
      Origin = 'PI_ID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qItensPI_PEDIDO: TStringField
      FieldName = 'PI_PEDIDO'
      Origin = 'PI_PEDIDO'
      Required = True
      Size = 10
    end
    object qItensPI_SEQ: TStringField
      FieldName = 'PI_SEQ'
      Origin = 'PI_SEQ'
      Required = True
      Size = 5
    end
    object qItensPI_PRO_CODIGO: TStringField
      FieldName = 'PI_PRO_CODIGO'
      Origin = 'PI_PRO_CODIGO'
      Required = True
      Size = 10
    end
    object qItensPI_PRO_DESCRICAO: TStringField
      FieldName = 'PI_PRO_DESCRICAO'
      Origin = 'PI_PRO_DESCRICAO'
      Required = True
      Size = 80
    end
    object qItensPI_PRO_VLR_VENDA: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'PI_PRO_VLR_VENDA'
      Origin = 'PI_PRO_VLR_VENDA'
    end
    object qItensPI_PRO_QTDE: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'PI_PRO_QTDE'
      Origin = 'PI_PRO_QTDE'
    end
    object qItensPI_PRO_TOTAL: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'PI_PRO_TOTAL'
      Origin = 'PI_PRO_TOTAL'
    end
  end
end
