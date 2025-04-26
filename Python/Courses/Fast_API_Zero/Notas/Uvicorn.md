## O que é o **Uvicorn**?

**Uvicorn** é um servidor ASGI (Asynchronous Server Gateway Interface) de alto desempenho para aplicações Python. Ele é projetado para executar aplicações **FastAPI**, **Django ASGI**, **Starlette**, e qualquer outra aplicação compatível com o padrão **ASGI**.

Diferente do tradicional **WSGI** (usado por servidores como Gunicorn e uWSGI), o **ASGI** permite suporte a **requisições assíncronas**, **WebSockets**, **HTTP/2**, e **eventos em tempo real**.

---
## 🔥 **Principais Características do Uvicorn**

1. **Alta Performance** 🚀 – Uvicorn é extremamente rápido e eficiente, pois é baseado na biblioteca **uvloop**, que otimiza operações assíncronas em Python.
2. **Suporte a Assincronismo (async/await)** – Perfeito para aplicações que fazem muitas operações de I/O (bancos de dados, APIs externas, WebSockets).
3. **Leve e Rápido** – Seu design minimalista e uso de **event loops** o torna uma das soluções mais rápidas para servir APIs.
4. **Compatível com FastAPI, Starlette e Django ASGI** – Ideal para rodar aplicações modernas baseadas em **ASGI**.
5. **Multi-threading e Multiprocessamento** – Suporte para execução eficiente de múltiplas requisições concorrentes.

---
## 🛠 **Como Instalar o Uvicorn**

Se você está usando **Poetry**, pode instalar com:

```bash
poetry add uvicorn
```

Ou com **pip**:

```bash
pip install uvicorn
```

Se quiser instalar com suporte extra para melhor desempenho:

```bash
pip install "uvicorn[standard]"
```

Isso instalará **uvloop** e **httptools**, que aumentam ainda mais a velocidade do servidor.

---
## 🚀 **Como Usar o Uvicorn para Rodar uma Aplicação FastAPI**

Depois de instalar, você pode iniciar seu servidor FastAPI com:

```bash
uvicorn nome_do_arquivo:app --host 0.0.0.0 --port 8000 --reload
```

### 📌 Explicação dos parâmetros:

- `nome_do_arquivo:app` – Refere-se ao arquivo onde está sua aplicação FastAPI. Por exemplo, se seu arquivo se chama `main.py` e contém `app = FastAPI()`, então o comando seria:
    
    ```bash
    uvicorn main:app --reload
    ```
    
- `--host 0.0.0.0` – Faz com que o servidor aceite conexões externas.
- `--port 8000` – Define a porta onde o servidor será iniciado (padrão: 8000).
- `--reload` – Habilita **hot-reloading**, ou seja, o servidor será reiniciado automaticamente sempre que o código for alterado.

---
## 🔄 **Usando Uvicorn com Gunicorn (produção)**

Embora o **Uvicorn** possa ser usado sozinho, em produção é comum usá-lo com **Gunicorn**, que gerencia múltiplos processos para maior estabilidade.

### Instalação:

```bash
pip install gunicorn
```

### Rodando com Gunicorn:

```bash
gunicorn -w 4 -k uvicorn.workers.UvicornWorker main:app
```

- `-w 4` – Define 4 "workers" para melhor desempenho.
- `-k uvicorn.workers.UvicornWorker` – Usa Uvicorn como worker dentro do Gunicorn.

---

## 🎯 **Quando Usar Uvicorn?**

✅ Para APIs de alto desempenho, como **FastAPI**.  
✅ Para aplicações que precisam de **requisições assíncronas**.  
✅ Quando precisar de **WebSockets**, **HTTP/2**, ou **eventos em tempo real**.  
✅ Para rodar aplicações modernas com **Django ASGI** e **Starlette**.

Se precisar de um servidor rápido e eficiente para APIs Python, **Uvicorn** é uma das melhores escolhas! 🚀