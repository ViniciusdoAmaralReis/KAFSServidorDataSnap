# 📦 KAFSServidorDataSnap

Servidor DataSnap Delphi/FireMonkey com integração MongoDB Atlas, interface administrativa e suporte a operações CRUD via API REST.

## ⚠️ Dependências Externas

Este projeto utiliza as seguintes unidades externas que devem ser adicionadas ao projeto:

- 🧩 [TKAFSConexaoMongoDBAtlas](https://github.com/ViniciusdoAmaralReis/TKAFSConexaoMongoDBAtlas): 
Fornece conexão segura e configurável com o MongoDB Atlas usando SRV records
- 🧩 [uKAFSFuncoes](https://github.com/ViniciusdoAmaralReis/uKAFSFuncoes): 
Oferece funções para codificação, cache, manipulação de IP e recursos gráficos
- 🧩 [uKAFSMongoDB](https://github.com/ViniciusdoAmaralReis/uKAFSMongoDB): 
Implementa as operações básicas de banco de dados com validação de dados

## 🚀 Aplicação

### 📡Inserir Dados
```pascal
function InserirDadosMongoDB(const _banco, _colecao: String; 
  const _dados: TJSONArray): Boolean;
```

**Exemplo de uso**:
```pascal
var ServerMethods := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
var Dados := TJSONArray.Create;
try
  // Criar dados para inserção
  with Dados do
  begin
    Add('nome'); // Campo
    Add('João Silva'); // Valor
    Add('email'); // Campo
    Add('joao@email.com'); // Valor
    Add('idade'); // Campo
    Add(30); // Ou TJSONNumber.Create(30) se preferir
  end;

  var Resultado := ServerMethods.InserirDadosMongoDB('meu_banco', 'minha_colecao', Dados);

  if Resultado then
    ShowMessage('Dados inseridos com sucesso!');
finally
  Dados.Free;
  ServerMethods.Free;
end;
```

### 📡Editar Dados
```pascal
function EditarDadosMongoDB(const _banco, _colecao: String; 
  const _filtro, _atualizacao: TJSONArray): Boolean;
```

**Exemplo de uso**:
```pascal
var ServerMethods := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
var Filtro := TJSONArray.Create;
var Atualizacao := TJSONArray.Create;
try
  // Criar filtro para localizar o documento
  with Filtro do
  begin
    Add('email'); // Campo
    Add('joao@email.com'); // Valor
  end;

  // Criar dados para atualização
  with Atualizacao do
  begin
    Add('idade'); // Campo
    Add(31); // Valor
    Add('cidade'); // Campo
    Add('São Paulo'); // Valor
  end;

  var Resultado := ServerMethods.EditarDadosMongoDB('meu_banco', 'minha_colecao', Filtro, Atualizacao);

  if Resultado then
    ShowMessage('Dados atualizados com sucesso!');
finally
  Atualizacao.Free;
  Filtro.Free;
  ServerMethods.Free;
end;
```

### 📡Buscar Dados
```pascal
function BuscarDadosMongoDB(const _banco, _colecao: string; 
  const _filtro: TJSONArray): TJSONArray;
```

**Exemplo de uso**:
```pascal
var ServerMethods := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
var Filtro := TJSONArray.Create;
try
  // Criar filtro para busca
  with Filtro do
  begin
    Add('cidade'); // Campo
    Add('São Paulo'); // Valor
  end;

  var Resultados := ServerMethods.BuscarDadosMongoDB('meu_banco', 'minha_colecao', Filtro);

  // Processar resultados
  for var I := 0 to Resultados.Size - 1 do
    Memo1.Lines.Add(Resultados.Get(I).ToString);
finally
  Resultados.Free;
  Filtro.Free;
  ServerMethods.Free;
end;
```
---

**Nota**: Requer configuração prévia do MongoDB Atlas e das credenciais apropriadas para funcionamento completo. Certifique-se de ter todas as unidades externas baixadas e configuradas corretamente no projeto.
