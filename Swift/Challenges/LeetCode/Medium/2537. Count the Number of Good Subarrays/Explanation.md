## [PT/BR]

### O Problema

Dado um array de inteiros `nums` e um inteiro `k`, precisamos retornar o número de subarrays bons de `nums`. Um subarray `arr` é considerado bom se existirem pelo menos `k` pares de índices `(i, j)` onde `i < j` e `arr[i] == arr[j]`.

### Raciocínio

1. **Sliding Window**:
   - Utilizamos a técnica de janela deslizante para percorrer o array
   - Mantemos uma janela `[left, right]` que representa o subarray atual
   - Expandimos a janela para a direita (`right++`) e contraímos pela esquerda (`left++`) conforme necessário

2. **Contagem de Pares**:
   - Para cada elemento `nums[right]`, calculamos quantos pares novos são formados
   - Um par novo é formado para cada ocorrência anterior do mesmo valor
   - Mantemos um dicionário `counts` para rastrear a frequência de cada valor

3. **Verificação de Condição**:
   - Enquanto o número de pares atuais (`currentPairs`) for ≥ `k`:
     - Movemos `left` para a direita, reduzindo `currentPairs`
     - Cada movimento de `left` representa um novo subarray válido
   - O número total de subarrays bons é acumulado em `totalGoodCount`

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array uma vez com dois ponteiros
- **Espaço**: O(n) - Armazenamos contagens de valores no dicionário

### Solução em Código

```swift
import Foundation

class Solution {
    func countGood(_ nums: [Int], _ k: Int) -> Int {
        var left = 0
        var currentPairs = 0
        var totalGoodCount = 0
        var counts = [Int: Int]()
        let n = nums.count

        for right in 0..<n {
            let numRight = nums[right]
            let oldCount = counts[numRight, default: 0]
            currentPairs += oldCount
            counts[numRight, default: 0] += 1

            while currentPairs >= k {
                let numLeft = nums[left]
                let countLeft = counts[numLeft]! 

                currentPairs -= (countLeft - 1)
                counts[numLeft]! -= 1
                if counts[numLeft]! == 0 {
                    counts[numLeft] = nil
                }
                left += 1
            }
            totalGoodCount += left
        }

        return totalGoodCount
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [1,1,1,1,1]`, `k = 10`  
**Output**: `1`  
**Explicação**:
- O único subarray com ≥10 pares é o array completo
- Número de pares: C(5,2) = 10

#### Exemplo 2:
**Input**: `nums = [3,1,4,3,2,2,4]`, `k = 2`  
**Output**: `4`  
**Explicação**:
- Subarrays válidos:
  1. [3,1,4,3,2,2] → 2 pares (3,3 e 2,2)
  2. [3,1,4,3,2,2,4] → 3 pares
  3. [1,4,3,2,2,4] → 2 pares
  4. [4,3,2,2,4] → 2 pares

### Conclusão

Esta solução eficiente utiliza a técnica de janela deslizante para contar subarrays bons em tempo linear, sendo ideal para os limites superiores do problema.

---

## [EN]

### The Problem

Given an integer array `nums` and an integer `k`, return the number of good subarrays of `nums`. A subarray `arr` is good if there are at least `k` pairs of indices `(i, j)` where `i < j` and `arr[i] == arr[j]`.

### Reasoning

1. **Sliding Window**:
   - Use sliding window technique to traverse the array
   - Maintain a window `[left, right]` representing current subarray
   - Expand window rightwards (`right++`) and contract leftwards (`left++`) as needed

2. **Pair Counting**:
   - For each `nums[right]`, calculate new pairs formed
   - Each existing occurrence of the value creates a new pair
   - Maintain `counts` dictionary to track value frequencies

3. **Condition Check**:
   - While current pairs (`currentPairs`) ≥ `k`:
     - Move `left` rightwards, reducing `currentPairs`
     - Each `left` movement represents a new valid subarray
   - Accumulate total good subarrays in `totalGoodCount`

### Complexity Analysis

- **Time**: O(n) - Single array traversal with two pointers
- **Space**: O(n) - Dictionary to store value counts

### Code Solution

```swift
import Foundation

class Solution {
    func countGood(_ nums: [Int], _ k: Int) -> Int {
        var left = 0
        var currentPairs = 0
        var totalGoodCount = 0
        var counts = [Int: Int]()
        let n = nums.count

        for right in 0..<n {
            let numRight = nums[right]
            let oldCount = counts[numRight, default: 0]
            currentPairs += oldCount
            counts[numRight, default: 0] += 1

            while currentPairs >= k {
                let numLeft = nums[left]
                let countLeft = counts[numLeft]! 

                currentPairs -= (countLeft - 1)
                counts[numLeft]! -= 1
                if counts[numLeft]! == 0 {
                    counts[numLeft] = nil
                }
                left += 1
            }
            totalGoodCount += left
        }

        return totalGoodCount
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [1,1,1,1,1]`, `k = 10`  
**Output**: `1`  
**Explanation**:
- Only the full array has ≥10 pairs
- Number of pairs: C(5,2) = 10

#### Example 2:
**Input**: `nums = [3,1,4,3,2,2,4]`, `k = 2`  
**Output**: `4`  
**Explanation**:
- Valid subarrays:
  1. [3,1,4,3,2,2] → 2 pairs
  2. [3,1,4,3,2,2,4] → 3 pairs
  3. [1,4,3,2,2,4] → 2 pairs
  4. [4,3,2,2,4] → 2 pairs

### Conclusion

This efficient solution uses sliding window technique to count good subarrays in linear time, ideal for the problem's upper constraints.