unit uFrmBusca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDM, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmBusca = class(TForm)
    pnlTitulo: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DBGrid1: TDBGrid;
    edtPesquisa: TEdit;
    fdQry: TFDQuery;
    dsQry: TDataSource;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure fdQryAfterOpen(DataSet: TDataSet);
    procedure edtPesquisaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    str_Caption, str_Tabela, str_Campos,
    str_OrderBy, str_Where: String;

    procedure GetAll;
  end;

var
  frmBusca: TfrmBusca;

implementation

{$R *.dfm}

{ TfrmBusca }

procedure TfrmBusca.BitBtn2Click(Sender: TObject);
begin
  if fdQry.IsEmpty then
    ModalResult := MrCancel
  else
    ModalResult := MrOK;
end;

procedure TfrmBusca.BitBtn3Click(Sender: TObject);
begin
  ModalResult := MrCancel;
end;

procedure TfrmBusca.DBGrid1DblClick(Sender: TObject);
begin
  BitBtn2Click(Self);
end;

procedure TfrmBusca.edtPesquisaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  GetAll;
end;

procedure TfrmBusca.fdQryAfterOpen(DataSet: TDataSet);
begin
  DM.DimensionarGrid(DBGrid1);
end;

procedure TfrmBusca.FormShow(Sender: TObject);
begin
  GetAll;
end;

procedure TfrmBusca.GetAll;
begin
  with fdQry do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT ' + str_Campos + ' FROM ' + str_Tabela + ' WHERE 1=1 ';

    if str_Where <> '' then
      SQL.Text := SQL.Text + str_Where;

    if edtPesquisa.Text <> '' then
    begin
      if str_Tabela = 'CLIENTE' then
        SQL.Text := SQL.Text + ' AND CLI_NOME LIKE ' + QuotedStr('%' + edtPesquisa.Text + '%');

      if str_Tabela = 'PRODUTO' then
        SQL.Text := SQL.Text + ' AND PRO_DESCRICAO LIKE ' + QuotedStr('%' + edtPesquisa.Text + '%');
    end;


    Open;

  end;
end;

end.
