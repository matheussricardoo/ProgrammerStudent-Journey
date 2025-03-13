## [PT/BR]

### O Problema

Dado um array `nums` ordenado em ordem não decrescente, precisamos retornar o máximo entre o número de inteiros positivos e o número de inteiros negativos no array. O valor zero não é considerado nem positivo nem negativo.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: O array está ordenado em ordem não decrescente, o que permite usar técnicas de busca binária para encontrar os pontos de transição entre números negativos e positivos de forma eficiente.

2. **Abordagem eficiente**: Utilizei a **busca binária** para encontrar:
   - O primeiro índice onde o elemento é maior ou igual a zero (fim dos números negativos).
   - O primeiro índice onde o elemento é maior que zero (início dos números positivos).

3. **Implementação**:
   - Usei a função `bisect_left` para encontrar o número de elementos negativos.
   - Usei a função `bisect_right` para encontrar o número de elementos positivos.
   - Retornei o máximo entre os dois valores.

4. **Otimização**: A busca binária garante uma complexidade de tempo \( O(\log n) \), onde \( n \) é o comprimento do array. Isso é eficiente e atende ao requisito de otimização.

### Análise da Complexidade

- **Complexidade de tempo**: \( O(\log n) \), devido ao uso de busca binária.
- **Complexidade de espaço**: \( O(1) \), pois usamos apenas algumas variáveis para armazenar os resultados.

### Solução em Código

```python
import bisect

class Solution:
    def maximumCount(self, nums: List[int]) -> int:
        # Conta os números negativos usando o primeiro índice onde o elemento >= 0
        neg = bisect.bisect_left(nums, 0)
        # Conta os números positivos usando o primeiro índice onde o elemento > 0
        pos = len(nums) - bisect.bisect_right(nums, 0)
        # Retorna o máximo entre neg e pos
        return max(neg, pos)
```

### Exemplos

#### Exemplo 1:
**Input**: nums = [-2, -1, -1, 1, 2, 3]  
**Output**: 3  
**Explicação**:  
- Números negativos: 3 (índices 0, 1, 2).  
- Números positivos: 3 (índices 3, 4, 5).  
- O máximo entre 3 e 3 é 3.

#### Exemplo 2:
**Input**: nums = [-3, -2, -1, 0, 0, 1, 2]  
**Output**: 3  
**Explicação**:  
- Números negativos: 3 (índices 0, 1, 2).  
- Números positivos: 2 (índices 5, 6).  
- O máximo entre 3 e 2 é 3.

#### Exemplo 3:
**Input**: nums = [5, 20, 66, 1314]  
**Output**: 4  
**Explicação**:  
- Números negativos: 0.  
- Números positivos: 4 (índices 0, 1, 2, 3).  
- O máximo entre 0 e 4 é 4.

### Conclusão

A solução é eficiente e utiliza busca binária para encontrar os pontos de transição entre números negativos e positivos. Ao calcular o número de elementos negativos e positivos de forma otimizada, garantimos que o problema seja resolvido com complexidade de tempo \( O(\log n) \).

---

## [EN]

### The Problem

Given an array `nums` sorted in non-decreasing order, we need to return the maximum between the number of positive integers and the number of negative integers in the array. The value zero is neither positive nor negative.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: The array is sorted in non-decreasing order, which allows us to use binary search techniques to efficiently find the transition points between negative and positive numbers.

2. **Efficient approach**: I used **binary search** to find:
   - The first index where the element is greater than or equal to zero (end of negative numbers).
   - The first index where the element is greater than zero (start of positive numbers).

3. **Implementation**:
   - Used the `bisect_left` function to count the number of negative elements.
   - Used the `bisect_right` function to count the number of positive elements.
   - Returned the maximum of the two values.

4. **Optimization**: Binary search ensures a time complexity of \( O(\log n) \), where \( n \) is the length of the array. This is efficient and meets the optimization requirement.

### Complexity Analysis

- **Time complexity**: \( O(\log n) \), due to the use of binary search.
- **Space complexity**: \( O(1) \), as we only use a few variables to store the results.

### Code Solution

```python
import bisect

class Solution:
    def maximumCount(self, nums: List[int]) -> int:
        # Count negative numbers using the first index where element >= 0
        neg = bisect.bisect_left(nums, 0)
        # Count positive numbers using the first index where element > 0
        pos = len(nums) - bisect.bisect_right(nums, 0)
        # Return the maximum between neg and pos
        return max(neg, pos)
```

### Examples

#### Example 1:
**Input**: nums = [-2, -1, -1, 1, 2, 3]  
**Output**: 3  
**Explanation**:  
- Negative numbers: 3 (indices 0, 1, 2).  
- Positive numbers: 3 (indices 3, 4, 5).  
- The maximum between 3 and 3 is 3.

#### Example 2:
**Input**: nums = [-3, -2, -1, 0, 0, 1, 2]  
**Output**: 3  
**Explanation**:  
- Negative numbers: 3 (indices 0, 1, 2).  
- Positive numbers: 2 (indices 5, 6).  
- The maximum between 3 and 2 is 3.

#### Example 3:
**Input**: nums = [5, 20, 66, 1314]  
**Output**: 4  
**Explanation**:  
- Negative numbers: 0.  
- Positive numbers: 4 (indices 0, 1, 2, 3).  
- The maximum between 0 and 4 is 4.

### Conclusion

The solution is efficient and uses binary search to find the transition points between negative and positive numbers. By calculating the number of negative and positive elements optimally, we ensure the problem is solved with a time complexity of \( O(\log n) \).