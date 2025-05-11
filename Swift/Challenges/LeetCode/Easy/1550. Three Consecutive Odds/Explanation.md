## [PT/BR]

### O Problema

Dado um array de inteiros `arr`, devemos retornar `true` se houver **três números consecutivos ímpares** no array. Caso contrário, retornamos `false`.

---

### Raciocínio

1. Um número é **ímpar** quando não é divisível por 2 (`num % 2 == 1`)
2. Se o array tiver menos de 3 elementos, é **impossível** ter três consecutivos → retornamos `false`
3. Percorremos o array do início até o penúltimo elemento antes do fim
4. Para cada posição `i`, verificamos:
   - `arr[i]`, `arr[i+1]` e `arr[i+2]` são todos ímpares?
5. Se encontrarmos uma sequência assim, retornamos `true`
6. Se percorrermos o array inteiro sem encontrar, retornamos `false`

---

### Análise da Complexidade

- **Tempo**: $O(n)$ — Percorremos o array uma única vez  
- **Espaço**: $O(1)$ — Não usamos memória extra além de variáveis locais

---

### Solução em Código 

```swift
class Solution {
    func threeConsecutiveOdds(_ arr: [Int]) -> Bool {
        // Verifica se há pelo menos 3 elementos para verificar
        guard arr.count >= 3 else {
            return false
        }

        // Itera pelo array até onde ainda há 3 elementos consecutivos possíveis
        for i in 0...(arr.count - 3) {
            // Verifica se os três elementos consecutivos são todos ímpares
            if arr[i] % 2 == 1 && arr[i + 1] % 2 == 1 && arr[i + 2] % 2 == 1 {
                return true
            }
        }

        // Nenhuma sequência de três ímpares foi encontrada
        return false
    }
}
```

---

### Exemplos

#### Exemplo 1:
**Input**: `arr = [2,6,4,1]`  
**Output**: `false`  
**Explicação**: Nenhum trio de números consecutivos é composto apenas por ímpares.

#### Exemplo 2:
**Input**: `arr = [1,2,34,3,4,5,7,23,12]`  
**Output**: `true`  
**Explicação**: A subsequência `[5,7,23]` consiste em três números ímpares consecutivos.

---

### Conclusão

Este problema é simples e pode ser resolvido com um único loop. A lógica é clara e direta: basta verificar cada grupo de três elementos consecutivos. Com uma pequena otimização inicial (`guard`), garantimos eficiência mesmo em casos triviais.

---

## [EN]

### The Problem

Given an integer array `arr`, return `true` if there are **three consecutive odd numbers** in the array. Otherwise, return `false`.

---

### Reasoning

1. A number is **odd** when it is not divisible by 2 (`num % 2 == 1`)
2. If the array has fewer than 3 elements, it's **impossible** to have 3 consecutive numbers → return `false`
3. We iterate through the array up to the third-to-last element
4. For each index `i`, we check whether:
   - `arr[i]`, `arr[i+1]` and `arr[i+2]` are all odd
5. If such a sequence is found, return `true`
6. If no such sequence is found after the loop, return `false`

---

### Complexity Analysis

- **Time**: $O(n)$ — We traverse the array once  
- **Space**: $O(1)$ — No additional memory used

---

### Code Solution 

```swift
class Solution {
    func threeConsecutiveOdds(_ arr: [Int]) -> Bool {
        // Check if we have at least 3 elements to check
        guard arr.count >= 3 else {
            return false
        }

        // Iterate through the array while checking triplets
        for i in 0...(arr.count - 3) {
            // Check if current triplet consists of all odd numbers
            if arr[i] % 2 == 1 && arr[i + 1] % 2 == 1 && arr[i + 2] % 2 == 1 {
                return true
            }
        }

        // No triplet of consecutive odds was found
        return false
    }
}
```

---

### Examples

#### Example 1:
**Input**: `arr = [2,6,4,1]`  
**Output**: `false`  
**Explanation**: There are no three consecutive odd numbers in the array.

#### Example 2:
**Input**: `arr = [1,2,34,3,4,5,7,23,12]`  
**Output**: `true`  
**Explanation**: The subarray `[5,7,23]` contains three consecutive odd numbers.

---

### Conclusion

This problem is straightforward and can be solved with a simple loop. The logic involves checking each group of three consecutive elements and verifying if they're all odd. With a small optimization using `guard`, the solution remains efficient even for edge cases.