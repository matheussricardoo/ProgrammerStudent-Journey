## [PT/BR]

### O Problema

Dada uma grade 2D de tamanho `m x n` e um inteiro `x`, em cada operação você pode adicionar ou subtrair `x` de qualquer elemento da grade. O objetivo é transformar a grade em uma "uni-value grid", onde todos os elementos são iguais. Retorne o número mínimo de operações necessárias ou `-1` se não for possível.

### Raciocínio

1. **Viabilidade**:  
   Todos os elementos da grade devem ter o mesmo resto quando divididos por `x`. Por exemplo, se `x = 2`, todos os elementos devem ser pares ou todos ímpares. Se algum elemento tiver um resto diferente, é impossível alcançar uma "uni-value grid".

2. **Escolha do Valor Alvo**:  
   O valor alvo ideal é a **mediana** dos elementos. A mediana minimiza a soma das diferenças absolutas, o que é crucial para minimizar as operações, já que cada operação altera o valor em `x`.

3. **Cálculo das Operações**:  
   Para cada elemento, calcula-se a diferença absoluta entre o elemento e a mediana. Essa diferença é dividida por `x` para determinar o número de operações necessárias. A soma desses valores resulta no total de operações.

### Análise da Complexidade

- **Tempo**:  
  Achatamento da grade: `O(m*n)`.  
  Verificação de restos: `O(m*n)`.  
  Ordenação da lista: `O(k log k)` (onde `k = m*n`).  
  Cálculo das operações: `O(k)`.  
  **Total**: `O(k log k)` (dominado pela ordenação).

- **Espaço**:  
  `O(k)` para armazenar a lista achatada.

### Solução em Código

```python
class Solution:
    def minOperations(self, grid: List[List[int]], x: int) -> int:
        # Passo 1: Achatar a grade em uma lista 1D
        flat_grid = [cell for row in grid for cell in row]
        
        # Passo 2: Verificar congruência dos elementos (mesmo resto módulo x)
        mod = flat_grid[0] % x
        for num in flat_grid:
            if num % x != mod:
                return -1
        
        # Passo 3: Encontrar a mediana da lista ordenada
        flat_grid.sort()
        median = flat_grid[len(flat_grid) // 2]
        
        # Passo 4: Calcular o total de operações
        operations = 0
        for num in flat_grid:
            operations += abs(num - median) // x
        
        return operations
```

### Exemplos

#### Exemplo 1:
**Input**:  
`grid = [[2,4],[6,8]]`, `x = 2`.  
**Output**: `4`.  
**Explicação**:  
Todos elementos têm resto `0` módulo `2`. A mediana é `4`.  
Operações:  
- `2 → 4`: 1 operação.  
- `4 → 4`: 0 operações.  
- `6 → 4`: 1 operação.  
- `8 → 4`: 2 operações.  
Total: `1 + 0 + 1 + 2 = 4`.

#### Exemplo 2:
**Input**:  
`grid = [[1,5],[2,3]]`, `x = 1`.  
**Output**: `5`.  
**Explicação**:  
Todos elementos têm resto `0` módulo `1`. A mediana é `3`.  
Operações:  
- `1 → 3`: 2 operações.  
- `5 → 3`: 2 operações.  
- `2 → 3`: 1 operação.  
- `3 → 3`: 0 operações.  
Total: `2 + 2 + 1 + 0 = 5`.

#### Exemplo 3:
**Input**:  
`grid = [[1,2],[3,4]]`, `x = 2`.  
**Output**: `-1`.  
**Explicação**:  
Os restos módulo `2` são `1, 0, 1, 0`. Como há restos diferentes, é impossível.

### Conclusão

A solução utiliza a mediana para minimizar as operações e verifica a congruência dos elementos para garantir a viabilidade. A ordenação é o passo mais custoso, mas é eficiente para os limites do problema. A escolha da mediana garante o menor número de operações possíveis.

---

## [EN]

### The Problem

Given an `m x n` 2D integer grid and an integer `x`, in one operation, you can add `x` to or subtract `x` from any element in the grid. The goal is to transform the grid into a "uni-value grid" where all elements are equal. Return the minimum number of operations required, or `-1` if it is impossible.

### Reasoning

1. **Feasibility Check**:  
   All elements in the grid must have the same remainder when divided by `x`. For example, if `x = 2`, all elements must be even or all odd. If any element has a different remainder, achieving a uni-value grid is impossible.

2. **Choosing the Target Value**:  
   The optimal target value is the **median** of the elements. The median minimizes the sum of absolute differences, which is crucial for minimizing operations since each operation changes the value by `x`.

3. **Operation Calculation**:  
   For each element, compute the absolute difference between the element and the median. Divide this difference by `x` to determine the number of operations needed. Summing these values gives the total operations.

### Complexity Analysis

- **Time**:  
  Flattening the grid: `O(m*n)`.  
  Remainder check: `O(m*n)`.  
  Sorting the list: `O(k log k)` (where `k = m*n`).  
  Calculating operations: `O(k)`.  
  **Total**: `O(k log k)` (dominated by sorting).

- **Space**:  
  `O(k)` to store the flattened list.

### Code Solution

```python
class Solution:
    def minOperations(self, grid: List[List[int]], x: int) -> int:
        # Step 1: Flatten the grid into a 1D list
        flat_grid = [cell for row in grid for cell in row]
        
        # Step 2: Check modulo consistency
        mod = flat_grid[0] % x
        for num in flat_grid:
            if num % x != mod:
                return -1
        
        # Step 3: Find the median of the sorted list
        flat_grid.sort()
        median = flat_grid[len(flat_grid) // 2]
        
        # Step 4: Calculate total operations
        operations = 0
        for num in flat_grid:
            operations += abs(num - median) // x
        
        return operations
```

### Examples

#### Example 1:
**Input**:  
`grid = [[2,4],[6,8]]`, `x = 2`.  
**Output**: `4`.  
**Explanation**:  
All elements have remainder `0` modulo `2`. Median is `4`.  
Operations:  
- `2 → 4`: 1 operation.  
- `4 → 4`: 0 operations.  
- `6 → 4`: 1 operation.  
- `8 → 4`: 2 operations.  
Total: `1 + 0 + 1 + 2 = 4`.

#### Example 2:
**Input**:  
`grid = [[1,5],[2,3]]`, `x = 1`.  
**Output**: `5`.  
**Explanation**:  
All elements have remainder `0` modulo `1`. Median is `3`.  
Operations:  
- `1 → 3`: 2 operations.  
- `5 → 3`: 2 operations.  
- `2 → 3`: 1 operation.  
- `3 → 3`: 0 operations.  
Total: `2 + 2 + 1 + 0 = 5`.

#### Example 3:
**Input**:  
`grid = [[1,2],[3,4]]`, `x = 2`.  
**Output**: `-1`.  
**Explanation**:  
Remainders modulo `2` are `1, 0, 1, 0`. Different remainders make it impossible.

### Conclusion

The solution uses the median to minimize operations and checks element congruency for feasibility. Sorting is the most expensive step but remains efficient for the problem constraints. Choosing the median ensures the minimum possible operations.