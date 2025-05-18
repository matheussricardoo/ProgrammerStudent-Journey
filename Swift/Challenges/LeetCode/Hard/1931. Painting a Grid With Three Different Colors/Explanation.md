## [PT/BR]

### O Problema

Você recebe dois inteiros `m` e `n`, representando as dimensões de uma grade (`m x n`).

Cada célula da grade deve ser pintada com uma cor entre 3 opções: **vermelho, verde ou azul** (representados por 0, 1 e 2).  
A regra é que **nenhuma duas células adjacentes** (horizontal ou verticalmente) podem ter a mesma cor.

O objetivo é calcular o número de **formas válidas de colorir toda a grade** seguindo essas regras. Como esse número pode ser muito grande, retorne-o **modulo $10^9 + 7$**.

---

### Raciocínio

1. **Entendendo o problema**:
   - Cada coluna tem `m` células
   - Cada célula tem 3 possíveis cores
   - Adjacências verticais devem ter cores diferentes → restrição dentro da coluna
   - Adjacências horizontais também → restrição entre colunas consecutivas

2. **Estratégia – Programação Dinâmica + Combinatória**:
   - Primeiro, geramos todas as **configurações válidas para uma única coluna**
     - Ou seja, sequências de `m` elementos com valores 0, 1 ou 2, onde **células adjacentes têm cores diferentes**
   - Depois, verificamos quais dessas colunas são compatíveis com outras → não compartilham cor na mesma posição
   - Usamos **programação dinâmica** para contar quantas maneiras há de montar a grade coluna por coluna, respeitando as transições válidas

3. **Vantagem da abordagem**:
   - Gera todas as configurações possíveis de coluna apenas uma vez
   - Trabalha com número pequeno de estados (no máximo algumas centenas)
   - Usa DP para resolver eficientemente até para `n = 1000`

---

### Análise da Complexidade

- **Tempo**:  
  - Geração de estados: $O(3^m)$ → aceitável pois `m <= 5`
  - DP: $O(n \cdot k^2)$, onde `k` é o número de estados válidos
- **Espaço**: $O(k^2 + n)$ → armazenamento de compatibilidades e DP

---

### Solução em Código (comentários em português)

```swift
class Solution {
    func colorTheGrid(_ m: Int, _ n: Int) -> Int {
        let MOD = 1_000_000_007
        
        // Passo 1: Gerar todas as combinações válidas para uma coluna
        var validColors = [[Int]]()
        func backtrack(_ path: [Int]) {
            if path.count == m {
                validColors.append(path)
                return
            }
            let last = path.last ?? -1
            for c in 0...2 {
                if last != c {
                    var newPath = path
                    newPath.append(c)
                    backtrack(newPath)
                }
            }
        }
        backtrack([])
        
        let k = validColors.count
        if k == 0 {
            return 0
        }
        
        // Passo 2: Construir mapa de compatibilidade entre colunas
        var compatible = [Int: [Int]]()
        for i in 0..<k {
            compatible[i] = []
            for j in 0..<k {
                var allDifferent = true
                for idx in 0..<m {
                    if validColors[i][idx] == validColors[j][idx] {
                        allDifferent = false
                        break
                    }
                }
                if allDifferent {
                    compatible[i]?.append(j)
                }
            }
        }
        
        // Passo 3: Programação Dinâmica para contar formas de montar a grade
        var dp = [Int](repeating: 1, count: k)
        
        // Para cada nova coluna adicional
        for _ in 1..<n {
            var newDp = [Int](repeating: 0, count: k)
            for i in 0..<k {
                // Para cada estado compatível com i
                for j in compatible[i] ?? [] {
                    newDp[j] = (newDp[j] + dp[i]) % MOD
                }
            }
            dp = newDp
        }
        
        // Retornar soma total de todos os caminhos possíveis
        return dp.reduce(0, { ($0 + $1) % MOD })
    }
}
```

---

### Exemplos

#### Exemplo 1:
**Input**: `m = 1`, `n = 1`  
**Output**: `3`  
**Explicação**: Só existe uma célula, e ela pode ser colorida com qualquer uma das 3 cores

#### Exemplo 2:
**Input**: `m = 1`, `n = 2`  
**Output**: `6`  
**Explicação**: Para 2 colunas de 1 linha, temos 3 escolhas para a primeira coluna, e 2 para a segunda (diferente da primeira)

#### Exemplo 3:
**Input**: `m = 5`, `n = 5`  
**Output**: `580986`  
**Explicação**: Número total de combinações válidas após aplicar todas as restrições

---

### Conclusão

Este é um exemplo clássico de problema combinatório com restrições espaciais. A solução usa backtracking para gerar estados válidos, e programação dinâmica para contar formas válidas de construir a grade completa.

É uma abordagem inteligente e otimizada, especialmente útil para casos onde `n` é grande (`n <= 1000`) mas `m` é pequeno (`m <= 5`), como exigido pelas restrições.

---

## [EN]

### The Problem

You are given two integers `m` and `n`, representing the dimensions of an `m x n` grid.

Each cell must be painted red (0), green (1), or blue (2), and **adjacent cells cannot have the same color**.

Return the number of ways to paint the entire grid under these constraints. Since the answer may be large, return it modulo $10^9 + 7$.

---

### Reasoning

1. **Constraints**:
   - Each column has `m` cells
   - All adjacent cells (vertical and horizontal) must have different colors
   - Grid must be fully colored

2. **Efficient Strategy – Backtracking + Dynamic Programming**:
   - Generate all valid column colorings where no two adjacent cells have the same color
   - Build compatibility map between these column patterns
   - Use dynamic programming to count how many valid grids can be formed with `n` columns

3. **Why this works**:
   - For small `m` (`<= 5`), number of valid column patterns is manageable
   - Compatibility map ensures transitions between columns are valid
   - DP efficiently builds up the solution for larger values of `n`

---

### Complexity Analysis

- **Time**:  
  - State generation: $O(3^m)$ → acceptable for `m <= 5`  
  - DP step: $O(n \cdot k^2)$, where `k` is the number of valid states
- **Space**: $O(k^2 + n)$ — for compatibility matrix and DP arrays

---

### Code Solution (comments in English)

```swift
class Solution {
    func colorTheGrid(_ m: Int, _ n: Int) -> Int {
        let MOD = 1_000_000_007
        
        // Step 1: Generate all valid column colorings
        var validColors = [[Int]]()
        func backtrack(_ path: [Int]) {
            if path.count == m {
                validColors.append(path)
                return
            }
            let last = path.last ?? -1
            for c in 0...2 {
                if last != c {
                    var newPath = path
                    newPath.append(c)
                    backtrack(newPath)
                }
            }
        }
        backtrack([])
        
        let k = validColors.count
        if k == 0 {
            return 0
        }
        
        // Step 2: Build compatibility map
        var compatible = [Int: [Int]]()
        for i in 0..<k {
            compatible[i] = []
            for j in 0..<k {
                var allDifferent = true
                for idx in 0..<m {
                    if validColors[i][idx] == validColors[j][idx] {
                        allDifferent = false
                        break
                    }
                }
                if allDifferent {
                    compatible[i]?.append(j)
                }
            }
        }
        
        // Step 3: DP initialization
        var dp = [Int](repeating: 1, count: k)
        
        // Iterate for each additional column
        for _ in 1..<n {
            var newDp = [Int](repeating: 0, count: k)
            for i in 0..<k {
                for j in compatible[i] ?? [] {
                    newDp[j] = (newDp[j] + dp[i]) % MOD
                }
            }
            dp = newDp
        }
        
        return dp.reduce(0, { ($0 + $1) % MOD })
    }
}
```

---

### Examples

#### Example 1:
**Input**: `m = 1`, `n = 1`  
**Output**: `3`  
**Explanation**: Only one cell, three possible colors

#### Example 2:
**Input**: `m = 1`, `n = 2`  
**Output**: `6`  
**Explanation**: 3 choices for first column, 2 for second (must differ)

#### Example 3:
**Input**: `m = 5`, `n = 5`  
**Output**: `580986`  
**Explanation**: Total valid colorings using dynamic programming

---

### Conclusion

This problem shows how **backtracking + dynamic programming** can solve complex combinatorial problems efficiently. By precomputing valid states and tracking state transitions, we reduce the complexity significantly.

It's especially useful when `m` is small but `n` is large, which fits the constraints perfectly.