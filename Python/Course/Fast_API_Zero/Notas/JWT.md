## 🔐 O que é JWT (JSON Web Token)?  
**JWT (JSON Web Token)** é um padrão de token seguro baseado em JSON, usado para autenticação e troca de informações entre sistemas. Ele é amplamente utilizado em **APIs REST** para autenticação de usuários de forma segura.  

---
## 📌 **Como um JWT é estruturado?**  
Um **JWT** é composto por **três partes**, separadas por pontos (`.`):  

```
HEADER.PAYLOAD.SIGNATURE
```

### **1️⃣ Header (Cabeçalho)**
Define o tipo de token (**JWT**) e o algoritmo de assinatura usado (**HS256, RS256, etc.**).  

```json
{
  "alg": "HS256",
  "typ": "JWT"
}
```

---
### **2️⃣ Payload (Corpo)**
Contém as informações do usuário (claims), como **ID, nome e permissões**.  

```json
{
  "sub": "1234567890",
  "name": "João Silva",
  "admin": true,
  "exp": 1712515200  // Data de expiração
}
```
**Claims mais usados:**  
- `sub` → Identificação do usuário  
- `exp` → Expiração do token  
- `iat` → Data de criação  
- `role` → Permissão do usuário  

---
### **3️⃣ Signature (Assinatura)**
Garante a **segurança e autenticidade** do token. Ela é gerada usando um **segredo** ou uma **chave privada/pública**.  

```python
HMACSHA256(
  base64UrlEncode(header) + "." + base64UrlEncode(payload),
  secret
)
```
Sem a assinatura correta, o JWT não é válido!

---
## **🔑 Como funciona a autenticação com JWT?**  
1️⃣ O usuário faz **login** e recebe um **JWT**.  
2️⃣ O token é armazenado no **localStorage**, **sessionStorage** ou **cookie HTTPOnly**.  
3️⃣ Em cada requisição, o token é enviado no **header**:  
   ```
   Authorization: Bearer <seu_token_aqui>
   ```
4️⃣ O servidor valida o JWT e, se for válido, autoriza o acesso.  

---
## **⚠️ Vantagens e Desvantagens do JWT**
### ✅ **Vantagens**  
✔ **Sem estado** – O servidor não precisa armazenar sessões.  
✔ **Seguro** – Assinado digitalmente para evitar fraudes.  
✔ **Escalável** – Ideal para microservices e APIs distribuídas.  

### ❌ **Desvantagens**  
❌ **Tokens não podem ser revogados facilmente** – Se um JWT for roubado, o usuário pode ficar logado até o token expirar.  
❌ **Maior tamanho da requisição** – Cada requisição inclui o JWT.  
❌ **Chave secreta deve ser protegida** – Se vazar, qualquer um pode gerar tokens falsos.  

---
## **🛠 Como usar JWT com FastAPI?**
### **1️⃣ Instale o PyJWT**
```bash
pip install pyjwt
```

### **2️⃣ Gere um token JWT**
```python
import jwt
import datetime

SECRET_KEY = "meu_segredo_super_secreto"

def criar_token(usuario_id: int):
    payload = {
        "sub": usuario_id,
        "exp": datetime.datetime.utcnow() + datetime.timedelta(hours=1)
    }
    return jwt.encode(payload, SECRET_KEY, algorithm="HS256")
```

### **3️⃣ Decodifique um token JWT**
```python
def verificar_token(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        return payload
    except jwt.ExpiredSignatureError:
        return "Token expirado!"
    except jwt.InvalidTokenError:
        return "Token inválido!"
```

---
## **🚀 Conclusão**  
O **JWT** é uma forma eficiente de autenticação para **APIs** e **microservices**, garantindo **segurança, escalabilidade e flexibilidade**. Contudo, é essencial **proteger a chave secreta e implementar boas práticas de segurança**! 🔐🚀  
