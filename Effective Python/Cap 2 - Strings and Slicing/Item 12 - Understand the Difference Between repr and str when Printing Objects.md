### **1. Principais Diferenças**

|**Aspecto**|`str` (pelo método `__str__()`)|`repr` (pelo método `__repr__()`)|
|---|---|---|
|**Propósito**|Representação **amigável para o usuário** (leitura).|Representação **precisa para o desenvolvedor** (depuração).|
|**Uso Comum**|`print()`, `str()`|`repr()`, console interativo, logs|
|**Formatoresultado**|Humana, informal (ex.: `"Hello"`).|Código-like, detalhado (ex.: `'Hello'`).|
|**Exemplo para lista**|`[1, 2, 'three']`|`[1, 2, 'three']`|
|**Para um objeto complexo**|Descrição simples (ex.: `"Person: Alice"`).|Detalhes completos (ex.: `Person(name='Alice', age=30)`).|

---
### **2. Comportamento Padrão**

- **Apenas `__str__` definido**:

    - `str()` usa `__str__`.

    - `repr()` usa o `__repr__` padrão (ex.: `<__main__.Person object at 0x...>`).

- **Apenas `__repr__` definido**:

    - `repr()` usa `__repr__`.

    - `str()` usa o mesmo valor (se `__str__` não estiver definido).

---
### **3. Exemplo Concreto**

```python
class Person:  
    def __init__(self, name, age):  
        self.name = name  
        self.age = age  

    def __str__(self):  
        return f" Pessoa: {self.name}, {self.age} anos."  

    def __repr__(self):  
        return f"Person(name='{self.name}', age={self.age})"  

p = Person("Alice", 30)  

# Saída usando __str__:  
print(p)  # → "Pessoa: Alice, 30 anos."  
print(str(p))  # → Mesmo resultado.  

# Saída usando __repr__:  
print(repr(p))  # → "Person(name='Alice', age=30)"  
```

---
### **4. Quando Usar Cada Um?**

- **`__str__`**:
    
    - **Foque em legibilidade** para usuários finais.

    - Ex.: `str(datetime.now())` → `"2023-10-10 10:00:00"`.

- **`__repr__`**:
    
    - **Foque em precisão** para depuração ou recriação do objeto.

    - Ex.: `repr([1, 2, 3])` → `"[1, 2, 3]"` (pode ser copiado e executado).
---
### **5. Boas Práticas**

- Defina **ambos os métodos** (`__str__` e `__repr__`) para classes complexas.
    
- Tente que `__repr__` retorne uma expressão válida em Python (ex.: `eval(repr(obj))` recrie o objeto).
---
### **Resumo**

- **`str`** → Usuário.

- **`repr`** → Desenvolvedor.

- Use `__repr__` para depuração e `__str__` para saídas visuais.