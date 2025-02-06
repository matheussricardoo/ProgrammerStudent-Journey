## 📌 O que é Ordenação por Seleção (Selection Sort)?  
O **Selection Sort** (Ordenação por Seleção) é um algoritmo simples de ordenação que funciona encontrando **o menor (ou maior) elemento** de uma lista e movendo-o para a posição correta **de forma repetitiva** até que toda a lista esteja ordenada.  

🔹 **Tipo de Ordenação:** Baseado em seleção.  
🔹 **Complexidade:** `O(n²)` no pior caso (ineficiente para listas grandes).  
🔹 **Estável?** ❌ **Não** (elementos iguais podem trocar de posição).  
🔹 **Uso de Memória:** `O(1)` (ordenamento **in-place**, ou seja, sem criar listas auxiliares).  

---
## 📌 Como Funciona o Selection Sort?  
1️⃣ **Encontra o menor elemento da lista** e troca com o primeiro.  
2️⃣ **Encontra o segundo menor elemento** e troca com o segundo.  
3️⃣ Repete esse processo até ordenar toda a lista.  

🔹 **Exemplo passo a passo para ordenar `[7, 3, 9, 1, 5]` em ordem crescente:**  

| Passo | Lista |
|-------|------------------|
| 1️⃣ Encontra o menor (1) e troca com 7 | **[1**, 3, 9, **7**, 5] |
| 2️⃣ Encontra o segundo menor (3) e mantém no lugar | [1, **3**, 9, 7, 5] |
| 3️⃣ Encontra o terceiro menor (5) e troca com 9 | [1, 3, **5**, 7, **9**] |
| 4️⃣ Encontra o quarto menor (7) e mantém no lugar | [1, 3, 5, **7**, 9] |
| ✅ Lista ordenada! | [1, 3, 5, 7, 9] |

---
## 📌 Implementação do Selection Sort em Python  

```python
def selection_sort(lista):
    n = len(lista)
    for i in range(n - 1):
        min_index = i
        for j in range(i + 1, n):
            if lista[j] < lista[min_index]:
                min_index = j  # Atualiza o índice do menor elemento
        lista[i], lista[min_index] = lista[min_index], lista[i]  # Troca os valores

# Exemplo de uso
nums = [7, 3, 9, 1, 5]
selection_sort(nums)
print(nums)  # Saída: [1, 3, 5, 7, 9]
```

---
## 📌 Complexidade do Selection Sort  

| Caso | Complexidade |
|------|-------------|
| **Melhor Caso** (Lista já ordenada) | `O(n²)` |
| **Pior Caso** (Lista invertida) | `O(n²)` |
| **Médio Caso** | `O(n²)` |

❌ **Desvantagem:** Muito lento para listas grandes.  
✅ **Vantagem:** Funciona bem para **listas pequenas** e não exige memória extra.  

---
## 📌 Quando Usar Selection Sort?  
✅ **Se a lista for pequena (até ~1000 elementos).**  
✅ **Se o consumo de memória extra for um problema.**  
❌ **Se precisar de um algoritmo rápido para grandes volumes de dados, use QuickSort ou MergeSort (`O(n log n)`).**  

---
## 📌 Conclusão  
O **Selection Sort** é simples, mas ineficiente para grandes listas. Ele é útil quando a memória extra precisa ser minimizada, mas geralmente não é a melhor escolha para ordenação em larga escala.  
