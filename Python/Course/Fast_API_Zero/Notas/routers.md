# 🔹 **Routers no FastAPI**  
No **FastAPI**, **routers** (ou "roteadores") são uma forma de organizar as rotas da aplicação, permitindo dividir a API em múltiplos módulos reutilizáveis. Eles ajudam a manter o código limpo, modular e escalável.  

---
## 📌 **Por que usar routers?**  
✅ **Melhor organização do código** → Separa diferentes funcionalidades em arquivos específicos.  
✅ **Facilita a manutenção e escalabilidade** → Permite adicionar novos módulos sem bagunçar o código principal.  
✅ **Reutilização de código** → Pode ser reaproveitado em múltiplos projetos ou aplicações.  
✅ **Melhor estruturação de projetos grandes** → Ajuda a evitar arquivos gigantescos cheios de endpoints.  

---
## 🔹 **Criando um Router no FastAPI**  

### 📌 **Passo 1: Criar um Router**  
Podemos criar um roteador usando `APIRouter()`.  

📂 **Estrutura recomendada**  
```
my_project/
│── main.py
│── routers/
│   ├── users.py
│   ├── products.py
│   ├── auth.py
│── models/
│── schemas/
│── database.py
```

📌 **Arquivo `routers/users.py`**  
```python
from fastapi import APIRouter

router = APIRouter()

@router.get("/users/")
def get_users():
    return [{"id": 1, "name": "Alice"}, {"id": 2, "name": "Bob"}]

@router.get("/users/{user_id}")
def get_user(user_id: int):
    return {"id": user_id, "name": "Usuário Exemplo"}
```

---
### 📌 **Passo 2: Integrar o Router no `main.py`**  
No arquivo principal (`main.py`), importamos e incluímos o roteador na aplicação principal.

```python
from fastapi import FastAPI
from routers import users

app = FastAPI()

# Incluindo o roteador de usuários
app.include_router(users.router, prefix="/api", tags=["Users"])

@app.get("/")
def home():
    return {"message": "Bem-vindo à API!"}
```

---
## 🔹 **Explicação do Código**  
✅ **`APIRouter()`** → Cria um roteador para gerenciar endpoints.  
✅ **`app.include_router(users.router, prefix="/api", tags=["Users"])`** → Inclui o router, adicionando um prefixo `/api` a todas as rotas dentro dele.  
✅ **Modularidade** → Podemos criar quantos arquivos de roteadores forem necessários (`auth.py`, `products.py`, `orders.py`, etc.).  

---
## 🔹 **Usando Prefixos para Melhor Organização**  
Podemos adicionar **prefixos** para categorizar os endpoints.  

📌 **Exemplo:**  
```python
app.include_router(users.router, prefix="/users", tags=["Users"])
```
Agora, todas as rotas dentro de `users.py` terão `/users/` como prefixo:  
- `GET /users/` → Lista todos os usuários.  
- `GET /users/{user_id}` → Obtém um usuário específico.  

---
## 🔹 **Usando Dependências e Segurança em Routers**  
Podemos adicionar **dependências**, **autenticação** e **middlewares** aos roteadores.

📌 **Exemplo com autenticação JWT**  
```python
from fastapi import Depends, HTTPException, APIRouter
from dependencies import get_current_user

router = APIRouter()

@router.get("/users/me")
def get_current_user_info(user: dict = Depends(get_current_user)):
    return user
```

---
## 🔹 **Quando Usar Routers?**  
✔ Projetos médios ou grandes para melhor organização.  
✔ Quando há múltiplos módulos (ex: autenticação, usuários, pedidos, produtos).  
✔ Para facilitar testes e reutilização de código.  

---
## 🔹 **Conclusão**  
Os **routers no FastAPI** ajudam a estruturar a aplicação de forma modular e organizada. Eles permitem separar funcionalidades, facilitando a manutenção, escalabilidade e reutilização do código. 🚀