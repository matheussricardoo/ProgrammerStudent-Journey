## 🔹 **Comandos Úteis do Debugger (Depurador) em Python**  

O **debugger** é essencial para encontrar e corrigir erros no código. No **pytest**, podemos combinar testes com ferramentas como `pdb` (Python Debugger) para inspecionar o código em tempo de execução.  

---
## ✅ **1. Rodando Testes com `task test` e `pytest`**  

### 📌 **Rodando um único teste**  
Se você quer rodar apenas **um teste específico**, use:  
```sh
task test tests/test_security.py::test_jwt
```
Isso executa **somente o teste `test_jwt`** dentro do arquivo `test_security.py`.  

---
## ✅ **2. Rodando Apenas os Testes que Falharam**  

### 📌 **Rodar apenas os testes que falharam na última execução**  
```sh
task test --lf
```
- O **`--lf` (last fail)** roda **somente os testes que falharam** na última execução.  
- Muito útil para evitar rodar todos os testes quando só precisa corrigir os falhos.  

---
## ✅ **3. Usando o Debugger Durante os Testes**  

Se precisar **interromper a execução no momento do erro**, use `--pdb`:  
```sh
task test --pdb
```
Isso **ativa o depurador** sempre que um teste falhar, permitindo **inspecionar variáveis** e **executar comandos interativos**.

---
## ✅ **4. Comandos Úteis Dentro do Debugger (`pdb`)**  

Quando o debugger (`pdb`) está ativo, você pode usar os seguintes comandos:

| **Comando** | **Descrição** |
|------------|--------------|
| `q`  | **Quit** → Sai do debugger. |
| `c`  | **Continue** → Continua a execução do programa. |
| `u`  | **Up** → Sobe um nível na pilha de chamadas (stack trace). |
| `d`  | **Down** → Desce um nível na pilha de chamadas. |
| `l`  | **List** → Mostra onde o código parou. |
| `w`  | **Where** → Exibe todas as chamadas da pilha de execução. |
| `n`  | **Next** → Executa a próxima linha de código (sem entrar em funções internas). |
| `s`  | **Step** → Avança para a próxima linha, entrando em funções internas. |
| `p variável`  | **Print** → Mostra o valor da variável no momento da execução. |
| `breakpoint()` | **Cria um ponto de parada manualmente no código.** |

---
## ✅ **5. Criando um Breakpoint Manualmente**  

Se quiser **parar o código em um ponto específico**, adicione `breakpoint()` dentro da função.  

### 📌 **Exemplo:**  
```python
def calcular_soma(a, b):
    breakpoint()  # O código pausa aqui
    return a + b

resultado = calcular_soma(5, 3)
print(resultado)  # Só será executado depois que você sair do debugger
```
📌 **Quando executar o script, o programa pausará no `breakpoint()`, permitindo inspecionar variáveis.**  

---
## ✅ **6. Instalando Dependências para Debugging**  

Se você estiver usando `poetry`, pode precisar instalar pacotes específicos:  

📌 **Para instalar dependências do projeto**  
```sh
poetry install
```
📌 **Para garantir que o pytest e o debugger estão instalados**  
```sh
poetry add --dev pytest pdbpp
```
Isso adiciona o **pytest** e um depurador melhorado (`pdbpp`) para facilitar a depuração.  

---
## ✅ **7. Rodando Testes de Forma Otimizada**  

| **Comando** | **Função** |
|------------|-----------|
| `task test` | Executa todos os testes. |
| `task test tests/test_app.py::test_funcao` | Roda um teste específico. |
| `task test --lf` | Roda apenas os últimos testes que falharam. |
| `task test --pdb` | Para nos erros e abre o debugger. |
| `task test --maxfail=1` | Para a execução no primeiro erro encontrado. |

---
## 🔥 **Conclusão**  

Com essas técnicas, você pode **depurar e testar seu código de forma eficiente**. 🚀  

✔ Use `--lf` para rodar apenas os testes que falharam.  
✔ Use `--pdb` para **entrar no debugger quando um teste falhar**.  
✔ Use `breakpoint()` para **parar manualmente a execução** e inspecionar variáveis.  
✔ Comandos como `l`, `w`, `p` e `q` tornam a depuração mais fácil.  