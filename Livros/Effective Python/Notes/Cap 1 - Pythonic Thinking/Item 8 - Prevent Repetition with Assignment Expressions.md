### **1. O Que São Expressões de Atribuição?**

As expressões de atribuição permitem que você **atribua um valor a uma variável dentro de uma expressão**, evitando a necessidade de computar o mesmo valor várias vezes. A sintaxe é:

```python
variavel := expressao  
```

---
### **2. Exemplo: Evitando Chamadas Redundantes**

Sem expressão de atribuição:

```python
data = get_data()  
if data is not None:  
    process(data)  
```

Com expressão de atribuição:

```python
if (data := get_data()) is not None:  
    process(data)  
```

- **Vantagem**: `get_data()` é chamado apenas uma vez, mesmo que a variável `data` seja usada em múltiplos lugares.
---
### **3. Uso em Loops e Condições**

- **Exemplo 1: Filtragem com Atribuição**

    ```python
    # Sem atribuição  
    for item in items:  
        if item.is_valid():  
            process(item)  
    
    # Com atribuição  
    for item in items:  
        if (valid := item.is_valid()):  
            process(item)  
    ```

- **Exemplo 2: Evitando Chamadas Duplas**

    ```python
    # Sem atribuição  
    if len(data) > 10:  
        print(f"Tamanho: {len(data)}")  
    
    # Com atribuição  
    if (size := len(data)) > 10:  
        print(f"Tamanho: {size}")  
    ```

---
### **4. Uso em Compreensões de Lista**

- **Sem Atribuição**:

    ```python
    results = []  
    for x in data:  
        if x > 0:  
            results.append(x * 2)  
    
    # Com atribuição  
    results = [(y := x * 2) for x in data if y > 0]  
    ```

- **Com Atribuição**:

    ```python
    results = [y for x in data if (y := x * 2) > 0]  
    ```

---
### **5. Melhores Práticas**

1. **Use em Condições e Loops**: Útil para evitar chamadas redundantes de funções caras ou com efeitos colaterais.

2. **Evite Abuso**: Não use `:=` em expressões complexas ou onde a legibilidade seja comprometida.

3. **Python 3.8+**: O recurso só está disponível a partir desta versão.

---
### **6. Exemplo Prático: Processamento de Dados**

```python
def get_user_input():  
    # Simula uma chamada   
    return input("Digite algo: ").strip()  
  
# Sem atribuição  
while True:  
    response = get_user_input()  
    if response:  
        break  
  
# Com atribuição  
while not (response := get_user_input()):  
    pass  
```

---
### **7. Conclusão**

As expressões de atribuição (`:=`) são úteis para **eliminar repetição de computação** e tornar o código mais conciso. Use-as com moderação para manter a legibilidade.

Para mais detalhes, consulte o **Item 8** do _Effective Python_ (3ª Edição) .