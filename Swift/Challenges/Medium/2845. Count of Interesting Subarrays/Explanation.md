## [PT/BR]

### O Problema

Dado um array `nums` indexado em 0, um inteiro `modulo` e um inteiro `k`, precisamos contar quantos subarrays são considerados interessantes. Um subarray `nums[l..r]` é interessante se:
- `cnt` é o número de índices `i` no intervalo `[l, r]` onde `nums[i] % modulo == k`
- E `cnt % modulo == k`

### Raciocínio

1. **Pré-processamento**:
   - Para cada elemento, verificamos se `nums[i] % modulo == k`
   - Criamos um array binário onde 1 indica que a condição é satisfeita e 0 caso contrário

2. **Soma de Prefixo com Módulo**:
   - Calculamos a soma de prefixo do array binário, aplicando módulo `modulo` a cada passo
   - Usamos um dicionário para contar as ocorrências de cada resto da soma de prefixo

3. **Contagem de Subarrays**:
   - Para cada posição, calculamos o resto alvo que faria `(prefix[r] - prefix[l-1]) % modulo == k`
   - Contamos quantas vezes esse resto alvo apareceu anteriormente

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array uma vez
- **Espaço**: O(modulo) - Armazenamos no máximo `modulo` restos diferentes

### Solução em Código

```swift
class Solution {
    func countInterestingSubarrays(_ nums: [Int], _ modulo: Int, _ k: Int) -> Int {
        var totalCount = 0
        var freq = [Int: Int]()
        freq[0] = 1
        var currentPrefixSumMod = 0

        for num in nums {
            let contribution = (num % modulo == k) ? 1 : 0
            currentPrefixSumMod = (currentPrefixSumMod + contribution) % modulo
            
            let targetRem = (currentPrefixSumMod - k + modulo) % modulo
            
            totalCount += freq[targetRem, default: 0]
            
            freq[currentPrefixSumMod, default: 0] += 1
        }

        return totalCount
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [3,2,4]`, `modulo = 2`, `k = 1`  
**Output**: `3`  
**Explicação**:
- Array binário: [1,0,0] (3%2=1, 2%2=0, 4%2=0)
- Somas de prefixo: [1,1,1]
- Subarrays interessantes: [3], [3,2], [3,2,4]

#### Exemplo 2:
**Input**: `nums = [3,1,9,6]`, `modulo = 3`, `k = 0`  
**Output**: `2`  
**Explicação**:
- Array binário: [1,0,1,1] (3%3=0, 1%3=1, 9%3=0, 6%3=0)
- Somas de prefixo: [1,1,2,3]
- Subarrays interessantes: [3,1,9,6], [1]

### Conclusão

Esta solução eficiente utiliza soma de prefixo e contagem de restos para identificar subarrays interessantes em tempo linear, sendo ideal para os limites do problema.

---

## [EN]

### The Problem

Given a 0-indexed array `nums`, an integer `modulo`, and an integer `k`, we need to count how many subarrays are considered interesting. A subarray `nums[l..r]` is interesting if:
- `cnt` is the number of indices `i` in range `[l, r]` where `nums[i] % modulo == k`
- And `cnt % modulo == k`

### Reasoning

1. **Preprocessing**:
   - For each element, check if `nums[i] % modulo == k`
   - Create a binary array where 1 indicates the condition is met and 0 otherwise

2. **Prefix Sum with Modulo**:
   - Calculate prefix sum of binary array, applying `modulo` at each step
   - Use dictionary to count occurrences of each prefix sum remainder

3. **Subarray Counting**:
   - For each position, calculate target remainder that would make `(prefix[r] - prefix[l-1]) % modulo == k`
   - Count how many times this target remainder appeared before

### Complexity Analysis

- **Time**: O(n) - Single pass through array
- **Space**: O(modulo) - Store at most `modulo` distinct remainders

### Code Solution

```swift
class Solution {
    func countInterestingSubarrays(_ nums: [Int], _ modulo: Int, _ k: Int) -> Int {
        var totalCount = 0
        var freq = [Int: Int]()
        freq[0] = 1
        var currentPrefixSumMod = 0

        for num in nums {
            let contribution = (num % modulo == k) ? 1 : 0
            currentPrefixSumMod = (currentPrefixSumMod + contribution) % modulo
            
            let targetRem = (currentPrefixSumMod - k + modulo) % modulo
            
            totalCount += freq[targetRem, default: 0]
            
            freq[currentPrefixSumMod, default: 0] += 1
        }

        return totalCount
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [3,2,4]`, `modulo = 2`, `k = 1`  
**Output**: `3`  
**Explanation**:
- Binary array: [1,0,0] (3%2=1, 2%2=0, 4%2=0)
- Prefix sums: [1,1,1]
- Interesting subarrays: [3], [3,2], [3,2,4]

#### Example 2:
**Input**: `nums = [3,1,9,6]`, `modulo = 3`, `k = 0`  
**Output**: `2`  
**Explanation**:
- Binary array: [1,0,1,1] (3%3=0, 1%3=1, 9%3=0, 6%3=0)
- Prefix sums: [1,1,2,3]
- Interesting subarrays: [3,1,9,6], [1]

### Conclusion

This efficient solution uses prefix sums and remainder counting to identify interesting subarrays in linear time, making it ideal for the problem constraints.