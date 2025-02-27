## [PT/BR]

### O Problema

Dado um array estritamente crescente de inteiros positivos, precisamos encontrar o comprimento da subsequência Fibonacci-like mais longa.

Uma sequência é considerada Fibonacci-like se:
- Possui pelo menos 3 elementos
- Para cada elemento à partir do terceiro: x_i + x_{i+1} = x_{i+2}

Uma subsequência é obtida ao remover zero ou mais elementos da sequência original, mantendo a ordem dos elementos restantes.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: Uma subsequência Fibonacci-like é completamente determinada pelos seus dois primeiros elementos.

2. **Abordagem bruta**: Poderíamos testar todos os pares possíveis (a, b) do array como primeiros elementos e verificar se conseguimos estender a sequência.

3. **Eficiência na busca**: Para verificar rapidamente se o próximo elemento existe no array, podemos usar um conjunto (set) para lookups em O(1).

4. **Implementação**:
   - Para cada par (arr[i], arr[j]) onde i < j:
     - Definimos a = arr[i] e b = arr[j]
     - Procuramos se a + b existe no array
     - Se existir, continuamos a busca com b e a + b
     - Seguimos esse processo até não conseguirmos mais estender a sequência
     - Mantemos o controle do comprimento máximo encontrado

5. **Otimização**: Usando um dicionário para mapear valores aos seus índices, podemos fazer lookups eficientes por valor.

### Análise da Complexidade

- **Complexidade de tempo**: O(n²), onde n é o comprimento do array
  - Precisamos testar todos os pares possíveis (n*(n-1)/2 pares)
  - Para cada par, o processo de extensão da sequência é O(n) no pior caso
  
- **Complexidade de espaço**: O(n)
  - Armazenamos todos os elementos em um conjunto e em um dicionário

### Solução em Código

```python
def lenLongestFibSubseq(self, arr: List[int]) -> int:
    n = len(arr)
    
    # Criar um conjunto de todos os elementos para busca rápida
    s = set(arr)
    
    # Criar um dicionário para armazenar o índice de cada elemento
    # Isso ajuda com buscas rápidas por valor
    index = {arr[i]: i for i in range(n)}
    
    max_length = 0
    
    # Tentar todos os pares possíveis como pontos de partida
    for i in range(n):
        for j in range(i + 1, n):
            # Temos os dois primeiros elementos: arr[i] e arr[j]
            a, b = arr[i], arr[j]
            length = 2  # Começar com 2 elementos (a, b)
            
            # Tentar estender a sequência
            while a + b in s:
                # Mover para o próximo par na sequência
                a, b = b, a + b
                length += 1
                
                # Atualizar max_length se encontramos uma sequência mais longa
                max_length = max(max_length, length)
    
    # Retornar 0 se nenhuma subsequência Fibonacci-like de comprimento pelo menos 3 for encontrada
    return max_length if max_length >= 3 else 0
```

### Exemplos

#### Exemplo 1:
**Input**: arr = [1,2,3,4,5,6,7,8]
**Output**: 5
**Explicação**: A subsequência mais longa que é Fibonacci-like é [1,2,3,5,8].

Passo a passo:
1. Começamos com (1,2)
2. 1+2=3, que está no array → [1,2,3]
3. 2+3=5, que está no array → [1,2,3,5]
4. 3+5=8, que está no array → [1,2,3,5,8]
5. 5+8=13, que não está no array → paramos

#### Exemplo 2:
**Input**: arr = [1,3,7,11,12,14,18]
**Output**: 3
**Explicação**: As subsequências mais longas que são Fibonacci-like são [1,11,12], [3,11,14] ou [7,11,18].

Por exemplo, com [1,11,12]:
1. Começamos com (1,11)
2. 1+11=12, que está no array → [1,11,12]
3. 11+12=23, que não está no array → paramos

### Conclusão

A solução é eficiente e usa propriedades fundamentais das sequências Fibonacci-like para encontrar a subsequência mais longa. Ao testar sistematicamente todos os pares possíveis e usar estruturas de dados eficientes para busca, conseguimos resolver o problema com complexidade de tempo O(n²).

---

## [EN]

### The Problem

Given a strictly increasing array of positive integers, we need to find the length of the longest Fibonacci-like subsequence.

A sequence is considered Fibonacci-like if:
- It has at least 3 elements
- For each element starting from the third: x_i + x_{i+1} = x_{i+2}

A subsequence is derived by removing zero or more elements from the original sequence while preserving the order of the remaining elements.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: A Fibonacci-like subsequence is fully determined by its first two elements.

2. **Brute force approach**: We could test all possible pairs (a, b) from the array as starting elements and check if we can extend the sequence.

3. **Search efficiency**: To quickly check if the next element exists in the array, we can use a set for O(1) lookups.

4. **Implementation**:
   - For each pair (arr[i], arr[j]) where i < j:
     - Set a = arr[i] and b = arr[j]
     - Check if a + b exists in the array
     - If it does, continue the search with b and a + b
     - Follow this process until we can't extend the sequence anymore
     - Keep track of the maximum length found

5. **Optimization**: Using a dictionary to map values to their indices, we can do efficient lookups by value.

### Complexity Analysis

- **Time complexity**: O(n²), where n is the length of the array
  - We need to test all possible pairs (n*(n-1)/2 pairs)
  - For each pair, the process of extending the sequence is O(n) in the worst case
  
- **Space complexity**: O(n)
  - We store all elements in a set and in a dictionary

### Code Solution

```python
def lenLongestFibSubseq(self, arr: List[int]) -> int:
    n = len(arr)
    
    # Create a set of all elements for quick lookup
    s = set(arr)
    
    # Create a dictionary to store the index of each element
    # This helps with quick lookups by value
    index = {arr[i]: i for i in range(n)}
    
    max_length = 0
    
    # Try all possible pairs as starting points
    for i in range(n):
        for j in range(i + 1, n):
            # We have the first two elements: arr[i] and arr[j]
            a, b = arr[i], arr[j]
            length = 2  # Start with 2 elements (a, b)
            
            # Try to extend the sequence
            while a + b in s:
                # Move to the next pair in the sequence
                a, b = b, a + b
                length += 1
                
                # Update max_length if we found a longer sequence
                max_length = max(max_length, length)
    
    # Return 0 if no Fibonacci-like subsequence of length at least 3 was found
    return max_length if max_length >= 3 else 0
```

### Examples

#### Example 1:
**Input**: arr = [1,2,3,4,5,6,7,8]
**Output**: 5
**Explanation**: The longest subsequence that is Fibonacci-like is [1,2,3,5,8].

Step by step:
1. Start with (1,2)
2. 1+2=3, which is in the array → [1,2,3]
3. 2+3=5, which is in the array → [1,2,3,5]
4. 3+5=8, which is in the array → [1,2,3,5,8]
5. 5+8=13, which is not in the array → stop

#### Example 2:
**Input**: arr = [1,3,7,11,12,14,18]
**Output**: 3
**Explanation**: The longest subsequences that are Fibonacci-like are [1,11,12], [3,11,14], or [7,11,18].

For example, with [1,11,12]:
1. Start with (1,11)
2. 1+11=12, which is in the array → [1,11,12]
3. 11+12=23, which is not in the array → stop

### Conclusion

The solution is efficient and uses fundamental properties of Fibonacci-like sequences to find the longest subsequence. By systematically testing all possible pairs and using efficient data structures for lookups, we can solve the problem with O(n²) time complexity.