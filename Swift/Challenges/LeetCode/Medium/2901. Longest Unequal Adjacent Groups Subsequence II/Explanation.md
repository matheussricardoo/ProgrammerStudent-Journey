## [PT/BR]

### O Problema

Você recebe:

- Um array de strings `words`
- Um array `groups` do mesmo tamanho, onde cada valor é um inteiro representando o grupo da palavra correspondente

Precisamos encontrar uma **subsequência mais longa** dos índices `[i0, i1, ..., ik-1]` tal que as seguintes condições sejam satisfeitas para todos os pares consecutivos na subsequência:

1. Os grupos correspondentes são diferentes: `groups[ij] != groups[ij+1]`
2. As palavras têm o mesmo comprimento e possuem **distância Hamming igual a 1**: ou seja, diferem em exatamente uma posição

Retorne o array de palavras correspondentes aos índices dessa subsequência mais longa.

Se houver múltiplas respostas válidas, retorne qualquer uma delas.

---

### Raciocínio

1. **Definição do problema**:
   - A sequência deve ser uma **subsequência válida**, ou seja, manter a ordem original, mas pode pular elementos
   - A condição entre dois elementos consecutivos é dupla:
     - Grupos devem ser diferentes
     - Palavras devem ter mesmo comprimento e distância Hamming exatamente igual a 1

2. **Estratégia – Programação Dinâmica (DP)**:
   - Usamos um array `dp[i]` que representa o comprimento da maior subsequência terminando em `i`
   - Também usamos um array `prev[i]` para reconstruir a subsequência
   - Para cada índice `i`, verificamos todos os índices anteriores `j < i`:
     - Se for possível ligar `j` a `i` pelas regras, atualizamos `dp[i]` com o melhor caminho até ele

3. **Reconstrução da subsequência**:
   - Depois de preencher `dp`, encontramos o índice com o maior valor
   - Usamos o array `prev` para voltar pelos predecessores e montar a subsequência na ordem correta

4. **Verificação da Hamming Distance**:
   - Função auxiliar verifica se duas palavras têm o mesmo comprimento e diferem em apenas uma posição

---

### Análise da Complexidade

- **Tempo**: $O(n^2 \cdot m)$ — Onde `n` é o número de palavras e `m` é o comprimento máximo das palavras  
  - Para cada par `(i,j)`, verificamos a Hamming distance
- **Espaço**: $O(n)$ — Arrays `dp` e `prev`

---

### Solução em Código (comentários em português)

```swift
class Solution {
    func getWordsInLongestSubsequence(_ words: [String], _ groups: [Int]) -> [String] {
        let n = words.count
        if n == 0 {
            return []
        }
        
        // dp[i] = comprimento da maior subsequência terminando em i
        var dp = [Int](repeating: 1, count: n)
        // prev[i] = índice anterior na subsequência ótima terminando em i
        var prev = [Int](repeating: -1, count: n)
        
        // Preenche dp e prev usando programação dinâmica
        for i in 0..<n {
            for j in 0..<i {
                // Verifica condições: grupos diferentes e palavras compatíveis
                if groups[j] != groups[i] && isSameLengthAndHamming1(words[j], words[i]) {
                    if dp[j] + 1 > dp[i] {
                        dp[i] = dp[j] + 1
                        prev[i] = j
                    }
                }
            }
        }
        
        // Encontra o índice com o maior comprimento de subsequência
        var maxLen = 0
        var lastIndex = 0
        for i in 0..<n {
            if dp[i] > maxLen {
                maxLen = dp[i]
                lastIndex = i
            }
        }
        
        // Reconstrói a subsequência a partir de lastIndex
        var result = [String]()
        var index = lastIndex
        while index != -1 {
            result.append(words[index])
            index = prev[index]
        }
        result.reverse()
        return result
    }
    
    // Função auxiliar: verifica se duas palavras têm mesmo comprimento e hamming distance 1
    private func isSameLengthAndHamming1(_ a: String, _ b: String) -> Bool {
        guard a.count == b.count else {
            return false
        }
        
        var diff = 0
        for (charA, charB) in zip(a, b) {
            if charA != charB {
                diff += 1
                if diff > 1 {
                    return false
                }
            }
        }
        return diff == 1
    }
}
```

---

### Exemplos

#### Exemplo 1:
**Input**:  
`words = ["bab","dab","cab"]`  
`groups = [1,2,2]`  
**Output**: `["bab","cab"]` ou `["bab","dab"]`

#### Exemplo 2:
**Input**:  
`words = ["a","b","c","d"]`  
`groups = [1,2,3,4]`  
**Output**: `["a","b","c","d"]`

---

### Conclusão

Este é um exemplo clássico de problema de subsequência mais longa com restrições. A solução usa **programação dinâmica** para construir a resposta passo a passo, garantindo que todas as condições sejam atendidas. É eficiente para o limite dado (`n <= 1000`) e garante uma resposta válida mesmo quando há múltiplas opções.

---

## [EN]

### The Problem

You are given:

- An array of distinct strings `words`
- A group array `groups` of the same length

You must select the **longest subsequence** of indices such that for every two adjacent indices `ij` and `ij+1`:

- Their group values are different: `groups[ij] != groups[ij+1]`
- The corresponding words have equal length and a **Hamming distance of exactly 1**

Return the list of words in this subsequence. If there are multiple valid answers, return any.

---

### Reasoning

1. **Conditions to be met**:
   - Adjacent elements in the sequence must:
     - Belong to different groups
     - Have same length
     - Have Hamming distance of exactly 1

2. **Strategy – Dynamic Programming**:
   - Use `dp[i]` to store the longest subsequence ending at index `i`
   - Use `prev[i]` to reconstruct the path
   - For each index `i`, check all previous indices `j < i`:
     - If conditions are met, update `dp[i]` with the best value from `dp[j] + 1`

3. **Reconstruction**:
   - After filling `dp`, find the maximum value and trace back using `prev` to build the answer

---

### Complexity Analysis

- **Time**: $O(n^2 \cdot m)$ — For each pair `(i,j)` and word comparison
- **Space**: $O(n)$ — For `dp` and `prev` arrays

---

### Code Solution (comments in English)

```swift
class Solution {
    func getWordsInLongestSubsequence(_ words: [String], _ groups: [Int]) -> [String] {
        let n = words.count
        if n == 0 {
            return []
        }
        
        // dp[i] = length of longest subsequence ending at i
        var dp = [Int](repeating: 1, count: n)
        // prev[i] = previous index in the optimal path ending at i
        var prev = [Int](repeating: -1, count: n)
        
        // Fill dp and prev arrays
        for i in 0..<n {
            for j in 0..<i {
                // Check both conditions: group and Hamming distance
                if groups[j] != groups[i] && isSameLengthAndHamming1(words[j], words[i]) {
                    if dp[j] + 1 > dp[i] {
                        dp[i] = dp[j] + 1
                        prev[i] = j
                    }
                }
            }
        }
        
        // Find the index with the maximum subsequence length
        var maxLen = 0
        var lastIndex = 0
        for i in 0..<n {
            if dp[i] > maxLen {
                maxLen = dp[i]
                lastIndex = i
            }
        }
        
        // Reconstruct the path from last index
        var result = [String]()
        var index = lastIndex
        while index != -1 {
            result.append(words[index])
            index = prev[index]
        }
        result.reverse()
        return result
    }
    
    // Helper: check if two words have same length and Hamming distance == 1
    private func isSameLengthAndHamming1(_ a: String, _ b: String) -> Bool {
        guard a.count == b.count else {
            return false
        }
        
        var diff = 0
        for (charA, charB) in zip(a, b) {
            if charA != charB {
                diff += 1
                if diff > 1 {
                    return false
                }
            }
        }
        return diff == 1
    }
}
```

---

### Examples

#### Example 1:
**Input**:  
`words = ["bab","dab","cab"]`  
`groups = [1,2,2]`  
**Output**: `["bab","cab"]` or `["bab","dab"]`

#### Example 2:
**Input**:  
`words = ["a","b","c","d"]`  
`groups = [1,2,3,4]`  
**Output**: `["a","b","c","d"]`

---

### Conclusion

This problem combines dynamic programming with string constraints (group condition and Hamming distance). Using DP, we efficiently build up the longest possible valid subsequence while ensuring all rules are followed. This approach guarantees correctness and performance within the given constraints.