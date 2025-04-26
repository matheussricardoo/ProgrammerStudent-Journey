## [PT/BR]

### O Problema

Dado um array `nums` de inteiros positivos, precisamos contar quantos subarrays são considerados completos. Um subarray é completo quando:
- O número de elementos distintos no subarray é igual ao número de elementos distintos no array inteiro.

### Raciocínio

1. **Identificação de Elementos Distintos**:
   - Primeiro calculamos quantos elementos distintos existem no array completo usando `Set(nums).count`

2. **Técnica de Janela Deslizante**:
   - Usamos uma janela deslizante para percorrer o array
   - Mantemos um contador de elementos distintos na janela atual
   - Expandimos a janela para a direita e contraímos pela esquerda conforme necessário

3. **Contagem de Subarrays Completos**:
   - Quando a janela contém todos os elementos distintos do array, todos os subarrays que terminam na posição atual e começam em qualquer posição à esquerda são completos
   - Contamos esses subarrays e ajustamos a janela

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array uma vez com a técnica de janela deslizante
- **Espaço**: O(1) - Usamos um array de tamanho fixo (2001) para contar frequências

### Solução em Código

```swift
import Foundation

class Solution {
    func countCompleteSubarrays(_ nums: [Int]) -> Int {
        let totalDistinct = Set(nums).count
        var frequency = [Int](repeating: 0, count: 2001)
        var left = 0
        var currentDistinct = 0
        var count = 0

        for right in 0..<nums.count {
            let num = nums[right]
            
            if frequency[num] == 0 {
                currentDistinct += 1
            }
            frequency[num] += 1

            while currentDistinct == totalDistinct {
                count += nums.count - right
                
                let leftNum = nums[left]
                frequency[leftNum] -= 1
                if frequency[leftNum] == 0 {
                    currentDistinct -= 1
                }
                left += 1
            }
        }

        return count
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [1,3,1,2,2]`  
**Output**: `4`  
**Explicação**:
- Elementos distintos: 1, 2, 3 (total 3)
- Subarrays completos:
  - [1,3,1,2] (índices 0-3)
  - [1,3,1,2,2] (0-4)
  - [3,1,2] (1-3)
  - [3,1,2,2] (1-4)

#### Exemplo 2:
**Input**: `nums = [5,5,5,5]`  
**Output**: `10`  
**Explicação**:
- Apenas 1 elemento distinto (5)
- Todos os 10 subarrays possíveis são completos

### Conclusão

Esta solução eficiente utiliza a técnica de janela deslizante para contar subarrays completos em tempo linear, sendo ideal para os limites do problema.

---

## [EN]

### The Problem

Given an array `nums` of positive integers, we need to count how many subarrays are considered complete. A subarray is complete when:
- The number of distinct elements in the subarray equals the number of distinct elements in the entire array.

### Reasoning

1. **Identifying Distinct Elements**:
   - First calculate how many distinct elements exist in the full array using `Set(nums).count`

2. **Sliding Window Technique**:
   - Use a sliding window to traverse the array
   - Maintain a counter of distinct elements in current window
   - Expand window rightwards and contract leftwards as needed

3. **Counting Complete Subarrays**:
   - When window contains all distinct elements of array, all subarrays ending at current position and starting at any left position are complete
   - Count these subarrays and adjust window

### Complexity Analysis

- **Time**: O(n) - Single pass through array with sliding window
- **Space**: O(1) - Use fixed-size array (2001) for frequency counting

### Code Solution

```swift
import Foundation

class Solution {
    func countCompleteSubarrays(_ nums: [Int]) -> Int {
        let totalDistinct = Set(nums).count
        var frequency = [Int](repeating: 0, count: 2001)
        var left = 0
        var currentDistinct = 0
        var count = 0

        for right in 0..<nums.count {
            let num = nums[right]
            
            if frequency[num] == 0 {
                currentDistinct += 1
            }
            frequency[num] += 1

            while currentDistinct == totalDistinct {
                count += nums.count - right
                
                let leftNum = nums[left]
                frequency[leftNum] -= 1
                if frequency[leftNum] == 0 {
                    currentDistinct -= 1
                }
                left += 1
            }
        }

        return count
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [1,3,1,2,2]`  
**Output**: `4`  
**Explanation**:
- Distinct elements: 1, 2, 3 (total 3)
- Complete subarrays:
  - [1,3,1,2] (indices 0-3)
  - [1,3,1,2,2] (0-4)
  - [3,1,2] (1-3)
  - [3,1,2,2] (1-4)

#### Example 2:
**Input**: `nums = [5,5,5,5]`  
**Output**: `10`  
**Explanation**:
- Only 1 distinct element (5)
- All 10 possible subarrays are complete

### Conclusion

This efficient solution uses sliding window technique to count complete subarrays in linear time, ideal for the problem constraints.