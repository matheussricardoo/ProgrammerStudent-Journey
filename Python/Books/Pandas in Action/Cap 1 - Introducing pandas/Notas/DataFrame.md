# 📌 **O que são DataFrames no Pandas?**  

Um **DataFrame** é uma **estrutura de dados bidimensional** no Pandas, semelhante a uma **tabela** ou **planilha do Excel**. Ele pode conter diferentes tipos de dados organizados em **linhas e colunas**.  

🔹 Cada **coluna** de um DataFrame é uma **Series**, e cada **linha** possui um índice único.  
🔹 Ele é amplamente utilizado para análise e manipulação de dados.  

---
## 🚀 **Criando um DataFrame**
Podemos criar um **DataFrame** de várias maneiras, como a partir de **listas, dicionários, NumPy arrays ou arquivos CSV/Excel**.

### 🔹 **1. Criando um DataFrame a partir de um dicionário**
```python
import pandas as pd

data = {
    "Nome": ["Ana", "Carlos", "Beatriz"],
    "Idade": [25, 30, 22],
    "Cidade": ["São Paulo", "Rio de Janeiro", "Belo Horizonte"]
}

df = pd.DataFrame(data)
print(df)
```
🔹 **As chaves do dicionário viram os nomes das colunas**, e os valores são organizados em linhas.  

---
### 🔹 **2. Criando um DataFrame a partir de uma lista de listas**
```python
data = [
    ["Ana", 25, "São Paulo"],
    ["Carlos", 30, "Rio de Janeiro"],
    ["Beatriz", 22, "Belo Horizonte"]
]

df = pd.DataFrame(data, columns=["Nome", "Idade", "Cidade"])
print(df)
```
🔹 Especificamos os nomes das **colunas** com o argumento `columns`.

---
### 🔹 **3. Criando um DataFrame a partir de um NumPy Array**
```python
import numpy as np

array = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
df = pd.DataFrame(array, columns=["A", "B", "C"])
print(df)
```
🔹 O NumPy array é transformado em um DataFrame com **nomes de colunas definidos**.

---
## 🛠 **Principais Métodos e Propriedades do DataFrame**
Depois de criar um DataFrame, podemos manipulá-lo de diversas formas.

### 🔹 **Exibir as primeiras e últimas linhas**
```python
df.head(3)  # Retorna as 3 primeiras linhas
df.tail(2)  # Retorna as 2 últimas linhas
```

### 🔹 **Verificar a estrutura do DataFrame**
```python
df.shape       # Retorna (número de linhas, número de colunas)
df.columns     # Lista os nomes das colunas
df.dtypes      # Retorna os tipos de dados de cada coluna
df.info()      # Exibe informações gerais sobre o DataFrame
```

### 🔹 **Selecionar colunas e linhas específicas**
```python
df["Nome"]  # Retorna apenas a coluna "Nome"
df[["Nome", "Idade"]]  # Retorna múltiplas colunas

df.iloc[1]   # Retorna a linha de índice 1 (segunda linha)
df.loc[2]    # Retorna a linha com índice 2 (se existir)
```

### 🔹 **Filtrar dados**
```python
df[df["Idade"] > 23]  # Retorna apenas as linhas onde Idade > 23
df[df["Cidade"] == "São Paulo"]  # Filtra por cidade específica
```

---
## 📊 **Carregar e Salvar DataFrames**
Os DataFrames podem ser lidos e salvos em **diferentes formatos**.

### 🔹 **Carregar um arquivo CSV**
```python
df = pd.read_csv("dados.csv")  # Lê um arquivo CSV
```

### 🔹 **Salvar um DataFrame em CSV**
```python
df.to_csv("saida.csv", index=False)  # Salva o DataFrame sem os índices
```

### 🔹 **Carregar e salvar arquivos Excel**
```python
df = pd.read_excel("dados.xlsx")  # Lê um arquivo Excel
df.to_excel("saida.xlsx", index=False)  # Salva como arquivo Excel
```

---
## 🔥 **Por que usar DataFrames?**
✅ **Fácil manipulação de grandes volumes de dados**  
✅ **Permite cálculos e operações estatísticas rapidamente**  
✅ **Suporte para importação/exportação de arquivos (CSV, Excel, SQL)**  
✅ **Ótima integração com bibliotecas como NumPy e Matplotlib**  