object frmPedidoItem: TfrmPedidoItem
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Inserindo/Alterando Item'
  ClientHeight = 182
  ClientWidth = 456
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 45
    Height = 13
    Caption = 'Produto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 63
    Height = 13
    Caption = 'R$ Unit'#225'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 169
    Top = 64
    Width = 30
    Height = 13
    Caption = 'Qtde.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 371
    Top = 64
    Width = 29
    Height = 13
    Caption = 'Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtProCodigo: TEdit
    Left = 8
    Top = 25
    Width = 91
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    OnExit = edtProCodigoExit
  end
  object btnBuscaProduto: TBitBtn
    Left = 97
    Top = 23
    Width = 27
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = btnBuscaProdutoClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 136
    Width = 456
    Height = 46
    Align = alBottom
    Color = clGrayText
    ParentBackground = False
    TabOrder = 5
    object BitBtn2: TBitBtn
      Left = 101
      Top = 8
      Width = 121
      Height = 33
      Caption = 'Gravar'
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
      Left = 228
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
  object edtVlrUnit: TEdit
    Left = 8
    Top = 81
    Width = 91
    Height = 21
    TabOrder = 3
    Text = '0,00'
    OnExit = edtVlrUnitExit
  end
  object edtQtde: TEdit
    Left = 169
    Top = 81
    Width = 91
    Height = 21
    TabOrder = 4
    Text = '0,00'
    OnExit = edtQtdeExit
  end
  object edtTotal: TEdit
    Left = 344
    Top = 81
    Width = 91
    Height = 21
    TabStop = False
    Alignment = taCenter
    Color = clGradientInactiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
    Text = '0,00'
  end
  object edtProDescricao: TEdit
    Left = 129
    Top = 25
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
    TabOrder = 2
  end
end
