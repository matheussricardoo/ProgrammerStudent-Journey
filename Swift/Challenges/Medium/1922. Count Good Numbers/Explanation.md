## [PT/BR]

### O Problema

Dado um inteiro `n`, precisamos contar quantas strings de dígitos "boas" existem com comprimento `n`. Uma string é considerada boa se:

1. Dígitos em posições pares (0-indexed) são pares (0, 2, 4, 6, 8)
2. Dígitos em posições ímpares são primos (2, 3, 5, 7)

### Raciocínio

1. **Análise Combinatória**:
   - Para cada posição par: 5 opções (0,2,4,6,8)
   - Para cada posição ímpar: 4 opções (2,3,5,7)
   - O número total é o produto das possibilidades para cada posição

2. **Cálculo Eficiente**:
   - Número de posições pares: `(n + 1) // 2`
   - Número de posições ímpares: `n // 2`
   - Usamos exponenciação modular para calcular grandes potências eficientemente

3. **Otimização**:
   - Pré-calculamos as potências usando o método de exponenciação por quadratura
   - Aplicamos módulo 10^9 + 7 em cada operação para evitar overflow

### Análise da Complexidade

- **Tempo**: O(log n) - Devido à exponenciação por quadratura
- **Espaço**: O(1) - Usamos apenas variáveis auxiliares constantes

### Solução em Código

```swift
import Foundation

class Solution {
    let MOD = 1_000_000_007

    // Função de exponenciação modular eficiente
    private func power(_ base: Int, _ exp: Int, _ mod: Int) -> Int {
        if exp == 0 {
            return 1 % mod
        }
        if base == 0 {
            return 0
        }

        var result: Int = 1
        var b: Int = base % mod
        var e: Int = exp 

        while e > 0 {
            if e % 2 == 1 {
                result = (result * b) % mod
            }
            b = (b * b) % mod
            e /= 2
        }
        
        return result
    }

    func countGoodNumbers(_ n: Int) -> Int {
        let choicesEven = 5 // Dígitos pares: 0,2,4,6,8
        let choicesOdd = 4  // Dígitos primos: 2,3,5,7

        // Conta posições pares e ímpares
        let evenCount = (n + 1) / 2
        let oddCount = n / 2

        // Calcula (5^evenCount) % MOD e (4^oddCount) % MOD
        let pow5 = power(choicesEven, evenCount, MOD)
        let pow4 = power(choicesOdd, oddCount, MOD)

        // Combina os resultados
        let result = (pow5 * pow4) % MOD

        return result
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `n = 1`  
**Output**: `5`  
**Explicação**:
- Apenas 1 posição (posição 0, par)
- Possibilidades: "0", "2", "4", "6", "8"
- Total: 5

#### Exemplo 2:
**Input**: `n = 4`  
**Output**: `400`  
**Explicação**:
- Posições pares (0,2): 5 opções cada
- Posições ímpares (1,3): 4 opções cada
- Total: 5 × 4 × 5 × 4 = 400

#### Exemplo 3:
**Input**: `n = 50`  
**Output**: `564908303`  
**Explicação**:
- Cálculo de grandes potências usando exponenciação modular
- Resultado módulo 10^9 + 7

### Conclusão

Esta solução eficiente conta strings de dígitos boas usando princípios combinatórios e exponenciação modular para lidar com valores grandes. A abordagem é ótima para o intervalo dado (até n = 10^15).

---

## [EN]

### The Problem

Given an integer `n`, we need to count how many "good" digit strings exist with length `n`. A string is considered good if:

1. Digits at even positions (0-indexed) are even (0, 2, 4, 6, 8)
2. Digits at odd positions are prime (2, 3, 5, 7)

### Reasoning

1. **Combinatorial Analysis**:
   - For each even position: 5 options (0,2,4,6,8)
   - For each odd position: 4 options (2,3,5,7)
   - Total count is the product of possibilities for each position

2. **Efficient Calculation**:
   - Number of even positions: `(n + 1) // 2`
   - Number of odd positions: `n // 2`
   - Use modular exponentiation for efficient large power calculations

3. **Optimization**:
   - Precompute powers using exponentiation by squaring
   - Apply modulo 10^9 + 7 at each operation to prevent overflow

### Complexity Analysis

- **Time**: O(log n) - Due to exponentiation by squaring
- **Space**: O(1) - Uses only constant auxiliary variables

### Code Solution

```swift
import Foundation

class Solution {
    let MOD = 1_000_000_007

    // Efficient modular exponentiation function
    private func power(_ base: Int, _ exp: Int, _ mod: Int) -> Int {
        if exp == 0 {
            return 1 % mod
        }
        if base == 0 {
            return 0
        }

        var result: Int = 1
        var b: Int = base % mod
        var e: Int = exp 

        while e > 0 {
            if e % 2 == 1 {
                result = (result * b) % mod
            }
            b = (b * b) % mod
            e /= 2
        }
        
        return result
    }

    func countGoodNumbers(_ n: Int) -> Int {
        let choicesEven = 5 // Even digits: 0,2,4,6,8
        let choicesOdd = 4  // Prime digits: 2,3,5,7

        // Count even and odd positions
        let evenCount = (n + 1) / 2
        let oddCount = n / 2

        // Calculate (5^evenCount) % MOD and (4^oddCount) % MOD
        let pow5 = power(choicesEven, evenCount, MOD)
        let pow4 = power(choicesOdd, oddCount, MOD)

        // Combine results
        let result = (pow5 * pow4) % MOD

        return result
    }
}
```

### Examples

#### Example 1:
**Input**: `n = 1`  
**Output**: `5`  
**Explanation**:
- Only 1 position (position 0, even)
- Possibilities: "0", "2", "4", "6", "8"
- Total: 5

#### Example 2:
**Input**: `n = 4`  
**Output**: `400`  
**Explanation**:
- Even positions (0,2): 5 options each
- Odd positions (1,3): 4 options each
- Total: 5 × 4 × 5 × 4 = 400

#### Example 3:
**Input**: `n = 50`  
**Output**: `564908303`  
**Explanation**:
- Large power calculations using modular exponentiation
- Result modulo 10^9 + 7

### Conclusion

This efficient solution counts good digit strings using combinatorial principles and modular exponentiation to handle large values. The approach is optimal for the given range (up to n = 10^15).