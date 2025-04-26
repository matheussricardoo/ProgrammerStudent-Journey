## [PT/BR]

### O Problema

Dado um array de inteiros `nums` e dois inteiros `minK` e `maxK`, precisamos contar quantos subarrays são considerados de limites fixos. Um subarray de limites fixos deve satisfazer:
- O valor mínimo no subarray é igual a `minK`
- O valor máximo no subarray é igual a `maxK`

### Raciocínio

1. **Identificação de Limites**:
   - Mantemos rastreamento dos índices mais recentes onde `minK` e `maxK` aparecem
   - Identificamos também o índice mais recente onde um valor fora do intervalo `[minK, maxK]` ocorre

2. **Cálculo de Subarrays Válidos**:
   - Para cada posição no array, calculamos quantos subarrays terminando nessa posição são válidos
   - Um subarray é válido se contém pelo menos um `minK` e um `maxK`, e nenhum elemento fora do intervalo

3. **Contagem Eficiente**:
   - Usamos os índices armazenados para determinar rapidamente quantos subarrays válidos terminam na posição atual
   - A cada iteração, atualizamos os índices relevantes e calculamos a contagem

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array uma única vez
- **Espaço**: O(1) - Usamos apenas algumas variáveis para armazenar índices

### Solução em Código

```swift
class Solution {
    func countSubarrays(_ nums: [Int], _ minK: Int, _ maxK: Int) -> Int {
        var count = 0
        var minPos = -1
        var maxPos = -1
        var leftBound = -1
        let n = nums.count

        for i in 0..<n {
            let num = nums[i]

            // Atualiza o limite esquerdo se encontrar um número fora do intervalo
            if num < minK || num > maxK {
                leftBound = i
            }

            // Atualiza as posições mais recentes de minK e maxK
            if num == minK {
                minPos = i
            }
            if num == maxK {
                maxPos = i
            }

            // Calcula quantos subarrays válidos terminam na posição atual
            let validSubarrays = max(0, min(minPos, maxPos) - leftBound)
            count += validSubarrays
        }

        return count
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [1,3,5,2,7,5]`, `minK = 1`, `maxK = 5`  
**Output**: `2`  
**Explicação**:
- Subarrays válidos:
  - [1,3,5] (índices 0-2)
  - [1,3,5,2] (índices 0-3)

#### Exemplo 2:
**Input**: `nums = [1,1,1,1]`, `minK = 1`, `maxK = 1`  
**Output**: `10`  
**Explicação**:
- Todos os 10 subarrays possíveis são válidos pois todos elementos são 1, que é igual a `minK` e `maxK`

### Conclusão

Esta solução eficiente conta subarrays de limites fixos em tempo linear, utilizando índices para rastrear as posições relevantes e calculando a contagem de forma otimizada.

---

## [EN]

### The Problem

Given an integer array `nums` and two integers `minK` and `maxK`, we need to count how many subarrays are considered fixed-bound. A fixed-bound subarray must satisfy:
- The minimum value in the subarray equals `minK`
- The maximum value in the subarray equals `maxK`

### Reasoning

1. **Boundary Identification**:
   - Track the most recent indices where `minK` and `maxK` appear
   - Also identify the most recent index where a value outside `[minK, maxK]` occurs

2. **Valid Subarray Calculation**:
   - For each position in the array, calculate how many valid subarrays end at that position
   - A subarray is valid if it contains at least one `minK` and one `maxK`, and no elements outside the range

3. **Efficient Counting**:
   - Use stored indices to quickly determine how many valid subarrays end at current position
   - Each iteration updates relevant indices and calculates the count

### Complexity Analysis

- **Time**: O(n) - Single pass through the array
- **Space**: O(1) - Uses only a few variables to store indices

### Code Solution

```swift
class Solution {
    func countSubarrays(_ nums: [Int], _ minK: Int, _ maxK: Int) -> Int {
        var count = 0
        var minPos = -1
        var maxPos = -1
        var leftBound = -1
        let n = nums.count

        for i in 0..<n {
            let num = nums[i]

            // Update left bound if number is outside range
            if num < minK || num > maxK {
                leftBound = i
            }

            // Update most recent positions of minK and maxK
            if num == minK {
                minPos = i
            }
            if num == maxK {
                maxPos = i
            }

            // Calculate how many valid subarrays end at current position
            let validSubarrays = max(0, min(minPos, maxPos) - leftBound)
            count += validSubarrays
        }

        return count
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [1,3,5,2,7,5]`, `minK = 1`, `maxK = 5`  
**Output**: `2`  
**Explanation**:
- Valid subarrays:
  - [1,3,5] (indices 0-2)
  - [1,3,5,2] (indices 0-3)

#### Example 2:
**Input**: `nums = [1,1,1,1]`, `minK = 1`, `maxK = 1`  
**Output**: `10`  
**Explanation**:
- All 10 possible subarrays are valid since all elements are 1, which equals both `minK` and `maxK`

### Conclusion

This efficient solution counts fixed-bound subarrays in linear time by tracking relevant positions and optimizing the counting process.