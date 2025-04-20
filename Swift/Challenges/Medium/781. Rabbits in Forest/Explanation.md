## [PT/BR]

### O Problema

Em uma floresta com um número desconhecido de coelhos, perguntamos a n coelhos: "Quantos coelhos têm a mesma cor que você?" e coletamos as respostas em um array `answers`, onde `answers[i]` é a resposta do i-ésimo coelho.

Dado o array `answers`, devemos retornar o número mínimo possível de coelhos na floresta.

### Raciocínio

1. **Agrupamento por Resposta**:
   - Coelhos que respondem o mesmo número podem ou não ser da mesma cor
   - Se um coelho responde `x`, deve haver no mínimo `x+1` coelhos daquela cor (incluindo ele mesmo)

2. **Cálculo de Grupos**:
   - Para cada resposta distinta `x`, calculamos quantos grupos de `x+1` coelhos são necessários
   - Exemplo: Se 3 coelhos respondem "2", precisamos de 1 grupo de 3 (2+1) coelhos

3. **Fórmula Matemática**:
   - Número de grupos = `ceil(count / (x+1))`
   - Coelhos por resposta = número de grupos * (x+1)

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array uma vez para contar as respostas e depois processamos cada resposta única
- **Espaço**: O(n) - Armazenamos contagens de respostas em um dicionário

### Solução em Código

```swift
import Foundation

class Solution {
    func numRabbits(_ answers: [Int]) -> Int {
        var counts: [Int: Int] = [:]
        for answer in answers {
            counts[answer, default: 0] += 1
        }

        var totalRabbits = 0
        
        for (answer, count) in counts {
            let groupSize = answer + 1 
            let numGroups = (count + groupSize - 1) / groupSize
            totalRabbits += numGroups * groupSize
        }

        return totalRabbits
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `answers = [1,1,2]`  
**Output**: `5`  
**Explicação**:
- Respostas "1": 2 coelhos → 1 grupo de 2 (1+1)
- Resposta "2": 1 coelho → 1 grupo de 3 (2+1)
- Total: 2 (do grupo 1) + 3 (do grupo 2) = 5 coelhos

#### Exemplo 2:
**Input**: `answers = [10,10,10]`  
**Output**: `11`  
**Explicação**:
- 3 coelhos respondem "10" → 1 grupo de 11 (10+1)
- Total: 11 coelhos

### Conclusão

Esta solução calcula eficientemente o número mínimo de coelhos usando agrupamento matemático, garantindo que todas as respostas sejam consistentes com a quantidade real de coelhos na floresta.

---

## [EN]

### The Problem

In a forest with an unknown number of rabbits, we asked n rabbits "How many rabbits have the same color as you?" and collected answers in array `answers` where `answers[i]` is the ith rabbit's answer.

Given `answers`, return the minimum possible number of rabbits in the forest.

### Reasoning

1. **Answer Grouping**:
   - Rabbits giving same answer may or may not be same color
   - If a rabbit answers `x`, there must be at least `x+1` rabbits of that color (including itself)

2. **Group Calculation**:
   - For each distinct answer `x`, calculate how many groups of `x+1` rabbits are needed
   - Example: 3 rabbits answer "2" → 1 group of 3 (2+1) rabbits

3. **Mathematical Formula**:
   - Number of groups = `ceil(count / (x+1))`
   - Rabbits per answer = number of groups * (x+1)

### Complexity Analysis

- **Time**: O(n) - Traverse array once to count answers, then process each unique answer
- **Space**: O(n) - Store answer counts in dictionary

### Code Solution

```swift
import Foundation

class Solution {
    func numRabbits(_ answers: [Int]) -> Int {
        var counts: [Int: Int] = [:]
        for answer in answers {
            counts[answer, default: 0] += 1
        }

        var totalRabbits = 0
        
        for (answer, count) in counts {
            let groupSize = answer + 1 
            let numGroups = (count + groupSize - 1) / groupSize
            totalRabbits += numGroups * groupSize
        }

        return totalRabbits
    }
}
```

### Examples

#### Example 1:
**Input**: `answers = [1,1,2]`  
**Output**: `5`  
**Explanation**:
- Answers "1": 2 rabbits → 1 group of 2
- Answer "2": 1 rabbit → 1 group of 3
- Total: 2 + 3 = 5 rabbits

#### Example 2:
**Input**: `answers = [10,10,10]`  
**Output**: `11`  
**Explanation**:
- 3 rabbits answer "10" → 1 group of 11
- Total: 11 rabbits

### Conclusion

This solution efficiently computes the minimum rabbit count using mathematical grouping, ensuring all answers are consistent with the actual forest population.