## [PT/BR]

### O Problema

Dado um array de inteiros `nums`, precisamos determinar se é possível particionar o array em dois subconjuntos cujas somas sejam iguais.

### Raciocínio

1. **Verificação Inicial**:
   - Calculamos a soma total do array
   - Se a soma for ímpar, é impossível dividir em dois subconjuntos de soma igual (retornamos `false`)

2. **Definindo o Alvo**:
   - Se a soma for par, nosso alvo será `soma_total / 2`
   - O problema se reduz a encontrar um subconjunto que some exatamente esse valor

3. **Programação Dinâmica**:
   - Usamos um array `dp` onde `dp[s]` indica se a soma `s` pode ser alcançada
   - Inicializamos `dp[0]` como `true` (soma zero sempre possível)
   - Para cada número, atualizamos `dp` verificando se podemos alcançar a soma `s` incluindo ou não o número atual

### Análise da Complexidade

- **Tempo**: O(n × targetSum) - Onde n é o tamanho do array e targetSum é metade da soma total
- **Espaço**: O(targetSum) - Para o array dp

### Solução em Código

```swift
import Foundation

class Solution {
    func canPartition(_ nums: [Int]) -> Bool {
        let totalSum = nums.reduce(0, +)
        
        // Caso a soma total seja ímpar, retornamos false
        if totalSum % 2 != 0 {
            return false
        }
        
        let targetSum = totalSum / 2
        var dp = Array(repeating: false, count: targetSum + 1)
        dp[0] = true  // Base case: soma zero sempre possível
        
        for num in nums {
            // Percorremos de trás para frente para evitar reuso do mesmo elemento
            for s in stride(from: targetSum, through: num, by: -1) {
                // Atualizamos dp[s] verificando se podemos alcançar a soma
                // com ou sem o número atual
                dp[s] = dp[s] || dp[s - num]
            }
        }
        
        return dp[targetSum]
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [1,5,11,5]`  
**Output**: `true`  
**Explicação**:
- Soma total = 22 (par)
- Alvo = 11
- Podemos formar 11 com [1,5,5]

#### Exemplo 2:
**Input**: `nums = [1,2,3,5]`  
**Output**: `false`  
**Explicação**:
- Soma total = 11 (ímpar)
- Retorna false imediatamente

### Conclusão

Esta solução utiliza programação dinâmica para resolver eficientemente o problema de particionamento, verificando primeiro a possibilidade matemática e depois buscando um subconjunto que atinja a soma desejada.

---

## [EN]

### The Problem

Given an integer array `nums`, we need to determine if it can be partitioned into two subsets with equal sums.

### Reasoning

1. **Initial Check**:
   - Calculate the total sum of the array
   - If the sum is odd, equal partition is impossible (return `false`)

2. **Target Definition**:
   - If sum is even, our target becomes `total_sum / 2`
   - The problem reduces to finding a subset that sums exactly to this target

3. **Dynamic Programming**:
   - Use a `dp` array where `dp[s]` indicates if sum `s` can be reached
   - Initialize `dp[0]` as `true` (zero sum is always possible)
   - For each number, update `dp` checking if we can reach sum `s` by including/excluding the current number

### Complexity Analysis

- **Time**: O(n × targetSum) - Where n is array length and targetSum is half of total sum
- **Space**: O(targetSum) - For the dp array

### Code Solution

```swift
import Foundation

class Solution {
    func canPartition(_ nums: [Int]) -> Bool {
        let totalSum = nums.reduce(0, +)
        
        // If total sum is odd, return false immediately
        if totalSum % 2 != 0 {
            return false
        }
        
        let targetSum = totalSum / 2
        var dp = Array(repeating: false, count: targetSum + 1)
        dp[0] = true  // Base case: zero sum always possible
        
        for num in nums {
            // Iterate backwards to avoid reusing same element
            for s in stride(from: targetSum, through: num, by: -1) {
                // Update dp[s] checking if we can reach the sum
                // with or without current number
                dp[s] = dp[s] || dp[s - num]
            }
        }
        
        return dp[targetSum]
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [1,5,11,5]`  
**Output**: `true`  
**Explanation**:
- Total sum = 22 (even)
- Target = 11
- Can form 11 with [1,5,5]

#### Example 2:
**Input**: `nums = [1,2,3,5]`  
**Output**: `false`  
**Explanation**:
- Total sum = 11 (odd)
- Returns false immediately

### Conclusion

This solution efficiently solves the partition problem using dynamic programming, first checking mathematical possibility then searching for a subset that reaches the target sum.