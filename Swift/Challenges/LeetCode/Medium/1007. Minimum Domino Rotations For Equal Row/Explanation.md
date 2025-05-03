## [PT/BR]

### O Problema

Temos uma linha de dominós, onde cada dominó tem um número no topo (`tops[i]`) e na base (`bottoms[i]`). Podemos girar qualquer dominó, trocando seus valores de topo e base. Precisamos determinar o número mínimo de rotações necessárias para que todos os valores no topo sejam iguais ou todos os valores na base sejam iguais. Se não for possível, retornamos -1.

### Raciocínio

1. **Identificação de Alvos**:
   - Os únicos candidatos possíveis para o valor uniforme são o primeiro valor do topo (`tops[0]`) ou o primeiro valor da base (`bottoms[0]`), pois qualquer outro valor não poderia estar presente em todos os dominós após rotações.

2. **Verificação de Possibilidade**:
   - Para cada candidato (valor do primeiro topo e valor da primeira base), verificamos se é possível fazer com que todos os dominós tenham esse valor no topo ou na base.
   - Se em qualquer posição o dominó não contiver o valor alvo, é impossível alcançar o objetivo com esse alvo.

3. **Cálculo de Rotações**:
   - Para cada alvo válido, calculamos o número mínimo de rotações necessárias para ter esse valor em todos os tops ou em todas as bases.
   - O resultado final é o menor número de rotações entre os dois alvos possíveis.

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array duas vezes (uma para cada alvo candidato)
- **Espaço**: O(1) - Usamos apenas algumas variáveis auxiliares para contagem

### Solução em Código

```swift
import Foundation

class Solution {
    func minDominoRotations(_ tops: [Int], _ bottoms: [Int]) -> Int {
        let n = tops.count
        
        func check(_ target: Int) -> Int {
            var rotationsTop = 0    // Número de rotações para ter target em todos os tops
            var rotationsBottom = 0 // Número de rotações para ter target em todas as bases
            
            for i in 0..<n {
                // Se o dominó não contém o target, é impossível
                if tops[i] != target && bottoms[i] != target {
                    return Int.max 
                }
                // Se o topo não é o target, precisamos rotacionar
                else if tops[i] != target {
                    rotationsTop += 1
                } 
                // Se a base não é o target, precisamos rotacionar
                else if bottoms[i] != target {
                    rotationsBottom += 1
                }
            }
            
            // Retorna o mínimo de rotações entre tops e bottoms
            return min(rotationsTop, rotationsBottom)
        }

        // Verifica os dois possíveis alvos
        let rotations1 = check(tops[0])
        let rotations2 = check(bottoms[0])

        // O resultado é o mínimo entre os dois, ou -1 se ambos forem impossíveis
        let result = min(rotations1, rotations2)

        return (result == Int.max) ? -1 : result
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `tops = [2,1,2,4,2,2]`, `bottoms = [5,2,6,2,3,2]`  
**Output**: `2`  
**Explicação**:
- Alvo 2 (primeiro topo):
  - Rotacionar dominó 1 (1↔2) e dominó 3 (4↔2)
  - Total: 2 rotações para ter todos os tops = 2

#### Exemplo 2:
**Input**: `tops = [3,5,1,2,3]`, `bottoms = [3,6,3,3,4]`  
**Output**: `-1`  
**Explicação**:
- Nem o valor 3 (primeiro topo) nem 3 (primeira base) podem estar presentes em todos os dominós após rotações
- Impossível alcançar o objetivo

### Conclusão

Esta solução eficiente verifica apenas os dois candidatos possíveis para o valor uniforme, calculando o número mínimo de rotações necessárias. A abordagem garante que encontremos a solução ótima com complexidade linear.

---

## [EN]

### The Problem

We have a row of dominoes, where each domino has a number on top (`tops[i]`) and bottom (`bottoms[i]`). We can rotate any domino, swapping its top and bottom values. We need to determine the minimum number of rotations required to make either all top values equal or all bottom values equal. If impossible, return -1.

### Reasoning

1. **Target Identification**:
   - The only possible candidates for the uniform value are the first top value (`tops[0]`) or first bottom value (`bottoms[0]`), as any other value couldn't be present in all dominoes after rotations.

2. **Feasibility Check**:
   - For each candidate (first top value and first bottom value), check if it's possible to make all dominoes have that value on top or bottom.
   - If any domino doesn't contain the target value, it's impossible with that target.

3. **Rotation Calculation**:
   - For each valid target, calculate minimum rotations needed to have that value on all tops or all bottoms.
   - Final result is the minimum rotations between the two possible targets.

### Complexity Analysis

- **Time**: O(n) - Traverse array twice (once per candidate target)
- **Space**: O(1) - Uses only a few helper variables for counting

### Code Solution

```swift
import Foundation

class Solution {
    func minDominoRotations(_ tops: [Int], _ bottoms: [Int]) -> Int {
        let n = tops.count
        
        func check(_ target: Int) -> Int {
            var rotationsTop = 0    // Rotations to have target on all tops
            var rotationsBottom = 0 // Rotations to have target on all bottoms
            
            for i in 0..<n {
                // If domino doesn't contain target, impossible
                if tops[i] != target && bottoms[i] != target {
                    return Int.max 
                }
                // If top isn't target, need to rotate
                else if tops[i] != target {
                    rotationsTop += 1
                } 
                // If bottom isn't target, need to rotate
                else if bottoms[i] != target {
                    rotationsBottom += 1
                }
            }
            
            // Return min rotations between tops and bottoms
            return min(rotationsTop, rotationsBottom)
        }

        // Check both possible targets
        let rotations1 = check(tops[0])
        let rotations2 = check(bottoms[0])

        // Result is minimum of both, or -1 if both impossible
        let result = min(rotations1, rotations2)

        return (result == Int.max) ? -1 : result
    }
}
```

### Examples

#### Example 1:
**Input**: `tops = [2,1,2,4,2,2]`, `bottoms = [5,2,6,2,3,2]`  
**Output**: `2`  
**Explanation**:
- Target 2 (first top):
  - Rotate domino 1 (1↔2) and domino 3 (4↔2)
  - Total: 2 rotations to make all tops = 2

#### Example 2:
**Input**: `tops = [3,5,1,2,3]`, `bottoms = [3,6,3,3,4]`  
**Output**: `-1`  
**Explanation**:
- Neither value 3 (first top) nor 3 (first bottom) can be present in all dominoes after rotations
- Impossible to achieve goal

### Conclusion

This efficient solution checks only the two possible candidate values for uniformity, calculating the minimum rotations needed. The approach ensures we find the optimal solution with linear complexity.