## [PT/BR]

### O Problema

Dado um array de inteiros `nums` de comprimento `n` com um único elemento dominante, precisamos encontrar o índice mínimo de uma divisão válida. Um elemento `x` é considerado dominante em um subarray se mais da metade dos elementos desse subarray for igual a `x`. Uma divisão no índice `i` é válida se os subarrays resultantes `nums[0..i]` e `nums[i+1..n-1]` tiverem o mesmo elemento dominante que o array original `nums`.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Identificar o Elemento Dominante**: Primeiro, determinei o elemento dominante do array original `nums`. Esse elemento deve aparecer mais que a metade das vezes no array.

2. **Contagem de Ocorrências**: Calculei o número total de ocorrências do elemento dominante em `nums`.

3. **Prefix Sum Array**: Criei um array de prefix sums para contar as ocorrências do elemento dominante até cada índice. Isso permite verificar rapidamente quantas vezes o elemento dominante aparece em qualquer subarray.

4. **Verificar Divisões Válidas**: Para cada possível índice de divisão `i`, verifiquei se ambos os subarrays resultantes têm o elemento dominante como dominante. Isso é feito verificando se o número de ocorrências do elemento dominante em cada subarray é maior que metade do comprimento do subarray.

5. **Retornar o Índice Mínimo**: Se uma divisão válida for encontrada, retorne o índice mais baixo. Caso contrário, retorne -1.

### Análise da Complexidade

- **Complexidade de Tempo**:
  - Identificar o elemento dominante: \( O(n) \).
  - Contar ocorrências do elemento dominante: \( O(n) \).
  - Construir o array de prefix sums: \( O(n) \).
  - Verificar divisões válidas: \( O(n) \).
  - Total: \( O(n) \).

- **Complexidade de Espaço**: \( O(n) \), devido ao armazenamento do array de prefix sums.

### Solução em Código

```python
from typing import List

class Solution:
    def minimumIndex(self, nums: List[int]) -> int:
        # Passo 1: Encontrar o elemento dominante usando o algoritmo de Boyer-Moore
        count = 0
        candidate = None
        for num in nums:
            if count == 0:
                candidate = num
                count = 1
            else:
                count += 1 if num == candidate else -1
        
        # Passo 2: Verificar se o candidato é realmente o elemento dominante e contar suas ocorrências
        total_dom = 0
        for num in nums:
            if num == candidate:
                total_dom += 1
        
        n = len(nums)
        # Passo 3: Construir o array de prefix sums para as ocorrências do elemento dominante
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + (1 if nums[i] == candidate else 0)
        
        # Passo 4: Verificar cada possível índice de divisão
        for i in range(n - 1):
            left_len = i + 1
            left_count = prefix[i + 1]
            if left_count * 2 <= left_len:
                continue  # O subarray à esquerda não tem o elemento dominante
            
            right_len = n - left_len
            right_count = total_dom - left_count
            if right_count * 2 > right_len:
                return i  # Divisão válida encontrada
        
        return -1  # Nenhuma divisão válida encontrada
```

### Exemplos

#### Exemplo 1:
**Input**:  
```plaintext
nums = [1, 2, 2, 2]
```
**Output**:  
```plaintext
2
```
**Explicação**:
1. O elemento dominante é `2`.
2. A divisão no índice `2` resulta em `[1, 2, 2]` e `[2]`.
   - Em `[1, 2, 2]`, `2` aparece 2 vezes, e \( 2 > 3/2 \).
   - Em `[2]`, `2` aparece 1 vez, e \( 1 > 1/2 \).
3. Ambos os subarrays têm `2` como elemento dominante.

#### Exemplo 2:
**Input**:  
```plaintext
nums = [2, 1, 3, 1, 1, 1, 7, 1, 2, 1]
```
**Output**:  
```plaintext
4
```
**Explicação**:
1. O elemento dominante é `1`.
2. A divisão no índice `4` resulta em `[2, 1, 3, 1, 1]` e `[1, 7, 1, 2, 1]`.
   - Em `[2, 1, 3, 1, 1]`, `1` aparece 3 vezes, e \( 3 > 5/2 \).
   - Em `[1, 7, 1, 2, 1]`, `1` aparece 3 vezes, e \( 3 > 5/2 \).
3. Ambos os subarrays têm `1` como elemento dominante.

#### Exemplo 3:
**Input**:  
```plaintext
nums = [3, 3, 3, 3, 7, 2, 2]
```
**Output**:  
```plaintext
-1
```
**Explicação**:
1. O elemento dominante é `3`.
2. Não há divisão que resulte em dois subarrays onde `3` seja dominante em ambos.

### Conclusão

A solução utiliza uma abordagem eficiente para identificar o elemento dominante e verificar divisões válidas em tempo linear. A complexidade de tempo \( O(n) \) e espaço \( O(n) \) tornam a solução adequada para entradas grandes.

---

## [EN]

### The Problem

Given an integer array `nums` of length `n` with a single dominant element, we need to find the minimum index of a valid split. An element `x` is considered dominant in a subarray if more than half of the elements in that subarray are equal to `x`. A split at index `i` is valid if the resulting subarrays `nums[0..i]` and `nums[i+1..n-1]` have the same dominant element as the original array `nums`.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Identify the Dominant Element**: First, I determined the dominant element of the original array `nums`. This element must appear more than half the time in the array.

2. **Count Occurrences**: I calculated the total number of occurrences of the dominant element in `nums`.

3. **Prefix Sum Array**: I created a prefix sum array to count the occurrences of the dominant element up to each index. This allows quick verification of how many times the dominant element appears in any subarray.

4. **Check Valid Splits**: For each possible split index `i`, I checked if both resulting subarrays have the dominant element as their dominant. This is done by verifying if the number of occurrences of the dominant element in each subarray is greater than half the length of the subarray.

5. **Return the Minimum Index**: If a valid split is found, return the lowest index. Otherwise, return -1.

### Complexity Analysis

- **Time Complexity**:
  - Identifying the dominant element: \( O(n) \).
  - Counting dominant element occurrences: \( O(n) \).
  - Building the prefix sum array: \( O(n) \).
  - Checking valid splits: \( O(n) \).
  - Total: \( O(n) \).

- **Space Complexity**: \( O(n) \), due to storing the prefix sum array.

### Code Solution

```python
from typing import List

class Solution:
    def minimumIndex(self, nums: List[int]) -> int:
        # Step 1: Find the dominant element using Boyer-Moore algorithm
        count = 0
        candidate = None
        for num in nums:
            if count == 0:
                candidate = num
                count = 1
            else:
                count += 1 if num == candidate else -1
        
        # Step 2: Verify the candidate is the dominant element and count its occurrences
        total_dom = 0
        for num in nums:
            if num == candidate:
                total_dom += 1
        
        n = len(nums)
        # Step 3: Build the prefix sum array for dominant element occurrences
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + (1 if nums[i] == candidate else 0)
        
        # Step 4: Check each possible split index
        for i in range(n - 1):
            left_len = i + 1
            left_count = prefix[i + 1]
            if left_count * 2 <= left_len:
                continue  # Left subarray does not have the dominant element
            
            right_len = n - left_len
            right_count = total_dom - left_count
            if right_count * 2 > right_len:
                return i  # Valid split found
        
        return -1  # No valid split found
```

### Examples

#### Example 1:
**Input**:  
```plaintext
nums = [1, 2, 2, 2]
```
**Output**:  
```plaintext
2
```
**Explanation**:
1. The dominant element is `2`.
2. Splitting at index `2` results in `[1, 2, 2]` and `[2]`.
   - In `[1, 2, 2]`, `2` appears 2 times, and \( 2 > 3/2 \).
   - In `[2]`, `2` appears 1 time, and \( 1 > 1/2 \).
3. Both subarrays have `2` as the dominant element.

#### Example 2:
**Input**:  
```plaintext
nums = [2, 1, 3, 1, 1, 1, 7, 1, 2, 1]
```
**Output**:  
```plaintext
4
```
**Explanation**:
1. The dominant element is `1`.
2. Splitting at index `4` results in `[2, 1, 3, 1, 1]` and `[1, 7, 1, 2, 1]`.
   - In `[2, 1, 3, 1, 1]`, `1` appears 3 times, and \( 3 > 5/2 \).
   - In `[1, 7, 1, 2, 1]`, `1` appears 3 times, and \( 3 > 5/2 \).
3. Both subarrays have `1` as the dominant element.

#### Example 3:
**Input**:  
```plaintext
nums = [3, 3, 3, 3, 7, 2, 2]
```
**Output**:  
```plaintext
-1
```
**Explanation**:
1. The dominant element is `3`.
2. There is no split that results in two subarrays where `3` is dominant in both.

### Conclusion

The solution uses an efficient approach to identify the dominant element and check valid splits in linear time. The time complexity \( O(n) \) and space complexity \( O(n) \) make the solution suitable for large inputs.