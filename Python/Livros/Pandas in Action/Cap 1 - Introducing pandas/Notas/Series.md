### 📌 **O que são `Series` no Pandas?**  

Uma **`Series`** no Pandas é uma estrutura de dados **unidimensional** semelhante a um array ou lista, mas com um **índice associado a cada valor**.  

Ela pode armazenar diversos tipos de dados, como:  
✔ Números inteiros (`int`)  
✔ Números decimais (`float`)  
✔ Strings (`str`)  
✔ Valores booleanos (`bool`)  
✔ Valores ausentes (`NaN`)  

---
## 🚀 **Criando uma `Series`**
Podemos criar uma `Series` a partir de diferentes estruturas de dados, como listas, dicionários, tuplas ou até mesmo valores aleatórios.

### 🔹 **Criando uma `Series` a partir de uma lista**
```python
import pandas as pd

fruits = ["Apple", "Banana", "Cherry", "Date"]
pd.Series(fruits)
```
🔹 O Pandas atribui índices automaticamente (0, 1, 2, ...).  

### 🔹 **Criando uma `Series` com índices personalizados**
```python
prices = [3.50, 2.00, 5.75, 7.30]
items = ["Apple", "Banana", "Cherry", "Date"]

pd.Series(prices, index=items)
```
🔹 Agora podemos acessar os valores usando os nomes dos itens como índice.  

---
## 🛠 **Principais Propriedades e Métodos**
Depois de criar uma `Series`, podemos manipulá-la de várias formas.

### 🔹 **Acessando valores**
```python
s = pd.Series([10, 20, 30], index=['a', 'b', 'c'])
s['b']  # Retorna 20
s[1]    # Retorna 20 (acesso pelo índice numérico)
```

### 🔹 **Filtrando valores**
```python
s[s > 15]  # Retorna apenas os valores maiores que 15
```

### 🔹 **Operações Matemáticas**
```python
s * 2  # Multiplica todos os valores por 2
s + 5  # Adiciona 5 a todos os valores
```

### 🔹 **Verificando valores nulos**
```python
s.isnull()  # Retorna True para valores NaN
s.notnull() # Retorna True para valores não nulos
```

### 🔹 **Convertendo Tipos**
```python
s.astype(float)  # Converte os valores para float
```

---
## 📊 **Criando `Series` a partir de um Dicionário**
Quando criamos uma `Series` a partir de um dicionário, as **chaves se tornam os índices** e os **valores se tornam os elementos**.

```python
calories = {
    'Apple': 52,
    'Banana': 89,
    'Cherry': 50
}

pd.Series(calories)
```

---
## 🔥 **Vantagens do uso de `Series`**
✅ **Fácil manipulação de dados**  
✅ **Suporte a operações matemáticas e estatísticas**  
✅ **Integração com NumPy para cálculos avançados**  
✅ **Acesso eficiente por índices personalizados**  