## [PT/BR]

### O Problema

Dado um array de inteiros `nums` e um inteiro `k`, precisamos determinar o número mínimo de operações necessárias para tornar todos os elementos do array iguais a `k`. Cada operação consiste em:

1. Escolher um inteiro válido `h` (onde todos elementos > h são iguais entre si)
2. Substituir todos elementos > h por h

Se for impossível tornar todos elementos iguais a `k`, devemos retornar -1.

### Raciocínio

1. **Verificação Inicial**:
   - Se qualquer elemento for menor que `k`, é impossível alcançar o objetivo (retorna -1)
   - Elementos iguais a `k` não requerem operações

2. **Contagem de Operações**:
   - Para elementos maiores que `k`, precisamos de uma operação para cada valor distinto
   - Usamos máscaras de bits para rastrear eficientemente valores distintos
     - `mask1` para valores entre 1-64
     - `mask2` para valores entre 65-100

3. **Eficiência**:
   - A abordagem com máscaras de bits permite verificação e contagem eficiente
   - Complexidade O(n) pois percorremos o array apenas uma vez

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array uma vez
- **Espaço**: O(1) - Usamos apenas algumas variáveis auxiliares

### Solução em Código

```swift
import Foundation

class Solution {
    func minOperations(_ nums: [Int], _ k: Int) -> Int {
        var mask1: UInt64 = 0  // Para valores 1-64
        var mask2: UInt64 = 0  // Para valores 65-100
        var operationCount = 0

        for num in nums {
            // Verifica se é possível alcançar k
            if num < k {
                return -1
            }

            // Só processa elementos maiores que k
            if num > k {
                if num <= 64 {
                    let bit: UInt64 = 1 << (num - 1)
                    if (mask1 & bit) == 0 {  // Se o bit ainda não estava setado
                        mask1 |= bit         // Marca o bit
                        operationCount += 1  // Conta como nova operação
                    }
                } else {  // Para valores 65-100
                    let bit: UInt64 = 1 << (num - 65)
                    if (mask2 & bit) == 0 {
                        mask2 |= bit
                        operationCount += 1
                    }
                }
            }
        }

        return operationCount
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [5,2,5,4,5]`, `k = 2`  
**Output**: `2`  
**Explicação**:
- Valores distintos > 2: 5 e 4
- Necessárias 2 operações (uma para cada valor distinto)

#### Exemplo 2:
**Input**: `nums = [2,1,2]`, `k = 2`  
**Output**: `-1`  
**Explicação**:
- O valor 1 < k, impossível alcançar o objetivo

#### Exemplo 3:
**Input**: `nums = [9,7,5,3]`, `k = 1`  
**Output**: `4`  
**Explicação**:
- Valores distintos > 1: 9,7,5,3
- Necessárias 4 operações (uma para cada valor distinto)

### Conclusão

Esta solução eficiente determina o número mínimo de operações necessárias usando máscaras de bits para rastrear valores distintos, garantindo performance ótima mesmo para os casos limite.

---

## [EN]

### The Problem

Given an integer array `nums` and an integer `k`, we need to determine the minimum number of operations required to make all array elements equal to `k`. Each operation consists of:

1. Choosing a valid integer `h` (where all elements > h are equal)
2. Replacing all elements > h with h

If it's impossible to make all elements equal to `k`, return -1.

### Reasoning

1. **Initial Check**:
   - If any element is less than `k`, the goal is impossible (return -1)
   - Elements equal to `k` require no operations

2. **Operation Counting**:
   - For elements greater than `k`, we need one operation per distinct value
   - Use bit masks to efficiently track distinct values
     - `mask1` for values 1-64
     - `mask2` for values 65-100

3. **Efficiency**:
   - Bitmask approach allows efficient checking and counting
   - O(n) complexity as we traverse the array only once

### Complexity Analysis

- **Time**: O(n) - Single array traversal
- **Space**: O(1) - Constant extra space used

### Code Solution

```swift
import Foundation

class Solution {
    func minOperations(_ nums: [Int], _ k: Int) -> Int {
        var mask1: UInt64 = 0  // For values 1-64
        var mask2: UInt64 = 0  // For values 65-100
        var operationCount = 0

        for num in nums {
            // Check if k is achievable
            if num < k {
                return -1
            }

            // Only process elements > k
            if num > k {
                if num <= 64 {
                    let bit: UInt64 = 1 << (num - 1)
                    if (mask1 & bit) == 0 {  // If bit not already set
                        mask1 |= bit         // Set the bit
                        operationCount += 1  // Count as new operation
                    }
                } else {  // For values 65-100
                    let bit: UInt64 = 1 << (num - 65)
                    if (mask2 & bit) == 0 {
                        mask2 |= bit
                        operationCount += 1
                    }
                }
            }
        }

        return operationCount
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [5,2,5,4,5]`, `k = 2`  
**Output**: `2`  
**Explanation**:
- Distinct values > 2: 5 and 4
- Requires 2 operations (one per distinct value)

#### Example 2:
**Input**: `nums = [2,1,2]`, `k = 2`  
**Output**: `-1`  
**Explanation**:
- Value 1 < k, goal impossible

#### Example 3:
**Input**: `nums = [9,7,5,3]`, `k = 1`  
**Output**: `4`  
**Explanation**:
- Distinct values > 1: 9,7,5,3
- Requires 4 operations (one per distinct value)

### Conclusion

This efficient solution determines the minimum operations needed using bitmasks to track distinct values, ensuring optimal performance even for edge cases. The approach guarantees correctness while maintaining linear time complexity.