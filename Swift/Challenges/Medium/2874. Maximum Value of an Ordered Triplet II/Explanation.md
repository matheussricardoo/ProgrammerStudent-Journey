## [PT/BR]

### O Problema

Dado um array de inteiros `nums` indexado a partir de 0, precisamos encontrar o valor máximo entre todos os tripletos de índices `(i, j, k)` onde `i < j < k`. O valor de um tripleto é calculado como `(nums[i] - nums[j]) * nums[k]`. Se todos os tripletos tiverem valor negativo, devemos retornar 0.

### Raciocínio

1. **Entendendo a Fórmula do Triplete**:
   - A fórmula `(nums[i] - nums[j]) * nums[k]` pode ser decomposta em duas partes:
     - `(nums[i] - nums[j])`: Diferença entre dois elementos
     - `nums[k]`: Um terceiro elemento à direita
   - Para maximizar o valor, precisamos:
     - Maximizar `(nums[i] - nums[j])` (ou seja, `nums[i]` grande e `nums[j]` pequeno)
     - Maximizar `nums[k]` (o maior valor possível à direita)

2. **Abordagem Eficiente**:
   - Em vez de verificar todos os tripletos possíveis (O(n³)), podemos otimizar para O(n) usando três variáveis:
     - `maxTripletValue`: Armazena o maior valor de tripleto encontrado
     - `maxI`: Armazena o maior valor de `nums[i]` encontrado até o momento
     - `maxDiffIJ`: Armazena a maior diferença `(nums[i] - nums[j])` encontrada

3. **Processamento em Uma Única Passagem**:
   - Percorremos o array uma única vez
   - Para cada elemento `num` (atuando como `nums[k]`):
     - Calculamos o valor potencial do tripleto como `maxDiffIJ * num`
     - Atualizamos `maxTripletValue` se for maior
     - Calculamos a diferença potencial `maxI - num` (que seria `nums[i] - nums[j]`)
     - Atualizamos `maxDiffIJ` se essa diferença for maior
     - Atualizamos `maxI` se `num` for maior que o valor atual

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array apenas uma vez
- **Espaço**: O(1) - Usamos apenas três variáveis adicionais

### Solução em Código

```swift
import Foundation

class Solution {
    func maximumTripletValue(_ nums: [Int]) -> Int {
        var maxTripletValue: Int = 0
        var maxI: Int = 0
        var maxDiffIJ: Int = 0

        for num in nums {
            let currentPotentialTripletValue = maxDiffIJ * num
            maxTripletValue = max(maxTripletValue, currentPotentialTripletValue)
            let currentPotentialDiff = maxI - num
            maxDiffIJ = max(maxDiffIJ, currentPotentialDiff)
            maxI = max(maxI, num)
        }
        return maxTripletValue
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [12,6,1,2,7]`  
**Output**: `77`  
**Explicação**:
- O tripleto `(0, 2, 4)` resulta em `(12 - 1) * 7 = 77`
- Este é o maior valor possível

#### Exemplo 2:
**Input**: `nums = [1,10,3,4,19]`  
**Output**: `133`  
**Explicação**:
- O tripleto `(1, 2, 4)` resulta em `(10 - 3) * 19 = 133`
- Este é o maior valor possível

#### Exemplo 3:
**Input**: `nums = [1,2,3]`  
**Output**: `0`  
**Explicação**:
- O único tripleto possível `(0, 1, 2)` resulta em `(1 - 2) * 3 = -3`
- Como é negativo, retornamos 0

### Conclusão

Esta solução é altamente eficiente, resolvendo o problema em tempo linear com uso constante de espaço. A chave está em manter e atualizar as três variáveis durante a passagem única pelo array, garantindo que encontremos o valor máximo do tripleto sem verificar todas combinações possíveis.

---

## [EN]

### The Problem

Given a 0-indexed integer array `nums`, we need to find the maximum value over all triplets of indices `(i, j, k)` where `i < j < k`. The value of a triplet is calculated as `(nums[i] - nums[j]) * nums[k]`. If all such triplets have negative value, we should return 0.

### Reasoning

1. **Understanding the Triplet Formula**:
   - The formula `(nums[i] - nums[j]) * nums[k]` can be broken into two parts:
     - `(nums[i] - nums[j])`: Difference between two elements
     - `nums[k]`: A third element to the right
   - To maximize the value, we need:
     - Maximize `(nums[i] - nums[j])` (i.e., large `nums[i]` and small `nums[j]`)
     - Maximize `nums[k]` (largest possible value to the right)

2. **Efficient Approach**:
   - Instead of checking all possible triplets (O(n³)), we optimize to O(n) using three variables:
     - `maxTripletValue`: Stores the maximum triplet value found
     - `maxI`: Stores the largest `nums[i]` value found so far
     - `maxDiffIJ`: Stores the largest `(nums[i] - nums[j])` difference found

3. **Single Pass Processing**:
   - We traverse the array once
   - For each element `num` (acting as `nums[k]`):
     - Calculate potential triplet value as `maxDiffIJ * num`
     - Update `maxTripletValue` if greater
     - Calculate potential difference `maxI - num` (which would be `nums[i] - nums[j]`)
     - Update `maxDiffIJ` if this difference is larger
     - Update `maxI` if `num` is larger than current value

### Complexity Analysis

- **Time**: O(n) - We traverse the array only once
- **Space**: O(1) - We use only three additional variables

### Code Solution

```swift
import Foundation

class Solution {
    func maximumTripletValue(_ nums: [Int]) -> Int {
        var maxTripletValue: Int = 0
        var maxI: Int = 0
        var maxDiffIJ: Int = 0

        for num in nums {
            let currentPotentialTripletValue = maxDiffIJ * num
            maxTripletValue = max(maxTripletValue, currentPotentialTripletValue)
            let currentPotentialDiff = maxI - num
            maxDiffIJ = max(maxDiffIJ, currentPotentialDiff)
            maxI = max(maxI, num)
        }
        return maxTripletValue
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [12,6,1,2,7]`  
**Output**: `77`  
**Explanation**:
- The triplet `(0, 2, 4)` gives `(12 - 1) * 7 = 77`
- This is the maximum possible value

#### Example 2:
**Input**: `nums = [1,10,3,4,19]`  
**Output**: `133`  
**Explanation**:
- The triplet `(1, 2, 4)` gives `(10 - 3) * 19 = 133`
- This is the maximum possible value

#### Example 3:
**Input**: `nums = [1,2,3]`  
**Output**: `0`  
**Explanation**:
- The only possible triplet `(0, 1, 2)` gives `(1 - 2) * 3 = -3`
- Since it's negative, we return 0

### Conclusion

This solution is highly efficient, solving the problem in linear time with constant space usage. The key is maintaining and updating the three variables during the single array traversal, ensuring we find the maximum triplet value without checking all possible combinations.