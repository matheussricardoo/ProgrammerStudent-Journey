## 🌍 **O que é HTTP?**

**HTTP (HyperText Transfer Protocol)** é um protocolo de comunicação que permite a transferência de informações entre clientes e servidores na web.

Ele define como as mensagens são formatadas e transmitidas, e como servidores e navegadores devem responder a essas mensagens.

---
## 📌 **Como o HTTP Funciona?**

O HTTP segue um modelo **cliente-servidor**:

1️⃣ **O cliente** (ex: navegador, API) faz uma **requisição HTTP** para um servidor.  
2️⃣ **O servidor** processa a requisição e responde com um **código de status HTTP** e um **conteúdo**.

✅ Exemplo de requisição:

```plaintext
GET /index.html HTTP/1.1
Host: www.exemplo.com
```

✅ Exemplo de resposta:

```plaintext
HTTP/1.1 200 OK
Content-Type: text/html

<html>
  <body>Olá, Mundo!</body>
</html>
```

---
## 🚀 **Principais Métodos HTTP**

Os métodos HTTP definem o **tipo de operação** que o cliente deseja realizar no servidor.

|Método|Descrição|
|---|---|
|**GET**|Obtém dados do servidor|
|**POST**|Envia dados para o servidor (criação de recurso)|
|**PUT**|Atualiza um recurso existente|
|**DELETE**|Remove um recurso no servidor|
|**PATCH**|Atualiza parcialmente um recurso|
|**HEAD**|Igual ao GET, mas sem corpo na resposta|
|**OPTIONS**|Retorna métodos suportados pelo servidor|

✅ Exemplo de requisição **POST** enviando JSON:

```plaintext
POST /api/users HTTP/1.1
Host: exemplo.com
Content-Type: application/json

{
  "name": "Maria",
  "email": "maria@email.com"
}
```

---
## 🎯 **Principais Códigos de Status HTTP**

O servidor responde com um **código de status** para indicar o resultado da requisição.

### 🔵 **Respostas de Sucesso (2xx)**

|Código|Significado|
|---|---|
|**200 OK**|Requisição bem-sucedida|
|**201 Created**|Recurso criado com sucesso|
|**204 No Content**|Sucesso, mas sem conteúdo na resposta|

### 🟡 **Redirecionamentos (3xx)**

|Código|Significado|
|---|---|
|**301 Moved Permanently**|URL movida permanentemente|
|**302 Found**|URL movida temporariamente|

### 🔴 **Erros do Cliente (4xx)**

|Código|Significado|
|---|---|
|**400 Bad Request**|Requisição inválida|
|**401 Unauthorized**|Requer autenticação|
|**403 Forbidden**|Acesso negado|
|**404 Not Found**|Recurso não encontrado|

### ⚫ **Erros do Servidor (5xx)**

|Código|Significado|
|---|---|
|**500 Internal Server Error**|Erro interno do servidor|
|**503 Service Unavailable**|Servidor indisponível|

---
## 🔥 **HTTP x HTTPS**

O **HTTPS** (HTTP Secure) é a versão segura do HTTP, pois usa **SSL/TLS** para criptografar a comunicação, garantindo **segurança e privacidade** dos dados.

- **HTTP** → Não criptografado (dados podem ser interceptados).
- **HTTPS** → Usa criptografia para proteger os dados.

✅ Sempre prefira **HTTPS** em aplicações seguras!

---
## 📌 **HTTP no FastAPI**

No **FastAPI**, podemos criar endpoints que respondem a requisições HTTP facilmente:

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Olá, Mundo!"}

@app.post("/users/")
def create_user(name: str):
    return {"message": f"Usuário {name} criado!"}
```

🚀 Para rodar o servidor:

```sh
uvicorn main:app --reload
```

Acesse no navegador: [`http://127.0.0.1:8000`](http://127.0.0.1:8000/)

---
## 🎯 **Conclusão**

✔ **HTTP** é o protocolo que permite a comunicação entre navegadores, APIs e servidores.  
✔ Ele usa **métodos (GET, POST, PUT, DELETE, etc.)** para operações.  
✔ Responde com **códigos de status** indicando sucesso, erro ou redirecionamento.  
✔ **HTTPS** adiciona segurança por meio de criptografia.  
✔ No **FastAPI**, podemos lidar com HTTP de forma simples e eficiente.
