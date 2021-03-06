unit uPedidoItem;

interface

uses
  System.SysUtils, System.Classes, INIFiles, Forms, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client, Dialogs, uDM;

type
TPedidoItem = class
 private
  F_PI_ID: INTEGER;
  F_PI_PEDIDO: STRING;
  F_PI_SEQ: STRING;
  F_PI_PRO_CODIGO: STRING;
  F_PI_PRO_DESCRICAO: STRING;
  F_PI_PRO_VLR_VENDA: DOUBLE;
  F_PI_PRO_QTDE: DOUBLE;
  F_PI_PRO_TOTAL: DOUBLE;

 public
   function Inserir(): Boolean;
   function Alterar(): Boolean;
   function Excluir(cPedido, cSeq, cProduto: String): Boolean;
   function ProximoCodigo(cPedido: String): String;
   function Pesquisar(Codigo, Seq: String): TPedidoItem;

 published
   property PI_ID: Integer read F_PI_ID write F_PI_ID;
   property PI_PEDIDO: String read F_PI_PEDIDO write F_PI_PEDIDO;
   property PI_SEQ: String read F_PI_SEQ write F_PI_SEQ;
   property PI_PRO_CODIGO: String read F_PI_PRO_CODIGO write F_PI_PRO_CODIGO;
   property PI_PRO_DESCRICAO: String read F_PI_PRO_DESCRICAO write F_PI_PRO_DESCRICAO;
   property PI_PRO_VLR_VENDA: Double read F_PI_PRO_VLR_VENDA write F_PI_PRO_VLR_VENDA;
   property PI_PRO_QTDE: Double read F_PI_PRO_QTDE write F_PI_PRO_QTDE;
   property PI_PRO_TOTAL: Double read F_PI_PRO_TOTAL write F_PI_PRO_TOTAL;

end;

implementation

{ TPedidoItem }

function TPedidoItem.Inserir: Boolean;
const
 Sql_Inserir = 'INSERT INTO PEDITE VALUES (' +
 ' :PI_ID, ' +
 ' :PI_PEDIDO, ' +
 ' :PI_SEQ, ' +
 ' :PI_PRO_CODIGO, ' +
 ' :PI_PRO_DESCRICAO, ' +
 ' :PI_PRO_VLR_VENDA, ' +
 ' :PI_PRO_QTDE, ' +
 ' :PI_PRO_TOTAL ' +
')';
var
  fdQry: TFDQuery;
begin
  try
    Result := True;
    fdQry := TFDQuery.Create(nil);
    with fdQry do
    begin
      Connection := DM.fdConn;
      SQL.Clear;
      SQL.Text := Sql_Inserir;

      ParamByName('PI_ID').Value := 'null';
      ParamByName('PI_PEDIDO').Value := F_PI_PEDIDO;
      ParamByName('PI_SEQ').Value := F_PI_SEQ;
      ParamByName('PI_PRO_CODIGO').Value := F_PI_PRO_CODIGO;
      ParamByName('PI_PRO_DESCRICAO').Value := F_PI_PRO_DESCRICAO;
      ParamByName('PI_PRO_VLR_VENDA').Value := F_PI_PRO_VLR_VENDA;
      ParamByName('PI_PRO_QTDE').Value := F_PI_PRO_QTDE;
      ParamByName('PI_PRO_TOTAL').Value := F_PI_PRO_TOTAL;

//      try
//        DM.fdConn.StartTransaction;
        ExecSQL;
//        DM.fdConn.Commit;
//      except on E: Exception do
//        begin
//          ShowMessage('Erro:' + E.Message);
//          DM.fdConn.Rollback;
//          Result := False;
//        end;
//      end;
    end;

  finally
    if Assigned(fdQry) then
      FreeAndNil(fdQry);
  end;
end;

function TPedidoItem.Alterar: Boolean;
const
 Sql_Alterar = 'UPDATE PEDITE SET ' +
 ' PI_PRO_CODIGO = :PI_PRO_CODIGO, ' +
 ' PI_PRO_DESCRICAO = :PI_PRO_DESCRICAO, ' +
 ' PI_PRO_VLR_VENDA = :PI_PRO_VLR_VENDA, ' +
 ' PI_PRO_QTDE = :PI_PRO_QTDE, ' +
 ' PI_PRO_TOTAL = :PI_PRO_TOTAL ' +
' WHERE PI_PEDIDO = :PI_PEDIDO ' +
' AND PI_SEQ = :PI_SEQ ';
var
  fdQry: TFDQuery;
begin
  try
    Result := True;
    fdQry := TFDQuery.Create(nil);
    with fdQry do
    begin
      Connection := DM.fdConn;
      SQL.Clear;
      SQL.Text := Sql_Alterar;

      ParamByName('PI_PEDIDO').Value := F_PI_PEDIDO;
      ParamByName('PI_SEQ').Value := F_PI_SEQ;
      ParamByName('PI_PRO_CODIGO').Value := F_PI_PRO_CODIGO;
      ParamByName('PI_PRO_DESCRICAO').Value := F_PI_PRO_DESCRICAO;
      ParamByName('PI_PRO_VLR_VENDA').Value := F_PI_PRO_VLR_VENDA;
      ParamByName('PI_PRO_QTDE').Value := F_PI_PRO_QTDE;
      ParamByName('PI_PRO_TOTAL').Value := F_PI_PRO_TOTAL;

      try
        DM.fdConn.StartTransaction;
        ExecSQL;
        DM.fdConn.Commit;
      except
        DM.fdConn.Rollback;
        Result := False;
      end;
    end;

  finally
    if Assigned(fdQry) then
      FreeAndNil(fdQry);
  end;
end;

function TPedidoItem.Excluir(cPedido, cSeq, cProduto: String): Boolean;
const
 Sql_Excluir_Itens = 'DELETE FROM PEDITE WHERE PI_PEDIDO = :PI_PEDIDO ' +
 ' AND PI_SEQ = :PI_SEQ AND PI_PRO_CODIGO = :PI_PRO_CODIGO ';
var
  fdQry: TFDQuery;
begin
  try
    Result := True;
    fdQry := TFDQuery.Create(nil);
    with fdQry do
    begin
      Connection := DM.fdConn;
      try
        SQL.Clear;
        SQL.Text := Sql_Excluir_Itens;
        ParamByName('PI_PEDIDO').Value := cPedido;
        ParamByName('PI_SEQ').Value := cSeq;
        ParamByName('PI_PRO_CODIGO').Value := cProduto;

        DM.fdConn.StartTransaction;
        ExecSQL;
        DM.fdConn.Commit;
      except
        DM.fdConn.Rollback;
        Result := False;
      end;
    end;

  finally
    if Assigned(fdQry) then
      FreeAndNil(fdQry);
  end;
end;

function TPedidoItem.ProximoCodigo(cPedido: String): String;
const
 Sql_Proximo = 'SELECT MAX(PI_SEQ) AS REC FROM PEDITE WHERE PI_PEDIDO = :PI_PEDIDO';
var
  fdQry: TFDQuery;
begin
  try
    fdQry := TFDQuery.Create(nil);
    with fdQry do
    begin
      Connection := DM.fdConn;
      SQL.Clear;
      SQL.Text := Sql_Proximo;
      ParamByName('PI_PEDIDO').Value := cPedido;
      try
        Open;
        if (FieldByName('REC').IsNull) or (FieldByName('REC').Value = '') then
          Result := FormatFloat('0000', 1)
        else
          Result := FormatFloat('0000', FieldByName('REC').Value + 1);
      except
        Raise;
      end;
    end;

  finally
    if Assigned(fdQry) then
      FreeAndNil(fdQry);
  end;
end;

function TPedidoItem.Pesquisar(Codigo, Seq: String): TPedidoItem;
const
 Sql_Pesquisa = 'SELECT * FROM PEDITE '+
' WHERE PI_PEDIDO = :PI_PEDIDO ' +
' WHERE PI_SEQ = :PI_SEQ ';
var
  fdQry: TFDQuery;
begin
  try
    fdQry := TFDQuery.Create(nil);
    with fdQry do
    begin
      Connection := DM.fdConn;
      SQL.Clear;
      SQL.Text := Sql_Pesquisa;
      ParamByName('PE_PEDIDO').Value := Codigo;
      Open;
      PI_ID := FieldByName('PI_ID').Value;
      PI_PEDIDO := FieldByName('PI_PEDIDO').Value;
      PI_PRO_CODIGO := FieldByName('PI_PRO_CODIGO').Value;
      PI_PRO_DESCRICAO := FieldByName('PI_PRO_DESCRICAO').Value;
      PI_PRO_VLR_VENDA := FieldByName('PI_PRO_VLR_VENDA').Value;
      PI_PRO_QTDE := FieldByName('PI_PRO_QTDE').Value;
      PI_PRO_TOTAL := FieldByName('PI_PRO_TOTAL').Value;
      Close;
    end;

  finally
    if Assigned(fdQry) then
      FreeAndNil(fdQry);
  end;
end;

end.
