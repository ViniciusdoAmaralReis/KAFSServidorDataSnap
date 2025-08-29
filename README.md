# 📦 KAFSServidorDataSnap

Servidor DataSnap Delphi/FireMonkey com integração MongoDB Atlas, interface administrativa e suporte a operações CRUD via API REST.

## 📋 Descrição

Servidor DataSnap completo com interface gráfica para monitoramento e gerenciamento, integrado com MongoDB Atlas para persistência de dados. Oferece endpoints RESTful para operações básicas de banco de dados.

## ✨ Características

- ✅ Servidor DataSnap com transporte TCP/IP
- ✅ Interface gráfica para monitoramento do status
- ✅ Integração nativa com MongoDB Atlas
- ✅ Operações CRUD completas (Inserir, Editar, Buscar)
- ✅ Validação de dados JSON
- ✅ Auto-reconexão com banco de dados
- ✅ Cache de configurações de conexão
- ✅ Exibição de IP local e público
- ✅ Log de atividades em tempo real

## 🏗️ Estrutura do Projeto

```
KAFSServidorDataSnap/
├── KAFSServidorDataSnap.dpr      # Programa principal
├── uPrincipal.pas                # Formulário principal com interface
├── uServerContainer.pas          # Container do servidor DataSnap
├── uServerMethods.pas            # Métodos do servidor (endpoints)
├── uKAFSConexaoMongoDBAtlas.pas  # Gerenciador de conexão MongoDB
├── uKAFSMongoDB.pas              # Operações MongoDB (CRUD)
└── uKAFSFuncoes.pas              # Funções utilitárias
```

## 🔗 Dependências Externas

Este projeto utiliza as seguintes unidades externas que devem ser adicionadas ao projeto:

🧩[TKAFSConexaoMongoDBAtlas](https://github.com/ViniciusdoAmaralReis/TKAFSConexaoMongoDBAtlas)
Fornece conexão segura e configurável com o MongoDB Atlas usando SRV records

🧩[uKAFSFuncoes](https://github.com/ViniciusdoAmaralReis/uKAFSFuncoes)
Oferece funções para codificação, cache, manipulação de IP e recursos gráficos

🧩[uKAFSMongoDB](https://github.com/ViniciusdoAmaralReis/uKAFSMongoDB)
Implementa as operações básicas de banco de dados com validação de dados

## 🛠️ Configuração

### Parâmetros do Servidor

```
Porta padrão: Configurável via interface (editável)
Protocolo: TCP/IP
Transporte: TDSTCPServerTransport
```

### Configuração MongoDB

As credenciais do MongoDB são armazenadas em cache após a primeira configuração:

```ini
[cache]
mongodb.nome=usuário
mongodb.senha=senha
mongodb.servidor=cluster.mongodb.net
```

## 📡 API Endpoints

### Inserir Dados
```pascal
function InserirDadosMongoDB(const _banco, _colecao: String; 
  const _dados: TJSONArray): Boolean;
```

**Exemplo de uso**:
```javascript
// POST request para inserir dados
{
  "banco": "meu_banco",
  "colecao": "minha_colecao",
  "dados": [
    "nome", "João Silva",
    "email", "joao@email.com",
    "idade", 30
  ]
}
```

### Editar Dados
```pascal
function EditarDadosMongoDB(const _banco, _colecao: String; 
  const _filtro, _atualizacao: TJSONArray): Boolean;
```

**Exemplo de uso**:
```javascript
// POST request para editar dados
{
  "banco": "meu_banco",
  "colecao": "minha_colecao",
  "filtro": [
    "email", "joao@email.com"
  ],
  "atualizacao": [
    "idade", 31,
    "cidade", "São Paulo"
  ]
}
```

### Buscar Dados
```pascal
function BuscarDadosMongoDB(const _banco, _colecao: string; 
  const _filtro: TJSONArray): TJSONArray;
```

**Exemplo de uso**:
```javascript
// POST request para buscar dados
{
  "banco": "meu_banco",
  "colecao": "minha_colecao",
  "filtro": [
    "cidade", "São Paulo"
  ]
}
```

## 🚀 Como Executar

1. **Executar o servidor**:
   - O servidor inicia automaticamente e tenta conectar com MongoDB
   - Se necessário, configure as credenciais do MongoDB via diálogo de entrada

2. **Monitorar status**:
   - Interface exibe status de conexão com MongoDB
   - Mostra IP local e público
   - Log de atividades em tempo real

3. **Gerenciar servidor**:
   - Configure a porta TCP desejada
   - Use o botão para iniciar/parar o servidor
   
## 🔧 Dependências do Sistema

- `FireDAC.Phys.MongoDBWrapper` - Driver MongoDB
- `Datasnap.DSServer` - Framework DataSnap
- `System.JSON` - Manipulação JSON
- `FMX.Forms` - Interface gráfica
- `IdHTTPWebBrokerBridge` - Servidor web

## ⚙️ Configuração MongoDB Atlas

1. Crie um cluster no MongoDB Atlas
2. Obtenha a string de conexão
3. Configure usuário e senha com permissões adequadas
4. Adicione seu IP à whitelist do cluster

## 📊 Interface Gráfica

A interface fornece:
- Status online/offline do servidor
- Exibição de IP local e público
- Porta de comunicação configurável
- Log de eventos em tempo real
- Controles para iniciar/parar servidor
- Teste de conexão com MongoDB

## ⚠️ Tratamento de Erros

- Validação de JSON de entrada
- Tratamento de exceções em operações de banco
- Diálogos para reconfiguração em caso de falha
- Log detalhado de erros para diagnóstico

## 🔒 Segurança

- Validação de parâmetros de entrada
- Conexão segura com MongoDB Atlas (SRV)
- Configurações sensíveis armazenadas codificadas

## 📝 Logs e Monitoramento

- Timestamp em todas as operações
- Status visual (ícones e cores)
- Mensagens descritivas de erro e sucesso
- Log de atividades persistente na interface

---

**Nota**: Este servidor requer configuração prévia do MongoDB Atlas e das credenciais apropriadas para funcionamento completo. Certifique-se de ter todas as unidades externas baixadas e configuradas corretamente no projeto.
