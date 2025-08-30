# 📦 KAFSServidorDataSnap

Servidor DataSnap Delphi/FireMonkey com integração MongoDB Atlas, interface administrativa e suporte a operações CRUD via API REST.

## ⚠️ Dependências externas

Este projeto utiliza as seguintes unidades externas que devem ser adicionadas ao projeto:
- 🧩 [TKAFSConexaoMongoDBAtlas](https://github.com/ViniciusdoAmaralReis/TKAFSConexaoMongoDBAtlas) 
- 🧩 [uKAFSFuncoes](https://github.com/ViniciusdoAmaralReis/uKAFSFuncoes) 
- 🧩 [uKAFSMongoDB](https://github.com/ViniciusdoAmaralReis/uKAFSMongoDB) 

*Componente utilizado para os exemplos de consumo no cliente. Não é necessário para compilar este projeto servidor.
- *🧩 [TKAFSConexaoDataSnap](https://github.com/ViniciusdoAmaralReis/TKAFSConexaoDataSnap)

## 💡 Consumo - Inserir dados
```pascal
function TServerMethods.InserirDadosMongoDB(const _banco, _colecao: String;
  const _dados: TJSONObject): TJSONObject;
```

- Exemplo de resposta com sucesso:
```json
{"sucesso": true}
```

- Exemplo de resposta com erro:
```json
{"sucesso": false, "erro": "Mensagem do erro aqui"}
```

- Exemplo de consumo:
```pascal
var _conexao := TKAFSConexaoDataSnap.Create(nil);
var _metodo := TServerMethodsClient.Create(_conexao.DBXConnection);
var _dados := TJSONObject.Create;
var _resultado := TJSONObject.Create;
try
  // Preparar dados para inserção
  with _dados do
  begin
    AddPair('nome', TJSONString.Create('João'));
    AddPair('email', TJSONString.Create('joao@email.com'));
    AddPair('nivel', TJSONNumber.Create(1));
  end;

  // Executar inserção
  _resultado := _metodo.InserirDadosMongoDB('meu_banco', 'minha_coleção', _dados);

  // Verificar resultado
  if not _resultado.GetValue<Boolean>('sucesso') then
    raise Exception.Create(_resultado.GetValue<string>('erro'));

  ShowMessage('Usuário inserido com sucesso!');
finally
  FreeAndNil(_resultado);
  FreeAndNil(_dados);
  FreeAndNil(_metodo);
  FreeAndNil(_conexao);
end;
```

## 💡 Consumo - Editar dados
```pascal
function TServerMethods.EditarDadosMongoDB(const _banco, _colecao: String;
  const _filtro, _atualizacao: TJSONObject): TJSONObject;
```

- Exemplo de resposta com sucesso:
```json
{"sucesso": true}
```

- Exemplo de resposta com erro:
```json
{"sucesso": false, "erro": "Mensagem do erro aqui"}
```

- Exemplo de consumo:
```pascal
var _conexao := TKAFSConexaoDataSnap.Create(nil);
var _metodo := TServerMethodsClient.Create(_conexao.DBXConnection);
var _filtro := TJSONObject.Create;
var _atualizacao := TJSONObject.Create;
var _resultado := TJSONObject.Create;
try
  // Preparar filtro para edição
  with _filtro do
  begin
    AddPair('email', TJSONString.Create('joao@email.com'));
  end;

  // Preparar dados para atualização
  with _atualizacao do
  begin
    AddPair('nivel', TJSONNumber.Create(2));
    AddPair('ultima_atualizacao', TJSONString.Create(FormatDateTime('yyyy-mm-dd hh:nn:ss', Now)));
  end;

  // Executar edição
  _resultado := _metodo.EditarDadosMongoDB('meu_banco', 'minha_coleção', _filtro, _atualizacao);

  // Verificar resultado
  if not _resultado.GetValue<Boolean>('sucesso') then
    raise Exception.Create(_resultado.GetValue<string>('erro'));

  ShowMessage('Usuário atualizado com sucesso!');
finally
  FreeAndNil(_resultado);
  FreeAndNil(_atualizacao);
  FreeAndNil(_filtro);
  FreeAndNil(_metodo);
  FreeAndNil(_conexao);
end;
```

## 💡 Consumo - Buscar dados
```pascal
function TServerMethods.BuscarDadosMongoDB(const _banco, _colecao: string;
  const _filtro: TJSONObject): TJSONObject;
```

- Exemplo de resposta com sucesso e com resultados:
```json
{
  "sucesso": true,
  "quantidade": 2,
  "resultados": [
    {
      "_id": "65a1b2c3d4e5f67890123456",
      "nome": "João",
      "email": "joao@email.com",
      "nivel": 1
    },
    {
      "_id": "65a1b2c3d4e5f67890123457",
      "nome": "Maria",
      "email": "maria@email.com",
      "nivel": 2
    }
  ]
}
```

- Exemplo de resposta com sucesso e sem resultado:
```json
{
  "sucesso": true,
  "quantidade": 0,
  "resultados": []
}
```

- Exemplo de resposta com erro:
```json
{"sucesso": false, "erro": "Mensagem do erro aqui"}
```

- Exemplo de consumo:
```pascal
var _conexao := TKAFSConexaoDataSnap.Create(nil);
var _metodo := TServerMethodsClient.Create(_conexao.DBXConnection);
var _filtro := TJSONObject.Create;
var _resultado := TJSONObject.Create;
try
  // Preparar filtro para busca
  _filtro := TJSONObject.Create;
  with _filtro do
  begin
    AddPair('email', TJSONString.Create('joao@email.com'));
  end;

  // Executar busca
  _resultado := _metodo.BuscarDadosMongoDB('meu_banco', 'minha_coleção', _filtro);

  // Verificar resultado
  if not _resultado.GetValue<Boolean>('sucesso') then
    raise Exception.Create(_resultado.GetValue<string>('erro'));

  // Processar resultados
  var _quantidade := _resultado.GetValue<Integer>('quantidade');
  var _usuarios := _resultado.GetValue<TJSONArray>('resultados');

  ShowMessage(Format('%d usuário(s) encontrado(s)', [_quantidade]));
finally
  FreeAndNil(_resultado);
  FreeAndNil(_filtro);
  FreeAndNil(_metodo);
  FreeAndNil(_conexao);
end;
```

# 🏛️ Status de compatibilidade

| Sistema operacional | Status FireDAC MongoDB | Observações |
|---------------------|------------------------|-------------|
| **Windows** | ✅ **Totalmente Compatível** | Funcionamento completo com todos os recursos |
| **Linux** | ❌ **Não Suportado** | Limitação técnica do driver FireDAC |

| IDE | Versão mínima | Observações |
|---------------------|------------------------|-------------|
| **Delphi** | ✅ **12.3** | Início do suporte nativo a DNS SRV |

---
**Nota**: Requer configuração prévia do MongoDB Atlas e das credenciais apropriadas para funcionamento completo. Certifique-se de ter todas as unidades externas baixadas e configuradas corretamente no projeto.
