# **🔹 `assert`, `raise`, `Field` e `alias` no Python e Pydantic**

Neste guia, vamos abordar quatro conceitos fundamentais em Python e Pydantic:

- **`assert`** → Afirmações para depuração e testes.
- **`raise`** → Levantamento de exceções.
- **`Field`** → Configuração avançada de atributos no Pydantic.
- **`alias`** → Alteração dos nomes dos atributos no Pydantic.

---
# **📌 `assert` (Afirmação/Verificação)**

O comando **`assert`** é usado para **verificar se uma condição é verdadeira**.  
Se for falsa, o programa lança um erro **`AssertionError`**.

### **✅ Exemplo 1: Verificando uma condição**

```python
x = 10
assert x > 5  # OK, pois 10 é maior que 5
assert x < 5  # Vai gerar um erro AssertionError
```

**Saída:**

```
AssertionError
```

### **✅ Exemplo 2: Personalizando a mensagem de erro**

```python
idade = 15
assert idade >= 18, "A idade mínima para dirigir é 18 anos"
```

**Saída:**

```
AssertionError: A idade mínima para dirigir é 18 anos
```

### **📌 Quando usar `assert`?**

✔ Para **testes rápidos** no código.  
✔ Para **validar entradas** de funções.  
✔ Para **depuração (debug)**, garantindo que valores atendam requisitos.

### **🚫 Quando NÃO usar `assert`?**

❌ Em código crítico para produção, pois **`assert` pode ser desativado** com `python -O script.py`.

---
# **📌 `raise` (Levantar Exceção)**

O comando **`raise`** é usado para **gerar manualmente um erro** no Python.  
Ele permite criar **mensagens personalizadas** e lançar exceções específicas.

### **✅ Exemplo 1: Levantando um erro genérico**

```python
x = -1
if x < 0:
    raise ValueError("O valor não pode ser negativo!")
```

**Saída:**

```
ValueError: O valor não pode ser negativo!
```

### **✅ Exemplo 2: Criando exceções personalizadas**

```python
def dividir(a, b):
    if b == 0:
        raise ZeroDivisionError("Não é possível dividir por zero!")
    return a / b

print(dividir(10, 2))  # OK
print(dividir(10, 0))  # Vai gerar erro
```

**Saída:**

```
ZeroDivisionError: Não é possível dividir por zero!
```

### **📌 Quando usar `raise`?**

✔ Para **validar entradas** em funções.  
✔ Para **interromper a execução** caso algo esteja errado.  
✔ Para **criar erros personalizados** em sistemas grandes.

---
# **📌 `Field` e `alias` no Pydantic**

No **Pydantic**, o **`Field`** é usado para definir **validações e configurações extras** nos atributos.  
O **`alias`** permite **renomear um atributo**, facilitando a integração com APIs e bancos de dados.

---
## **✅ Exemplo 1: Usando `Field` para definir restrições**

O `Field` pode ser utilizado para **definir validações personalizadas**, como valores mínimos e máximos.

```python
from pydantic import BaseModel, Field

class Usuario(BaseModel):
    nome: str = Field(..., min_length=3, max_length=50, description="Nome completo do usuário")
    idade: int = Field(..., ge=18, le=120, description="Idade deve estar entre 18 e 120 anos")

# Criando um usuário válido
usuario = Usuario(nome="Carlos Silva", idade=25)
print(usuario)
```

**Explicação:**

- **`min_length=3`** → O nome deve ter pelo menos **3 caracteres**.
- **`max_length=50`** → O nome não pode ter mais de **50 caracteres**.
- **`ge=18`** → A idade deve ser **maior ou igual a 18**.
- **`le=120`** → A idade deve ser **menor ou igual a 120**.

---
## **✅ Exemplo 2: Usando `alias` para modificar os nomes dos atributos**

Em alguns casos, os dados que recebemos podem ter **nomes diferentes**.  
O **`alias`** ajuda a **mapear esses nomes** para atributos mais claros no código.

```python
class Produto(BaseModel):
    nome: str = Field(..., alias="Nome do Produto")
    preco: float = Field(..., alias="Preço")

# Criando um produto com os aliases corretos
dados_produto = {
    "Nome do Produto": "Smartphone",
    "Preço": 1999.99
}

produto = Produto(**dados_produto)
print(produto)
```

**Saída:**

```
nome='Smartphone' preco=1999.99
```

**Explicação:**

- **`alias="Nome do Produto"`** → No JSON ou entrada de dados, usamos **"Nome do Produto"**, mas no código ele será tratado como `nome`.
- **`alias="Preço"`** → Permite usar `"Preço"` na entrada de dados, mas internamente será `preco`.

Isso é útil ao **trabalhar com APIs externas** ou **formatos de dados específicos**.

---
## **✅ Exemplo 3: Alias com JSON**

Se estivermos lidando com um **JSON de entrada**, podemos converter os nomes corretamente:

```python
from pydantic import BaseModel, Field
import json

class Cliente(BaseModel):
    nome: str = Field(..., alias="Nome Completo")
    email: str = Field(..., alias="E-mail")

# Simulando um JSON recebido de uma API
json_recebido = '''
{
    "Nome Completo": "Ana Souza",
    "E-mail": "ana@email.com"
}
'''

# Convertendo JSON para dicionário e validando com Pydantic
dados_cliente = json.loads(json_recebido)
cliente = Cliente(**dados_cliente)

print(cliente)
```

**Saída:**

```
nome='Ana Souza' email='ana@email.com'
```

---
# **📌 Resumo**

|Comando|Uso|
|---|---|
|`assert`|Verificar se uma condição é verdadeira. Se for falsa, lança um erro `AssertionError`.|
|`raise`|Levanta exceções manualmente, permitindo mensagens personalizadas.|
|`Field`|Configura atributos no Pydantic, definindo validações e metadados.|
|`alias`|Permite alterar o nome dos atributos no Pydantic para compatibilidade com APIs e bancos de dados.|

---
## **🔹 Conclusão**

- **`assert`** → Ótimo para **testes rápidos**, mas não deve ser usado em código de produção.
- **`raise`** → Permite **lançar erros personalizados** e melhorar a segurança do código.
- **`Field`** → Facilita **validações avançadas** e **configuração de atributos** no Pydantic.
- **`alias`** → Essencial para **compatibilidade com APIs** e **formatos externos de dados**.