## [PT/BR]

### O Problema

Você recebe:

- Um array de inteiros `nums` de tamanho `n`
- Uma lista de consultas (`queries`) onde cada consulta é representada por um par `[li, ri]`, indicando um intervalo de índices

Cada consulta permite que você selecione **um subconjunto de índices** dentro do intervalo `[li, ri]` e decremente os elementos correspondentes em 1.

O objetivo é determinar se é possível transformar o array `nums` em um **array zero** (todos os elementos iguais a zero) após aplicar todas as consultas na ordem dada.

---

### Raciocínio

1. **Objetivo**:
   - Para cada elemento `nums[i]`, precisamos decrementar ele exatamente `nums[i]` vezes
   - Cada decremento só pode ser feito durante uma ou mais queries que incluem esse índice

2. **Estratégia – Diferenças Prefixadas (Prefix Difference)**:
   - Em vez de aplicar diretamente os decrementos para cada query (muito lento), usamos uma técnica chamada **prefix difference array**:
     - Marcamos quantas vezes cada posição será decrementada
     - Fazemos isso usando um array auxiliar de diferenças
     - Depois percorremos o array original acumulando esses decrementos

3. **Verificação final**:
   - Durante a passagem pelo array, verificamos se o número total de decrementos possíveis é suficiente para zerar cada elemento

4. **Eficiência da abordagem**:
   - Tempo: $O(n + q)$ — Processa todos os elementos e todas as queries apenas uma vez
   - Espaço: $O(n)$ — Usamos um array adicional pequeno

---

### Análise da Complexidade

- **Tempo**: $O(n + q)$  
  - `n` = comprimento de `nums`  
  - `q` = número de `queries`
- **Espaço**: $O(n)$ — Array de diferenças

---

### Solução em Código (comentários em português)

```swift
class Solution {
    func isZeroArray(_ nums: [Int], _ queries: [[Int]]) -> Bool {
        let n = nums.count
        
        // Array de diferença para registrar quantas vezes cada posição será decrementada
        var diff = [Int](repeating: 0, count: n + 2)
        
        // Aplica todas as queries no array de diferenças
        for q in queries {
            let l = q[0]
            let r = q[1]
            diff[l] += 1
            if r + 1 < n {
                diff[r + 1] -= 1
            }
        }
        
        // Percorre o array acumulando os decrementos
        var currDec = 0
        for i in 0..<n {
            currDec += diff[i]
            
            // Verifica se podemos zerar nums[i] com os decrementos disponíveis
            if currDec < nums[i] {
                return false
            }
        }
        
        return true
    }
}
```

---

### Exemplos

#### Exemplo 1:
**Input**: `nums = [1,0,1]`, `queries = [[0,2]]`  
**Output**: `true`  
**Explicação**: Podemos decrementar os índices 0 e 2 → `[0,0,0]`

#### Exemplo 2:
**Input**: `nums = [4,3,2,1]`, `queries = [[1,3],[0,2]]`  
**Output**: `false`  
**Explicação**: Mesmo após as duas queries, não há decrementos suficientes para zerar todos os elementos

---

### Conclusão

Este problema demonstra como técnicas de prefix sum podem ser usadas para resolver problemas de atualização de intervalos de forma eficiente. A ideia de usar um **array de diferenças** é poderosa e evita simular todas as operações de decremento, tornando a solução muito mais rápida e escalável.

---

## [EN]

### The Problem

You are given:

- An integer array `nums` of length `n`
- A list of range queries `queries[i] = [li, ri]`

Each query allows you to select a subset of indices within the range `[li, ri]` and decrement those elements by 1.

Return `true` if it is possible to transform `nums` into an array where all values are zero after applying all queries sequentially. Otherwise, return `false`.

---

### Reasoning

1. **Goal**:
   - Each element `nums[i]` must be reduced exactly `nums[i]` times
   - You can only apply decrements during queries that include index `i`

2. **Efficient Strategy – Prefix Difference Technique**:
   - Use a **difference array** to efficiently track how many times each index will be decremented
   - For each query `[l, r]`, increment `diff[l]` and decrement `diff[r+1]`
   - Then compute the prefix sum over `diff` to find how many times each index is affected

3. **Validation**:
   - As we walk through the array, check if the number of allowed decrements is enough to reduce `nums[i]` to zero

---

### Complexity Analysis

- **Time**: $O(n + q)$ — Linear in size of input and number of queries
- **Space**: $O(n)$ — Additional difference array used

---

### Code Solution (comments in English)

```swift
class Solution {
    func isZeroArray(_ nums: [Int], _ queries: [[Int]]) -> Bool {
        let n = nums.count
        
        // Difference array to track how many times each index is decremented
        var diff = [Int](repeating: 0, count: n + 2)
        
        // Apply each query to the difference array
        for q in queries {
            let l = q[0]
            let r = q[1]
            diff[l] += 1
            if r + 1 < n {
                diff[r + 1] -= 1
            }
        }
        
        // Traverse the array and accumulate decrements
        var currDec = 0
        for i in 0..<n {
            currDec += diff[i]
            
            // Check if current decrements are sufficient to reduce nums[i] to 0
            if currDec < nums[i] {
                return false
            }
        }
        
        return true
    }
}
```

---

### Examples

#### Example 1:
**Input**: `nums = [1,0,1]`, `queries = [[0,2]]`  
**Output**: `true`  
**Explanation**: After one query, both ends are decremented once → `[0,0,0]`

#### Example 2:
**Input**: `nums = [4,3,2,1]`, `queries = [[1,3],[0,2]]`  
**Output**: `false`  
**Explanation**: Even after two queries, not enough decrements to make all elements zero

---

### Conclusion

This problem demonstrates the power of using a **prefix difference array** to handle range updates efficiently. Instead of applying each query directly (which would be too slow), we use a smart tracking technique to calculate how many times each index can be decremented.

This approach is optimal and works well even under tight time constraints.