unit uFrmPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, uCliente, uPedido, Data.DB,
  Datasnap.DBClient, uPedidoItem, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmPedido = class(TForm)
    pnlTitulo: TPanel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    tbGeral: TTabSheet;
    pnlBotoesItem: TPanel;
    DBGrid1: TDBGrid;
    edtCliCodigo: TEdit;
    Label1: TLabel;
    edtCliNome: TEdit;
    btnBuscaCliente: TBitBtn;
    Panel3: TPanel;
    edtPedido: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtCliCidade: TEdit;
    edtCliUF: TEdit;
    Label4: TLabel;
    btnInserirProduto: TBitBtn;
    btnEditarProduto: TBitBtn;
    btnExcluirProduto: TBitBtn;
    btnInserir: TBitBtn;
    btnEditar: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    edtVlrTotal: TEdit;
    Label5: TLabel;
    btnBuscaPedido: TBitBtn;
    edtEmissao: TDateTimePicker;
    Label6: TLabel;
    cdsItens: TClientDataSet;
    dsItens: TDataSource;
    cdsItensSEQ: TStringField;
    cdsItensCODIGO: TStringField;
    cdsItensDESCRICAO: TStringField;
    cdsItensVLR_UNITARIO: TFloatField;
    cdsItensQTDE: TFloatField;
    cdsItensTOTAL: TFloatField;
    qItens: TFDQuery;
    qItensPI_ID: TFDAutoIncField;
    qItensPI_PEDIDO: TStringField;
    qItensPI_SEQ: TStringField;
    qItensPI_PRO_CODIGO: TStringField;
    qItensPI_PRO_DESCRICAO: TStringField;
    qItensPI_PRO_VLR_VENDA: TSingleField;
    qItensPI_PRO_QTDE: TSingleField;
    qItensPI_PRO_TOTAL: TSingleField;
    procedure FormShow(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnInserirProdutoClick(Sender: TObject);
    procedure btnEditarProdutoClick(Sender: TObject);
    procedure btnBuscaClienteClick(Sender: TObject);
    procedure edtCliCodigoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirProdutoClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnBuscaPedidoClick(Sender: TObject);
    procedure edtPedidoExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Metodo: String;
    SeqItens: Integer;

    procedure Totalizar;
    procedure LimparCampos;

    procedure UpdateBotoes;
    procedure IgualarCampos;

    procedure GetAllItens;
    procedure Inserir;
    procedure Alterar;
  end;

var
  frmPedido: TfrmPedido;
  oCliente: TCliente;
  oPedido: TPedido;
  oPedidoItem: TPedidoItem;

implementation

{$R *.dfm}

uses uFrmBusca, uFrmPedidoItem, uDM, uFrmBuscaPedido;

{ TfrmPedido }

procedure TfrmPedido.Alterar;
begin
//  DM.fdConn.StartTransaction;
//  try
    with oPedido do
    begin
      PE_EMISSAO := DM.DateToDateSQL(edtEmissao.Date);
      PE_PEDIDO := edtPedido.Text;
      PE_CLI_CODIGO := edtCliCodigo.Text;
      PE_VLR_TOTAL := StrToFloat(edtVlrTotal.Text);
      Alterar;
    end;
//    with oPedidoItem do
//    begin
//      cdsItens.DisableControls;
//      cdsItens.First;
//      while not cdsItens.EOF do
//      begin
//        PI_PEDIDO := oPedido.PE_PEDIDO;
//        PI_SEQ := cdsItensSEQ.Text;
//        PI_PRO_CODIGO := cdsItensCODIGO.Text;
//        PI_PRO_DESCRICAO := cdsItensDESCRICAO.Text;
//        PI_PRO_VLR_VENDA := cdsItensVLR_UNITARIO.Value;
//        PI_PRO_QTDE := cdsItensQTDE.Value;
//        PI_PRO_TOTAL := cdsItensTOTAL.Value;
//        Inserir;
//        cdsItens.Next;
//      end;
//      cdsItens.EnableControls;
//    end;
//    DM.fdConn.Commit;
//  except
//    DM.fdConn.Rollback;
//  end;
end;

procedure TfrmPedido.btnInserirProdutoClick(Sender: TObject);
var
  F: TfrmPedidoItem;
begin
  F := TfrmPedidoItem.Create(Self);
  F.Metodo := 'I';
  F.ShowModal;

  SeqItens := 0;
  if cdsItens.IsEmpty then
  begin
    SeqItens := SeqItens + 1;
  end
  else
  begin
    cdsItens.Last;
    SeqItens := StrToInt(cdsItensSEQ.Text) + 1;
  end;

  if F.ModalResult = MrOK then
  begin
    with oPedidoItem do
    begin
      PI_PEDIDO := edtPedido.Text;
      PI_SEQ    := FormatFloat('0000', SeqItens);
      PI_PRO_CODIGO := F.edtProCodigo.Text;
      PI_PRO_DESCRICAO := F.edtProDescricao.Text;
      PI_PRO_VLR_VENDA := StrToFloat(F.edtVlrUnit.Text);
      PI_PRO_QTDE := StrToFloat(F.edtQtde.Text);
      PI_PRO_TOTAL := StrToFloat(F.edtTotal.Text);
      Inserir;
    end;
  end;
  GetAllItens;
end;

procedure TfrmPedido.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    btnExcluirProdutoClick(Self);
  if DBGrid1.CanFocus then
    if Key = VK_RETURN then
      btnEditarProdutoClick(Sender);
end;

procedure TfrmPedido.edtCliCodigoExit(Sender: TObject);
begin
  if edtCliCodigo.Text <> '' then
  begin
    edtCliCodigo.Text := FormatFloat('000000', StrToInt(edtCliCodigo.Text));
    oCliente.Pesquisar(edtCliCodigo.Text);
    if oCliente.CLI_CODIGO <> '' then
    begin
      edtCliCodigo.Text := oCliente.CLI_CODIGO;
      edtCliNome.Text   := oCliente.CLI_NOME;
      edtCliCidade.Text := oCliente.CLI_CIDADE;
      edtCliUF.Text     := oCliente.CLI_UF;
      //
    end
    else
    begin
      ShowMessage('Cliente năo encontrado !');
      edtCliNome.Text   := '';
      edtCliCidade.Text := '';
      edtCliUF.Text     := '';
      edtCliCodigo.SetFocus;
    end;
  end
  else
  begin
    edtCliNome.Text   := '';
    edtCliCidade.Text := '';
    edtCliUF.Text     := '';
  end;
end;

procedure TfrmPedido.edtPedidoExit(Sender: TObject);
begin
  if edtPedido.Text <> '' then
  begin
    edtPedido.Text := FormatFloat('000000', StrToInt(edtPedido.Text));
    oPedido.Pesquisar(edtPedido.Text);
    if oPedido.PE_PEDIDO <> '' then
    begin
      edtPedido.Text    := oPedido.PE_PEDIDO;
      edtEmissao.Date   := StrToDate(oPedido.PE_EMISSAO);
      edtCliCodigo.Text := oPedido.PE_CLI_CODIGO;

      btnEditarClick(Self);
    end
    else
    begin
      ShowMessage('Pedido năo encontrado !');
      edtPedido.Text    := '';
      edtEmissao.Date   := Now;
      edtCliCodigo.Text := '';
      edtCliCodigoExit(Self);
      edtCliCodigo.SetFocus;
    end;
  end
  else
  begin
    edtCliNome.Text   := '';
    edtCliCidade.Text := '';
    edtCliUF.Text     := '';
  end;
end;

procedure TfrmPedido.btnEditarProdutoClick(Sender: TObject);
var
  F: TfrmPedidoItem;
begin
  if cdsItens.IsEmpty then
    Exit;

  F := TfrmPedidoItem.Create(Self);
  F.Metodo := 'A';
  F.ShowModal;
  if F.ModalResult = MrOk then
  begin
    with oPedidoItem do
    begin
      PI_PEDIDO := edtPedido.Text;
      PI_SEQ    := cdsItensSEQ.Text;
      PI_PRO_CODIGO := F.edtProCodigo.Text;
      PI_PRO_DESCRICAO := F.edtProDescricao.Text;
      PI_PRO_VLR_VENDA := StrToFloat(F.edtVlrUnit.Text);
      PI_PRO_QTDE := StrToFloat(F.edtQtde.Text);
      PI_PRO_TOTAL := StrToFloat(F.edtTotal.Text);
      Alterar;
    end;
  end;
  GetAllItens;
end;

procedure TfrmPedido.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Excluir o Pedido: ' + edtPedido.Text + ' ?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    oPedido.Excluir(edtPedido.Text);
    btnCancelarClick(Self);
  end;
  Totalizar;
end;

procedure TfrmPedido.btnExcluirProdutoClick(Sender: TObject);
begin
  if cdsItens.IsEmpty then
    Exit;

  if MessageDlg('Excluir o Produto: ' + cdsItensDESCRICAO.Text + ' ?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
  begin
    oPedidoItem.Excluir(edtPedido.Text, cdsItensSEQ.Text, cdsItensCODIGO.Text);
  end;
  GetAllItens;
end;

procedure TfrmPedido.btnBuscaClienteClick(Sender: TObject);
var
  F: TfrmBusca;
begin
  F := TfrmBusca.Create(Self);
  F.Caption     := 'Buscar Cliente';
  F.str_Tabela  := 'CLIENTE';
  F.str_Campos  := '*';
  F.ShowModal;
  if F.ModalResult = MrOK then
  begin
    edtCliCodigo.Text := F.fdQry.FieldByName('CLI_CODIGO').AsString;
    edtCliCodigoExit(Self);
  end;
end;

procedure TfrmPedido.btnBuscaPedidoClick(Sender: TObject);
var
  F: TfrmBuscaPedido;
begin
  F := TfrmBuscaPedido.Create(Self);
  F.ShowModal;
  if F.ModalResult = MrOK then
  begin
    edtPedido.Text := F.fdQry.FieldByName('PE_PEDIDO').AsString;
    edtPedidoExit(Self);
  end;
end;

procedure TfrmPedido.btnCancelarClick(Sender: TObject);
begin
  Metodo := '';
  UpdateBotoes;
  LimparCampos;
  edtPedido.SetFocus;
end;

procedure TfrmPedido.btnEditarClick(Sender: TObject);
begin
  if edtPedido.Text = '' then
  begin
    ShowMessage('Selecione um Pedido para Editar !');
    edtPedido.SetFocus;
    Exit;
  end;
  Caption := 'Pedido de Venda [EDITANDO]';
  Metodo := 'A';
  UpdateBotoes;
  IgualarCampos;
end;

procedure TfrmPedido.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPedido.btnGravarClick(Sender: TObject);
begin
  if edtPedido.Text = '' then
  begin
    ShowMessage('Número do Pedido obrigatório !');
    Exit;
  end;

  if edtCliCodigo.Text = '' then
  begin
    ShowMessage('Cliente do Pedido obrigatório !');
    edtCliCodigo.SetFocus;
    Exit;
  end;

//  if Metodo = 'I' then
//    Inserir
//  else if Metodo = 'A' then
//    Alterar;

  Alterar;

  ShowMessage('Pedido: ' + edtPedido.Text + ' gravado com sucesso !');
  btnCancelarClick(Self);
end;

procedure TfrmPedido.btnInserirClick(Sender: TObject);
begin
  LimparCampos;
  edtPedido.Text := oPedido.ProximoCodigo;
  oPedido.InserirTemp(edtPedido.Text);
  edtEmissao.Date := Now;
  Caption := 'Pedido de Venda [INSERINDO]';
  Metodo  := 'I';
  UpdateBotoes;
  SeqItens := 1;
  if not cdsItens.Active then
    cdsItens.Active := True;

  edtCliCodigo.SetFocus;
end;

procedure TfrmPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Destruir Classes
  if Assigned(oCliente) then FreeAndNil(oCliente);
  if Assigned(oPedido) then FreeAndNil(oPedido);
  if Assigned(oPedidoItem) then FreeAndNil(oPedidoItem);
end;

procedure TfrmPedido.FormCreate(Sender: TObject);
begin
  //Criar Classes Utilizadas
  oCliente := TCliente.Create;
  oPedido  := TPedido.Create;
  oPedidoItem := TPedidoItem.Create;
end;

procedure TfrmPedido.FormKeyPress(Sender: TObject; var Key: Char);
Begin
 If Key = #13 then //Se o comando for igual a enter
 Begin
  Key := #0;
  Perform (wm_nextdlgctl, 0, 0); //Para pular de campo em campo
 End;
End;

procedure TfrmPedido.FormResize(Sender: TObject);
begin
  DM.DimensionarGrid(DBGrid1);
end;

procedure TfrmPedido.FormShow(Sender: TObject);
begin
  DM.DimensionarGrid(DBGrid1);
  edtEmissao.Date := Now;
  Metodo := '';
  UpdateBotoes;
  edtPedido.SetFocus;
end;

procedure TfrmPedido.GetAllItens;
begin
  qItens.Close;
  qItens.SQL.Clear;
  qItens.SQL.Text := 'SELECT * FROM PEDITE ' +
  ' WHERE PI_PEDIDO = ' + QuotedStr(edtPedido.Text);
  qItens.Open;

  cdsItens.EmptyDataSet;
  cdsItens.DisableControls;
  while not qItens.Eof do
  begin
    cdsItens.Append;
    cdsItensSEQ.Text := qItensPI_SEQ.Text;
    cdsItensCODIGO.Text := qItensPI_PRO_CODIGO.Text;
    cdsItensDESCRICAO.Text := qItensPI_PRO_DESCRICAO.Text;
    cdsItensVLR_UNITARIO.Value := qItensPI_PRO_VLR_VENDA.Value;
    cdsItensQTDE.Value := qItensPI_PRO_QTDE.Value;
    cdsItensTOTAL.Value := qItensPI_PRO_TOTAL.Value;
    cdsItens.Post;
    qItens.Next;
  end;
  cdsItens.EnableControls;
  DM.DimensionarGrid(DBGrid1);
  Totalizar;
end;

procedure TfrmPedido.IgualarCampos;
begin
  with oPedido do
  begin
    Pesquisar(edtPedido.Text);
    edtCliCodigo.Text := PE_CLI_CODIGO;
    edtCliCodigoExit(Self);
    edtVlrTotal.Text := FormatFloat('0.00', PE_VLR_TOTAL);
  end;

  GetAllItens;
end;

procedure TfrmPedido.Inserir;
begin
//  DM.fdConn.StartTransaction;
//  try
    with oPedido do
    begin
      PE_EMISSAO := DM.DateToDateSQL(edtEmissao.Date);
      PE_PEDIDO := edtPedido.Text;
      PE_CLI_CODIGO := edtCliCodigo.Text;
      PE_VLR_TOTAL := StrToFloat(edtVlrTotal.Text);
      Inserir;
    end;
//    with oPedidoItem do
//    begin
//      cdsItens.DisableControls;
//      cdsItens.First;
//      while not cdsItens.EOF do
//      begin
//        PI_PEDIDO := oPedido.PE_PEDIDO;
//        PI_SEQ := cdsItensSEQ.Text;
//        PI_PRO_CODIGO := cdsItensCODIGO.Text;
//        PI_PRO_DESCRICAO := cdsItensDESCRICAO.Text;
//        PI_PRO_VLR_VENDA := cdsItensVLR_UNITARIO.Value;
//        PI_PRO_QTDE := cdsItensQTDE.Value;
//        PI_PRO_TOTAL := cdsItensTOTAL.Value;
//        Inserir;
//        cdsItens.Next;
//      end;
//      cdsItens.EnableControls;
//    end;
//    DM.fdConn.Commit;
//  except
//    DM.fdConn.Rollback;
//  end;
end;

procedure TfrmPedido.LimparCampos;
begin
  edtPedido.Text := '';
  edtCliCodigo.Text := '';
  edtCliNome.Text := '';
  edtCliCidade.Text := '';
  edtCliUF.Text := '';
  edtVlrTotal.Text := '0,00';
  cdsItens.EmptyDataSet;
end;

procedure TfrmPedido.Totalizar;
var
  vTotal: Double;
begin
  cdsItens.DisableControls;
  cdsItens.First;
  while not cdsItens.Eof do
  begin
    vTotal := vTotal + cdsItensTOTAL.Value;
    cdsItens.Next;
  end;
  cdsItens.EnableControls;
  edtVlrTotal.Text := FormatFloat('0.00', vTotal);
end;

procedure TfrmPedido.UpdateBotoes;
begin
  if (Metodo = 'I') or (Metodo = 'A') then
  begin
    btnInserir.Enabled     := False;
    btnEditar.Enabled      := False;
    btnGravar.Enabled      := True;
    btnCancelar.Enabled    := True;
    btnExcluir.Enabled     := True;
    btnBuscaPedido.Visible := False;
    pnlBotoesItem.Enabled  := True;
    edtCliCodigo.Enabled   := True;
    btnBuscaCliente.Enabled:= True;
    edtCliNome.Enabled     := True;
    edtCliCidade.Enabled   := True;
    edtCliUF.Enabled       := True;
    edtPedido.Enabled      := False;
  end
  else
  begin
    Caption := 'Pedido de Venda';
    btnInserir.Enabled     := True;
    btnEditar.Enabled      := True;
    btnGravar.Enabled      := False;
    btnCancelar.Enabled    := False;
    btnExcluir.Enabled     := False;
    btnBuscaPedido.Visible := True;
    pnlBotoesItem.Enabled  := False;
    edtCliCodigo.Enabled   := False;
    btnBuscaCliente.Enabled:= False;
    edtCliNome.Enabled     := False;
    edtCliCidade.Enabled   := False;
    edtCliUF.Enabled       := False;
    edtPedido.Enabled      := True;
  end;
  pnlTitulo.Caption := Caption;
end;

end.
