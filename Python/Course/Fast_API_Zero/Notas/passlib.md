### 🔐 **O que é `passlib`?**  
O **Passlib** é uma biblioteca de Python usada para **hashing seguro de senhas**. Ele suporta diversos **algoritmos de hash** e é amplamente utilizado em aplicações web, incluindo projetos com **FastAPI**, para garantir a segurança das senhas dos usuários.  

📌 **Principais recursos do `passlib`:**  
✅ Suporte a múltiplos algoritmos de hash (**bcrypt, pbkdf2, argon2, sha512_crypt, etc.**)  
✅ Facilidade para **verificação de senhas**  
✅ Proteção contra ataques de força bruta  
✅ Suporte a **migração de hashes** antigos  

---
## **🔑 Como instalar o Passlib?**
Para instalar, basta rodar o seguinte comando:  

```bash
pip install passlib[bcrypt]
```
O `[bcrypt]` é uma recomendação para usar **bcrypt**, um dos algoritmos mais seguros atualmente.

---
## **🔐 Como usar o `passlib` para hashing de senhas?**

### **1️⃣ Criando o hash de uma senha**
```python
from passlib.context import CryptContext

# Criando um contexto de criptografia com bcrypt
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_senha(senha: str) -> str:
    return pwd_context.hash(senha)

# Exemplo de uso
senha_hash = hash_senha("minha_senha_super_segura")
print(senha_hash)  
```
📌 **O resultado será um hash seguro, como este:**  
```
$2b$12$w1Gdh/e6QgH5th1PjDq.Nu9X.Kq7xFPD7BQ
```

---
### **2️⃣ Verificando uma senha**
Para autenticar um usuário, devemos **comparar** a senha digitada com o hash armazenado.  

```python
def verificar_senha(senha_digitada: str, senha_hash: str) -> bool:
    return pwd_context.verify(senha_digitada, senha_hash)

# Exemplo de uso
senha_correta = "minha_senha_super_segura"
senha_errada = "senha_incorreta"

print(verificar_senha(senha_correta, senha_hash))  # ✅ True
print(verificar_senha(senha_errada, senha_hash))   # ❌ False
```

---
## **⚡️ Usando `passlib` no FastAPI**
Se você está criando um sistema de login no **FastAPI**, pode integrar `passlib` facilmente para armazenar e validar senhas.

```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from passlib.context import CryptContext

app = FastAPI()
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

class Usuario(BaseModel):
    username: str
    password: str

# Banco de dados fictício
db_usuarios = {}

@app.post("/cadastro/")
def cadastrar_usuario(usuario: Usuario):
    if usuario.username in db_usuarios:
        raise HTTPException(status_code=400, detail="Usuário já existe!")
    
    # Hash da senha antes de armazenar
    senha_hash = pwd_context.hash(usuario.password)
    db_usuarios[usuario.username] = senha_hash
    return {"msg": "Usuário cadastrado com sucesso!"}

@app.post("/login/")
def login(usuario: Usuario):
    senha_hash = db_usuarios.get(usuario.username)

    if not senha_hash or not pwd_context.verify(usuario.password, senha_hash):
        raise HTTPException(status_code=401, detail="Credenciais inválidas!")
    
    return {"msg": "Login bem-sucedido!"}
```

---
## **📌 Conclusão**  
O **Passlib** é uma ferramenta essencial para qualquer aplicação que lide com autenticação de usuários. Ele ajuda a garantir que as senhas sejam armazenadas de forma **segura**, evitando problemas de segurança como **armazenamento em texto puro** ou **hashing fraco**.  