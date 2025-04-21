## [PT/BR]

### O Problema

Dado um array `differences` de tamanho `n` que descreve as diferenças entre elementos consecutivos de uma sequência oculta de tamanho `n+1`, e dois inteiros `lower` e `upper` que definem o intervalo válido para os elementos da sequência oculta, precisamos determinar quantas sequências ocultas válidas existem.

### Raciocínio

1. **Entendendo a Sequência Oculta**:
   - A sequência oculta `hidden` tem tamanho `n+1`
   - Cada elemento em `differences` representa `hidden[i+1] - hidden[i]`
   - Todos elementos de `hidden` devem estar no intervalo `[lower, upper]`

2. **Análise Matemática**:
   - Podemos expressar todos elementos da sequência em termos do primeiro elemento `hidden[0]`
   - Calculamos os valores mínimo e máximo que `hidden[0]` pode assumir para que todos elementos subsequentes permaneçam dentro dos limites

3. **Implementação**:
   - Calculamos a soma acumulada das diferenças
   - Determinamos os desvios mínimo e máximo em relação ao primeiro elemento
   - Calculamos o intervalo válido para `hidden[0]`
   - O número de sequências válidas é o tamanho deste intervalo

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array de diferenças uma vez
- **Espaço**: O(1) - Usamos apenas algumas variáveis auxiliares

### Solução em Código

```swift
class Solution {
    func numberOfArrays(_ differences: [Int], _ lower: Int, _ upper: Int) -> Int {
        var currentSum = 0
        var minRelative = 0
        var maxRelative = 0

        for diff in differences {
            currentSum += diff
            minRelative = min(minRelative, currentSum)
            maxRelative = max(maxRelative, currentSum)
        }

        let minH0 = lower - minRelative
        let maxH0 = upper - maxRelative

        return max(maxH0 - minH0 + 1, 0)
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `differences = [1,-3,4]`, `lower = 1`, `upper = 6`  
**Output**: `2`  
**Explicação**:
- Somas acumuladas: [1, -2, 2]
- `minRelative` = -2, `maxRelative` = 2
- `hidden[0]` deve estar entre 1-(-2)=3 e 6-2=4
- Valores possíveis para `hidden[0]`: 3, 4 → 2 sequências

#### Exemplo 2:
**Input**: `differences = [3,-4,5,1,-2]`, `lower = -4`, `upper = 5`  
**Output**: `4`  
**Explicação**:
- Somas acumuladas: [3, -1, 4, 5, 3]
- `minRelative` = -1, `maxRelative` = 5
- `hidden[0]` deve estar entre -4-(-1)=-3 e 5-5=0
- Valores possíveis: -3, -2, -1, 0 → 4 sequências

#### Exemplo 3:
**Input**: `differences = [4,-7,2]`, `lower = 3`, `upper = 6`  
**Output**: `0`  
**Explicação**:
- Somas acumuladas: [4, -3, -1]
- `minRelative` = -3, `maxRelative` = 4
- `hidden[0]` deve estar entre 3-(-3)=6 e 6-4=2 → Intervalo inválido (6 > 2)

### Conclusão

Esta solução eficiente determina o número de sequências ocultas válidas em tempo linear, explorando propriedades matemáticas das somas acumuladas e intervalos permitidos.

---

## [EN]

### The Problem

Given a 0-indexed array `differences` of size `n` describing the differences between consecutive elements of a hidden sequence of size `n+1`, and two integers `lower` and `upper` defining the valid range for the hidden sequence elements, we need to determine how many valid hidden sequences exist.

### Reasoning

1. **Understanding the Hidden Sequence**:
   - The hidden sequence `hidden` has size `n+1`
   - Each element in `differences` represents `hidden[i+1] - hidden[i]`
   - All elements of `hidden` must be within `[lower, upper]`

2. **Mathematical Analysis**:
   - We can express all sequence elements in terms of the first element `hidden[0]`
   - Calculate the minimum and maximum values `hidden[0]` can take to keep all subsequent elements within bounds

3. **Implementation**:
   - Compute cumulative sum of differences
   - Determine minimum and maximum deviations from first element
   - Calculate valid range for `hidden[0]`
   - Number of valid sequences is the size of this range

### Complexity Analysis

- **Time**: O(n) - Single pass through differences array
- **Space**: O(1) - Uses only a few helper variables

### Code Solution

```swift
class Solution {
    func numberOfArrays(_ differences: [Int], _ lower: Int, _ upper: Int) -> Int {
        var currentSum = 0
        var minRelative = 0
        var maxRelative = 0

        for diff in differences {
            currentSum += diff
            minRelative = min(minRelative, currentSum)
            maxRelative = max(maxRelative, currentSum)
        }

        let minH0 = lower - minRelative
        let maxH0 = upper - maxRelative

        return max(maxH0 - minH0 + 1, 0)
    }
}
```

### Examples

#### Example 1:
**Input**: `differences = [1,-3,4]`, `lower = 1`, `upper = 6`  
**Output**: `2`  
**Explanation**:
- Cumulative sums: [1, -2, 2]
- `minRelative` = -2, `maxRelative` = 2
- `hidden[0]` must be between 1-(-2)=3 and 6-2=4
- Possible values for `hidden[0]`: 3, 4 → 2 sequences

#### Example 2:
**Input**: `differences = [3,-4,5,1,-2]`, `lower = -4`, `upper = 5`  
**Output**: `4`  
**Explanation**:
- Cumulative sums: [3, -1, 4, 5, 3]
- `minRelative` = -1, `maxRelative` = 5
- `hidden[0]` must be between -4-(-1)=-3 and 5-5=0
- Possible values: -3, -2, -1, 0 → 4 sequences

#### Example 3:
**Input**: `differences = [4,-7,2]`, `lower = 3`, `upper = 6`  
**Output**: `0`  
**Explanation**:
- Cumulative sums: [4, -3, -1]
- `minRelative` = -3, `maxRelative` = 4
- `hidden[0]` must be between 3-(-3)=6 and 6-4=2 → Invalid range (6 > 2)

### Conclusion

This efficient solution determines the number of valid hidden sequences in linear time by leveraging mathematical properties of cumulative sums and allowed ranges.