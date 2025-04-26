## [PT/BR]

### O Problema

Dado um array de inteiros `nums`, precisamos garantir que todos os elementos sejam distintos. Para isso, podemos realizar a seguinte operação qualquer número de vezes:

- Remover 3 elementos do início do array. Se o array tiver menos de 3 elementos, removemos todos os elementos restantes.

Um array vazio é considerado como tendo elementos distintos. Devemos retornar o número mínimo de operações necessárias para tornar todos os elementos do array distintos.

### Raciocínio

1. **Verificação de Elementos Distintos**:
   - Primeiro verificamos se o array já possui todos elementos distintos
   - Se sim, retornamos 0 operações necessárias

2. **Identificação de Duplicatas**:
   - Percorremos o array de trás para frente para encontrar o primeiro elemento duplicado
   - Isso nos diz até onde precisamos remover elementos para eliminar todas duplicatas

3. **Cálculo das Operações**:
   - Calculamos quantas operações de remoção (de 3 elementos cada) são necessárias para remover todos elementos até o primeiro duplicado encontrado
   - Usamos arredondamento para cima na divisão por 3

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array uma vez para verificar duplicatas
- **Espaço**: O(n) - Usamos um Set para armazenar elementos vistos

### Solução em Código

```swift
import Foundation

class Solution {
    func minimumOperations(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 0 {
            return 0
        }

        var seen = Set<Int>(minimumCapacity: n) 
        var firstDuplicateIndex = -1 

        // Encontra o índice do primeiro duplicado (varrendo de trás para frente)
        for i in stride(from: n - 1, through: 0, by: -1) {
            if seen.contains(nums[i]) {
                firstDuplicateIndex = i
                break 
            } else {
                seen.insert(nums[i])
            }
        }

        // Se não encontrou duplicatas, retorna 0
        if firstDuplicateIndex == -1 {
            return 0
        }

        // Calcula quantos elementos precisam ser removidos
        let removalLength = firstDuplicateIndex + 1
        // Calcula o número de operações (arredondando para cima a divisão por 3)
        let operations = (removalLength + 2) / 3 

        return operations
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [1,2,3,4,2,3,3,5,7]`  
**Output**: `2`  
**Explicação**:
- O primeiro duplicado é o 3 no índice 6
- Precisamos remover 7 elementos (índices 0-6)
- (7 + 2) / 3 = 3 operações (arredondando para cima)

#### Exemplo 2:
**Input**: `nums = [4,5,6,4,4]`  
**Output**: `2`  
**Explicação**:
- Primeiro duplicado é 4 no índice 3
- Precisamos remover 4 elementos
- (4 + 2) / 3 = 2 operações

#### Exemplo 3:
**Input**: `nums = [6,7,8,9]`  
**Output**: `0`  
**Explicação**:
- Todos elementos são distintos
- Nenhuma operação necessária

### Conclusão

Esta solução eficiente encontra o número mínimo de operações necessárias para tornar todos os elementos do array distintos, usando uma abordagem que identifica a posição do primeiro elemento duplicado e calcula as operações de remoção necessárias.

---

## [EN]

### The Problem

Given an integer array `nums`, we need to ensure all elements are distinct. We can perform the following operation any number of times:

- Remove 3 elements from the beginning of the array. If the array has fewer than 3 elements, remove all remaining elements.

An empty array is considered to have distinct elements. We should return the minimum number of operations needed to make all array elements distinct.

### Reasoning

1. **Distinct Elements Check**:
   - First verify if the array already has all distinct elements
   - If yes, return 0 operations needed

2. **Duplicate Identification**:
   - Traverse the array backwards to find the first duplicate element
   - This tells us how far we need to remove elements to eliminate all duplicates

3. **Operation Calculation**:
   - Calculate how many removal operations (of 3 elements each) are needed to remove elements up to the first duplicate found
   - Use ceiling division by 3

### Complexity Analysis

- **Time**: O(n) - We traverse the array once to check for duplicates
- **Space**: O(n) - We use a Set to store seen elements

### Code Solution

```swift
import Foundation

class Solution {
    func minimumOperations(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 0 {
            return 0
        }

        var seen = Set<Int>(minimumCapacity: n) 
        var firstDuplicateIndex = -1 

        // Find index of first duplicate (scanning backwards)
        for i in stride(from: n - 1, through: 0, by: -1) {
            if seen.contains(nums[i]) {
                firstDuplicateIndex = i
                break 
            } else {
                seen.insert(nums[i])
            }
        }

        // If no duplicates found, return 0
        if firstDuplicateIndex == -1 {
            return 0
        }

        // Calculate how many elements need removal
        let removalLength = firstDuplicateIndex + 1
        // Calculate number of operations (ceiling division by 3)
        let operations = (removalLength + 2) / 3 

        return operations
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [1,2,3,4,2,3,3,5,7]`  
**Output**: `2`  
**Explanation**:
- First duplicate is 3 at index 6
- Need to remove 7 elements (indices 0-6)
- (7 + 2) / 3 = 3 operations (ceiling division)

#### Example 2:
**Input**: `nums = [4,5,6,4,4]`  
**Output**: `2`  
**Explanation**:
- First duplicate is 4 at index 3
- Need to remove 4 elements
- (4 + 2) / 3 = 2 operations

#### Example 3:
**Input**: `nums = [6,7,8,9]`  
**Output**: `0`  
**Explanation**:
- All elements are distinct
- No operations needed

### Conclusion

This efficient solution finds the minimum number of operations needed to make all array elements distinct, using an approach that identifies the position of the first duplicate element and calculates the required removal operations.