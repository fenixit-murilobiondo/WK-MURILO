program PedidoWK;

uses
  Vcl.Forms,
  uFrmPedido in 'uFrmPedido.pas' {frmPedido},
  uFuncoes in 'uFuncoes.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  uFrmBusca in 'uFrmBusca.pas' {frmBusca},
  uFrmPedidoItem in 'uFrmPedidoItem.pas' {frmPedidoItem},
  uCliente in 'Classes\uCliente.pas',
  uProduto in 'Classes\uProduto.pas',
  uPedido in 'Classes\uPedido.pas',
  uFrmBuscaPedido in 'uFrmBuscaPedido.pas' {frmBuscaPedido},
  uPedidoItem in 'Classes\uPedidoItem.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPedido, frmPedido);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmBusca, frmBusca);
  Application.CreateForm(TfrmPedidoItem, frmPedidoItem);
  Application.CreateForm(TfrmBuscaPedido, frmBuscaPedido);
  Application.Run;
end.
