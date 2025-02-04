## 📑 **Swagger UI e ReDoc: O que são e como funcionam no FastAPI?**

O **Swagger UI** e o **ReDoc** são ferramentas de documentação automática para APIs. Eles são gerados automaticamente no **FastAPI**, permitindo que desenvolvedores visualizem e testem endpoints HTTP de maneira interativa.

📌 **Ambos são interfaces gráficas** baseadas no **OpenAPI**, um padrão para descrever APIs RESTful.

---
## 🚀 **Swagger UI**

O **Swagger UI** é uma interface gráfica interativa onde você pode visualizar e testar endpoints diretamente no navegador.

🔹 **Vantagens:**  
✅ Interface **interativa e amigável**.  
✅ Permite **testar requisições** diretamente do navegador.  
✅ **Gera exemplos de requisições e respostas** automaticamente.  
✅ Melhor para **ambientes de desenvolvimento**.

### 📌 **Acessando o Swagger UI no FastAPI**

Após rodar o FastAPI com Uvicorn, a documentação Swagger pode ser acessada em:

```
http://127.0.0.1:8000/docs
```

---
## 🎨 **ReDoc**

O **ReDoc** é uma alternativa ao Swagger UI, oferecendo uma documentação mais organizada e estruturada.

🔹 **Vantagens:**  
✅ Design **limpo e responsivo**.  
✅ Melhor organização para **grandes APIs**.  
✅ Foco em **documentação clara**, sem a interface de testes do Swagger.

### 📌 **Acessando o ReDoc no FastAPI**

A documentação ReDoc pode ser acessada em:

```
http://127.0.0.1:8000/redoc
```

---
## ⚙️ **Configurando Swagger UI e ReDoc no FastAPI**

Por padrão, o **FastAPI já gera ambas as documentações automaticamente**. Mas você pode personalizar os caminhos e desativar uma delas:

```python
from fastapi import FastAPI

app = FastAPI(
    title="Minha API",
    description="Uma API feita com FastAPI 🚀",
    version="1.0.0",
    docs_url="/swagger",  # Altera o caminho do Swagger UI
    redoc_url="/api-docs"  # Altera o caminho do ReDoc
)

@app.get("/ping")
async def ping():
    return {"message": "pong"}
```

### 📌 **Explicação das configurações:**

- `docs_url="/swagger"` → Swagger UI acessível em **`/swagger`**.
- `redoc_url="/api-docs"` → ReDoc acessível em **`/api-docs`**.
- Se quiser **desativar** o Swagger ou ReDoc, basta definir `docs_url=None` ou `redoc_url=None`.

---
## 🔥 **Qual escolher: Swagger UI ou ReDoc?**

|**Critério**|**Swagger UI** ✅|**ReDoc** ✅|
|---|---|---|
|Interface Interativa|✅ Sim|❌ Não|
|Melhor para Testes|✅ Sim|❌ Não|
|Melhor para Documentação|❌ Não|✅ Sim|
|Design Minimalista|❌ Não|✅ Sim|

📌 **Conclusão:**

- Use **Swagger UI** durante o **desenvolvimento**, para testar endpoints facilmente.
- Use **ReDoc** para **documentação final**, pois é mais organizado e limpo.

🚀 **Com o FastAPI, você tem o melhor dos dois mundos!** 🚀