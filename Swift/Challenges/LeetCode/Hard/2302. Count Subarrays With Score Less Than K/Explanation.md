## [PT/BR]

### O Problema

Dado um array de inteiros positivos `nums` e um inteiro `k`, precisamos contar quantos subarrays não vazios têm pontuação estritamente menor que `k`. A pontuação de um subarray é definida como o produto da soma dos elementos pelo comprimento do subarray.

### Raciocínio

1. **Técnica de Janela Deslizante**:
   - Usamos uma janela deslizante para percorrer o array e calcular a pontuação dos subarrays
   - Mantemos uma janela `[left, right]` que representa o subarray atual
   - Expandimos a janela para a direita (`right++`) e contraímos pela esquerda (`left++`) conforme necessário

2. **Cálculo da Pontuação**:
   - Para cada posição `right`, calculamos a soma acumulada (`currentSum`) do subarray atual
   - Verificamos se `currentSum * length >= k` (onde `length = right - left + 1`)
   - Se sim, movemos `left` para a direita até que a condição seja satisfeita

3. **Contagem de Subarrays Válidos**:
   - Todos os subarrays terminando em `right` e começando em qualquer posição entre `left` e `right` são válidos
   - A contagem é incrementada pelo tamanho da janela atual (`right - left + 1`)

### Análise da Complexidade

- **Tempo**: O(n) - Cada elemento é visitado no máximo duas vezes (uma por `right` e outra por `left`)
- **Espaço**: O(1) - Usamos apenas algumas variáveis auxiliares

### Solução em Código

```swift
class Solution {
    func countSubarrays(_ nums: [Int], _ k: Int) -> Int {
        var count = 0
        var currentSum = 0
        var left = 0
        let n = nums.count

        for right in 0..<n {
            currentSum += nums[right]

            while currentSum * (right - left + 1) >= k && left <= right {
                currentSum -= nums[left]
                left += 1
            }
            
            count += (right - left + 1)
        }

        return count
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [2,1,4,3,5]`, `k = 10`  
**Output**: `6`  
**Explicação**:
- Subarrays válidos:
  - [2] → 2*1 = 2
  - [1] → 1*1 = 1
  - [4] → 4*1 = 4
  - [3] → 3*1 = 3
  - [5] → 5*1 = 5
  - [2,1] → (2+1)*2 = 6
- Total: 6 subarrays com pontuação < 10

#### Exemplo 2:
**Input**: `nums = [1,1,1]`, `k = 5`  
**Output**: `5`  
**Explicação**:
- Subarrays válidos:
  - [1] → 1*1 = 1 (3 ocorrências)
  - [1,1] → (1+1)*2 = 4 (2 ocorrências)
- Total: 5 subarrays com pontuação < 5

### Conclusão

Esta solução eficiente utiliza a técnica de janela deslizante para contar subarrays válidos em tempo linear, sendo ideal para os limites do problema. A abordagem garante que todos os subarrays sejam verificados de forma otimizada, sem repetições desnecessárias.

---

## [EN]

### The Problem

Given a positive integer array `nums` and an integer `k`, we need to count how many non-empty subarrays have a score strictly less than `k`. The score of a subarray is defined as the product of its sum and its length.

### Reasoning

1. **Sliding Window Technique**:
   - Use a sliding window to traverse the array and calculate subarray scores
   - Maintain a window `[left, right]` representing the current subarray
   - Expand window rightwards (`right++`) and contract leftwards (`left++`) as needed

2. **Score Calculation**:
   - For each `right` position, calculate the cumulative sum (`currentSum`) of current subarray
   - Check if `currentSum * length >= k` (where `length = right - left + 1`)
   - If true, move `left` rightwards until condition is satisfied

3. **Valid Subarray Counting**:
   - All subarrays ending at `right` and starting between `left` and `right` are valid
   - Increment count by current window size (`right - left + 1`)

### Complexity Analysis

- **Time**: O(n) - Each element visited at most twice (once by `right`, once by `left`)
- **Space**: O(1) - Uses only a few helper variables

### Code Solution

```swift
class Solution {
    func countSubarrays(_ nums: [Int], _ k: Int) -> Int {
        var count = 0
        var currentSum = 0
        var left = 0
        let n = nums.count

        for right in 0..<n {
            currentSum += nums[right]

            while currentSum * (right - left + 1) >= k && left <= right {
                currentSum -= nums[left]
                left += 1
            }
            
            count += (right - left + 1)
        }

        return count
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [2,1,4,3,5]`, `k = 10`  
**Output**: `6`  
**Explanation**:
- Valid subarrays:
  - [2] → 2*1 = 2
  - [1] → 1*1 = 1
  - [4] → 4*1 = 4
  - [3] → 3*1 = 3
  - [5] → 5*1 = 5
  - [2,1] → (2+1)*2 = 6
- Total: 6 subarrays with score < 10

#### Example 2:
**Input**: `nums = [1,1,1]`, `k = 5`  
**Output**: `5`  
**Explanation**:
- Valid subarrays:
  - [1] → 1*1 = 1 (3 occurrences)
  - [1,1] → (1+1)*2 = 4 (2 occurrences)
- Total: 5 subarrays with score < 5

### Conclusion

This efficient solution uses the sliding window technique to count valid subarrays in linear time, making it ideal for the problem constraints. The approach ensures all subarrays are checked optimally without unnecessary repetitions.