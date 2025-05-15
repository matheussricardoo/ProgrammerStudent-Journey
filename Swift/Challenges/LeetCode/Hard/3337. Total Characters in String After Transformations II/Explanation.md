## [PT/BR]

### O Problema

Você recebe:

- Uma string `s` formada por letras minúsculas
- Um inteiro `t`, representando o número de transformações que devem ser aplicadas
- Um array `nums` de tamanho 26, onde cada valor indica quantos caracteres substituem cada letra do alfabeto

Cada transformação funciona assim:

- Cada caractere `c` na string é substituído por `nums[ord(c) - ord('a')]` caracteres consecutivos no alfabeto.
- Se o fim do alfabeto for ultrapassado, ele "volta" para o início (wrap around).
- Exemplo: `'y'` com `nums[24] = 3` vira `"zab"`.

O objetivo é retornar o **comprimento da string final** após exatamente `t` transformações. Como isso pode crescer exponencialmente, retorne o resultado módulo $10^9 + 7$.

---

### Raciocínio

1. **Transformação é complexa e pode aumentar o tamanho exponencialmente**:
   - Não podemos simular a string diretamente para grandes valores de `t` (`t <= 1e9`)
   - Precisamos de uma abordagem matemática eficiente

2. **Abordagem Matemática – Multiplicação de Matrizes**:
   - Representamos as transições usando uma **matriz de transição 26x26**, uma para cada letra do alfabeto
   - Cada posição `M[i][j]` representa quantas vezes um caractere `i` gera um caractere `j` em uma transformação
   - Elevamos essa matriz à potência `t` usando **exponenciação rápida de matrizes**
   - Com a matriz pronta, multiplicamos pelo vetor inicial de contagens dos caracteres para obter o total final

3. **Vantagem da Abordagem**:
   - Tempo: $O(\log t \cdot 26^3)$ → aceitável mesmo se `t` for até $10^9$
   - Espaço: $O(26^2)$ → muito pequeno

---

### Análise da Complexidade

- **Tempo**: $O(\log t \cdot 26^3)$ — operação rápida com matrizes pequenas
- **Espaço**: $O(26^2)$ — armazenamos matrizes fixas

---

### Solução em Código (comentários em português)

```swift
class Solution {
    func lengthAfterTransformations(_ s: String, _ t: Int, _ nums: [Int]) -> Int {
        let MOD = 1_000_000_007
        let n = 26
        
        // Passo 1: Criar a matriz de transição M
        var M = Array(repeating: Array(repeating: 0, count: 26), count: 26)
        for i in 0..<26 {
            let m = nums[i]
            let start = (i + 1) % 26
            for k in 0..<m {
                let j = (start + k) % 26
                M[i][j] = (M[i][j] + 1) % MOD
            }
        }
        
        // Função: multiplicar duas matrizes
        func multiply(_ A: [[Int]], _ B: [[Int]]) -> [[Int]] {
            var result = Array(repeating: Array(repeating: 0, count: n), count: n)
            for i in 0..<n {
                for k in 0..<n {
                    if A[i][k] == 0 { continue }
                    for j in 0..<n {
                        result[i][j] = (result[i][j] + A[i][k] * B[k][j]) % MOD
                    }
                }
            }
            return result
        }
        
        // Função: elevar uma matriz à potência t usando exponenciação rápida
        func matrixPower(_ matrix: [[Int]], _ power: Int) -> [[Int]] {
            var result = Array(repeating: Array(repeating: 0, count: n), count: n)
            for i in 0..<n {
                result[i][i] = 1
            }
            var current = matrix
            var remaining = power
            while remaining > 0 {
                if remaining % 2 == 1 {
                    result = multiply(result, current)
                }
                current = multiply(current, current)
                remaining /= 2
            }
            return result
        }
        
        // Passo 2: Calcular M elevado a t
        let powerMatrix = matrixPower(M, t)
        
        // Inicializar contagem de cada caractere
        var counts = Array(repeating: 0, count: 26)
        for c in s {
            let idx = Int(c.asciiValue!) - Int(Character("a").asciiValue!)
            counts[idx] += 1
        }
        
        // Passo 3: Aplicar a transformação final
        var finalCounts = Array(repeating: 0, count: 26)
        for i in 0..<26 {
            for j in 0..<26 {
                finalCounts[j] = (finalCounts[j] + counts[i] * powerMatrix[i][j]) % MOD
            }
        }
        
        // Somar todas as contagens para obter o comprimento final
        var totalLength = 0
        for count in finalCounts {
            totalLength = (totalLength + count) % MOD
        }
        
        return totalLength
    }
}
```

---

### Exemplos

#### Exemplo 1:
**Input**:  
`s = "abcyy"`  
`t = 2`  
`nums = [1,1,1,...,1,2]`  
**Output**: `7`  
**Explicação**:
- Após transformações: `"cdeabab"` → comprimento = 7

#### Exemplo 2:
**Input**:  
`s = "azbk"`  
`t = 1`  
`nums = [2,2,...,2]`  
**Output**: `8`  
**Explicação**:
- Após transformação: `"bcabcdlm"` → comprimento = 8

---

### Conclusão

Este problema demonstra como técnicas matriciais podem ser usadas para resolver transformações repetidas de forma eficiente, mesmo quando o número de iterações é extremamente grande. Em vez de trabalhar com a string real, rastreamos apenas contagens de letras, permitindo escalar para entradas maiores sem perda de desempenho.

---

## [EN]

### The Problem

You are given:

- A string `s` of lowercase English letters
- An integer `t`, representing the number of transformations to perform
- An array `nums` of size 26, where each value indicates how many characters replace each letter in the alphabet

Each character is transformed like this:

- Each character `c` is replaced by `nums[ord(c) - ord('a')]` consecutive characters in the alphabet
- Wrap around if the transformation overflows `'z'` (e.g., `'y'` with `nums[24] = 3` becomes `"zab"`)

Return the **length of the resulting string after exactly `t` transformations**, modulo $10^9 + 7$

---

### Reasoning

1. **Transformation can cause exponential growth**:
   - Simulating the actual string is not feasible for large values of `t` (`t <= 10^9`)
   - Instead, we simulate using **character counts only**

2. **Efficient Matrix-Based Approach**:
   - Use a **26x26 transition matrix**, where `M[i][j]` represents how many times a character `i` generates a character `j`
   - Raise this matrix to the `t`th power using **fast matrix exponentiation**
   - Multiply the initial character counts vector with the resulting matrix to get final character counts

3. **Modulo usage**:
   - Apply modulo at every step to avoid overflow

---

### Complexity Analysis

- **Time**: $O(\log t \cdot 26^3)$ — efficient even for large `t`
- **Space**: $O(26^2)$ — small and fixed-size matrices used

---

### Code Solution (comments in English)

```swift
class Solution {
    func lengthAfterTransformations(_ s: String, _ t: Int, _ nums: [Int]) -> Int {
        let MOD = 1_000_000_007
        let n = 26
        
        // Step 1: Build transformation matrix M
        var M = Array(repeating: Array(repeating: 0, count: 26), count: 26)
        for i in 0..<26 {
            let m = nums[i]
            let start = (i + 1) % 26
            for k in 0..<m {
                let j = (start + k) % 26
                M[i][j] = (M[i][j] + 1) % MOD
            }
        }
        
        // Function to multiply two matrices
        func multiply(_ A: [[Int]], _ B: [[Int]]) -> [[Int]] {
            var result = Array(repeating: Array(repeating: 0, count: n), count: n)
            for i in 0..<n {
                for k in 0..<n {
                    if A[i][k] == 0 { continue }
                    for j in 0..<n {
                        result[i][j] = (result[i][j] + A[i][k] * B[k][j]) % MOD
                    }
                }
            }
            return result
        }
        
        // Function: compute matrix power using fast exponentiation
        func matrixPower(_ matrix: [[Int]], _ power: Int) -> [[Int]] {
            var result = Array(repeating: Array(repeating: 0, count: n), count: n)
            for i in 0..<n {
                result[i][i] = 1
            }
            var current = matrix
            var remaining = power
            while remaining > 0 {
                if remaining % 2 == 1 {
                    result = multiply(result, current)
                }
                current = multiply(current, current)
                remaining /= 2
            }
            return result
        }
        
        // Step 2: Compute M^t
        let powerMatrix = matrixPower(M, t)
        
        // Initialize counts of each character from input string
        var counts = Array(repeating: 0, count: 26)
        for c in s {
            let idx = Int(c.asciiValue!) - Int(Character("a").asciiValue!)
            counts[idx] += 1
        }
        
        // Step 3: Multiply counts vector with the power matrix
        var finalCounts = Array(repeating: 0, count: 26)
        for i in 0..<26 {
            for j in 0..<26 {
                finalCounts[j] = (finalCounts[j] + counts[i] * powerMatrix[i][j]) % MOD
            }
        }
        
        // Sum all counts to get final string length
        var totalLength = 0
        for count in finalCounts {
            totalLength = (totalLength + count) % MOD
        }
        
        return totalLength
    }
}
```

---

### Examples

#### Example 1:
**Input**:  
`s = "abcyy"`  
`t = 2`  
`nums = [1,1,1,...,1,2]`  
**Output**: `7`  
**Explanation**: After 2 transformations: `"cdeabab"` → length = 7

#### Example 2:
**Input**:  
`s = "azbk"`  
`t = 1`  
`nums = [2,2,...,2]`  
**Output**: `8`  
**Explanation**: After transformation: `"bcabcdlm"` → length = 8

---

### Conclusion

This problem illustrates how matrix exponentiation can be used to efficiently model repeated transformations on discrete states (here, characters). By avoiding direct string manipulation and instead tracking character counts through matrix multiplication, we optimize performance and handle large inputs gracefully.