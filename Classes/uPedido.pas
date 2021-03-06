unit uPedido;

interface

uses
  System.SysUtils, System.Classes, INIFiles, Forms, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client, Dialogs, uDM;

type
TPedido = class
 private
   F_PE_ID: Integer;
   F_PE_EMISSAO: String;
   F_PE_PEDIDO: String;
   F_PE_CLI_CODIGO: String;
   F_PE_VLR_TOTAL: Double;

 public
   function Inserir(): Boolean;
   function InserirTemp(cPedido: String): Boolean;
   function Alterar(): Boolean;
   function Excluir(cPedido: String): Boolean;
   function ProximoCodigo(): String;
   function Pesquisar(Codigo: String): TPedido;

 published
   property PE_ID: Integer read F_PE_ID write F_PE_ID;
   property PE_EMISSAO: String read F_PE_EMISSAO write F_PE_EMISSAO;
   property PE_PEDIDO: String read F_PE_PEDIDO write F_PE_PEDIDO;
   property PE_CLI_CODIGO: String read F_PE_CLI_CODIGO write F_PE_CLI_CODIGO;
   property PE_VLR_TOTAL: Double read F_PE_VLR_TOTAL write F_PE_VLR_TOTAL;

end;

implementation

{ TPedido }

function TPedido.Inserir: Boolean;
const
 Sql_Inserir = 'INSERT INTO PEDIDO VALUES (' +
 ' :PE_ID, ' +
 ' :PE_EMISSAO, ' +
 ' :PE_PEDIDO, ' +
 ' :PE_CLI_CODIGO, ' +
 ' :PE_VLR_TOTAL ' +
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

      ParamByName('PE_ID').Value := 'null';
      ParamByName('PE_EMISSAO').Value := F_PE_EMISSAO;
      ParamByName('PE_PEDIDO').Value := ProximoCodigo;
      ParamByName('PE_CLI_CODIGO').Value := F_PE_CLI_CODIGO;
      ParamByName('PE_VLR_TOTAL').Value := F_PE_VLR_TOTAL;

      try
        DM.fdConn.StartTransaction;
        ExecSQL;
        DM.fdConn.Commit;
      except on E: Exception do
        begin
          ShowMessage('Erro:' + E.Message);
          DM.fdConn.Rollback;
          Result := False;
        end;
      end;
    end;

  finally
    if Assigned(fdQry) then
      FreeAndNil(fdQry);
  end;
end;

function TPedido.InserirTemp(cPedido: String): Boolean;
const
 Sql_Inserir = 'INSERT INTO PEDIDO VALUES (' +
 ' :PE_ID, ' +
 ' :PE_EMISSAO, ' +
 ' :PE_PEDIDO, ' +
 ' :PE_CLI_CODIGO, ' +
 ' :PE_VLR_TOTAL ' +
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

      ParamByName('PE_ID').Value := 'null';
      ParamByName('PE_EMISSAO').Value := 'null';
      ParamByName('PE_PEDIDO').Value := cPedido;
      ParamByName('PE_CLI_CODIGO').Value := '000000';
      ParamByName('PE_VLR_TOTAL').Value := 0;

      try
        DM.fdConn.StartTransaction;
        ExecSQL;
        DM.fdConn.Commit;
      except on E: Exception do
        begin
          ShowMessage('Erro:' + E.Message);
          DM.fdConn.Rollback;
          Result := False;
        end;
      end;
    end;

  finally
    if Assigned(fdQry) then
      FreeAndNil(fdQry);
  end;
end;

function TPedido.Alterar: Boolean;
const
 Sql_Alterar = 'UPDATE PEDIDO SET ' +
' PE_EMISSAO = :PE_EMISSAO,' +
' PE_CLI_CODIGO = :PE_CLI_CODIGO,' +
' PE_VLR_TOTAL = :PE_VLR_TOTAL ' +
' WHERE PE_PEDIDO = :PE_PEDIDO';
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

      ParamByName('PE_EMISSAO').Value    := PE_EMISSAO;
      ParamByName('PE_PEDIDO').Value     := PE_PEDIDO;
      ParamByName('PE_CLI_CODIGO').Value := PE_CLI_CODIGO;
      ParamByName('PE_VLR_TOTAL').Value  := PE_VLR_TOTAL;

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

function TPedido.Excluir(cPedido: String): Boolean;
const
 Sql_Excluir_Cab = 'DELETE FROM PEDIDO WHERE PE_PEDIDO = :PE_PEDIDO';

 Sql_Excluir_Itens = 'DELETE FROM PEDITE WHERE PI_PEDIDO = :PI_PEDIDO';
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
      SQL.Text := Sql_Excluir_Itens;
      ParamByName('PI_PEDIDO').Value := cPedido;
      ExecSQL;

      SQL.Clear;
      SQL.Text := Sql_Excluir_Cab;
      ParamByName('PE_PEDIDO').Value := cPedido;
      ExecSQL;

      Result := False;
    end;
  finally
    if Assigned(fdQry) then
      FreeAndNil(fdQry);
  end;
end;

function TPedido.ProximoCodigo(): String;
const
 Sql_Proximo = 'SELECT MAX(PE_PEDIDO) AS REC FROM PEDIDO';
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
      try
        Open;
        if (FieldByName('REC').IsNull) or (FieldByName('REC').Value = '') then
          Result := FormatFloat('000000', 1)
        else
          Result := FormatFloat('000000', FieldByName('REC').Value + 1);
      except
        Raise;
      end;
    end;

  finally
    if Assigned(fdQry) then
      FreeAndNil(fdQry);
  end;
end;

function TPedido.Pesquisar(Codigo: String): TPedido;
const
 Sql_Pesquisa = 'SELECT * FROM PEDIDO '+
' WHERE PE_PEDIDO = :PE_PEDIDO AND PE_CLI_CODIGO <> ''000000'' ';
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
      PE_ID := FieldByName('PE_ID').Value;
      PE_EMISSAO := FieldByName('PE_EMISSAO').Value;
      PE_PEDIDO := FieldByName('PE_PEDIDO').Value;
      PE_CLI_CODIGO := FieldByName('PE_CLI_CODIGO').Value;
      PE_VLR_TOTAL := FieldByName('PE_VLR_TOTAL').Value;
      Close;
    end;

  finally
    if Assigned(fdQry) then
      FreeAndNil(fdQry);
  end;
end;

end.
