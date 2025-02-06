## 📌 O que são Informações e Rótulos em Machine Learning?

No contexto de **Aprendizado de Máquina (Machine Learning - ML)**, **informações** e **rótulos** são conceitos fundamentais para entender como os algoritmos aprendem a partir dos dados.

---
## 📌 1️⃣ O que são **Informações (Features)?**

As **informações** (também chamadas de **features** ou **variáveis de entrada**) são **as características que descrevem os dados** usados para treinar um modelo de Machine Learning.

🔹 Cada **feature** representa um **atributo importante** sobre um exemplo da base de dados.  
🔹 Um **bom conjunto de features** melhora a precisão do modelo.

✅ **Exemplo:** Para prever o preço de um carro, as features podem ser:

- 🚗 **Ano de fabricação**
- 📏 **Quilometragem**
- ⛽ **Tipo de combustível**
- 🏷 **Marca e modelo**

📌 **Representação em Tabela (Dataset)**

|Ano|Quilometragem|Combustível|Preço (Rótulo)|
|---|---|---|---|
|2018|40.000 km|Gasolina|**R$ 55.000**|
|2020|20.000 km|Diesel|**R$ 70.000**|
|2015|90.000 km|Flex|**R$ 35.000**|

---
## 📌 2️⃣ O que são **Rótulos (Labels)?**

Os **rótulos** são os **valores que queremos prever** em um modelo de Machine Learning supervisionado.

🔹 No treinamento do modelo, o algoritmo aprende a **mapear as features para os rótulos corretos**.  
🔹 O rótulo pode ser **numérico** (regressão) ou **categórico** (classificação).

✅ **Exemplo:**

- **Regressão:** Prever o preço de um carro (**rótulo numérico**).
- **Classificação:** Identificar se um e-mail é "spam" ou "não spam" (**rótulo categórico**).

---
## 📌 3️⃣ Diferença entre **Informações (Features)** e **Rótulos (Labels)**

|Conceito|O que é?|Exemplo (Preço de Carro)|
|---|---|---|
|**Informações (Features)**|Variáveis usadas como entrada no modelo|Ano, Quilometragem, Tipo de Combustível|
|**Rótulo (Label)**|O valor que queremos prever|Preço do carro|

📌 **Em aprendizado supervisionado, o modelo aprende a prever os rótulos com base nas informações!**

---
## 📌 4️⃣ Exemplo de Implementação em Python

### 🔹 Conjunto de Dados (Features + Rótulos)

```python
import pandas as pd

# Criando um dataset com Features e Labels
dados = {
    'Ano': [2018, 2020, 2015],
    'Quilometragem': [40000, 20000, 90000],
    'Combustível': ['Gasolina', 'Diesel', 'Flex'],
    'Preço': [55000, 70000, 35000]  # Rótulo (Label)
}

df = pd.DataFrame(dados)
print(df)
```

### 🔹 Separando Features e Labels

```python
# Features (Informações usadas para prever)
X = df[['Ano', 'Quilometragem', 'Combustível']]

# Label (O que queremos prever)
y = df['Preço']

print("Features:\n", X)
print("\nRótulo (Label):\n", y)
```

---
## 📌 Conclusão

- **Informações (Features)** são os atributos usados para fazer previsões.
- **Rótulos (Labels)** são os valores que queremos prever.
- Em **Machine Learning supervisionado**, o modelo aprende a mapear features para rótulos e fazer previsões futuras.
