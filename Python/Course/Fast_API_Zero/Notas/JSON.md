## 📌 **O que é JSON?**

**JSON (JavaScript Object Notation)** é um formato leve de intercâmbio de dados, fácil de ler e escrever para humanos e fácil de interpretar para máquinas.

É amplamente usado em APIs e comunicação entre sistemas, pois permite a transferência de informações estruturadas de forma simples e eficiente.

---
## 🛠 **Características do JSON**

✔ **Leve** → Formato compacto, ideal para troca de dados.  
✔ **Estruturado** → Usa pares **chave: valor** (similar a um dicionário em Python).  
✔ **Baseado em texto** → Pode ser lido e editado facilmente.  
✔ **Independente de linguagem** → Suportado por Python, JavaScript, Java, C#, entre outras.

---
## 📌 **Estrutura JSON**

O JSON usa chaves e valores para representar dados. Os principais tipos de dados suportados são:

|Tipo|Exemplo|
|---|---|
|**String**|`"nome": "Maria"`|
|**Número**|`"idade": 25`|
|**Booleano**|`"ativo": true`|
|**Nulo**|`"telefone": null`|
|**Array**|`"hobbies": ["leitura", "música", "futebol"]`|
|**Objeto**|`"endereco": {"cidade": "São Paulo", "estado": "SP"}`|

✅ **Exemplo de um JSON válido:**

```json
{
  "nome": "João",
  "idade": 30,
  "email": "joao@email.com",
  "ativo": true,
  "hobbies": ["leitura", "futebol"],
  "endereco": {
    "rua": "Rua das Flores",
    "cidade": "São Paulo",
    "estado": "SP"
  }
}
```

---
## 🚀 **JSON em Python**

Python possui o módulo `json` para manipulação de JSON.

### **🔄 Convertendo JSON para Dicionário (Deserialização)**

```python
import json

json_data = '{"nome": "Maria", "idade": 25, "cidade": "Rio"}'
dicionario = json.loads(json_data)

print(dicionario["nome"])  # Maria
```

### **🔄 Convertendo Dicionário para JSON (Serialização)**

```python
dados = {"nome": "Carlos", "idade": 40, "ativo": True}
json_convertido = json.dumps(dados, indent=2)

print(json_convertido)
```

**Saída:**

```json
{
  "nome": "Carlos",
  "idade": 40,
  "ativo": true
}
```

---
## 🔥 **JSON no FastAPI**

FastAPI retorna e recebe dados em JSON automaticamente!

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/usuario")
def get_usuario():
    return {"nome": "Ana", "idade": 28}
```

✅ A resposta será em JSON:

```json
{
  "nome": "Ana",
  "idade": 28
}
```

---
## 🎯 **Conclusão**

✔ JSON é um formato leve e universal para troca de dados.  
✔ Usa estrutura de **chave: valor**, suportando tipos como strings, números e listas.  
✔ Pode ser manipulado facilmente em **Python** usando o módulo `json`.  
✔ É o formato padrão de comunicação em **APIs**, incluindo **FastAPI**.
