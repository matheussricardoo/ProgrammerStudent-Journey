## [PT/BR]

### O Problema

Temos `n` dominós em linha, cada um inicialmente posicionado verticalmente. Alguns dominós são empurrados para a esquerda ('L') ou direita ('R'), enquanto outros permanecem não empurrados ('.'). Precisamos determinar o estado final dos dominós após todas as forças serem aplicadas.

### Raciocínio

1. **Adicionando Limites**:
   - Adicionamos um 'L' no início e um 'R' no final para facilitar o processamento dos extremos

2. **Identificação de Segmentos**:
   - Percorremos a string identificando segmentos entre dois dominós não verticais (L ou R)
   - Para cada segmento entre dois caracteres não verticais, determinamos como os dominós intermediários serão afetados

3. **Processamento de Segmentos**:
   - Se os limites do segmento forem 'R' e 'L', os dominós do meio cairão para dentro (encontro de forças)
   - Se os limites forem iguais ('R' e 'R' ou 'L' e 'L'), todos os dominós intermediários cairão na mesma direção
   - Se um limite for 'L' e o outro 'R', os dominós intermediários permanecerão verticais (forças opostas se anulam)

4. **Remoção de Limites**:
   - Removemos os caracteres adicionados no início e no final antes de retornar o resultado

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos a string uma única vez
- **Espaço**: O(n) - Criamos um array para manipular os caracteres

### Solução em Código

```swift
class Solution {
    func pushDominoes(_ dominoes: String) -> String {
        var chars = Array("L" + dominoes + "R")
        var i = 0
        
        while i < chars.count {
            var j = i + 1
            while j < chars.count && chars[j] == "." {
                j += 1
            }
            
            if j < chars.count {
                let left = chars[i]
                let right = chars[j]
                
                if left == "R" && right == "L" {
                    var l = i + 1, r = j - 1
                    while l < r {
                        chars[l] = "R"
                        chars[r] = "L"
                        l += 1
                        r -= 1
                    }
                } else if left == right {
                    for k in (i + 1)..<j {
                        chars[k] = left
                    }
                }
            }
            
            i = j
        }
        
        return String(chars[1..<chars.count-1])
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `dominoes = "RR.L"`  
**Output**: `"RR.L"`  
**Explicação**:
- O primeiro 'R' não afeta o segundo 'R' pois já está caindo para direita
- O '.' entre 'R' e 'L' permanece vertical pois as forças se anulam

#### Exemplo 2:
**Input**: `dominoes = ".L.R...LR..L.."`  
**Output**: `"LL.RR.LLRRLL.."`  
**Explicação**:
- Segmentos processados:
  - 'L' e 'L' → todos viram 'L'
  - 'L' e 'R' → permanecem verticais
  - 'R' e 'L' → encontro de forças
  - 'R' e 'R' → todos viram 'R'

### Conclusão

Esta solução eficiente processa os dominós em segmentos, aplicando as regras de queda de forma otimizada. A abordagem garante que todas as interações entre os dominós sejam consideradas com complexidade linear.

---

## [EN]

### The Problem

We have `n` dominoes in a line, each initially standing upright. Some dominoes are pushed left ('L') or right ('R'), while others remain unpushed ('.'). We need to determine the final state of the dominoes after all forces are applied.

### Reasoning

1. **Adding Boundaries**:
   - Add 'L' at start and 'R' at end to simplify edge processing

2. **Segment Identification**:
   - Traverse the string identifying segments between two non-vertical dominoes (L or R)
   - For each segment between two non-vertical characters, determine how intermediate dominoes will be affected

3. **Segment Processing**:
   - If segment bounds are 'R' and 'L', middle dominoes will fall inward (force collision)
   - If bounds are equal ('R' and 'R' or 'L' and 'L'), all intermediate dominoes will fall in same direction
   - If one bound is 'L' and other 'R', intermediate dominoes remain vertical (opposing forces cancel)

4. **Boundary Removal**:
   - Remove added boundary characters before returning result

### Complexity Analysis

- **Time**: O(n) - Single pass through the string
- **Space**: O(n) - Create an array to manipulate characters

### Code Solution

```swift
class Solution {
    func pushDominoes(_ dominoes: String) -> String {
        var chars = Array("L" + dominoes + "R")
        var i = 0
        
        while i < chars.count {
            var j = i + 1
            while j < chars.count && chars[j] == "." {
                j += 1
            }
            
            if j < chars.count {
                let left = chars[i]
                let right = chars[j]
                
                if left == "R" && right == "L" {
                    var l = i + 1, r = j - 1
                    while l < r {
                        chars[l] = "R"
                        chars[r] = "L"
                        l += 1
                        r -= 1
                    }
                } else if left == right {
                    for k in (i + 1)..<j {
                        chars[k] = left
                    }
                }
            }
            
            i = j
        }
        
        return String(chars[1..<chars.count-1])
    }
}
```

### Examples

#### Example 1:
**Input**: `dominoes = "RR.L"`  
**Output**: `"RR.L"`  
**Explanation**:
- First 'R' doesn't affect second 'R' (already falling right)
- '.' between 'R' and 'L' stays vertical (forces cancel)

#### Example 2:
**Input**: `dominoes = ".L.R...LR..L.."`  
**Output**: `"LL.RR.LLRRLL.."`  
**Explanation**:
- Processed segments:
  - 'L' and 'L' → all become 'L'
  - 'L' and 'R' → remain vertical
  - 'R' and 'L' → force collision
  - 'R' and 'R' → all become 'R'

### Conclusion

This efficient solution processes dominoes in segments, applying fall rules optimally. The approach ensures all domino interactions are considered with linear complexity.