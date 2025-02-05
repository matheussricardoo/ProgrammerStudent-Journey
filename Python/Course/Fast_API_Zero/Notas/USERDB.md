### 📌 **O que é USERDB?**

O termo **USERDB** geralmente se refere a um **banco de dados de usuários** (User Database), ou seja, uma estrutura usada para armazenar, gerenciar e autenticar usuários em um sistema. No contexto de **FastAPI** e **autenticação**, **USERDB** pode representar um modelo ou schema específico para armazenar informações de usuários, como credenciais, permissões e perfis.

---
## **📌 Contexto de USERDB em FastAPI e Bancos de Dados**

Se você está construindo uma API com **FastAPI**, normalmente usará um banco de dados para armazenar **usuários** e suas informações. Para isso, você pode definir um **schema USERDB** com **Pydantic** e um modelo ORM (como SQLAlchemy) para armazenar esses dados.

---
## **📌 Exemplo: Criando um USERDB no FastAPI com Pydantic**

Podemos definir um modelo de **UserDB** usando **Pydantic** para validar os dados de um usuário:

```python
from pydantic import BaseModel, EmailStr
from typing import Optional

# Definindo o Schema de Usuário (UserDB)
class UserDB(BaseModel):
    id: int
    username: str
    email: EmailStr
    hashed_password: str
    is_active: bool = True
    is_admin: bool = False
```

### **O que cada campo faz?**

- **`id`**: Um identificador único para cada usuário.
- **`username`**: O nome de usuário da conta.
- **`email`**: O e-mail do usuário (validado como email).
- **`hashed_password`**: A senha armazenada de forma segura (criptografada).
- **`is_active`**: Indica se o usuário está ativo no sistema.
- **`is_admin`**: Indica se o usuário tem permissões administrativas.

---
## **📌 Exemplo de USERDB com SQLAlchemy**

Se estiver usando **SQLAlchemy**, podemos criar um modelo **UserDB** para persistir os dados no banco:

```python
from sqlalchemy import Column, Integer, String, Boolean
from database import Base  # Base é a classe base do SQLAlchemy

# Modelo do Banco de Dados para Usuário
class UserDB(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)
    email = Column(String, unique=True, index=True)
    hashed_password = Column(String)
    is_active = Column(Boolean, default=True)
    is_admin = Column(Boolean, default=False)
```

---
## **📌 Como usar o USERDB para Autenticação?**

Se quisermos autenticar um usuário, podemos criar um endpoint no **FastAPI** para validar um usuário com o **USERDB**.

### **Exemplo: Autenticando um Usuário**

```python
from fastapi import FastAPI, HTTPException, Depends
from sqlalchemy.orm import Session
from database import get_db  # Função para obter sessão do banco
from models import UserDB  # Nosso modelo de banco de dados

app = FastAPI()

def authenticate_user(db: Session, username: str, password: str):
    user = db.query(UserDB).filter(UserDB.username == username).first()
    if not user or user.hashed_password != password:  # Aqui você usaria um hash seguro
        return None
    return user

@app.post("/login/")
def login(username: str, password: str, db: Session = Depends(get_db)):
    user = authenticate_user(db, username, password)
    if not user:
        raise HTTPException(status_code=400, detail="Credenciais inválidas")
    return {"message": "Login bem-sucedido", "user": user.username}
```

---
## **📌 USERDB no Contexto de FastAPI Users**

Se você estiver usando a biblioteca **FastAPI Users** para gerenciar autenticação e usuários, o **UserDB** é um modelo usado para definir os usuários no banco de dados.

### **Exemplo de USERDB no FastAPI Users**

```python
from fastapi_users.db import SQLAlchemyBaseUserTable
from database import Base

class UserDB(SQLAlchemyBaseUserTable, Base):
    pass
```

Aqui, estamos **herdando** o modelo de usuário padrão do **FastAPI Users** e integrando ao nosso banco.

---
## **🎯 Conclusão**

- **USERDB** é um banco de dados de usuários, podendo ser implementado com **Pydantic** e **SQLAlchemy**.
- É usado para armazenar informações de **usuários, credenciais e permissões**.
- Pode ser integrado a sistemas de autenticação, como **FastAPI Users**.
- Essencial para **gestão de usuários e segurança** em APIs.

