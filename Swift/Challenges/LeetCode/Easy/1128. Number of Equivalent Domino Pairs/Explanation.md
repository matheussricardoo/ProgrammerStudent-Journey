## [PT/BR]

### O Problema

Dada uma lista de dominós, onde cada dominó é representado por um par de números `[a, b]`, dois dominós são considerados equivalentes se eles forem iguais ou se um puder ser girado para se tornar igual ao outro (ou seja, `[a, b]` é equivalente a `[b, a]`). Precisamos contar quantos pares de índices `(i, j)` existem onde `i < j` e `dominoes[i]` é equivalente a `dominoes[j]`.

### Raciocínio

1. **Normalização dos Dominós**:
   - Para tratar `[a, b]` e `[b, a]` como o mesmo dominó, podemos normalizar cada par ordenando os valores. Assim, ambos `[a, b]` e `[b, a]` serão representados como `[min(a, b), max(a, b)]`.

2. **Contagem de Ocorrências**:
   - Usamos um dicionário para contar quantas vezes cada dominó normalizado aparece na lista.
   - Para cada dominó, convertemos ele em sua forma normalizada e atualizamos o dicionário.

3. **Cálculo de Pares**:
   - Para cada dominó, o número de pares que podem ser formados com ele é igual ao número de vezes que esse dominó já apareceu antes. Isso porque cada aparição anterior pode formar um novo par com o dominó atual.
   - Somamos esse valor ao total de pares e atualizamos a contagem no dicionário.

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos a lista de dominós uma única vez.
- **Espaço**: O(n) - No pior caso, armazenamos cada dominó no dicionário.

### Solução em Código

```swift
import Foundation

class Solution {
    func numEquivDominoPairs(_ dominoes: [[Int]]) -> Int {
        var pairCount = 0
        var counts: [Int: Int] = [:]

        for domino in dominoes {
            guard domino.count == 2 else { continue } 
            let a = domino[0]
            let b = domino[1]

            // Normaliza o dominó para tratar [a, b] e [b, a] como iguais
            let key = min(a, b) * 10 + max(a, b)

            // Adiciona o número de vezes que esse dominó já apareceu ao contador de pares
            pairCount += counts[key, default: 0]

            // Incrementa a contagem desse dominó no dicionário
            counts[key, default: 0] += 1
        }

        return pairCount
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `dominoes = [[1,2],[2,1],[3,4],[5,6]]`  
**Output**: `1`  
**Explicação**:
- Os dominós `[1,2]` e `[2,1]` são equivalentes, formando um par.
- Os outros dominós não têm equivalentes, então o total é 1.

#### Exemplo 2:
**Input**: `dominoes = [[1,2],[1,2],[1,1],[1,2],[2,2]]`  
**Output**: `3`  
**Explicação**:
- Três pares podem ser formados com os dominós `[1,2]` (que são equivalentes a `[2,1]`).
- O dominó `[1,1]` não forma pares adicionais, e `[2,2]` aparece apenas uma vez.

### Conclusão

Esta solução eficiente normaliza cada dominó para tratar giros como equivalentes e conta quantas vezes cada dominó normalizado aparece, permitindo calcular o número de pares equivalentes de forma otimizada. A abordagem garante que todos os pares sejam contados com complexidade linear.

---

## [EN]

### The Problem

Given a list of dominoes, where each domino is represented by a pair of numbers `[a, b]`, two dominoes are considered equivalent if they are equal or if one can be rotated to become equal to the other (i.e., `[a, b]` is equivalent to `[b, a]`). We need to count how many index pairs `(i, j)` exist where `i < j` and `dominoes[i]` is equivalent to `dominoes[j]`.

### Reasoning

1. **Normalization of Dominoes**:
   - To treat `[a, b]` and `[b, a]` as the same domino, we can normalize each pair by sorting the values. Thus, both `[a, b]` and `[b, a]` will be represented as `[min(a, b), max(a, b)]`.

2. **Counting Occurrences**:
   - We use a dictionary to count how many times each normalized domino appears in the list.
   - For each domino, we convert it to its normalized form and update the dictionary.

3. **Pair Calculation**:
   - For each domino, the number of pairs that can be formed with it is equal to the number of times that domino has appeared before. This is because each previous occurrence can form a new pair with the current domino.
   - We add this value to the total pair count and update the count in the dictionary.

### Complexity Analysis

- **Time**: O(n) - We traverse the list of dominoes once.
- **Space**: O(n) - In the worst case, we store each domino in the dictionary.

### Code Solution

```swift
import Foundation

class Solution {
    func numEquivDominoPairs(_ dominoes: [[Int]]) -> Int {
        var pairCount = 0
        var counts: [Int: Int] = [:]

        for domino in dominoes {
            guard domino.count == 2 else { continue } 
            let a = domino[0]
            let b = domino[1]

            // Normalize the domino to treat [a, b] and [b, a] as equal
            let key = min(a, b) * 10 + max(a, b)

            // Add the number of times this domino has appeared to the pair count
            pairCount += counts[key, default: 0]

            // Increment the count of this domino in the dictionary
            counts[key, default: 0] += 1
        }

        return pairCount
    }
}
```

### Examples

#### Example 1:
**Input**: `dominoes = [[1,2],[2,1],[3,4],[5,6]]`  
**Output**: `1`  
**Explanation**:
- The dominoes `[1,2]` and `[2,1]` are equivalent, forming one pair.
- The other dominoes have no equivalents, so the total is 1.

#### Example 2:
**Input**: `dominoes = [[1,2],[1,2],[1,1],[1,2],[2,2]]`  
**Output**: `3`  
**Explanation**:
- Three pairs can be formed with the dominoes `[1,2]` (which are equivalent to `[2,1]`).
- The domino `[1,1]` does not form additional pairs, and `[2,2]` appears only once.

### Conclusion

This efficient solution normalizes each domino to treat rotations as equivalent and counts how many times each normalized domino appears, allowing us to calculate the number of equivalent pairs in an optimized manner. The approach ensures that all pairs are counted with linear complexity.