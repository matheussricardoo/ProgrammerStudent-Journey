## [PT/BR]

### O Problema

Você tem `k` sacos e um array `weights` onde `weights[i]` representa o peso da i-ésima bolinha de gude. O objetivo é dividir as bolinhas de gude nos `k` sacos seguindo estas regras:

1. Nenhum saco pode ficar vazio.
2. Se a i-ésima e a j-ésima bolinha estão no mesmo saco, todas as bolinhas com índices entre `i` e `j` também devem estar no mesmo saco.
3. O custo de um saco que contém as bolinhas de `i` até `j` é dado por `weights[i] + weights[j]`.
4. A pontuação total é a soma dos custos de todos os sacos.

A tarefa é retornar a diferença entre a pontuação máxima e mínima possível ao distribuir as bolinhas nos `k` sacos.

### Raciocínio

1. **Entendendo as Divisões**:
   - Para dividir `n` bolinhas em `k` sacos, precisamos fazer `k-1` cortes no array `weights`.
   - Cada corte entre as posições `i` e `i+1` significa que as bolinhas de `0` até `i` vão para um saco, e as de `i+1` até `n-1` vão para outro.

2. **Custo dos Cortes**:
   - O custo de cada corte entre `i` e `i+1` é `weights[i] + weights[i+1]`.
   - Esses custos são armazenados em um array `boundaryCosts`.

3. **Pontuação Mínima e Máxima**:
   - A pontuação mínima é obtida somando os `k-1` menores custos de corte.
   - A pontuação máxima é obtida somando os `k-1` maiores custos de corte.
   - A diferença entre essas pontuações é a resposta desejada.

4. **Casos Especiais**:
   - Se `k == 1` ou `k == n`, todas as distribuições terão a mesma pontuação, então a diferença é zero.

### Análise da Complexidade

- **Tempo**:
  - Calcular `boundaryCosts`: \( O(n) \).
  - Ordenar `boundaryCosts`: \( O(n \log n) \).
  - Calcular as somas dos prefixos e sufixos: \( O(k) \).
  - **Total**: \( O(n \log n) \).

- **Espaço**:
  - Armazenar `boundaryCosts`: \( O(n) \).
  - **Total**: \( O(n) \).

### Solução em Código

```swift
import Foundation 

class Solution {
    func putMarbles(_ weights: [Int], _ k: Int) -> Int {
        let n = weights.count
        
        if k == 1 || k == n {
            return 0
        }

        var boundaryCosts: [Int] = []
        boundaryCosts.reserveCapacity(n - 1) 
        
        for i in 0..<(n - 1) {
             boundaryCosts.append(weights[i] + weights[i + 1])
        }

        boundaryCosts.sort()

        let numSplits = k - 1
        
        let minScoreContribution = boundaryCosts.prefix(numSplits).reduce(0, +)
        let maxScoreContribution = boundaryCosts.suffix(numSplits).reduce(0, +)

        return maxScoreContribution - minScoreContribution
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `weights = [1,3,5,1]`, `k = 2`  
**Output**: `4`  
**Explicação**:
- `boundaryCosts = [1+3, 3+5, 5+1] = [4, 8, 6]`.
- Ordenado: `[4, 6, 8]`.
- `k-1 = 1`, então:
  - Pontuação mínima: `4` (corte entre 1 e 3).
  - Pontuação máxima: `8` (corte entre 3 e 5).
- Diferença: `8 - 4 = 4`.

#### Exemplo 2:
**Input**: `weights = [1, 3]`, `k = 2`  
**Output**: `0`  
**Explicação**:
- A única divisão possível é `[1],[3]`.
- Ambas as pontuações são `(1+1) + (3+3) = 4` (na verdade, o custo é `(1+1) + (3+3) = 4` para qualquer divisão, já que só há um corte possível).
- Diferença: `0`.

### Conclusão

A solução apresentada calcula eficientemente a diferença entre as pontuações máxima e mínima ao distribuir as bolinhas de gude nos sacos. Utilizando ordenação e somas de prefixos/sufixos, o algoritmo garante um desempenho ótimo para os limites dados. A abordagem é direta e eficaz, resolvendo o problema dentro das restrições de tempo e espaço.

---

## [EN]

### The Problem

You have `k` bags and an array `weights` where `weights[i]` represents the weight of the i-th marble. The goal is to divide the marbles into the `k` bags following these rules:

1. No bag can be empty.
2. If the i-th and j-th marbles are in the same bag, all marbles with indices between `i` and `j` must also be in that bag.
3. The cost of a bag containing marbles from `i` to `j` is `weights[i] + weights[j]`.
4. The total score is the sum of the costs of all bags.

The task is to return the difference between the maximum and minimum possible scores when distributing the marbles into `k` bags.

### Reasoning

1. **Understanding the Divisions**:
   - To divide `n` marbles into `k` bags, we need to make `k-1` cuts in the `weights` array.
   - Each cut between positions `i` and `i+1` means marbles from `0` to `i` go into one bag, and marbles from `i+1` to `n-1` go into another.

2. **Cost of Cuts**:
   - The cost of each cut between `i` and `i+1` is `weights[i] + weights[i+1]`.
   - These costs are stored in an array `boundaryCosts`.

3. **Minimum and Maximum Scores**:
   - The minimum score is obtained by summing the `k-1` smallest cut costs.
   - The maximum score is obtained by summing the `k-1` largest cut costs.
   - The difference between these scores is the desired answer.

4. **Special Cases**:
   - If `k == 1` or `k == n`, all distributions will have the same score, so the difference is zero.

### Complexity Analysis

- **Time**:
  - Calculating `boundaryCosts`: \( O(n) \).
  - Sorting `boundaryCosts`: \( O(n \log n) \).
  - Calculating prefix and suffix sums: \( O(k) \).
  - **Total**: \( O(n \log n) \).

- **Space**:
  - Storing `boundaryCosts`: \( O(n) \).
  - **Total**: \( O(n) \).

### Code Solution

```swift
import Foundation 

class Solution {
    func putMarbles(_ weights: [Int], _ k: Int) -> Int {
        let n = weights.count
        
        if k == 1 || k == n {
            return 0
        }

        var boundaryCosts: [Int] = []
        boundaryCosts.reserveCapacity(n - 1) 
        
        for i in 0..<(n - 1) {
             boundaryCosts.append(weights[i] + weights[i + 1])
        }

        boundaryCosts.sort()

        let numSplits = k - 1
        
        let minScoreContribution = boundaryCosts.prefix(numSplits).reduce(0, +)
        let maxScoreContribution = boundaryCosts.suffix(numSplits).reduce(0, +)

        return maxScoreContribution - minScoreContribution
    }
}
```

### Examples

#### Example 1:
**Input**: `weights = [1,3,5,1]`, `k = 2`  
**Output**: `4`  
**Explanation**:
- `boundaryCosts = [1+3, 3+5, 5+1] = [4, 8, 6]`.
- Sorted: `[4, 6, 8]`.
- `k-1 = 1`, so:
  - Minimum score: `4` (cut between 1 and 3).
  - Maximum score: `8` (cut between 3 and 5).
- Difference: `8 - 4 = 4`.

#### Example 2:
**Input**: `weights = [1, 3]`, `k = 2`  
**Output**: `0`  
**Explanation**:
- The only possible division is `[1],[3]`.
- Both scores are `(1+1) + (3+3) = 4` (actually, the cost is `(1+1) + (3+3) = 4` for any division, since there's only one possible cut).
- Difference: `0`.

### Conclusion

The provided solution efficiently calculates the difference between the maximum and minimum scores when distributing marbles into bags. By using sorting and prefix/suffix sums, the algorithm ensures optimal performance within the given constraints. The approach is straightforward and effective, solving the problem within time and space limits.