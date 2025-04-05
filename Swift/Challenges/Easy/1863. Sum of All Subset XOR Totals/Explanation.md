## [PT/BR]

### O Problema

Dado um array `nums`, precisamos calcular a soma de todos os XOR totais para cada subconjunto possível de `nums`. O XOR total de um subconjunto é definido como o XOR bit a bit de todos os seus elementos, ou 0 se o subconjunto estiver vazio.

### Raciocínio

1. **Entendendo Subconjuntos e XOR**:
   - Um subconjunto é obtido removendo zero ou mais elementos do array original
   - O XOR total de um subconjunto é o resultado da operação XOR entre todos seus elementos
   - Precisamos considerar todos os 2^n subconjuntos possíveis (onde n é o tamanho do array)

2. **Otimização Matemática**:
   - Em vez de gerar todos subconjuntos (O(2^n)), podemos usar uma propriedade matemática:
     - Cada bit no resultado final é influenciado pelo OR bit a bit de todos números
     - O resultado final é igual a `OR_total * 2^(n-1)`
   - Isso reduz a complexidade para O(n)

3. **Implementação**:
   - Calculamos o OR bit a bit de todos elementos
   - Multiplicamos pelo fator `2^(n-1)`

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array uma vez para calcular o OR total
- **Espaço**: O(1) - Usamos apenas algumas variáveis auxiliares

### Solução em Código

```swift
import Foundation

class Solution {
    func subsetXORSum(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 0 {
            return 0
        }

        var orTotal = 0
        for num in nums {
            orTotal |= num
        }

        let multiplier = 1 << (n - 1)
        
        return orTotal * multiplier
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [1,3]`  
**Output**: `6`  
**Explicação**:
- OR total: 1 | 3 = 3
- Multiplicador: 2^(2-1) = 2
- Resultado: 3 * 2 = 6

#### Exemplo 2:
**Input**: `nums = [5,1,6]`  
**Output**: `28`  
**Explicação**:
- OR total: 5 | 1 | 6 = 7
- Multiplicador: 2^(3-1) = 4
- Resultado: 7 * 4 = 28

#### Exemplo 3:
**Input**: `nums = [3,4,5,6,7,8]`  
**Output**: `480`  
**Explicação**:
- OR total: 3 | 4 | 5 | 6 | 7 | 8 = 15
- Multiplicador: 2^(6-1) = 32
- Resultado: 15 * 32 = 480

### Conclusão

Esta solução inteligente aproveita propriedades matemáticas do XOR e OR bit a bit para calcular o resultado sem gerar explicitamente todos subconjuntos, tornando-a extremamente eficiente mesmo para os casos limite.

---

## [EN]

### The Problem

Given an array `nums`, we need to calculate the sum of all XOR totals for every possible subset of `nums`. The XOR total of a subset is defined as the bitwise XOR of all its elements, or 0 if the subset is empty.

### Reasoning

1. **Understanding Subsets and XOR**:
   - A subset is obtained by removing zero or more elements from the original array
   - The XOR total of a subset is the result of XOR operation between all its elements
   - We need to consider all 2^n possible subsets (where n is array length)

2. **Mathematical Optimization**:
   - Instead of generating all subsets (O(2^n)), we use a mathematical property:
     - Each bit in the final result is influenced by the bitwise OR of all numbers
     - The final result equals `OR_total * 2^(n-1)`
   - This reduces complexity to O(n)

3. **Implementation**:
   - Calculate the bitwise OR of all elements
   - Multiply by factor `2^(n-1)`

### Complexity Analysis

- **Time**: O(n) - Traverse array once to calculate OR total
- **Space**: O(1) - Use only a few helper variables

### Code Solution

```swift
import Foundation

class Solution {
    func subsetXORSum(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 0 {
            return 0
        }

        var orTotal = 0
        for num in nums {
            orTotal |= num
        }

        let multiplier = 1 << (n - 1)
        
        return orTotal * multiplier
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [1,3]`  
**Output**: `6`  
**Explanation**:
- OR total: 1 | 3 = 3
- Multiplier: 2^(2-1) = 2
- Result: 3 * 2 = 6

#### Example 2:
**Input**: `nums = [5,1,6]`  
**Output**: `28`  
**Explanation**:
- OR total: 5 | 1 | 6 = 7
- Multiplier: 2^(3-1) = 4
- Result: 7 * 4 = 28

#### Example 3:
**Input**: `nums = [3,4,5,6,7,8]`  
**Output**: `480`  
**Explanation**:
- OR total: 3 | 4 | 5 | 6 | 7 | 8 = 15
- Multiplier: 2^(6-1) = 32
- Result: 15 * 32 = 480

### Conclusion

This clever solution leverages mathematical properties of bitwise XOR and OR to compute the result without explicitly generating all subsets, making it extremely efficient even for edge cases.