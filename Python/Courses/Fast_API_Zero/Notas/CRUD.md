## 🔥 **O que é CRUD?**

**CRUD** é um acrônimo para as quatro operações básicas usadas em aplicações que manipulam dados:

- **C** → **Create** (Criar)
- **R** → **Read** (Ler/Consultar)
- **U** → **Update** (Atualizar)
- **D** → **Delete** (Excluir)

O CRUD é um conceito fundamental em sistemas que interagem com bancos de dados, como APIs, sistemas web e aplicativos.

---
## 🚀 **CRUD no FastAPI**

O **FastAPI** é um framework rápido para criar APIs com Python. Vamos ver como implementar um CRUD simples usando FastAPI e SQLAlchemy.

---
### 📌 **1. Instale as Dependências**

Se ainda não instalou, use **Poetry** ou `pip`:

```sh
poetry add fastapi sqlalchemy sqlite3 pydantic
```

ou

```sh
pip install fastapi sqlalchemy sqlite3 pydantic
```

---
### 📌 **2. Criar um Modelo de Banco de Dados (SQLAlchemy)**

Criamos um modelo para armazenar **usuários**:

```python
from sqlalchemy import Column, Integer, String, create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

DATABASE_URL = "sqlite:///./test.db"

engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    email = Column(String, unique=True, index=True)

Base.metadata.create_all(bind=engine)
```

---
### 📌 **3. Criar um CRUD Completo com FastAPI**

Agora, criamos uma API que permite **Criar, Ler, Atualizar e Excluir Usuários**.

```python
from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from database import SessionLocal, User  # Importa nossa configuração do banco de dados

app = FastAPI()

# Dependência para obter a sessão do banco de dados
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# 🟢 CREATE (Criar usuário)
@app.post("/users/")
def create_user(name: str, email: str, db: Session = Depends(get_db)):
    db_user = User(name=name, email=email)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

# 🔵 READ (Listar usuários)
@app.get("/users/")
def read_users(db: Session = Depends(get_db)):
    return db.query(User).all()

# 🟡 UPDATE (Atualizar usuário)
@app.put("/users/{user_id}")
def update_user(user_id: int, name: str, email: str, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="Usuário não encontrado")
    user.name = name
    user.email = email
    db.commit()
    return user

# 🔴 DELETE (Excluir usuário)
@app.delete("/users/{user_id}")
def delete_user(user_id: int, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="Usuário não encontrado")
    db.delete(user)
    db.commit()
    return {"message": "Usuário deletado com sucesso"}
```

---
### 🚀 **Rodando a API**

Inicie o servidor com:

```sh
uvicorn main:app --reload
```

Agora você pode acessar a **documentação automática** no navegador:

- **Swagger UI** → [`http://127.0.0.1:8000/docs`](http://127.0.0.1:8000/docs)
- **ReDoc** → [`http://127.0.0.1:8000/redoc`](http://127.0.0.1:8000/redoc)

---
## 🎯 **Conclusão**

✔ CRUD significa **Create, Read, Update e Delete**.  
✔ É usado para manipular dados em sistemas e APIs.  
✔ No **FastAPI**, podemos usar **SQLAlchemy** para gerenciar um banco de dados.  
✔ Com poucos passos, criamos uma API **completa e funcional**.