# 🔹 **Algoritmos HS256 e Argon2**  

Os algoritmos **HS256** e **Argon2** são usados para segurança em aplicações, mas com propósitos diferentes:  
- **HS256** → Algoritmo de assinatura para JWT (JSON Web Token).  
- **Argon2** → Algoritmo de hashing para proteger senhas.  

Vamos explorar cada um deles em detalhes. 🚀  

---
## 🔹 **HS256 (HMAC-SHA256) – Algoritmo de Assinatura de JWT**  

### 📌 **O que é o HS256?**  
O **HS256 (HMAC-SHA256)** é um algoritmo de assinatura usado para garantir a **autenticidade** e **integridade** dos JSON Web Tokens (**JWT**).  

Ele faz parte da família HMAC (**Hash-based Message Authentication Code**) e usa o **SHA-256** para criptografar os dados junto com uma chave secreta.  

### 🔹 **Como o HS256 Funciona?**  
1. O servidor cria um **JWT** contendo informações do usuário (payload).  
2. O JWT é assinado com **HS256** usando uma **chave secreta**.  
3. No cliente, o token pode ser enviado em cada requisição.  
4. O servidor **verifica a assinatura** para garantir que o token não foi alterado.  

### 📌 **Exemplo de JWT usando HS256**  
JWT é formado por **três partes** separadas por pontos (`.`):  
```
header.payload.signature
```
Cada parte é codificada em **Base64** e assinada com **HS256**.

📌 **Exemplo em Python usando `pyjwt`**  
```python
import jwt

# Chave secreta
SECRET_KEY = "minha_chave_super_secreta"

# Criando um token JWT
payload = {"user_id": 123, "role": "admin"}
token = jwt.encode(payload, SECRET_KEY, algorithm="HS256")

print(f"Token JWT: {token}")

# Decodificando o token
decoded_payload = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
print(f"Payload decodificado: {decoded_payload}")
```

### ✅ **Vantagens do HS256**  
✔ Rápido e eficiente para assinar tokens.  
✔ Fácil de implementar.  
✔ Compatível com JWT (padrão para autenticação).  

### 🚫 **Desvantagens do HS256**  
❌ A segurança depende da **chave secreta** – se for comprometida, qualquer um pode criar tokens falsos.  
❌ Não suporta **assinatura assimétrica** como RSA ou ECDSA.  

📌 **Alternativas mais seguras?**  
- **RS256 (RSA + SHA256)** → Usa um par de chaves pública e privada.  
- **ES256 (ECDSA + SHA256)** → Algoritmo mais eficiente para assinaturas digitais.  

---
## 🔹 **Argon2 – Algoritmo de Hashing de Senhas**  

### 📌 **O que é Argon2?**  
O **Argon2** é um algoritmo de hashing de senhas considerado o mais seguro atualmente. Ele ganhou o **Password Hashing Competition (PHC)** em 2015.  

**Diferente do HS256**, que é usado para **assinar tokens**, o **Argon2** é usado para **armazenar senhas de forma segura**.  

### 🔹 **Como o Argon2 Funciona?**  
Ele transforma a senha em um **hash seguro**, adicionando um **salt aleatório** para evitar ataques de força bruta e rainbow table.  

O Argon2 tem **três variantes**:  
🔹 **Argon2i** → Protege contra ataques baseados em acesso à memória.  
🔹 **Argon2d** → Melhor contra ataques baseados em GPUs.  
🔹 **Argon2id** → Combinação dos dois e recomendado como padrão.  

### 📌 **Exemplo de Uso do Argon2 com Python (`argon2-cffi`)**  
```python
from argon2 import PasswordHasher

ph = PasswordHasher()

# Criando um hash de senha
senha = "minha_senha_super_secreta"
hash_senha = ph.hash(senha)

print(f"Hash da senha: {hash_senha}")

# Verificando a senha
try:
    ph.verify(hash_senha, "minha_senha_super_secreta")
    print("Senha correta!")
except:
    print("Senha incorreta!")
```

### ✅ **Vantagens do Argon2**  
✔ **Altamente seguro** – projetado para ser resistente a ataques de hardware.  
✔ **Proteção contra ataques de força bruta** – usa memória e tempo para tornar ataques mais difíceis.  
✔ **Padrão recomendado** para hashing de senhas modernas.  

### 🚫 **Desvantagens do Argon2**  
❌ **Mais lento do que SHA-256** – porque foi projetado para dificultar ataques.  
❌ **Pode consumir mais memória** dependendo dos parâmetros usados.  

📌 **Alternativas mais antigas** (menos seguras):  
- **bcrypt** → Ainda usado, mas menos seguro que Argon2.  
- **PBKDF2** → Seguro, mas inferior ao Argon2 em termos de proteção contra ataques modernos.  

---
## 🔹 **Conclusão**  
| Algoritmo  | Uso Principal | Vantagens | Desvantagens |
|------------|--------------|-----------|--------------|
| **HS256**  | Assinar tokens JWT | Rápido, fácil de implementar | Se a chave secreta vazar, o sistema fica vulnerável |
| **Argon2** | Hash de senhas | Altamente seguro contra ataques | Mais lento devido ao alto consumo de memória |

✅ Se você precisa assinar **tokens JWT**, use **HS256**.  
✅ Se você quer armazenar **senhas de forma segura**, use **Argon2**.  

Para sistemas seguros, pode ser uma boa prática combinar os dois:  
1. **Argon2** → Para armazenar senhas de usuários.  
2. **HS256** (ou **RS256**) → Para autenticação com JWT.  

🔐 Segurança é essencial! Use os algoritmos certos para proteger seus dados. 🚀