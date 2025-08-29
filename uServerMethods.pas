unit uServerMethods;

interface

uses
  System.Classes, System.Generics.Collections, System.Json;

type
{$METHODINFO ON}
  TServerMethods = class(TDataModule)
    function InserirDadosMongoDB(const _banco, _colecao: String; const _dados: TJSONObject): TJSONObject;
    function EditarDadosMongoDB(const _banco, _colecao: String; const _filtro, _atualizacao: TJSONObject): TJSONObject;
    function BuscarDadosMongoDB(const _banco, _colecao: string; const _filtro: TJSONObject): TJSONObject;
  end;
{$METHODINFO OFF}

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  uKAFSMongoDB;

function TServerMethods.InserirDadosMongoDB(const _banco, _colecao: String; const _dados: TJSONObject): TJSONObject;
begin
  Result := InserirDados(_banco, _colecao, _dados);
end;
function TServerMethods.EditarDadosMongoDB(const _banco, _colecao: String; const _filtro, _atualizacao: TJSONObject): TJSONObject;
begin
  Result := EditarDados(_banco, _colecao, _filtro, _atualizacao);
end;
function TServerMethods.BuscarDadosMongoDB(const _banco, _colecao: string; const _filtro: TJSONObject): TJSONObject;
begin
  Result := BuscarDados(_banco, _colecao, _filtro);
end;

end.
