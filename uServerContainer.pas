unit uServerContainer;

interface

uses
  System.Classes,
  Datasnap.DSCommonServer, Datasnap.DSServer, Datasnap.DSTCPServerTransport,
  IPPeerAPI, IPPeerServer;

type
  TServerContainer = class(TDataModule)
    DSServer: TDSServer;
    DSTCPServerTransport: TDSTCPServerTransport;
    DSServerClass: TDSServerClass;

    procedure DSServerClassGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
  end;

var
  ServerContainer: TServerContainer;

implementation

{$R *.dfm}

uses
  uServerMethods;

procedure TServerContainer.DSServerClassGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := uServerMethods.TServerMethods;
end;

end.

