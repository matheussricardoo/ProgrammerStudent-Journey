## [PT/BR]

### O Problema

Você recebe:

- Um array de strings chamado `words`
- Um array binário chamado `groups` (onde cada elemento é 0 ou 1)

Precisamos encontrar uma **subsequência mais longa** de elementos de `words` tal que, para quaisquer dois elementos consecutivos dessa subsequência, os valores correspondentes em `groups` sejam **diferentes**.

Uma **subsequência** pode pular elementos do array original, mas mantém a ordem relativa.

Se houver múltiplas respostas válidas com o mesmo comprimento máximo, podemos retornar qualquer uma delas.

---

### Raciocínio

1. **Definição da regra**:
   - Para cada par de índices consecutivos na subsequência escolhida, `groups[i] != groups[j]`

2. **Estratégia gulosa**:
   - Começamos com a primeira palavra
   - Percorremos o array e adicionamos à resposta somente as palavras cujo grupo é diferente do último grupo adicionado
   - Isso funciona porque queremos apenas alternâncias entre 0 e 1 → basta manter o rastreamento do último grupo selecionado

3. **Eficiência**:
   - Como só percorremos o array uma única vez, a complexidade é linear

---

### Análise da Complexidade

- **Tempo**: $O(n)$ — Percorremos o array uma única vez
- **Espaço**: $O(k)$ — Onde `k` é o número de elementos na subsequência resultante

---

### Solução em Código (comentários em português)

```swift
class Solution {
    func getLongestSubsequence(_ words: [String], _ groups: [Int]) -> [String] {
        // Inicia com a primeira palavra
        var result = [words[0]]
        var prevGroup = groups[0]
        
        // Percorre o restante das palavras
        for i in 1..<groups.count {
            // Se o grupo atual é diferente do anterior, incluímos a palavra
            if groups[i] != prevGroup {
                result.append(words[i])
                prevGroup = groups[i]
            }
        }
        
        return result
    }
}
```

---

### Exemplos

#### Exemplo 1:
**Input**:  
`words = ["e","a","b"]`,  
`groups = [0,0,1]`  
**Output**: `["e","b"]` ou `["a","b"]`

#### Exemplo 2:
**Input**:  
`words = ["a","b","c","d"]`,  
`groups = [1,0,1,1]`  
**Output**: `["a","b","c"]` ou `["a","b","d"]`

---

### Conclusão

Este problema é um exemplo clássico de seleção de subsequência com restrições de alternância. A abordagem gulosa é suficiente e eficiente, já que precisamos apenas garantir que grupos consecutivos na resposta sejam diferentes. A solução é simples, rápida e direta.

---

## [EN]

### The Problem

You are given:

- An array of distinct strings called `words`
- A binary array `groups` of the same length

You must select the **longest alternating subsequence** from `words` such that any two consecutive elements in the subsequence have different corresponding values in `groups`.

A **subsequence** can skip elements but must preserve the original order.

If there are multiple valid answers with the same maximum length, return **any** of them.

---

### Reasoning

1. **Rule Definition**:
   - For any two consecutive elements in the result, their group values must be different

2. **Greedy Strategy**:
   - Start with the first word
   - Iterate through the list and only add a word to the result if its group is different from the last one added
   - This ensures we always alternate between 0 and 1 in the `groups` array

3. **Efficiency**:
   - We process each element exactly once → very efficient

---

### Complexity Analysis

- **Time**: $O(n)$ — Single pass through the arrays
- **Space**: $O(k)$ — Where `k` is the number of selected elements

---

### Code Solution (comments in English)

```swift
class Solution {
    func getLongestSubsequence(_ words: [String], _ groups: [Int]) -> [String] {
        // Start with the first word
        var result = [words[0]]
        var prevGroup = groups[0]
        
        // Iterate over the rest of the elements
        for i in 1..<groups.count {
            // Only include the word if its group is different from the previous one
            if groups[i] != prevGroup {
                result.append(words[i])
                prevGroup = groups[i]
            }
        }
        
        return result
    }
}
```

---

### Examples

#### Example 1:
**Input**:  
`words = ["e","a","b"]`  
`groups = [0,0,1]`  
**Output**: `["e","b"]` or `["a","b"]`

#### Example 2:
**Input**:  
`words = ["a","b","c","d"]`  
`groups = [1,0,1,1]`  
**Output**: `["a","b","c"]` or `["a","b","d"]`

---

### Conclusion

This problem demonstrates how a greedy approach can efficiently solve a subsequence selection task. By maintaining the last used group value and selecting only alternating groups, we construct a valid longest alternating subsequence in linear time.