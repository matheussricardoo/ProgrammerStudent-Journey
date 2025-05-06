## [PT/BR]

### O Problema

Temos dois tipos de peças para ladrilhar um tabuleiro 2 x n:
1. Dominó: peça retangular 2x1 (pode ser girada para ficar 1x2)
2. Tromino: peça em forma de L que cobre 3 quadrados (pode ser girada em 4 orientações)

Precisamos calcular de quantas maneiras diferentes podemos ladrilhar completamente um tabuleiro 2 x n usando essas peças, onde duas ladrilhagens são consideradas diferentes se houver pelo menos um par de quadrados adjacentes que estão cobertos de forma diferente.

### Raciocínio

1. **Casos Base**:
   - Para n = 1: Só podemos colocar 1 dominó vertical → 1 maneira
   - Para n = 2: Podemos colocar 2 dominós verticais ou 2 horizontais → 2 maneiras

2. **Relação de Recorrência**:
   - Para n ≥ 3, o número de ladrilhagens pode ser expresso como:
     - dp[n] = 2*dp[n-1] + dp[n-3]
   - Isso porque:
     - 2*dp[n-1]: Adicionamos um dominó vertical ou dois horizontais no final
     - dp[n-3]: Adicionamos um tromino que afeta os últimos 3 colunas

3. **Programação Dinâmica**:
   - Usamos um array para armazenar os resultados intermediários
   - Implementamos de forma iterativa para evitar estouro de pilha com recursão
   - Aplicamos módulo 10^9 + 7 para manter os números gerenciáveis

### Análise da Complexidade

- **Tempo**: O(n) - Calculamos iterativamente até n
- **Espaço**: O(1) - Usamos apenas 3 variáveis para armazenar os últimos resultados

### Solução em Código

```swift
import Foundation

class Solution {
    func numTilings(_ n: Int) -> Int {
        if n == 1 { return 1 }
        if n == 2 { return 2 }
        
        let MOD = 1_000_000_007
        
        // Inicializa os casos base
        var dp_i_3 = 1 // dp[0] (não usado diretamente)
        var dp_i_2 = 1 // dp[1]
        var dp_i_1 = 2 // dp[2]
        var dp_i = 0
        
        for _ in 3...n {
            dp_i = (2 * dp_i_1 % MOD + dp_i_3 % MOD) % MOD
            
            // Atualiza para próxima iteração
            dp_i_3 = dp_i_2
            dp_i_2 = dp_i_1
            dp_i_1 = dp_i
        }
        
        return dp_i
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: n = 3  
**Output**: 5  
**Explicação**:
1. Três dominós verticais
2. Dominó horizontal + dois verticais
3. Dois verticais + horizontal
4. Tromino + dominó (duas orientações)
Total: 5 maneiras

#### Exemplo 2:
**Input**: n = 1  
**Output**: 1  
**Explicação**:
- Apenas 1 dominó vertical possível

### Conclusão

Esta solução utiliza programação dinâmica para calcular eficientemente o número de ladrilhagens possíveis, evitando recálculos desnecessários através da relação de recorrência identificada. A abordagem iterativa com otimização de espaço garante boa performance mesmo para valores grandes de n.

---

## [EN]

### The Problem

We have two types of tiles to cover a 2 x n board:
1. Domino: 2x1 rectangular piece (can be rotated to 1x2)
2. Tromino: L-shaped piece covering 3 squares (can be rotated in 4 orientations)

We need to calculate how many distinct ways we can completely tile a 2 x n board using these pieces, where two tilings are considered different if there's at least one pair of adjacent squares covered differently.

### Reasoning

1. **Base Cases**:
   - For n = 1: Only 1 vertical domino → 1 way
   - For n = 2: Two vertical dominoes or two horizontal dominoes → 2 ways

2. **Recurrence Relation**:
   - For n ≥ 3, the number of tilings can be expressed as:
     - dp[n] = 2*dp[n-1] + dp[n-3]
   - This is because:
     - 2*dp[n-1]: Add a vertical domino or two horizontal dominoes at the end
     - dp[n-3]: Add a tromino affecting the last 3 columns

3. **Dynamic Programming**:
   - Use an array to store intermediate results
   - Implement iteratively to avoid stack overflow with recursion
   - Apply modulo 10^9 + 7 to keep numbers manageable

### Complexity Analysis

- **Time**: O(n) - Compute iteratively up to n
- **Space**: O(1) - Use only 3 variables to store recent results

### Code Solution

```swift
import Foundation

class Solution {
    func numTilings(_ n: Int) -> Int {
        if n == 1 { return 1 }
        if n == 2 { return 2 }
        
        let MOD = 1_000_000_007
        
        // Initialize base cases
        var dp_i_3 = 1 // dp[0] (not directly used)
        var dp_i_2 = 1 // dp[1]
        var dp_i_1 = 2 // dp[2]
        var dp_i = 0
        
        for _ in 3...n {
            dp_i = (2 * dp_i_1 % MOD + dp_i_3 % MOD) % MOD
            
            // Update for next iteration
            dp_i_3 = dp_i_2
            dp_i_2 = dp_i_1
            dp_i_1 = dp_i
        }
        
        return dp_i
    }
}
```

### Examples

#### Example 1:
**Input**: n = 3  
**Output**: 5  
**Explanation**:
1. Three vertical dominoes
2. Horizontal domino + two vertical
3. Two vertical + horizontal
4. Tromino + domino (two orientations)
Total: 5 ways

#### Example 2:
**Input**: n = 1  
**Output**: 1  
**Explanation**:
- Only 1 vertical domino possible

### Conclusion

This solution uses dynamic programming to efficiently calculate the number of possible tilings, avoiding unnecessary recalculations through the identified recurrence relation. The iterative approach with space optimization ensures good performance even for large values of n.