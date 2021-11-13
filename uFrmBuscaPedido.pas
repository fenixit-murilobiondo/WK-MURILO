unit uFrmBuscaPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uDM;

type
  TfrmBuscaPedido = class(TForm)
    pnlTitulo: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    cbFiltro: TComboBox;
    edtPesquisa: TEdit;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DBGrid1: TDBGrid;
    fdQry: TFDQuery;
    dsQry: TDataSource;
    procedure edtPesquisaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure fdQryAfterOpen(DataSet: TDataSet);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetAll;
  public
    { Public declarations }
  end;

var
  frmBuscaPedido: TfrmBuscaPedido;

implementation

{$R *.dfm}

{ TfrmBuscaPedido }

procedure TfrmBuscaPedido.BitBtn2Click(Sender: TObject);
begin
  if fdQry.IsEmpty then
    ModalResult := MrCancel;

  ModalResult := MrOK;
end;

procedure TfrmBuscaPedido.BitBtn3Click(Sender: TObject);
begin
  ModalResult := MrCancel;
end;

procedure TfrmBuscaPedido.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn2Click(Self);
end;

procedure TfrmBuscaPedido.edtPesquisaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  GetAll;
end;

procedure TfrmBuscaPedido.fdQryAfterOpen(DataSet: TDataSet);
begin
  DM.DimensionarGrid(DBGrid1);
end;

procedure TfrmBuscaPedido.FormShow(Sender: TObject);
begin
  GetAll;
  edtPesquisa.SetFocus;
end;

procedure TfrmBuscaPedido.GetAll;
begin
  with fdQry do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT PE_PEDIDO, PE_EMISSAO, ' +
    ' PE_CLI_CODIGO, CLI_NOME AS NOME, PE_VLR_TOTAL, CLI_CIDADE, CLI_UF FROM PEDIDO LEFT JOIN CLIENTE ON CLI_CODIGO = PE_CLI_CODIGO ' +
    ' WHERE PE_CLI_CODIGO <> ''000000'' ';

    if cbFiltro.ItemIndex = 0 then
      SQL.Text := SQL.Text + ' AND PE_PEDIDO LIKE ' + QuotedStr('%' + edtPesquisa.Text + '%');

    if cbFiltro.ItemIndex = 1 then
      SQL.Text := SQL.Text + ' AND PE_CLI_CODIGO LIKE ' + QuotedStr('%' + edtPesquisa.Text + '%');

    if cbFiltro.ItemIndex = 2 then
      SQL.Text := SQL.Text + ' AND CLI_NOME LIKE ' + QuotedStr('%' + edtPesquisa.Text + '%');

    if cbFiltro.ItemIndex = 3 then
      SQL.Text := SQL.Text + ' AND CLI_CIDADE LIKE ' + QuotedStr('%' + edtPesquisa.Text + '%');

    if cbFiltro.ItemIndex = 4 then
      SQL.Text := SQL.Text + ' AND PE_EMISSAO ' + DM.StrToDateSQL(edtPesquisa.Text);

    Open;
  end;
end;

end.
