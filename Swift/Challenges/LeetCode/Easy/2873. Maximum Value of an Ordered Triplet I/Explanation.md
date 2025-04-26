## [PT/BR]

### O Problema

Dado um array de inteiros `nums` indexado a partir de 0, o objetivo é encontrar o valor máximo entre todos os tripletos de índices `(i, j, k)` onde `i < j < k`. O valor de um tripleto é calculado como `(nums[i] - nums[j]) * nums[k]`. Se todos os tripletos tiverem valor negativo, deve-se retornar 0.

### Raciocínio

1. **Entendendo a Fórmula do Triplete**:
   - A fórmula `(nums[i] - nums[j]) * nums[k]` pode ser reescrita como `(nums[i] - nums[j]) * nums[k]`.
   - Para maximizar esse valor, precisamos:
     - Maximizar `(nums[i] - nums[j])`: ou seja, queremos `nums[i]` grande e `nums[j]` pequeno.
     - Maximizar `nums[k]`: o maior valor possível à direita de `j`.

2. **Abordagem Eficiente**:
   - Em vez de verificar todos os tripletos possíveis (O(n³)), podemos otimizar para O(n) mantendo três variáveis:
     - `maxTripletValue`: armazena o maior valor de tripleto encontrado.
     - `maxIValue`: armazena o maior valor de `nums[i]` encontrado até o momento.
     - `maxDiff`: armazena a maior diferença `(nums[i] - nums[j])` encontrada até o momento.

3. **Processamento em Uma Única Passagem**:
   - Percorremos o array uma única vez.
   - Para cada elemento `num` (atuando como `nums[k]`):
     - Calculamos o valor do tripleto atual como `maxDiff * num`.
     - Atualizamos `maxTripletValue` se o valor atual for maior.
     - Calculamos a diferença potencial `maxIValue - num` (que seria `nums[i] - nums[j]`).
     - Atualizamos `maxDiff` se essa diferença for maior que a anterior.
     - Atualizamos `maxIValue` se `num` for maior que o valor atual de `maxIValue`.

### Análise da Complexidade

- **Tempo**: O(n), pois percorremos o array apenas uma vez.
- **Espaço**: O(1), pois usamos um número constante de variáveis adicionais.

### Solução em Código

```swift
import Foundation

class Solution {
    func maximumTripletValue(_ nums: [Int]) -> Int {
        var maxTripletValue: Int = 0
        var maxIValue: Int = 0 
        var maxDiff: Int = 0 
        
        for num in nums {
            let currentTripletValue = maxDiff * num
            maxTripletValue = max(maxTripletValue, currentTripletValue)
            let potentialNewDiff = maxIValue - num
            maxDiff = max(maxDiff, potentialNewDiff)
            
            maxIValue = max(maxIValue, num)
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
- O tripleto `(0, 2, 4)` resulta em `(12 - 1) * 7 = 77`, que é o maior valor possível.

#### Exemplo 2:
**Input**: `nums = [1,10,3,4,19]`  
**Output**: `133`  
**Explicação**:
- O tripleto `(1, 2, 4)` resulta em `(10 - 3) * 19 = 133`, que é o maior valor possível.

#### Exemplo 3:
**Input**: `nums = [1,2,3]`  
**Output**: `0`  
**Explicação**:
- O único tripleto possível `(0, 1, 2)` resulta em `(1 - 2) * 3 = -3`, que é negativo, então retornamos 0.

### Conclusão

A solução apresentada é eficiente e elegante, resolvendo o problema em tempo linear com uso constante de espaço. A chave está em manter e atualizar as variáveis `maxIValue`, `maxDiff` e `maxTripletValue` durante a única passagem pelo array, garantindo que encontremos o valor máximo do tripleto sem precisar verificar todas as combinações possíveis.

---

## [EN]

### The Problem

Given a 0-indexed integer array `nums`, the goal is to find the maximum value over all triplets of indices `(i, j, k)` where `i < j < k`. The value of a triplet is calculated as `(nums[i] - nums[j]) * nums[k]`. If all such triplets have a negative value, return 0.

### Reasoning

1. **Understanding the Triplet Formula**:
   - The formula `(nums[i] - nums[j]) * nums[k]` can be rewritten as `(nums[i] - nums[j]) * nums[k]`.
   - To maximize this value, we need:
     - To maximize `(nums[i] - nums[j])`: i.e., we want `nums[i]` to be large and `nums[j]` to be small.
     - To maximize `nums[k]`: the largest possible value to the right of `j`.

2. **Efficient Approach**:
   - Instead of checking all possible triplets (O(n³)), we can optimize to O(n) by maintaining three variables:
     - `maxTripletValue`: stores the largest triplet value found.
     - `maxIValue`: stores the largest `nums[i]` value found so far.
     - `maxDiff`: stores the largest difference `(nums[i] - nums[j])` found so far.

3. **Single Pass Processing**:
   - We traverse the array once.
   - For each element `num` (acting as `nums[k]`):
     - Calculate the current triplet value as `maxDiff * num`.
     - Update `maxTripletValue` if the current value is larger.
     - Calculate the potential difference `maxIValue - num` (which would be `nums[i] - nums[j]`).
     - Update `maxDiff` if this difference is larger than the previous one.
     - Update `maxIValue` if `num` is larger than the current `maxIValue`.

### Complexity Analysis

- **Time**: O(n), as we traverse the array only once.
- **Space**: O(1), as we use a constant number of additional variables.

### Code Solution

```swift
import Foundation

class Solution {
    func maximumTripletValue(_ nums: [Int]) -> Int {
        var maxTripletValue: Int = 0
        var maxIValue: Int = 0 
        var maxDiff: Int = 0 
        
        for num in nums {
            let currentTripletValue = maxDiff * num
            maxTripletValue = max(maxTripletValue, currentTripletValue)
            let potentialNewDiff = maxIValue - num
            maxDiff = max(maxDiff, potentialNewDiff)
            
            maxIValue = max(maxIValue, num)
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
- The triplet `(0, 2, 4)` results in `(12 - 1) * 7 = 77`, which is the maximum possible value.

#### Example 2:
**Input**: `nums = [1,10,3,4,19]`  
**Output**: `133`  
**Explanation**:
- The triplet `(1, 2, 4)` results in `(10 - 3) * 19 = 133`, which is the maximum possible value.

#### Example 3:
**Input**: `nums = [1,2,3]`  
**Output**: `0`  
**Explanation**:
- The only possible triplet `(0, 1, 2)` results in `(1 - 2) * 3 = -3`, which is negative, so we return 0.

### Conclusion

The presented solution is efficient and elegant, solving the problem in linear time with constant space usage. The key lies in maintaining and updating the variables `maxIValue`, `maxDiff`, and `maxTripletValue` during the single pass through the array, ensuring that we find the maximum triplet value without needing to check all possible combinations.