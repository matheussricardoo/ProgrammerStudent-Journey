## 📌 **O que são Schemas?**

No contexto de **FastAPI** e **APIs em geral**, um **schema** é uma definição ou modelo que descreve como os dados são estruturados. Ele define as **propriedades e tipos de dados** que são esperados em uma requisição ou resposta, servindo como uma **validação e documentação** para garantir que os dados sejam consistentes.

### **Por que usamos Schemas?**

- **Validação**: Garantir que os dados que recebemos e enviamos estejam no formato esperado.
- **Documentação**: Gerar uma documentação clara e automática sobre os dados aceitos e retornados pela API.
- **Autodocumentação**: Com o uso de bibliotecas como **Pydantic** e **FastAPI**, é possível gerar automaticamente uma documentação interativa (Swagger UI ou ReDoc).

---
## 📌 **Schemas com Pydantic**

Em FastAPI, usamos a biblioteca **Pydantic** para definir e validar schemas. Pydantic oferece classes baseadas em **modelos de dados** que podem ser facilmente convertidos para **JSON** e vice-versa.

### **Exemplo de Schema em FastAPI**

Vamos criar um schema que define a estrutura de um **usuário**:

```python
from pydantic import BaseModel

class User(BaseModel):
    name: str
    email: str
    age: int
```

- O **`BaseModel`** é a classe base que fornece validação de dados automaticamente.
- A **validação** é feita em tempo real. Ou seja, se tentarmos passar um valor errado, o FastAPI irá gerar um erro.

---
## 📌 **Usando Schemas para Requisições e Respostas**

Vamos ver como podemos usar os **schemas** em **requisições** e **respostas**.

### **Exemplo de POST com Schema (requisição)**

Vamos criar uma API que cria um usuário, esperando um **JSON** no corpo da requisição:

```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# Definindo o schema de usuário
class User(BaseModel):
    name: str
    email: str
    age: int

# Endpoint para criar usuário
@app.post("/users/")
def create_user(user: User):
    return {"message": f"Usuário {user.name} criado com sucesso!"}
```

- Quando um cliente faz uma **requisição POST** para `/users/` com um **JSON** contendo os dados, o FastAPI valida os dados com o schema `User`.
- Exemplo de JSON enviado para este endpoint:

```json
{
  "name": "João",
  "email": "joao@email.com",
  "age": 30
}
```

---
### **Exemplo de GET com Schema (resposta)**

Vamos criar um endpoint que retorna um usuário com base em um `id`:

```python
@app.get("/users/{user_id}")
def get_user(user_id: int):
    user = {"name": "João", "email": "joao@email.com", "age": 30}
    return user  # FastAPI retorna automaticamente como JSON
```

Aqui, **FastAPI** automaticamente converte o **dicionário Python** em **JSON** usando o schema do tipo de dados, já que estamos retornando um dicionário ou objeto que se parece com o schema `User`.

---
## 📌 **Schemas de Resposta e Validação de Dados**

Os schemas não são apenas usados para entradas de dados, mas também para **garantir a consistência da resposta**. Podemos utilizar os schemas para **definir o formato de saída da API**:

### **Exemplo de Validação de Resposta com Schema**

```python
from typing import List

class Item(BaseModel):
    name: str
    price: float
    description: str | None = None

@app.get("/items/", response_model=List[Item])
def get_items():
    return [
        {"name": "Item 1", "price": 10.99, "description": "Item 1 Description"},
        {"name": "Item 2", "price": 5.99}
    ]
```

- O **`response_model`** indica qual schema será usado para validar a resposta.
- **FastAPI** usa o schema `Item` para garantir que os dados retornados sejam consistentes com o tipo especificado.

---
## 📌 **Campos Opcionais e Definição de Valores Padrão**

No Pydantic, é possível definir campos opcionais com valores padrão e até mesmo tipos mais complexos.

### **Exemplo de Campos Opcionais e Valores Padrão**

```python
from pydantic import BaseModel
from typing import Optional

class Product(BaseModel):
    name: str
    description: Optional[str] = None
    price: float
    tax: Optional[float] = None
```

- **`Optional[str]`**: significa que o campo pode ser uma string **ou** `None`, ou seja, o campo não é obrigatório.
- O **valor padrão** (`None`) é atribuído quando o campo não é fornecido.

---
## 📌 **Validação Adicional e Customização**

Além das validações básicas, o Pydantic também permite a criação de validações mais avançadas para os campos de dados.

### **Exemplo de Validação Customizada**

```python
from pydantic import BaseModel, validator

class User(BaseModel):
    name: str
    email: str
    age: int
    
    @validator('email')
    def validate_email(cls, v):
        if "@" not in v:
            raise ValueError("Email inválido!")
        return v
```

- Usamos **validators** para adicionar validações customizadas no Pydantic. Aqui, estamos verificando se o email contém um **"@"**.

---
## 🎯 **Vantagens de Usar Schemas**

- **Validação Automática**: Reduz erros ao garantir que os dados enviados ou recebidos estejam no formato correto.
- **Segurança**: Garante que os dados estejam em conformidade com os tipos esperados, minimizando o risco de falhas.
- **Documentação Interativa**: FastAPI gera documentação automática e interativa (Swagger UI) para seus schemas.

---
## 🎯 **Conclusão**

Schemas são essenciais para garantir que a comunicação entre o **cliente e o servidor** seja eficiente e sem erros. No FastAPI, eles são definidos com **Pydantic**, proporcionando validação automática e documentação.

🚀 Ao utilizar schemas corretamente, você ganha **segurança**, **facilidade** e **eficiência** no seu código.