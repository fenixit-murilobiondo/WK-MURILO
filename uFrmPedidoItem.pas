unit uFrmPedidoItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  uProduto;

type
  TfrmPedidoItem = class(TForm)
    Label1: TLabel;
    edtProCodigo: TEdit;
    btnBuscaProduto: TBitBtn;
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label2: TLabel;
    edtVlrUnit: TEdit;
    Label3: TLabel;
    edtQtde: TEdit;
    Label4: TLabel;
    edtTotal: TEdit;
    edtProDescricao: TEdit;
    procedure edtVlrUnitExit(Sender: TObject);
    procedure edtQtdeExit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnBuscaProdutoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtProCodigoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure Calcular;
  public
    { Public declarations }
    Metodo: String;
  end;

var
  frmPedidoItem: TfrmPedidoItem;
  oProduto: TProduto;

implementation

{$R *.dfm}

uses uFrmBusca;

procedure TfrmPedidoItem.BitBtn2Click(Sender: TObject);
begin
  if edtProCodigo.Text = '' then
  begin
    ShowMessage('O Código do produto é obrigatório !');
    edtProCodigo.SetFocus;
    Exit;
  end;

  if StrToFloat(edtQtde.Text) <= 0 then
  begin
    ShowMessage('Qtde. Inválida !');
    edtQtde.SetFocus;
    Exit;
  end;

  ModalResult := MrOK;
end;

procedure TfrmPedidoItem.BitBtn3Click(Sender: TObject);
begin
  ModalResult := MrCancel;
end;

procedure TfrmPedidoItem.btnBuscaProdutoClick(Sender: TObject);
var
  F: TfrmBusca;
begin
  F := TfrmBusca.Create(Self);
  F.Caption     := 'Buscar Produto';
  F.str_Tabela  := 'PRODUTO';
  F.str_Campos  := '*';
  F.ShowModal;
  if F.ModalResult = MrOK then
  begin
    edtProCodigo.Text := F.fdQry.FieldByName('PRO_CODIGO').AsString;
    edtProCodigoExit(Self);
  end;
end;

procedure TfrmPedidoItem.Calcular;
begin
  edtTotal.Text := FormatFloat('0.00', StrToFloat(edtVlrUnit.Text) * StrToFloat(edtQtde.Text));
end;

procedure TfrmPedidoItem.edtVlrUnitExit(Sender: TObject);
begin
  edtVlrUnit.Text := FormatFloat('0.00', StrToFloat(edtVlrUnit.Text));
  Calcular;
end;

procedure TfrmPedidoItem.edtQtdeExit(Sender: TObject);
begin
  edtQtde.Text := FormatFloat('0.00', StrToFloat(edtQtde.Text));
  Calcular;
end;

procedure TfrmPedidoItem.edtProCodigoExit(Sender: TObject);
begin
  if edtProCodigo.Text <> '' then
  begin
    edtProCodigo.Text := FormatFloat('000000', StrToInt(edtProCodigo.Text));
    oProduto.Pesquisar(edtProCodigo.Text);
    if oProduto.PRO_CODIGO <> '' then
    begin
      edtProCodigo.Text      := oProduto.PRO_CODIGO;
      edtProDescricao.Text   := oProduto.PRO_DESCRICAO;
      edtVlrUnit.Text        := FloatToStr(oProduto.PRO_VLR_VENDA);
      edtVlrUnitExit(Self);
      edtQtde.SetFocus;
      //
    end
    else
    begin
      ShowMessage('Produto năo encontrado !');
      edtProCodigo.Text      := oProduto.PRO_CODIGO;
      edtProDescricao.Text   := oProduto.PRO_DESCRICAO;
      edtVlrUnit.Text        := '0,00';
      edtQtde.Text           := '0,00';
      edtTotal.Text          := '0,00';
      edtProCodigo.SetFocus;
    end;
  end
  else
  begin
    edtProCodigo.Text      := oProduto.PRO_CODIGO;
    edtProDescricao.Text   := oProduto.PRO_DESCRICAO;
    edtVlrUnit.Text        := '0,00';
    edtQtde.Text           := '0,00';
    edtTotal.Text          := '0,00';
  end;
end;

procedure TfrmPedidoItem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(oProduto) then FreeAndNil(oProduto);
end;

procedure TfrmPedidoItem.FormCreate(Sender: TObject);
begin
  oProduto := TProduto.Create;
end;

procedure TfrmPedidoItem.FormKeyPress(Sender: TObject; var Key: Char);
Begin
 If Key = #13 then //Se o comando for igual a enter
 Begin
  Key := #0;
  Perform (wm_nextdlgctl, 0, 0); //Para pular de campo em campo
 End;
End;

end.
