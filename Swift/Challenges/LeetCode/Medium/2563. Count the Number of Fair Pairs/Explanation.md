## [PT/BR]

### O Problema

Dado um array de inteiros `nums` de tamanho `n` e dois inteiros `lower` e `upper`, precisamos retornar o número de pares justos. Um par `(i, j)` é considerado justo se:
1. `0 <= i < j < n`
2. `lower <= nums[i] + nums[j] <= upper`

### Raciocínio

1. **Ordenação do Array**:
   - Primeiro ordenamos o array para facilitar a contagem de pares
   - A ordenação permite usar a técnica de dois ponteiros

2. **Contagem de Pares**:
   - Usamos uma função auxiliar para contar pares com soma ≤ target
   - Calculamos:
     - Pares com soma ≤ upper
     - Pares com soma ≤ (lower - 1)
   - O resultado é a diferença entre esses dois valores

3. **Técnica de Dois Ponteiros**:
   - Ponteiro `left` no início e `right` no final
   - Movemos os ponteiros conforme a soma atual:
     - Se soma ≤ target: todos pares entre left e right são válidos
     - Senão: diminuímos `right` para reduzir a soma

### Análise da Complexidade

- **Tempo**: O(n log n) - Ordenação domina o tempo de execução
- **Espaço**: O(n) - Para armazenar o array ordenado (ou O(1) se ordenação in-place)

### Solução em Código

```swift
class Solution {
    private func countPairsLessOrEqualToTarget(_ sortedNums: [Int], _ target: Int) -> Int {
        let n = sortedNums.count
        var count = 0
        var left = 0
        var right = n - 1

        while left < right {
            let sum = sortedNums[left] + sortedNums[right]
            if sum <= target {
                count += right - left
                left += 1
            } else {
                right -= 1
            }
        }
        return count
    }

    func countFairPairs(_ nums: [Int], _ lower: Int, _ upper: Int) -> Int {
        let sortedNums = nums.sorted()
        let countUpper = countPairsLessOrEqualToTarget(sortedNums, upper)
        let countLower = countPairsLessOrEqualToTarget(sortedNums, lower - 1)
        return countUpper - countLower
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [0,1,7,4,4,5]`, `lower = 3`, `upper = 6`  
**Output**: `6`  
**Explicação**:
- Array ordenado: [0,1,4,4,5,7]
- Pares com soma ≤ 6: (0,1), (0,4), (0,4), (0,5), (1,4), (1,4), (1,5) → 7
- Pares com soma ≤ 2: (0,1) → 1
- Resultado: 7 - 1 = 6 pares justos

#### Exemplo 2:
**Input**: `nums = [1,7,9,2,5]`, `lower = 11`, `upper = 11`  
**Output**: `1`  
**Explicação**:
- Array ordenado: [1,2,5,7,9]
- Pares com soma ≤ 11: todos exceto (7,9) → 9 combinações
- Pares com soma ≤ 10: 8 combinações
- Resultado: 9 - 8 = 1 par justo

### Conclusão

Esta solução eficiente utiliza ordenação e técnica de dois ponteiros para contar pares justos em tempo O(n log n), ideal para os limites do problema.

---

## [EN]

### The Problem

Given a 0-indexed integer array `nums` of size `n` and two integers `lower` and `upper`, return the number of fair pairs. A pair `(i, j)` is fair if:
1. `0 <= i < j < n`
2. `lower <= nums[i] + nums[j] <= upper`

### Reasoning

1. **Array Sorting**:
   - First sort the array to facilitate pair counting
   - Sorting enables efficient two-pointer technique

2. **Pair Counting**:
   - Use helper function to count pairs with sum ≤ target
   - Calculate:
     - Pairs with sum ≤ upper
     - Pairs with sum ≤ (lower - 1)
   - Result is the difference between these counts

3. **Two-Pointer Technique**:
   - Pointer `left` at start and `right` at end
   - Move pointers based on current sum:
     - If sum ≤ target: all pairs between left and right are valid
     - Else: decrease `right` to reduce sum

### Complexity Analysis

- **Time**: O(n log n) - Sorting dominates runtime
- **Space**: O(n) - To store sorted array (or O(1) if in-place sort)

### Code Solution

```swift
class Solution {
    private func countPairsLessOrEqualToTarget(_ sortedNums: [Int], _ target: Int) -> Int {
        let n = sortedNums.count
        var count = 0
        var left = 0
        var right = n - 1

        while left < right {
            let sum = sortedNums[left] + sortedNums[right]
            if sum <= target {
                count += right - left
                left += 1
            } else {
                right -= 1
            }
        }
        return count
    }

    func countFairPairs(_ nums: [Int], _ lower: Int, _ upper: Int) -> Int {
        let sortedNums = nums.sorted()
        let countUpper = countPairsLessOrEqualToTarget(sortedNums, upper)
        let countLower = countPairsLessOrEqualToTarget(sortedNums, lower - 1)
        return countUpper - countLower
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [0,1,7,4,4,5]`, `lower = 3`, `upper = 6`  
**Output**: `6`  
**Explanation**:
- Sorted array: [0,1,4,4,5,7]
- Pairs with sum ≤ 6: (0,1), (0,4), (0,4), (0,5), (1,4), (1,4), (1,5) → 7
- Pairs with sum ≤ 2: (0,1) → 1
- Result: 7 - 1 = 6 fair pairs

#### Example 2:
**Input**: `nums = [1,7,9,2,5]`, `lower = 11`, `upper = 11`  
**Output**: `1`  
**Explanation**:
- Sorted array: [1,2,5,7,9]
- Pairs with sum ≤ 11: all except (7,9) → 9 combinations
- Pairs with sum ≤ 10: 8 combinations
- Result: 9 - 8 = 1 fair pair

### Conclusion

This efficient solution uses sorting and two-pointer technique to count fair pairs in O(n log n) time, ideal for the problem constraints.