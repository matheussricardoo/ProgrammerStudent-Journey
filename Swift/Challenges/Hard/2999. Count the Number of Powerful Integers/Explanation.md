## [PT/BR]

### O Problema

Dados três inteiros `start`, `finish` e `limit`, e uma string `s` representando um inteiro positivo, precisamos contar quantos números "poderosos" existem no intervalo [start..finish]. Um número é considerado poderoso se:

1. Termina com a string `s` (ou seja, `s` é um sufixo do número)
2. Todos os seus dígitos são menores ou iguais a `limit`

### Raciocínio

1. **Pré-processamento**:
   - Convertemos a string `s` para um inteiro `S`
   - Calculamos `P = 10^m` onde `m` é o comprimento de `s` (para identificar sufixos)

2. **Contagem de Números Poderosos**:
   - Usamos uma abordagem de programação dinâmica para contar números válidos
   - Calculamos a quantidade para `finish` e subtraímos a quantidade para `start-1` (técnica de prefix sum)
   - Para cada número `N`, consideramos:
     - Números no formato `prefixo * P + S`
     - Onde `prefixo` deve ter dígitos ≤ `limit`

3. **Otimização**:
   - Usamos memoização para armazenar resultados intermediários
   - Limitamos a busca considerando apenas prefixos válidos

### Análise da Complexidade

- **Tempo**: O(log N) para cada chamada de `calculateCount` (devido à DP)
- **Espaço**: O(log N) para armazenamento da memoização

### Solução em Código

```swift
import Foundation

fileprivate class DigitDPSolver {
    let K_str_digits: [Int] 
    let L_K: Int          
    let limit: Int        
    var memo: [[[Int?]]] 

    init(K: Int, limit: Int) {
        let K_str = String(K)
        self.K_str_digits = K_str.map { Int(String($0))! } 
        self.L_K = K_str_digits.count
        self.limit = limit
        self.memo = Array(repeating: Array(repeating: Array(repeating: nil, count: 2), count: 2), count: L_K)
    }

    func count() -> Int {
        return solve(idx: 0, is_less: false, is_leading: true)
    }

    private func solve(idx: Int, is_less: Bool, is_leading: Bool) -> Int {
        if idx == L_K { return 1 } 
      
        let isLessIdx = is_less ? 1 : 0
        let isLeadingIdx = is_leading ? 1 : 0
        if let cached = memo[idx][isLessIdx][isLeadingIdx] {
            return cached
        }

        var ans = 0 
        
        let current_limit_digit = K_str_digits[idx]
        let upper_bound = is_less ? limit : min(limit, current_limit_digit)
      
        for d in 0...upper_bound {
            let new_is_less = is_less || (d < current_limit_digit)
            
            if is_leading {
                if d == 0 {
                    ans += solve(idx: idx + 1, is_less: new_is_less, is_leading: true)
                } else { 
                    ans += solve(idx: idx + 1, is_less: new_is_less, is_leading: false)
                }
            } else { 
                ans += solve(idx: idx + 1, is_less: new_is_less, is_leading: false)
            }
        }
      
        memo[idx][isLessIdx][isLeadingIdx] = ans
        return ans
    }
}

class Solution {
    func numberOfPowerfulInt(_ start: Int, _ finish: Int, _ limit: Int, _ s: String) -> Int {
        guard let S = Int(s) else { 
            return 0 
        }
        let m = s.count 
        
        var P: Int = 1
        for _ in 0..<m {
             if P > Int.max / 10 { 
                 return 0 
             }
             P *= 10
        }

        let count_finish = calculateCount(N: finish, limit: limit, S: S, P: P)
        let count_start_minus_1 = calculateCount(N: start - 1, limit: limit, S: S, P: P)
      
        return count_finish - count_start_minus_1
    }

    private func calculateCount(N: Int, limit: Int, S: Int, P: Int) -> Int {
        if N < S { return 0 }
      
        var totalPowerfulCount = 0
      
        if S <= N {
            totalPowerfulCount = 1 
        }
      
        let diff = N - S 
        let N_prefix_limit = diff / P 
            
        if N_prefix_limit > 0 {
            let solver = DigitDPSolver(K: N_prefix_limit, limit: limit)
            let count_p_including_zero = solver.count() 
                
            let count_positive_p = count_p_including_zero - 1
                
            totalPowerfulCount += count_positive_p
        }

        return totalPowerfulCount
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `start = 1`, `finish = 6000`, `limit = 4`, `s = "124"`  
**Output**: `5`  
**Explicação**:
- Números poderosos: 124, 1124, 2124, 3124, 4124
- Total: 5

#### Exemplo 2:
**Input**: `start = 15`, `finish = 215`, `limit = 6`, `s = "10"`  
**Output**: `2`  
**Explicação**:
- Números poderosos: 110, 210
- Total: 2

#### Exemplo 3:
**Input**: `start = 1000`, `finish = 2000`, `limit = 4`, `s = "3000"`  
**Output**: `0`  
**Explicação**:
- Nenhum número no intervalo tem sufixo 3000

### Conclusão

Esta solução eficiente conta números poderosos usando programação dinâmica e técnicas de prefix sum, garantindo performance ótima mesmo para intervalos grandes (até 10^15). A abordagem divide o problema em partes gerenciáveis e usa memoização para evitar recálculos desnecessários.

---

## [EN]

### The Problem

Given three integers `start`, `finish`, and `limit`, and a string `s` representing a positive integer, we need to count how many "powerful" numbers exist in the range [start..finish]. A number is considered powerful if:

1. It ends with the string `s` (i.e., `s` is a suffix of the number)
2. All its digits are less than or equal to `limit`

### Reasoning

1. **Preprocessing**:
   - Convert string `s` to integer `S`
   - Calculate `P = 10^m` where `m` is the length of `s` (to identify suffixes)

2. **Counting Powerful Numbers**:
   - Use dynamic programming to count valid numbers
   - Calculate count for `finish` and subtract count for `start-1` (prefix sum technique)
   - For each number `N`, consider:
     - Numbers in format `prefix * P + S`
     - Where `prefix` must have digits ≤ `limit`

3. **Optimization**:
   - Use memoization to store intermediate results
   - Limit search to valid prefixes only

### Complexity Analysis

- **Time**: O(log N) per `calculateCount` call (due to DP)
- **Space**: O(log N) for memoization storage

### Code Solution

```swift
import Foundation

fileprivate class DigitDPSolver {
    let K_str_digits: [Int] 
    let L_K: Int          
    let limit: Int        
    var memo: [[[Int?]]] 

    init(K: Int, limit: Int) {
        let K_str = String(K)
        self.K_str_digits = K_str.map { Int(String($0))! } 
        self.L_K = K_str_digits.count
        self.limit = limit
        self.memo = Array(repeating: Array(repeating: Array(repeating: nil, count: 2), count: 2), count: L_K)
    }

    func count() -> Int {
        return solve(idx: 0, is_less: false, is_leading: true)
    }

    private func solve(idx: Int, is_less: Bool, is_leading: Bool) -> Int {
        if idx == L_K { return 1 } 
      
        let isLessIdx = is_less ? 1 : 0
        let isLeadingIdx = is_leading ? 1 : 0
        if let cached = memo[idx][isLessIdx][isLeadingIdx] {
            return cached
        }

        var ans = 0 
        
        let current_limit_digit = K_str_digits[idx]
        let upper_bound = is_less ? limit : min(limit, current_limit_digit)
      
        for d in 0...upper_bound {
            let new_is_less = is_less || (d < current_limit_digit)
            
            if is_leading {
                if d == 0 {
                    ans += solve(idx: idx + 1, is_less: new_is_less, is_leading: true)
                } else { 
                    ans += solve(idx: idx + 1, is_less: new_is_less, is_leading: false)
                }
            } else { 
                ans += solve(idx: idx + 1, is_less: new_is_less, is_leading: false)
            }
        }
      
        memo[idx][isLessIdx][isLeadingIdx] = ans
        return ans
    }
}

class Solution {
    func numberOfPowerfulInt(_ start: Int, _ finish: Int, _ limit: Int, _ s: String) -> Int {
        guard let S = Int(s) else { 
            return 0 
        }
        let m = s.count 
        
        var P: Int = 1
        for _ in 0..<m {
             if P > Int.max / 10 { 
                 return 0 
             }
             P *= 10
        }

        let count_finish = calculateCount(N: finish, limit: limit, S: S, P: P)
        let count_start_minus_1 = calculateCount(N: start - 1, limit: limit, S: S, P: P)
      
        return count_finish - count_start_minus_1
    }

    private func calculateCount(N: Int, limit: Int, S: Int, P: Int) -> Int {
        if N < S { return 0 }
      
        var totalPowerfulCount = 0
      
        if S <= N {
            totalPowerfulCount = 1 
        }
      
        let diff = N - S 
        let N_prefix_limit = diff / P 
            
        if N_prefix_limit > 0 {
            let solver = DigitDPSolver(K: N_prefix_limit, limit: limit)
            let count_p_including_zero = solver.count() 
                
            let count_positive_p = count_p_including_zero - 1
                
            totalPowerfulCount += count_positive_p
        }

        return totalPowerfulCount
    }
}
```

### Examples

#### Example 1:
**Input**: `start = 1`, `finish = 6000`, `limit = 4`, `s = "124"`  
**Output**: `5`  
**Explanation**:
- Powerful numbers: 124, 1124, 2124, 3124, 4124
- Total: 5

#### Example 2:
**Input**: `start = 15`, `finish = 215`, `limit = 6`, `s = "10"`  
**Output**: `2`  
**Explanation**:
- Powerful numbers: 110, 210
- Total: 2

#### Example 3:
**Input**: `start = 1000`, `finish = 2000`, `limit = 4`, `s = "3000"`  
**Output**: `0`  
**Explanation**:
- No numbers in range have suffix 3000

### Conclusion

This efficient solution counts powerful numbers using dynamic programming and prefix sum techniques, ensuring optimal performance even for large ranges (up to 10^15). The approach breaks the problem into manageable parts and uses memoization to avoid unnecessary recalculations.