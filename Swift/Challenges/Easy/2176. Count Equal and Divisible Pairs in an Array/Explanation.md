## [PT/BR]

### O Problema

Dado um array de inteiros `nums` de comprimento `n` e um inteiro `k`, precisamos retornar o número de pares `(i, j)` onde:
1. `0 <= i < j < n`
2. `nums[i] == nums[j]`
3. `(i * j)` é divisível por `k`

### Raciocínio

1. **Abordagem Direta**:
   - Percorrer todos os pares possíveis `(i, j)` no array
   - Para cada par, verificar as três condições:
     - `i < j`
     - `nums[i] == nums[j]`
     - `(i * j) % k == 0`

2. **Otimização**:
   - Como o tamanho máximo do array é 100 (constraints), a solução O(n²) é aceitável
   - Não há necessidade de estruturas de dados complexas

3. **Implementação**:
   - Dois loops aninhados para gerar todos os pares `(i, j)`
   - Verificação direta das condições para cada par

### Análise da Complexidade

- **Tempo**: O(n²) - Para cada elemento, verificamos todos os elementos à frente
- **Espaço**: O(1) - Usamos apenas um contador

### Solução em Código

```swift
import Foundation 

class Solution {
    func countPairs(_ nums: [Int], _ k: Int) -> Int {
        var count = 0
        let n = nums.count

        for i in 0..<n {
            for j in (i + 1)..<n {
                if nums[i] == nums[j] && (i * j) % k == 0 {
                    count += 1
                }
            }
        }

        return count
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [3,1,2,2,2,1,3]`, `k = 2`  
**Output**: `4`  
**Explicação**:
- (0,6): nums[0]==nums[6] e 0*6=0 (divisível por 2)
- (2,3): nums[2]==nums[3] e 2*3=6 (divisível por 2)
- (2,4): nums[2]==nums[4] e 2*4=8 (divisível por 2)
- (3,4): nums[3]==nums[4] e 3*4=12 (divisível por 2)

#### Exemplo 2:
**Input**: `nums = [1,2,3,4]`, `k = 1`  
**Output**: `0`  
**Explicação**:
- Nenhum par tem valores iguais

### Conclusão

Esta solução direta é eficiente para os limites dados, utilizando uma abordagem simples de força bruta que é ideal para o tamanho máximo do array (100 elementos).

---

## [EN]

### The Problem

Given a 0-indexed integer array `nums` of length `n` and an integer `k`, return the number of pairs `(i, j)` where:
1. `0 <= i < j < n`
2. `nums[i] == nums[j]`
3. `(i * j)` is divisible by `k`

### Reasoning

1. **Direct Approach**:
   - Iterate through all possible pairs `(i, j)` in the array
   - For each pair, check three conditions:
     - `i < j`
     - `nums[i] == nums[j]`
     - `(i * j) % k == 0`

2. **Optimization**:
   - With maximum array size 100 (constraints), O(n²) solution is acceptable
   - No need for complex data structures

3. **Implementation**:
   - Two nested loops to generate all `(i, j)` pairs
   - Direct condition checking for each pair

### Complexity Analysis

- **Time**: O(n²) - For each element, check all subsequent elements
- **Space**: O(1) - Uses only a counter variable

### Code Solution

```swift
import Foundation 

class Solution {
    func countPairs(_ nums: [Int], _ k: Int) -> Int {
        var count = 0
        let n = nums.count

        for i in 0..<n {
            for j in (i + 1)..<n {
                if nums[i] == nums[j] && (i * j) % k == 0 {
                    count += 1
                }
            }
        }

        return count
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [3,1,2,2,2,1,3]`, `k = 2`  
**Output**: `4`  
**Explanation**:
- (0,6): nums[0]==nums[6] and 0*6=0 (divisible by 2)
- (2,3): nums[2]==nums[3] and 2*3=6 (divisible by 2)
- (2,4): nums[2]==nums[4] and 2*4=8 (divisible by 2)
- (3,4): nums[3]==nums[4] and 3*4=12 (divisible by 2)

#### Example 2:
**Input**: `nums = [1,2,3,4]`, `k = 1`  
**Output**: `0`  
**Explanation**:
- No pairs have equal values

### Conclusion

This straightforward solution is efficient for given constraints, using a simple brute-force approach ideal for maximum array size (100 elements).