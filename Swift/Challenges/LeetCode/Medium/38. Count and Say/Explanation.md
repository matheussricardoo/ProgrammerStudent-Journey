## [PT/BR]

### O Problema

A sequência "count-and-say" é uma sequência de strings de dígitos definida por uma fórmula recursiva:
- `countAndSay(1) = "1"`
- `countAndSay(n)` é a codificação run-length (RLE) de `countAndSay(n-1)`

A codificação run-length (RLE) comprime strings substituindo caracteres idênticos consecutivos pela contagem seguida do caractere. Por exemplo:
- "3322251" → "23"+"32"+"15"+"11" = "23321511"

Dado um inteiro positivo `n`, devemos retornar o n-ésimo elemento da sequência.

### Raciocínio

1. **Caso Base**:
   - Quando `n = 1`, retornamos diretamente "1"

2. **Construção Iterativa**:
   - Começando com "1", iteramos de 2 até `n`
   - Para cada iteração:
     - Percorremos a string atual contando as sequências de caracteres iguais
     - Construímos a nova string com a contagem seguida do caractere

3. **Implementação**:
   - Usamos um loop para gerar cada termo sequencialmente
   - Para cada termo, usamos dois ponteiros para contar as sequências

### Análise da Complexidade

- **Tempo**: O(m * n), onde m é o comprimento máximo da string gerada
- **Espaço**: O(m), para armazenar a string atual

### Solução em Código

```swift
import Foundation

class Solution {
    func countAndSay(_ n: Int) -> String {
        if n == 1 {
            return "1"
        }

        var currentSay = "1"

        for _ in 2...n {
            var nextSay = ""
            let chars = Array(currentSay)
            var i = 0
            
            while i < chars.count {
                let currentChar = chars[i]
                var count = 1
                
                while i + count < chars.count && chars[i + count] == currentChar {
                    count += 1
                }
                
                nextSay += "\(count)\(currentChar)"
                i += count
            }
            
            currentSay = nextSay
        }

        return currentSay
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `n = 4`  
**Output**: `"1211"`  
**Explicação**:
1. "1" (base)
2. "11" (um "1")
3. "21" (dois "1s")
4. "1211" (um "2", um "1")

#### Exemplo 2:
**Input**: `n = 1`  
**Output**: `"1"`  
**Explicação**: Caso base direto

### Conclusão

Esta solução implementa eficientemente a sequência count-and-say usando uma abordagem iterativa clara, gerando cada termo a partir do anterior através de compressão RLE.

---

## [EN]

### The Problem

The count-and-say sequence is a digit string sequence defined recursively:
- `countAndSay(1) = "1"`
- `countAndSay(n)` is the run-length encoding (RLE) of `countAndSay(n-1)`

Run-length encoding compresses strings by replacing consecutive identical characters with count followed by character. Example:
- "3322251" → "23"+"32"+"15"+"11" = "23321511"

Given positive integer `n`, return the nth count-and-say element.

### Reasoning

1. **Base Case**:
   - When `n = 1`, directly return "1"

2. **Iterative Construction**:
   - Starting with "1", iterate from 2 to `n`
   - For each iteration:
     - Scan current string counting character runs
     - Build new string with counts followed by characters

3. **Implementation**:
   - Use loop to generate each term sequentially
   - For each term, use two pointers to count runs

### Complexity Analysis

- **Time**: O(m * n), where m is maximum generated string length
- **Space**: O(m), to store current string

### Code Solution

```swift
import Foundation

class Solution {
    func countAndSay(_ n: Int) -> String {
        if n == 1 {
            return "1"
        }

        var currentSay = "1"

        for _ in 2...n {
            var nextSay = ""
            let chars = Array(currentSay)
            var i = 0
            
            while i < chars.count {
                let currentChar = chars[i]
                var count = 1
                
                while i + count < chars.count && chars[i + count] == currentChar {
                    count += 1
                }
                
                nextSay += "\(count)\(currentChar)"
                i += count
            }
            
            currentSay = nextSay
        }

        return currentSay
    }
}
```

### Examples

#### Example 1:
**Input**: `n = 4`  
**Output**: `"1211"`  
**Explanation**:
1. "1" (base)
2. "11" (one "1")
3. "21" (two "1s")
4. "1211" (one "2", one "1")

#### Example 2:
**Input**: `n = 1`  
**Output**: `"1"`  
**Explanation**: Direct base case

### Conclusion

This solution efficiently implements the count-and-say sequence using a clear iterative approach, generating each term from the previous via RLE compression.