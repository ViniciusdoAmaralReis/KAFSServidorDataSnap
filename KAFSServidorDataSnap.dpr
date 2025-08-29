program KAFSServidorDataSnap;

uses
  FMX.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uKAFSFuncoes in '..\uKAFSFuncoes\uKAFSFuncoes.pas',
  uKAFSConexaoMongoDBAtlas in '..\TKAFSConexaoMongoDBAtlas\uKAFSConexaoMongoDBAtlas.pas',
  uKAFSMongoDB in '..\uKAFSMongoDB\uKAFSMongoDB.pas',
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uServerContainer in 'uServerContainer.pas' {ServerContainer: TDataModule},
  uServerMethods in 'uServerMethods.pas' {ServerMethods: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TServerContainer, ServerContainer);
  Application.Run;
end.

