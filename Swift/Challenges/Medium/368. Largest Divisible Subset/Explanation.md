## [PT/BR]

### O Problema

Dado um conjunto de inteiros positivos distintos `nums`, precisamos retornar o maior subconjunto `answer` onde para todo par de elementos `(answer[i], answer[j])` no subconjunto:

- `answer[i] % answer[j] == 0`, ou
- `answer[j] % answer[i] == 0`

Se houver múltiplas soluções, podemos retornar qualquer uma delas.

### Raciocínio

1. **Ordenação Inicial**:
   - Primeiro ordenamos o array para facilitar a verificação das condições de divisibilidade
   - Isso nos permite verificar apenas pares onde o número menor vem antes do maior

2. **Programação Dinâmica**:
   - Usamos dois arrays:
     - `dp`: armazena o tamanho do maior subconjunto divisível terminando em cada posição
     - `prevIndex`: armazena o índice do elemento anterior no subconjunto
   - Para cada elemento, verificamos todos os elementos anteriores que o dividem
   - Atualizamos `dp` e `prevIndex` conforme encontramos subconjuntos maiores

3. **Reconstrução do Subconjunto**:
   - Encontramos o índice do elemento que termina o maior subconjunto
   - Usamos `prevIndex` para reconstruir o subconjunto do final para o início
   - Invertemos o resultado para obter a ordem crescente

### Análise da Complexidade

- **Tempo**: O(n²) - Dois loops aninhados sobre o array
- **Espaço**: O(n) - Armazenamos dois arrays auxiliares de tamanho n

### Solução em Código

```swift
import Foundation

class Solution {
    func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
        let n = nums.count
        if n <= 1 {
            return nums
        }

        let sortedNums = nums.sorted()

        var dp = Array(repeating: 1, count: n)
        var prevIndex = Array(repeating: -1, count: n) 

        var maxSize = 1
        var maxIndex = 0

        for i in 0..<n {
            for j in 0..<i {
                if sortedNums[i] % sortedNums[j] == 0 {
                    if 1 + dp[j] > dp[i] {
                        dp[i] = 1 + dp[j]
                        prevIndex[i] = j 
                    }
                }
            }
            if dp[i] > maxSize {
                maxSize = dp[i]
                maxIndex = i
            }
        }

        var result: [Int] = []
        var currentIndex = maxIndex
        while currentIndex != -1 {
            result.append(sortedNums[currentIndex])
            currentIndex = prevIndex[currentIndex] 
        }

        return result.reversed()
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [1,2,3]`  
**Output**: `[1,2]` ou `[1,3]`  
**Explicação**:
- Ordenado: `[1,2,3]`
- Subconjuntos válidos: `[1,2]` e `[1,3]` (ambos tamanho 2)

#### Exemplo 2:
**Input**: `nums = [1,2,4,8]`  
**Output**: `[1,2,4,8]`  
**Explicação**:
- Ordenado: `[1,2,4,8]`
- Subconjunto válido máximo: o próprio array (tamanho 4)

### Conclusão

Esta solução eficiente encontra o maior subconjunto divisível usando programação dinâmica após ordenar o array. A abordagem garante que encontremos a solução ótima em tempo quadrático, com uso linear de espaço adicional.

---

## [EN]

### The Problem

Given a set of distinct positive integers `nums`, we need to return the largest subset `answer` where for every pair of elements `(answer[i], answer[j])` in this subset:

- `answer[i] % answer[j] == 0`, or
- `answer[j] % answer[i] == 0`

If there are multiple solutions, we can return any of them.

### Reasoning

1. **Initial Sorting**:
   - First sort the array to facilitate divisibility condition checks
   - This allows us to only check pairs where the smaller number comes before the larger one

2. **Dynamic Programming**:
   - We use two arrays:
     - `dp`: stores the size of the largest divisible subset ending at each position
     - `prevIndex`: stores the index of the previous element in the subset
   - For each element, we check all previous elements that divide it
   - We update `dp` and `prevIndex` when we find larger subsets

3. **Subset Reconstruction**:
   - Find the index of the element ending the largest subset
   - Use `prevIndex` to reconstruct the subset from end to start
   - Reverse the result to get ascending order

### Complexity Analysis

- **Time**: O(n²) - Two nested loops over the array
- **Space**: O(n) - We store two auxiliary arrays of size n

### Code Solution

```swift
import Foundation

class Solution {
    func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
        let n = nums.count
        if n <= 1 {
            return nums
        }

        let sortedNums = nums.sorted()

        var dp = Array(repeating: 1, count: n)
        var prevIndex = Array(repeating: -1, count: n) 

        var maxSize = 1
        var maxIndex = 0

        for i in 0..<n {
            for j in 0..<i {
                if sortedNums[i] % sortedNums[j] == 0 {
                    if 1 + dp[j] > dp[i] {
                        dp[i] = 1 + dp[j]
                        prevIndex[i] = j 
                    }
                }
            }
            if dp[i] > maxSize {
                maxSize = dp[i]
                maxIndex = i
            }
        }

        var result: [Int] = []
        var currentIndex = maxIndex
        while currentIndex != -1 {
            result.append(sortedNums[currentIndex])
            currentIndex = prevIndex[currentIndex] 
        }

        return result.reversed()
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [1,2,3]`  
**Output**: `[1,2]` or `[1,3]`  
**Explanation**:
- Sorted: `[1,2,3]`
- Valid subsets: `[1,2]` and `[1,3]` (both size 2)

#### Example 2:
**Input**: `nums = [1,2,4,8]`  
**Output**: `[1,2,4,8]`  
**Explanation**:
- Sorted: `[1,2,4,8]`
- Maximum valid subset: the array itself (size 4)

### Conclusion

This efficient solution finds the largest divisible subset using dynamic programming after sorting the array. The approach guarantees we find the optimal solution in quadratic time, with linear additional space usage.