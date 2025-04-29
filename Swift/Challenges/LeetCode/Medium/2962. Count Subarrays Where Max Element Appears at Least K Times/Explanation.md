## [PT/BR]

### O Problema

Dado um array de inteiros `nums` e um inteiro positivo `k`, precisamos contar quantos subarrays contêm o elemento máximo do array pelo menos `k` vezes.

### Raciocínio

1. **Identificação do Elemento Máximo**:
   - Primeiro encontramos o valor máximo em `nums` usando `nums.max()`

2. **Técnica de Janela Deslizante**:
   - Usamos uma janela deslizante para percorrer o array
   - Mantemos um contador de quantas vezes o elemento máximo aparece na janela atual
   - Expandimos a janela para a direita (`right++`) e contraímos pela esquerda (`left++`) conforme necessário

3. **Contagem de Subarrays Válidos**:
   - Quando o contador de máximos na janela atinge `k`, todos os subarrays que terminam em `right` e começam em qualquer posição entre `left` e `right` são válidos
   - A contagem total é acumulada adicionando `left` a cada iteração

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array uma única vez com a técnica de janela deslizante
- **Espaço**: O(1) - Usamos apenas algumas variáveis auxiliares para contagem

### Solução em Código

```swift
class Solution {
    func countSubarrays(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        guard n > 0 else { return 0 }
        
        guard let maxVal = nums.max() else { return 0 }
        
        var left = 0
        var countMax = 0
        var total = 0
        
        for right in 0..<n {
            if nums[right] == maxVal {
                countMax += 1
            }
            
            while countMax >= k {
                if nums[left] == maxVal {
                    countMax -= 1
                }
                left += 1
            }
            
            total += left
        }
        
        return total
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [1,3,2,3,3]`, `k = 2`  
**Output**: `6`  
**Explicação**:
- Elemento máximo: 3
- Subarrays válidos:
  - [1,3,2,3]
  - [1,3,2,3,3]
  - [3,2,3]
  - [3,2,3,3]
  - [2,3,3]
  - [3,3]

#### Exemplo 2:
**Input**: `nums = [1,4,2,1]`, `k = 3`  
**Output**: `0`  
**Explicação**:
- Elemento máximo: 4
- Nenhum subarray contém 4 pelo menos 3 vezes

### Conclusão

Esta solução eficiente utiliza a técnica de janela deslizante para contar subarrays válidos em tempo linear, sendo ideal para os limites do problema. A abordagem garante que todos os subarrays sejam verificados de forma otimizada, sem repetições desnecessárias.

---

## [EN]

### The Problem

Given an integer array `nums` and a positive integer `k`, we need to count how many subarrays contain the maximum element of the array at least `k` times.

### Reasoning

1. **Identifying Maximum Element**:
   - First find the maximum value in `nums` using `nums.max()`

2. **Sliding Window Technique**:
   - Use a sliding window to traverse the array
   - Maintain a counter of how many times the maximum element appears in current window
   - Expand window rightwards (`right++`) and contract leftwards (`left++`) as needed

3. **Counting Valid Subarrays**:
   - When the maximum count in window reaches `k`, all subarrays ending at `right` and starting between `left` and `right` are valid
   - Total count is accumulated by adding `left` each iteration

### Complexity Analysis

- **Time**: O(n) - Single pass through array with sliding window
- **Space**: O(1) - Uses only a few helper variables for counting

### Code Solution

```swift
class Solution {
    func countSubarrays(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        guard n > 0 else { return 0 }
        
        guard let maxVal = nums.max() else { return 0 }
        
        var left = 0
        var countMax = 0
        var total = 0
        
        for right in 0..<n {
            if nums[right] == maxVal {
                countMax += 1
            }
            
            while countMax >= k {
                if nums[left] == maxVal {
                    countMax -= 1
                }
                left += 1
            }
            
            total += left
        }
        
        return total
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [1,3,2,3,3]`, `k = 2`  
**Output**: `6`  
**Explanation**:
- Maximum element: 3
- Valid subarrays:
  - [1,3,2,3]
  - [1,3,2,3,3]
  - [3,2,3]
  - [3,2,3,3]
  - [2,3,3]
  - [3,3]

#### Example 2:
**Input**: `nums = [1,4,2,1]`, `k = 3`  
**Output**: `0`  
**Explanation**:
- Maximum element: 4
- No subarray contains 4 at least 3 times

### Conclusion

This efficient solution uses sliding window technique to count valid subarrays in linear time, making it ideal for the problem constraints. The approach ensures all subarrays are checked optimally without unnecessary repetitions.