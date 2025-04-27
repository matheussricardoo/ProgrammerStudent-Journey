## [PT/BR]

### O Problema

Dado um array de inteiros `nums`, precisamos retornar o número de subarrays de comprimento 3 onde a soma do primeiro e terceiro números é exatamente metade do número do meio.

### Raciocínio

1. **Verificação de Subarrays**:
   - Percorremos o array verificando todos os subarrays consecutivos de tamanho 3
   - Para cada subarray, verificamos se `2 * (primeiro + terceiro) == meio`

2. **Condição Específica**:
   - A condição matemática que define um subarray válido é que a soma dos elementos das extremidades, multiplicada por 2, deve ser igual ao elemento central

3. **Implementação Direta**:
   - Usamos um loop simples para iterar por todos os possíveis subarrays de tamanho 3
   - Contamos quantos satisfazem a condição especificada

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array uma vez, verificando cada possível subarray de tamanho 3
- **Espaço**: O(1) - Usamos apenas algumas variáveis auxiliares para contar e armazenar valores temporários

### Solução em Código

```swift
class Solution {
    func countSubarrays(_ nums: [Int]) -> Int {
        var count = 0
        let n = nums.count

        guard n >= 3 else { 
            return 0
        }

        for i in 0...(n - 3) {
            let first = nums[i]
            let middle = nums[i + 1]
            let third = nums[i + 2]

            if 2 * (first + third) == middle {
                count += 1
            }
        }

        return count
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [1,2,1,4,1]`  
**Output**: `1`  
**Explicação**:
- Subarrays de tamanho 3:
  - [1,2,1]: 2*(1+1) = 4 ≠ 2 → inválido
  - [2,1,4]: 2*(2+4) = 12 ≠ 1 → inválido
  - [1,4,1]: 2*(1+1) = 4 == 4 → válido
- Apenas 1 subarray válido

#### Exemplo 2:
**Input**: `nums = [1,1,1]`  
**Output**: `0`  
**Explicação**:
- Único subarray [1,1,1]: 2*(1+1) = 4 ≠ 1 → inválido
- Nenhum subarray válido

### Conclusão

Esta solução direta e eficiente verifica todos os subarrays possíveis de tamanho 3, contando aqueles que satisfazem a condição matemática especificada, com complexidade linear ideal para o tamanho do problema.

---

## [EN]

### The Problem

Given an integer array `nums`, return the number of subarrays of length 3 where the sum of the first and third numbers equals exactly half of the middle number.

### Reasoning

1. **Subarray Verification**:
   - Iterate through the array checking all consecutive subarrays of size 3
   - For each subarray, check if `2 * (first + third) == middle`

2. **Specific Condition**:
   - The mathematical condition defining a valid subarray is that the sum of the edge elements, multiplied by 2, must equal the center element

3. **Direct Implementation**:
   - Use a simple loop to iterate through all possible size-3 subarrays
   - Count how many satisfy the specified condition

### Complexity Analysis

- **Time**: O(n) - Single pass through the array checking each possible size-3 subarray
- **Space**: O(1) - Uses only a few helper variables for counting and temporary storage

### Code Solution

```swift
class Solution {
    func countSubarrays(_ nums: [Int]) -> Int {
        var count = 0
        let n = nums.count

        guard n >= 3 else { 
            return 0
        }

        for i in 0...(n - 3) {
            let first = nums[i]
            let middle = nums[i + 1]
            let third = nums[i + 2]

            if 2 * (first + third) == middle {
                count += 1
            }
        }

        return count
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [1,2,1,4,1]`  
**Output**: `1`  
**Explanation**:
- Size-3 subarrays:
  - [1,2,1]: 2*(1+1) = 4 ≠ 2 → invalid
  - [2,1,4]: 2*(2+4) = 12 ≠ 1 → invalid
  - [1,4,1]: 2*(1+1) = 4 == 4 → valid
- Only 1 valid subarray

#### Example 2:
**Input**: `nums = [1,1,1]`  
**Output**: `0`  
**Explanation**:
- Only subarray [1,1,1]: 2*(1+1) = 4 ≠ 1 → invalid
- No valid subarrays

### Conclusion

This straightforward and efficient solution checks all possible size-3 subarrays, counting those that satisfy the specified mathematical condition, with ideal linear complexity for the problem size.