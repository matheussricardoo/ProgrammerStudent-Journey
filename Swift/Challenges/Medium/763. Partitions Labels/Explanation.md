## [PT/BR]

### O Problema

Dada uma string `s`, queremos particioná-la no maior número possível de partes, de forma que cada caractere apareça em apenas uma parte. Por exemplo, a string "ababcc" pode ser particionada em ["abab", "cc"], mas partições como ["aba", "bcc"] ou ["ab", "ab", "cc"] são inválidas. O objetivo é retornar uma lista de inteiros representando o tamanho de cada parte.

### Raciocínio

1. **Última Ocorrência de Cada Caractere**: Primeiro, precisamos determinar a última posição em que cada caractere aparece na string. Isso nos ajudará a definir os limites de cada partição.

2. **Definindo as Partições**: Percorremos a string e, para cada caractere, atualizamos o limite da partição atual para incluir a última ocorrência desse caractere. Quando chegamos ao fim da partição atual (ou seja, o índice atual é igual ao limite da partição), adicionamos o tamanho da partição ao resultado e começamos uma nova partição.

3. **Eficiência**: O algoritmo percorre a string duas vezes: uma para determinar as últimas ocorrências e outra para definir as partições. Isso garante uma solução eficiente com complexidade linear.

### Análise da Complexidade

- **Complexidade de Tempo**:
  - Determinar as últimas ocorrências: \( O(n) \), onde \( n \) é o comprimento da string.
  - Definir as partições: \( O(n) \).
  - **Total**: \( O(n) \).

- **Complexidade de Espaço**:
  - Armazenar as últimas ocorrências: \( O(1) \), pois há um número fixo de caracteres possíveis (26 letras minúsculas).
  - **Total**: \( O(1) \).

### Solução em Código

```swift
import Foundation

class Solution {
    func partitionLabels(_ s: String) -> [Int] {
        if s.isEmpty {
            return []
        }

        var lastOccurrence: [Character: Int] = [:]
        let sChars = Array(s)

        for (index, char) in sChars.enumerated() {
            lastOccurrence[char] = index
        }

        var result: [Int] = []
        var start = 0
        var end = 0

        for (i, char) in sChars.enumerated() {
            if let charLastOccurrence = lastOccurrence[char] {
                end = max(end, charLastOccurrence)
            }

            if i == end {
                let partitionLength = i - start + 1
                result.append(partitionLength)
                start = i + 1
            }
        }

        return result
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `s = "ababcbacadefegdehijhklij"`  
**Output**: `[9,7,8]`  
**Explicação**:
- A última ocorrência de 'a' é 8, 'b' é 5, 'c' é 7, 'd' é 14, 'e' é 15, 'f' é 11, 'g' é 13, 'h' é 19, 'i' é 22, 'j' é 23, 'k' é 20, 'l' é 21.
- A primeira partição vai do índice 0 ao 8 ("ababcbaca").
- A segunda partição vai do índice 9 ao 15 ("defegde").
- A terceira partição vai do índice 16 ao 23 ("hijhklij").

#### Exemplo 2:
**Input**: `s = "eccbbbbdec"`  
**Output**: `[10]`  
**Explicação**:
- A última ocorrência de 'e' é 8, 'c' é 9, 'b' é 6, 'd' é 7.
- A única partição vai do índice 0 ao 9 ("eccbbbbdec").

### Conclusão

A solução apresentada utiliza uma abordagem eficiente para particionar a string em partes onde cada caractere aparece em apenas uma parte. Ao determinar as últimas ocorrências de cada caractere e percorrer a string para definir os limites das partições, o algoritmo garante que o resultado seja ótimo e correto. A complexidade linear torna a solução adequada para strings de até 500 caracteres, conforme especificado nas restrições.

---

## [EN]

### The Problem

Given a string `s`, we want to partition it into as many parts as possible so that each letter appears in at most one part. For example, the string "ababcc" can be partitioned into ["abab", "cc"], but partitions like ["aba", "bcc"] or ["ab", "ab", "cc"] are invalid. The goal is to return a list of integers representing the size of each part.

### Reasoning

1. **Last Occurrence of Each Character**: First, we need to determine the last position where each character appears in the string. This will help us define the boundaries of each partition.

2. **Defining the Partitions**: As we traverse the string, for each character, we update the current partition's boundary to include the last occurrence of that character. When we reach the end of the current partition (i.e., the current index equals the partition's boundary), we add the partition's length to the result and start a new partition.

3. **Efficiency**: The algorithm traverses the string twice: once to determine the last occurrences and once to define the partitions. This ensures an efficient solution with linear complexity.

### Complexity Analysis

- **Time Complexity**:
  - Determining last occurrences: \( O(n) \), where \( n \) is the length of the string.
  - Defining partitions: \( O(n) \).
  - **Total**: \( O(n) \).

- **Space Complexity**:
  - Storing last occurrences: \( O(1) \), since there is a fixed number of possible characters (26 lowercase letters).
  - **Total**: \( O(1) \).

### Code Solution

```swift
import Foundation

class Solution {
    func partitionLabels(_ s: String) -> [Int] {
        if s.isEmpty {
            return []
        }

        var lastOccurrence: [Character: Int] = [:]
        let sChars = Array(s)

        for (index, char) in sChars.enumerated() {
            lastOccurrence[char] = index
        }

        var result: [Int] = []
        var start = 0
        var end = 0

        for (i, char) in sChars.enumerated() {
            if let charLastOccurrence = lastOccurrence[char] {
                end = max(end, charLastOccurrence)
            }

            if i == end {
                let partitionLength = i - start + 1
                result.append(partitionLength)
                start = i + 1
            }
        }

        return result
    }
}
```

### Examples

#### Example 1:
**Input**: `s = "ababcbacadefegdehijhklij"`  
**Output**: `[9,7,8]`  
**Explanation**:
- The last occurrence of 'a' is 8, 'b' is 5, 'c' is 7, 'd' is 14, 'e' is 15, 'f' is 11, 'g' is 13, 'h' is 19, 'i' is 22, 'j' is 23, 'k' is 20, 'l' is 21.
- The first partition spans from index 0 to 8 ("ababcbaca").
- The second partition spans from index 9 to 15 ("defegde").
- The third partition spans from index 16 to 23 ("hijhklij").

#### Example 2:
**Input**: `s = "eccbbbbdec"`  
**Output**: `[10]`  
**Explanation**:
- The last occurrence of 'e' is 8, 'c' is 9, 'b' is 6, 'd' is 7.
- The only partition spans from index 0 to 9 ("eccbbbbdec").

### Conclusion

The provided solution efficiently partitions the string into parts where each character appears in only one part. By determining the last occurrences of each character and traversing the string to define partition boundaries, the algorithm ensures an optimal and correct result. The linear complexity makes the solution suitable for strings up to 500 characters, as specified in the constraints.