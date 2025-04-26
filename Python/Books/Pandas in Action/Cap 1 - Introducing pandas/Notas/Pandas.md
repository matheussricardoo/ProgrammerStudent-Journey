# 📌 O que é Pandas?  

O **Pandas** é uma biblioteca de código aberto para **análise e manipulação de dados** em Python. Ele fornece estruturas de dados poderosas e flexíveis, como **DataFrames** e **Series**, que facilitam o trabalho com grandes volumes de dados.  

🔹 **Principais características do Pandas:**  
✅ Manipulação eficiente de grandes conjuntos de dados  
✅ Leitura e escrita de arquivos CSV, Excel, JSON, SQL, etc.  
✅ Filtragem, agregação e transformação de dados  
✅ Integração com bibliotecas como NumPy, Matplotlib e Scikit-learn  

---
# 📌 Instalação do Pandas  

Para instalar o Pandas, basta rodar:  

```bash
pip install pandas
```

Depois, importe a biblioteca no seu código:  

```python
import pandas as pd
```

---
# 📌 Principais Estruturas de Dados no Pandas  

### 🔹 **1. Series (Estrutura Unidimensional, tipo um Vetor)**  
Uma **Series** é uma estrutura semelhante a um array do NumPy, mas com um **índice associado**.  

```python
import pandas as pd

dados = [10, 20, 30, 40]
serie = pd.Series(dados)

print(serie)
```

📌 **Saída:**  
```
0    10
1    20
2    30
3    40
dtype: int64
```

---
### 🔹 **2. DataFrame (Tabela de Dados, tipo uma Planilha)**  
Um **DataFrame** é uma estrutura **bidimensional**, parecida com uma tabela do Excel ou um banco de dados.  

```python
dados = {
    'Nome': ['Ana', 'Bruno', 'Carlos'],
    'Idade': [25, 30, 35],
    'Cidade': ['São Paulo', 'Rio de Janeiro', 'Belo Horizonte']
}

df = pd.DataFrame(dados)
print(df)
```

📌 **Saída:**  
```
    Nome  Idade           Cidade
0    Ana     25      São Paulo
1  Bruno     30  Rio de Janeiro
2 Carlos     35  Belo Horizonte
```

---

# 📌 Operações Básicas com Pandas  

### 🔹 **1. Ler Arquivos com Pandas**  
```python
df = pd.read_csv("arquivo.csv")  # Lê um arquivo CSV
df = pd.read_excel("arquivo.xlsx")  # Lê um arquivo Excel
```

### 🔹 **2. Exibir os Primeiros Registros**  
```python
print(df.head())  # Mostra os primeiros 5 registros
print(df.tail())  # Mostra os últimos 5 registros
```

### 🔹 **3. Obter Informações sobre os Dados**  
```python
print(df.info())  # Mostra informações sobre as colunas e tipos de dados
print(df.describe())  # Exibe estatísticas gerais dos dados numéricos
```

### 🔹 **4. Filtrar Dados**  
```python
df_filtrado = df[df["Idade"] > 30]  # Seleciona apenas pessoas com idade maior que 30
```

### 🔹 **5. Adicionar e Remover Colunas**  
```python
df["Profissão"] = ["Engenheiro", "Médico", "Advogado"]  # Adiciona uma nova coluna
df.drop("Idade", axis=1, inplace=True)  # Remove a coluna 'Idade'
```

### 🔹 **6. Agrupar Dados**  
```python
df_grouped = df.groupby("Cidade").mean()  # Agrupa por cidade e calcula a média
```

### 🔹 **7. Ordenar Dados**  
```python
df_sorted = df.sort_values("Idade", ascending=False)  # Ordena pelo campo 'Idade' de forma decrescente
```

---
# 📌 Exemplo Completo de Uso do Pandas  

```python
import pandas as pd

# Criando um DataFrame
dados = {
    'Nome': ['Alice', 'Bob', 'Carlos', 'Diana'],
    'Idade': [23, 35, 29, 41],
    'Salario': [5000, 7000, 6500, 8000],
    'Cidade': ['São Paulo', 'Rio de Janeiro', 'Belo Horizonte', 'São Paulo']
}

df = pd.DataFrame(dados)

# Filtrar pessoas com salário maior que 6000
df_filtrado = df[df["Salario"] > 6000]

# Agrupar por cidade e calcular a média salarial
df_agrupado = df.groupby("Cidade")["Salario"].mean()

# Ordenar por idade
df_ordenado = df.sort_values("Idade")

# Exibir resultados
print("DataFrame Original:\n", df)
print("\nFiltrado (Salário > 6000):\n", df_filtrado)
print("\nMédia Salarial por Cidade:\n", df_agrupado)
print("\nOrdenado por Idade:\n", df_ordenado)
```

---
# 📌 Conclusão  
O Pandas é uma ferramenta essencial para manipulação de dados em Python. Ele permite **ler, processar e transformar grandes conjuntos de dados** de forma eficiente, sendo amplamente usado em **Ciência de Dados, Machine Learning e Análises Estatísticas**.  
