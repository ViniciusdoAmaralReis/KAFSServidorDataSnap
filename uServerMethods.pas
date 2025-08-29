unit uServerMethods;

interface

uses
  System.Classes, System.Generics.Collections, System.Json;

type
{$METHODINFO ON}
  TServerMethods = class(TDataModule)

    function InserirDadosMongoDB(const _banco, _colecao: String; const _dados: TJSONArray): Boolean;
    function EditarDadosMongoDB(const _banco, _colecao: String; const _filtro, _atualizacao: TJSONArray): Boolean;
    function BuscarDadosMongoDB(const _banco, _colecao: string; const _filtro: TJSONArray): TJSONArray;
  end;
{$METHODINFO OFF}

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  uKAFSMongoDB;

function TServerMethods.InserirDadosMongoDB(const _banco, _colecao: String; const _dados: TJSONArray): Boolean;
begin
  Result := InserirDados(_banco, _colecao, _dados).Ok;
end;
function TServerMethods.EditarDadosMongoDB(const _banco, _colecao: String; const _filtro, _atualizacao: TJSONArray): Boolean;
begin
  Result := EditarDados(_banco, _colecao, _filtro, _atualizacao).Ok;
end;
function TServerMethods.BuscarDadosMongoDB(const _banco, _colecao: string; const _filtro: TJSONArray): TJSONArray;
begin
  Result := BuscarDados(_banco, _colecao, _filtro);
end;

end.

