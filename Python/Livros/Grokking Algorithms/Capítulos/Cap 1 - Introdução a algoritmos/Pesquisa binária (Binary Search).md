### 📌 O que é a Busca Binária?

A **Busca Binária** é um algoritmo eficiente para encontrar um elemento em uma lista ordenada. Ele divide repetidamente a lista ao meio até encontrar o valor desejado (ou determinar que ele não está presente).

### 📌 Como Funciona?

1️⃣ A busca começa no meio da lista.  
2️⃣ Se o valor procurado for menor que o do meio, busca-se na metade inferior.  
3️⃣ Se for maior, busca-se na metade superior.  
4️⃣ Esse processo se repete até encontrar o valor ou até que a sublista fique vazia.

### 📌 Complexidade e Número de Passos

✅ A Busca Binária reduz o tamanho da entrada pela metade a cada iteração.  
✅ O número máximo de comparações necessárias pode ser expresso como **log₂(n)**.  
✅ Isso significa que, para uma lista de **1.000.000** elementos, precisaríamos de no máximo **log₂(1.000.000) ≈ 20** comparações.

### 📌 Exemplo de Implementação

```python
def busca_binaria(lista, alvo):
    inicio, fim = 0, len(lista) - 1

    while inicio <= fim:
        meio = (inicio + fim) // 2  # Pega o meio da lista
        if lista[meio] == alvo:
            return meio  # Encontrou o elemento
        elif lista[meio] < alvo:
            inicio = meio + 1  # Busca na metade superior
        else:
            fim = meio - 1  # Busca na metade inferior

    return -1  # Elemento não encontrado

# Testando a busca binária
numeros = [1, 3, 5, 7, 9, 11, 13, 15]
print(busca_binaria(numeros, 7))  # Saída: 3 (índice do número 7)
```

### 📌 Comparação com Busca Linear

🔺 **Busca Linear** → Percorre a lista elemento por elemento (**O(n)**).  
🔹 **Busca Binária** → Divide a lista pela metade a cada passo (**O(log n)**).

### 📌 Exemplo de Comparação

Para encontrar um número em uma lista de **1.000.000** elementos:  
✅ **Busca Linear** pode exigir até **1.000.000** passos.  
✅ **Busca Binária** faz isso em **≈20 passos**!

### 📌 Quando Usar a Busca Binária?

✔ Quando os dados estão **ordenados**.  
✔ Quando a lista é **muito grande** e eficiência é importante.  
❌ Não funciona bem para **listas desordenadas** (precisaria ordenar antes).

### 📌 Conclusão

A Busca Binária é um algoritmo poderoso para encontrar elementos rapidamente em listas ordenadas. Sua eficiência cresce conforme o tamanho da entrada aumenta, tornando-se muito superior à busca linear para grandes conjuntos de dados. 🚀