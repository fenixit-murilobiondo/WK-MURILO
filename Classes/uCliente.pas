unit uCliente;

interface

uses
  System.SysUtils, System.Classes, INIFiles, Forms, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client, Dialogs, uDM;

type
TCliente = class
 private
   F_CLI_CODIGO: String;
   F_CLI_NOME: String;
   F_CLI_CIDADE: String;
   F_CLI_UF: String;

 public
   function Pesquisar(Codigo: String): TCliente;

 published
   property CLI_CODIGO: String read F_CLI_CODIGO write F_CLI_CODIGO;
   property CLI_NOME: String read F_CLI_NOME write F_CLI_NOME;
   property CLI_CIDADE: String read F_CLI_CIDADE write F_CLI_CIDADE;
   property CLI_UF: String read F_CLI_UF write F_CLI_UF;

end;

implementation

{ TCliente }

function TCliente.Pesquisar(Codigo: String): TCliente;
const
 Sql_Pesquisa = 'SELECT * FROM CLIENTE '+
' WHERE CLI_CODIGO = :CLI_CODIGO';
var
  fdQry: TFDQuery;
  Cliente: TCliente;
begin
  try
    fdQry := TFDQuery.Create(nil);
    with fdQry do
    begin
      Connection := DM.fdConn;
      SQL.Clear;
      SQL.Text := Sql_Pesquisa;
      ParamByName('CLI_CODIGO').Value := Codigo;
      try
        Open;
        CLI_CODIGO    := FieldByName('CLI_CODIGO').Value;
        CLI_NOME      := FieldByName('CLI_NOME').Value;
        CLI_CIDADE    := FieldByName('CLI_CIDADE').Value;
        CLI_UF        := FieldByName('CLI_UF').Value;
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
