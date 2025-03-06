## [PT/BR]

### O Problema

Dada uma matriz 2D de inteiros `grid` de tamanho \( n \times n \), onde cada valor está no intervalo \([1, n^2]\), cada número aparece exatamente uma vez, exceto por um número \( a \) que aparece duas vezes e um número \( b \) que está faltando. A tarefa é encontrar os números repetido (\( a \)) e faltante (\( b \)).

Retorne um array de inteiros `ans` de tamanho 2, onde `ans[0]` é o número repetido \( a \) e `ans[1]` é o número faltante \( b \).

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: A matriz contém todos os números no intervalo \([1, n^2]\), exceto por um número que está faltando e um número que aparece duas vezes. Isso sugere que podemos usar a soma e a soma dos quadrados dos números para identificar \( a \) e \( b \).

2. **Abordagem matemática**:
   - Calcule a soma esperada de todos os números no intervalo \([1, n^2]\).
   - Calcule a soma real dos números na matriz.
   - A diferença entre a soma esperada e a soma real nos dá \( b - a \).
   - Repita o processo para a soma dos quadrados dos números para obter \( b^2 - a^2 \).
   - Resolva as equações para encontrar \( a \) e \( b \).

3. **Implementação**:
   - Use um conjunto para identificar o número repetido \( a \).
   - Calcule o número faltante \( b \) usando a diferença entre a soma esperada e a soma real, ajustada pelo número repetido.

4. **Otimização**: A abordagem é eficiente, pois percorre a matriz uma única vez e utiliza operações matemáticas simples.

### Análise da Complexidade

- **Complexidade de tempo**: \( O(n^2) \), onde \( n \) é o tamanho da matriz.
  - Percorremos a matriz uma vez para calcular a soma e identificar o número repetido.
  
- **Complexidade de espaço**: \( O(n^2) \)
  - Usamos um conjunto para armazenar os números já vistos, que pode conter até \( n^2 \) elementos.

### Solução em Código

```python
class Solution:
    def findMissingAndRepeatedValues(self, grid: List[List[int]]) -> List[int]:
        n = len(grid)
        total_numbers = n * n
        expected_sum = total_numbers * (total_numbers + 1) // 2  # Soma esperada de 1 a n^2
        actual_sum = 0
        seen = set()
        a = 0
        
        # Percorre a matriz para calcular a soma real e encontrar o número repetido
        for row in grid:
            for num in row:
                actual_sum += num
                if num in seen:
                    a = num
                seen.add(num)
        
        # Calcula o número faltante b
        b = expected_sum - (actual_sum - a)
        
        return [a, b]
```

### Exemplos

#### Exemplo 1:
**Input**: grid = [[1,3],[2,2]]  
**Output**: [2,4]  
**Explicação**:  
- O número 2 aparece duas vezes.  
- O número 4 está faltando.  
- Cálculo:  
  - Soma esperada: \( 1 + 2 + 3 + 4 = 10 \).  
  - Soma real: \( 1 + 3 + 2 + 2 = 8 \).  
  - Diferença: \( 10 - 8 = 2 \).  
  - Número faltante: \( 4 \).

#### Exemplo 2:
**Input**: grid = [[9,1,7],[8,9,2],[3,4,6]]  
**Output**: [9,5]  
**Explicação**:  
- O número 9 aparece duas vezes.  
- O número 5 está faltando.  
- Cálculo:  
  - Soma esperada: \( 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 = 45 \).  
  - Soma real: \( 9 + 1 + 7 + 8 + 9 + 2 + 3 + 4 + 6 = 49 \).  
  - Diferença: \( 45 - 49 = -4 \).  
  - Número faltante: \( 5 \).

### Conclusão

A solução é eficiente e utiliza uma abordagem matemática para identificar o número repetido e o número faltante. Ao calcular as somas esperadas e reais, conseguimos resolver o problema com complexidade de tempo \( O(n^2) \).

---

## [EN]

### The Problem

Given a 0-indexed 2D integer matrix `grid` of size \( n \times n \), where each value is in the range \([1, n^2]\), each number appears exactly once, except for one number \( a \) that appears twice and one number \( b \) that is missing. The task is to find the repeating number \( a \) and the missing number \( b \).

Return a 0-indexed integer array `ans` of size 2, where `ans[0]` is the repeating number \( a \) and `ans[1]` is the missing number \( b \).

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: The matrix contains all numbers in the range \([1, n^2]\), except for one missing number and one number that appears twice. This suggests that we can use the sum and the sum of squares of the numbers to identify \( a \) and \( b \).

2. **Mathematical approach**:
   - Calculate the expected sum of all numbers in the range \([1, n^2]\).
   - Calculate the actual sum of the numbers in the matrix.
   - The difference between the expected sum and the actual sum gives \( b - a \).
   - Repeat the process for the sum of squares of the numbers to get \( b^2 - a^2 \).
   - Solve the equations to find \( a \) and \( b \).

3. **Implementation**:
   - Use a set to identify the repeating number \( a \).
   - Calculate the missing number \( b \) using the difference between the expected sum and the actual sum, adjusted by the repeating number.

4. **Optimization**: The approach is efficient, as it traverses the matrix once and uses simple mathematical operations.

### Complexity Analysis

- **Time complexity**: \( O(n^2) \), where \( n \) is the size of the matrix.
  - We traverse the matrix once to calculate the sum and identify the repeating number.
  
- **Space complexity**: \( O(n^2) \)
  - We use a set to store the seen numbers, which can contain up to \( n^2 \) elements.

### Code Solution

```python
class Solution:
    def findMissingAndRepeatedValues(self, grid: List[List[int]]) -> List[int]:
        n = len(grid)
        total_numbers = n * n
        expected_sum = total_numbers * (total_numbers + 1) // 2  # Expected sum from 1 to n^2
        actual_sum = 0
        seen = set()
        a = 0
        
        # Traverse the matrix to calculate the actual sum and find the repeating number
        for row in grid:
            for num in row:
                actual_sum += num
                if num in seen:
                    a = num
                seen.add(num)
        
        # Calculate the missing number b
        b = expected_sum - (actual_sum - a)
        
        return [a, b]
```

### Examples

#### Example 1:
**Input**: grid = [[1,3],[2,2]]  
**Output**: [2,4]  
**Explanation**:  
- The number 2 appears twice.  
- The number 4 is missing.  
- Calculation:  
  - Expected sum: \( 1 + 2 + 3 + 4 = 10 \).  
  - Actual sum: \( 1 + 3 + 2 + 2 = 8 \).  
  - Difference: \( 10 - 8 = 2 \).  
  - Missing number: \( 4 \).

#### Example 2:
**Input**: grid = [[9,1,7],[8,9,2],[3,4,6]]  
**Output**: [9,5]  
**Explanation**:  
- The number 9 appears twice.  
- The number 5 is missing.  
- Calculation:  
  - Expected sum: \( 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 = 45 \).  
  - Actual sum: \( 9 + 1 + 7 + 8 + 9 + 2 + 3 + 4 + 6 = 49 \).  
  - Difference: \( 45 - 49 = -4 \).  
  - Missing number: \( 5 \).

### Conclusion

The solution is efficient and uses a mathematical approach to identify the repeating and missing numbers. By calculating the expected and actual sums, we can solve the problem with \( O(n^2) \) time complexity.