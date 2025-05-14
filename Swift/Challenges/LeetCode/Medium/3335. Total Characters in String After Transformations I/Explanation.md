## [PT/BR]

### O Problema

Você recebe uma string `s` e um inteiro `t`, representando o número de transformações que devem ser aplicadas à string.

Cada transformação consiste em substituir cada caractere da string pelas seguintes regras:

- Se o caractere for `'z'`, ele é substituído pela string `"ab"`.
- Caso contrário, ele é substituído pelo próximo caractere no alfabeto (`'a' → 'b'`, `'b' → 'c'`, ..., `'y' → 'z'`).

O objetivo é retornar o **comprimento da string após exatamente `t` transformações**. Como o comprimento pode ficar muito grande, retorne-o módulo $10^9 + 7$.

---

### Raciocínio

1. **Transformações mudam o tamanho da string**:
   - `'z'` vira `"ab"` → aumenta o tamanho em 1
   - Todos os outros caracteres apenas avançam no alfabeto, sem alterar o tamanho individualmente

2. **Simulação direta não é viável**:
   - Para grandes valores de `t` (até $10^5$), simular as transformações diretamente na string seria **muito lento**.
   - Em vez disso, usamos contagem de caracteres para simular as transformações de forma eficiente.

3. **Estratégia otimizada**:
   - Usamos um array `currentCounts[26]` para contar quantas vezes cada letra aparece atualmente.
   - Simulamos as transformações apenas nos **contadores de letras**, não na string real.
   - Cada vez que `'z'` aparece, sabemos que ela adicionará mais um caractere (`"ab"` tem 2 caracteres, mas só adiciona 1 extra).
   - Atualizamos o comprimento da string conforme essa expansão.

4. **Módulo necessário**:
   - Como o resultado pode ser muito grande, aplicamos o módulo $10^9 + 7$ durante todas as operações.

---

### Análise da Complexidade

- **Tempo**: $O(t \cdot 26)$ — Para cada transformação, atualizamos todos os 26 caracteres.
- **Espaço**: $O(1)$ — Apenas arrays fixos de 26 posições.

---

### Solução em Código (comentários em português)

```swift
class Solution {
    func lengthAfterTransformations(_ s: String, _ t: Int) -> Int {
        let MOD = 1_000_000_007
        
        // Contador de cada caractere (a-z)
        var currentCounts = [Int](repeating: 0, count: 26)
        
        // Inicializa contagem dos caracteres iniciais
        for c in s {
            let idx = Int(c.asciiValue!) - Int(Character("a").asciiValue!)
            currentCounts[idx] += 1
        }
        
        // Comprimento inicial da string
        var length = s.count
        
        // Aplica cada transformação
        for _ in 0..<t {
            let zCount = currentCounts[25] // Quantos 'z's existem agora
            
            // Cada 'z' vira "ab", aumentando o comprimento em 1
            length = (length + zCount) % MOD
            
            // Prepara o próximo estado com base nas regras de transformação
            var nextCounts = [Int](repeating: 0, count: 26)
            
            for i in 0..<26 {
                // Cada caractere move-se para o próximo no alfabeto
                if i >= 1 {
                    nextCounts[i] += currentCounts[i - 1]
                    nextCounts[i] %= MOD
                }
                
                // 'z' (índice 25) se torna "ab", ou seja, 'a' e 'b'
                if i == 0 || i == 1 {
                    nextCounts[i] += currentCounts[25]
                    nextCounts[i] %= MOD
                }
            }
            
            // Atualiza os contadores para o próximo estado
            currentCounts = nextCounts
        }
        
        return length % MOD
    }
}
```

---

### Exemplos

#### Exemplo 1:
**Input**: `s = "abcyy"`, `t = 2`  
**Output**: `7`  
**Explicação**:
- Após 1ª transformação: `"bcdzz"`
- Após 2ª transformação: `"cdeabab"` → comprimento = 7

#### Exemplo 2:
**Input**: `s = "azbk"`, `t = 1`  
**Output**: `5`  
**Explicação**:
- Após transformação: `"babcl"` → comprimento = 5

---

### Conclusão

Este problema mostra como simulações podem ser feitas de maneira inteligente, evitando trabalhar com estruturas grandes (como strings completas). Ao invés disso, rastreamos apenas informações relevantes (como quantidade de cada caractere e o comprimento total), garantindo eficiência mesmo para grandes entradas.

---

## [EN]

### The Problem

You are given a string `s` and an integer `t`, representing the number of transformations to perform.

In each transformation:

- Each character is replaced with the next one in the alphabet (`'a' → 'b'`, `'b' → 'c'`, ..., `'y' → 'z'`)
- If the character is `'z'`, it is replaced with the string `"ab"`

Return the **length of the resulting string after exactly `t` transformations**. Since the result may be very large, return it modulo $10^9 + 7$.

---

### Reasoning

1. **Transformations change string size**:
   - `'z'` becomes `"ab"` → increases length by 1
   - All other characters just shift forward → same length contribution

2. **Direct simulation is not feasible**:
   - For large `t` (up to $10^5$), simulating the actual string transformations would be **too slow**
   - Instead, we simulate using **character counts only**

3. **Efficient strategy**:
   - Use an array `currentCounts[26]` to track how many times each letter appears
   - Update character counts per transformation based on rules
   - Track the length separately, increasing it when `'z'` is expanded into `"ab"`

4. **Modulo usage**:
   - Apply modulo at every step to avoid overflow

---

### Complexity Analysis

- **Time**: $O(t \cdot 26)$ — For each transformation, update all 26 letters
- **Space**: $O(1)$ — Fixed-size arrays used

---

### Code Solution (comments in English)

```swift
class Solution {
    func lengthAfterTransformations(_ s: String, _ t: Int) -> Int {
        let MOD = 1_000_000_007
        
        // Count of each character (a-z)
        var currentCounts = [Int](repeating: 0, count: 26)
        
        // Initialize character counts from input string
        for c in s {
            let idx = Int(c.asciiValue!) - Int(Character("a").asciiValue!)
            currentCounts[idx] += 1
        }
        
        // Current length of the string
        var length = s.count
        
        // Apply each transformation
        for _ in 0..<t {
            let zCount = currentCounts[25] // How many 'z's are there now
            
            // Each 'z' becomes "ab", adding one more character
            length = (length + zCount) % MOD
            
            // Prepare next state character counts
            var nextCounts = [Int](repeating: 0, count: 26)
            
            for i in 0..<26 {
                // Every character moves to the next in the alphabet
                if i >= 1 {
                    nextCounts[i] += currentCounts[i - 1]
                    nextCounts[i] %= MOD
                }
                
                // 'z' becomes "ab" → contributes to 'a' and 'b'
                if i == 0 || i == 1 {
                    nextCounts[i] += currentCounts[25]
                    nextCounts[i] %= MOD
                }
            }
            
            // Move to next state
            currentCounts = nextCounts
        }
        
        return length % MOD
    }
}
```

---

### Examples

#### Example 1:
**Input**: `s = "abcyy"`, `t = 2`  
**Output**: `7`  
**Explanation**:
- After 1st transformation: `"bcdzz"`
- After 2nd transformation: `"cdeabab"` → length = 7

#### Example 2:
**Input**: `s = "azbk"`, `t = 1`  
**Output**: `5`  
**Explanation**:
- After transformation: `"babcl"` → length = 5

---

### Conclusion

This problem demonstrates how to simulate transformations efficiently without directly working with strings. By tracking character counts and updating them iteratively, we can maintain performance even for large inputs. This approach avoids unnecessary memory usage and ensures results stay within safe numeric limits via modular arithmetic.