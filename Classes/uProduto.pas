unit uProduto;

interface

uses
  System.SysUtils, System.Classes, INIFiles, Forms, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client, Dialogs, uDM;

type
TProduto = class
 private
   F_PRO_CODIGO: String;
   F_PRO_DESCRICAO: String;
   F_PRO_VLR_VENDA: Double;

 public
   function Pesquisar(Codigo: String): TProduto;

 published
   property PRO_CODIGO: String read F_PRO_CODIGO write F_PRO_CODIGO;
   property PRO_DESCRICAO: String read F_PRO_DESCRICAO write F_PRO_DESCRICAO;
   property PRO_VLR_VENDA: Double read F_PRO_VLR_VENDA write F_PRO_VLR_VENDA;

end;

implementation

{ TCliente }

function TProduto.Pesquisar(Codigo: String): TProduto;
const
 Sql_Pesquisa = 'SELECT * FROM PRODUTO '+
' WHERE PRO_CODIGO = :PRO_CODIGO';
var
  fdQry: TFDQuery;
  Produto: TProduto;
begin
  try
    fdQry := TFDQuery.Create(nil);
    with fdQry do
    begin
      Connection := DM.fdConn;
      SQL.Clear;
      SQL.Text := Sql_Pesquisa;
      ParamByName('PRO_CODIGO').Value := Codigo;
      try
        Open;
        PRO_CODIGO    := FieldByName('PRO_CODIGO').Value;
        PRO_DESCRICAO := FieldByName('PRO_DESCRICAO').Value;
        PRO_VLR_VENDA := FieldByName('PRO_VLR_VENDA').Value;
        Close;
      except
      end;
    end;
  finally
    if Assigned(fdQry) then
      FreeAndNil(fdQry);
  end;
end;

end.
