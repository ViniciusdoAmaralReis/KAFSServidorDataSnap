unit uPrincipal;

interface

uses
  System.Classes, System.SysUtils, System.Threading,
  FMX.Controls, FMX.Controls.Presentation, FMX.Edit, FMX.Forms, FMX.Layouts,
  FMX.Memo, FMX.Memo.Types, FMX.ScrollBox, FMX.StdCtrls, FMX.Types,
  uKAFSConexaoMongoDBAtlas;

type
  TfrmPrincipal = class(TForm)
    lytComandos: TLayout;
    btnConectarBanco: TButton;
    memStatus: TMemo;
    btnIniciarServidor: TButton;
    edtPorta: TEdit;

    procedure FormShow(Sender: TObject);
    procedure BtnConectarMongoDBClick(Sender: TObject);
    procedure BtnIniciarServidorDataSnapClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uKAFSFuncoes, uServerContainer;

{$R *.fmx}

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  BtnConectarMongoDBClick(Sender);
  BtnIniciarServidorDataSnapClick(Sender);
end;

procedure TfrmPrincipal.BtnConectarMongoDBClick(Sender: TObject);
begin
  TTask.Run(procedure
  begin
    try
      TThread.Synchronize(nil, procedure begin memStatus.lines.Add(DateTimeToStr(Now) + ' 🏃 Testando MongoDB'); end);

      var _mongodb := TKAFSConexaoMongoDBAtlas.Create(nil);
      try
        TThread.Synchronize(nil, procedure begin memStatus.lines.Add(DateTimeToStr(Now) + ' 🟢 MongoDB pronto'); end);
      finally
        FreeAndNil(_mongodb);
      end;
    except
      on E: Exception do
        TThread.Synchronize(nil, procedure begin memStatus.lines.Add(DateTimeToStr(Now) + ' ❌ ' + E.Message); end);
    end
  end);
end;
procedure TfrmPrincipal.BtnIniciarServidorDataSnapClick(Sender: TObject);
begin
  TTask.Run(procedure
  begin
    try
      if not ServerContainer.DSServer.Started then
      begin
        TThread.Synchronize(nil, procedure begin memStatus.lines.Add(DateTimeToStr(Now) + ' 🏃 Iniciando servidor'); end);
        ServerContainer.DSTCPServerTransport.Port := StrToInt(EdtPorta.Text);
        ServerContainer.DSServer.Start;
        TThread.Synchronize(nil, procedure
        begin
          Caption := '🟢 Online | IPLocal: '+IPlocal + ' | IPInternet: '+IPInternet + ' | Porta: ' + IntToStr(ServerContainer.DSTCPServerTransport.Port);
          btnIniciarServidor.Text := 'Parar servidor';
          edtPorta.Enabled := False;
          memStatus.lines.Add(DateTimeToStr(Now) + ' 🟢 Servidor online');
        end);
      end
      else
      begin
        TThread.Synchronize(nil, procedure begin memStatus.lines.Add(DateTimeToStr(Now) + ' 🏃 Finalizando servidor'); end);
        ServerContainer.DSServer.Stop;
        TThread.Synchronize(nil, procedure
        begin
          Caption := '🔴 Offline';
          btnIniciarServidor.Text := 'Iniciar servidor';
          edtPorta.Enabled := True;
          memStatus.lines.Add(DateTimeToStr(Now) + ' 🔴 Servidor offline');
        end);
      end;
    except
      on E: Exception do
        TThread.Synchronize(nil, procedure begin memStatus.lines.Add(DateTimeToStr(Now) + ' ❌ ' + E.Message); end);
    end
  end);
end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
  ServerContainer.DSServer.Stop;
  CanClose := True;
end;

end.

