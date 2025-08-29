# 📦 KAFSServidorDataSnap

Servidor DataSnap Delphi/FireMonkey com integração MongoDB Atlas, interface administrativa e suporte a operações CRUD via API REST.

## 🔗 Dependências Externas

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
var
  ServerMethods: TServerMethodsClient;
  Dados: TJSONArray;
  Resultado: Boolean;
begin
  ServerMethods := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
  try
    Dados := TJSONArray.Create;
    Dados.Add('nome');
    Dados.Add('João Silva');
    Dados.Add('email');
    Dados.Add('joao@email.com');
    Dados.Add('idade');
    Dados.Add(30);
    
    Resultado := ServerMethods.InserirDadosMongoDB('meu_banco', 'minha_colecao', Dados);
    
    if Resultado then
      ShowMessage('Dados inseridos com sucesso!');
  finally
    Dados.Free;
    ServerMethods.Free;
  end;
end;
```

### 📡Editar Dados
```pascal
function EditarDadosMongoDB(const _banco, _colecao: String; 
  const _filtro, _atualizacao: TJSONArray): Boolean;
```

**Exemplo de uso**:
```pascal
var
  ServerMethods: TServerMethodsClient;
  Filtro, Atualizacao: TJSONArray;
  Resultado: Boolean;
begin
  ServerMethods := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
  try
    // Criar filtro para localizar o documento
    Filtro := TJSONArray.Create;
    Filtro.Add('email');
    Filtro.Add('joao@email.com');
    
    // Criar dados para atualização
    Atualizacao := TJSONArray.Create;
    Atualizacao.Add('idade');
    Atualizacao.Add(31);
    Atualizacao.Add('cidade');
    Atualizacao.Add('São Paulo');
    
    Resultado := ServerMethods.EditarDadosMongoDB('meu_banco', 'minha_colecao', Filtro, Atualizacao);
    
    if Resultado then
      ShowMessage('Dados atualizados com sucesso!');
  finally
    Filtro.Free;
    Atualizacao.Free;
    ServerMethods.Free;
  end;
end;
```

### 📡Buscar Dados
```pascal
function BuscarDadosMongoDB(const _banco, _colecao: string; 
  const _filtro: TJSONArray): TJSONArray;
```

**Exemplo de uso**:
```pascal
var
  ServerMethods: TServerMethodsClient;
  Filtro, Resultados: TJSONArray;
  I: Integer;
begin
  ServerMethods := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
  try
    // Criar filtro para busca
    Filtro := TJSONArray.Create;
    Filtro.Add('cidade');
    Filtro.Add('São Paulo');
    
    Resultados := ServerMethods.BuscarDadosMongoDB('meu_banco', 'minha_colecao', Filtro);
    
    // Processar resultados
    for I := 0 to Resultados.Size - 1 do
    begin
      Memo1.Lines.Add(Resultados.Get(I).ToString);
    end;
  finally
    Filtro.Free;
    Resultados.Free;
    ServerMethods.Free;
  end;
end;
```
---

**Nota**: Requer configuração prévia do MongoDB Atlas e das credenciais apropriadas para funcionamento completo. Certifique-se de ter todas as unidades externas baixadas e configuradas corretamente no projeto.
