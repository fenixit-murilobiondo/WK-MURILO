unit uDM;

interface

uses
  System.SysUtils, System.Classes, INIFiles, Forms, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client, Dialogs, Vcl.DBGrids;

type
  TDM = class(TDataModule)
    fdConn: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function LerIni(Chave: String; ValorPadrao: String = ''): String;
  public
    { Public declarations }
    function StrToDateSQL(cDate: String): String;
    function DateToDateSQL(cDate: TDateTime): String;
    procedure DimensionarGrid(dbg: TDBGrid);

  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  try
    with fdConn do
     begin
      Connected := False;
      Params.Clear;
      Params.Values['DriverID']   := 'MySQL';
      Params.Values['Server']     := LerIni('MySQL','Servidor');
      Params.Values['Port']       := LerIni('MySQL','Porta');
      Params.Values['Database']   := LerIni('MySQL','BD');
      Params.Values['User_name']  := LerIni('MySQL','User');
      Params.Values['Password']   := LerIni('MySQL','Password');
      Params.Values['VendorLib']  := ExtractFilePath(Application.ExeName) + 'libmysql.dll';
      Connected := True;
     end;
  except
     on E:Exception do
      MessageDlg('Erro ao conectar!'#13'Erro: ' + e.Message, mtError, [mbOK], 0);
  end;
end;

function TDM.DateToDateSQL(cDate: TDateTime): String;
begin
  Result := StrToDateSQL(DateTimeToStr(cDate));
end;

procedure TDM.DimensionarGrid(dbg: TDBGrid);
type
  TArray = Array of Integer;
  procedure AjustarColumns(Swidth, TSize: Integer; Asize: TArray);
  var
    idx: Integer;
  begin
    if TSize = 0 then
    begin
      TSize := dbg.Columns.count;
      for idx := 0 to dbg.Columns.count - 1 do
        dbg.Columns[idx].Width := (dbg.Width - dbg.Canvas.TextWidth('AAAAAA')
          ) div TSize
    end
    else
      for idx := 0 to dbg.Columns.count - 1 do
        dbg.Columns[idx].Width := dbg.Columns[idx].Width +
          (Swidth * Asize[idx] div TSize);
  end;

var
  idx, Twidth, TSize, Swidth: Integer;
  AWidth: TArray;
  Asize: TArray;
  NomeColuna: String;
begin
  SetLength(AWidth, dbg.Columns.count);
  SetLength(Asize, dbg.Columns.count);
  Twidth := 0;
  TSize := 0;
  for idx := 0 to dbg.Columns.count - 1 do
  begin
    NomeColuna := dbg.Columns[idx].Title.Caption;
    dbg.Columns[idx].Width := dbg.Canvas.TextWidth
      (dbg.Columns[idx].Title.Caption + 'A');
    AWidth[idx] := dbg.Columns[idx].Width;
    Twidth := Twidth + AWidth[idx];

    if Assigned(dbg.Columns[idx].Field) then
      Asize[idx] := dbg.Columns[idx].Field.Size
    else
      Asize[idx] := 1;

    TSize := TSize + Asize[idx];
  end;
  if TDBGridOption.dgColLines in dbg.Options then
    Twidth := Twidth + dbg.Columns.count;

  // adiciona a largura da coluna indicada do cursor
  if TDBGridOption.dgIndicator in dbg.Options then
    Twidth := Twidth + IndicatorWidth;

  Swidth := dbg.ClientWidth - Twidth;
  AjustarColumns(Swidth, TSize, Asize);
end;

function TDM.LerIni(Chave, ValorPadrao: String): String;
var
  Arquivo: String;
  FileIni: TIniFile;
begin
  try
    FileIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config.ini');
    Result := FileIni.ReadString(Chave, ValorPadrao, '');
  finally
    FreeAndNil(FileIni)
  end;
end;

function TDM.StrToDateSQL(cDate: String): String;
begin
  if length(cDate) = 10 then // cDate = dd/mm/yyyy
    Result := Copy(cDate, 7, 4) + '-' + Copy(cDate, 4, 2) + '-' + Copy(cDate, 1, 2)
  else // dd/mm/yy
  begin
    if StrToInt(Copy(cDate, 7, 2)) > 50 then
      Result := '19' + Copy(cDate, 7, 2) + '-' + Copy(cDate, 4, 2) + '-' + Copy(cDate, 1, 2)
    else
      Result := '20' + Copy(cDate, 7, 2) + '-' + Copy(cDate, 4, 2) + '-' + Copy(cDate, 1, 2);
  end;
end;

end.
