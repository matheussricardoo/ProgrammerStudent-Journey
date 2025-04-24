## [PT/BR]

### O Problema

Dado um inteiro `n`, precisamos agrupar todos os números de 1 a `n` de acordo com a soma de seus dígitos e retornar quantos grupos têm o maior tamanho.

### Raciocínio

1. **Cálculo da Soma dos Dígitos**:
   - Para cada número, calculamos a soma de seus dígitos
   - Exemplo: 13 → 1 + 3 = 4

2. **Agrupamento por Soma**:
   - Usamos um dicionário para mapear cada soma ao número de elementos no grupo
   - Exemplo: soma 1 → [1, 10], soma 2 → [2, 11], etc.

3. **Identificação dos Maiores Grupos**:
   - Encontramos o tamanho máximo entre todos os grupos
   - Contamos quantos grupos têm esse tamanho máximo

### Análise da Complexidade

- **Tempo**: O(n log n) - Para cada número, calculamos a soma dos dígitos (log n operações)
- **Espaço**: O(n) - Armazenamos os tamanhos dos grupos

### Solução em Código

```swift
import Foundation

class Solution {
    private func sumOfDigits(_ num: Int) -> Int {
        var sum = 0
        var currentNum = num
        while currentNum > 0 {
            sum += currentNum % 10
            currentNum /= 10
        }
        return sum
    }

    func countLargestGroup(_ n: Int) -> Int {
        var groupSizes = [Int: Int]()
        
        for i in 1...n {
            let sum = sumOfDigits(i)
            groupSizes[sum, default: 0] += 1
        }
        
        guard let maxSize = groupSizes.values.max() else {
            return 0
        }
        
        return groupSizes.values.filter { $0 == maxSize }.count
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `n = 13`  
**Output**: `4`  
**Explicação**:
- Grupos: [1,10], [2,11], [3,12], [4,13], [5], [6], [7], [8], [9]
- 4 grupos com 2 elementos cada (maior tamanho)

#### Exemplo 2:
**Input**: `n = 2`  
**Output**: `2`  
**Explicação**:
- Grupos: [1], [2]
- 2 grupos com 1 elemento cada (todos têm o maior tamanho)

### Conclusão

Esta solução eficiente agrupa números por soma de dígitos e conta quantos grupos têm o maior tamanho, usando operações simples e estrutura de dados otimizada.

---

## [EN]

### The Problem

Given an integer `n`, we need to group all numbers from 1 to `n` by the sum of their digits and return how many groups have the largest size.

### Reasoning

1. **Digit Sum Calculation**:
   - For each number, calculate the sum of its digits
   - Example: 13 → 1 + 3 = 4

2. **Grouping by Sum**:
   - Use a dictionary to map each sum to its group size
   - Example: sum 1 → [1, 10], sum 2 → [2, 11], etc.

3. **Identifying Largest Groups**:
   - Find the maximum group size
   - Count how many groups have this maximum size

### Complexity Analysis

- **Time**: O(n log n) - For each number, compute digit sum (log n operations)
- **Space**: O(n) - Store group sizes

### Code Solution

```swift
import Foundation

class Solution {
    private func sumOfDigits(_ num: Int) -> Int {
        var sum = 0
        var currentNum = num
        while currentNum > 0 {
            sum += currentNum % 10
            currentNum /= 10
        }
        return sum
    }

    func countLargestGroup(_ n: Int) -> Int {
        var groupSizes = [Int: Int]()
        
        for i in 1...n {
            let sum = sumOfDigits(i)
            groupSizes[sum, default: 0] += 1
        }
        
        guard let maxSize = groupSizes.values.max() else {
            return 0
        }
        
        return groupSizes.values.filter { $0 == maxSize }.count
    }
}
```

### Examples

#### Example 1:
**Input**: `n = 13`  
**Output**: `4`  
**Explanation**:
- Groups: [1,10], [2,11], [3,12], [4,13], [5], [6], [7], [8], [9]
- 4 groups with 2 elements each (largest size)

#### Example 2:
**Input**: `n = 2`  
**Output**: `2`  
**Explanation**:
- Groups: [1], [2]
- 2 groups with 1 element each (all have largest size)

### Conclusion

This efficient solution groups numbers by digit sum and counts how many groups have the largest size, using simple operations and optimized data structure.