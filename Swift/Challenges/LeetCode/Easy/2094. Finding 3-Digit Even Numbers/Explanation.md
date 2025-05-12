## [PT/BR]

### O Problema

Você recebe um array de inteiros chamado `digits`, onde cada elemento é um dígito (0 a 9). O array pode conter **duplicatas**.

Você precisa encontrar todos os **números inteiros únicos de três dígitos** que podem ser formados usando **três elementos do array (em qualquer ordem)**, obedecendo às seguintes regras:

1. O número não pode começar com **zero** (não deve ter zeros à esquerda).
2. O número deve ser **par**.
3. Um dígito só pode ser usado tantas vezes quanto aparece no array.

No final, retorne o resultado como uma **lista ordenada de números únicos**.

---

### Raciocínio

1. **Gerar números de 3 dígitos pares**:
   - Todos os números de 3 dígitos estão entre `100` e `999`.
   - Como queremos apenas os **pares**, iteramos com passo `2`.

2. **Verificar se podemos construir o número com os dígitos disponíveis**:
   - Para cada número par de 3 dígitos, extraímos seus dígitos: centena, dezena e unidade.
   - Verificamos se temos quantidade suficiente de cada dígito no array original.
   - Levamos em conta as repetições: por exemplo, se usarmos o mesmo dígito mais de uma vez, precisamos garantir que ele apareça no array ao menos esse número de vezes.

3. **Usar estrutura para evitar duplicatas**:
   - Usamos um `Set<Int>` para garantir que os resultados sejam únicos.

4. **Ordenar antes de retornar**:
   - No final, convertemos o conjunto em um array e o ordenamos.

---

### Análise da Complexidade

- **Tempo**: $O(1)$ — Há no máximo 450 números pares de 3 dígitos (`(999 - 100) / 2 + 1 = 450`) → operações constantes por número
- **Espaço**: $O(1)$ — Tamanho do resultado é limitado a 450 no máximo

---

### Solução em Código (comentários em português)

```swift
class Solution {
    func findEvenNumbers(_ digits: [Int]) -> [Int] {
        // Conta quantas vezes cada dígito aparece
        var counts = [Int](repeating: 0, count: 10)
        for digit in digits {
            counts[digit] += 1
        }
        
        // Usaremos um Set para armazenar resultados únicos
        var result = Set<Int>()
        
        // Percorre todos os números pares de 3 dígitos
        for num in stride(from: 100, through: 999, by: 2) {
            let hundreds = num / 100     // Primeiro dígito (centena)
            let tens = (num / 10) % 10   // Segundo dígito (dezena)
            let units = num % 10         // Terceiro dígito (unidade)
            
            // Verifica se ainda temos esses dígitos disponíveis
            guard counts[hundreds] > 0 else { continue }
            guard counts[tens] > 0 else { continue }
            guard counts[units] > 0 else { continue }
            
            // Faz uma cópia temporária das contagens para verificar uso múltiplo
            var tempCounts = counts
            tempCounts[hundreds] -= 1
            tempCounts[tens] -= 1
            tempCounts[units] -= 1
            
            // Se todas as contagens forem válidas, adiciona o número ao resultado
            if tempCounts[hundreds] >= 0 && tempCounts[tens] >= 0 && tempCounts[units] >= 0 {
                result.insert(num)
            }
        }
        
        // Retorna o resultado ordenado
        return Array(result).sorted()
    }
}
```

---

### Exemplos

#### Exemplo 1:
**Input**: `digits = [2,1,3,0]`  
**Output**: `[102,120,130,132,210,230,302,310,312,320]`  
**Explicação**: Todos os números são pares, sem zero à esquerda, e usam os dígitos disponíveis.

#### Exemplo 2:
**Input**: `digits = [2,2,8,8,2]`  
**Output**: `[222,228,282,288,822,828,882]`  
**Explicação**: O dígito `2` aparece três vezes, então pode ser usado até três vezes em qualquer número.

#### Exemplo 3:
**Input**: `digits = [3,7,5]`  
**Output**: `[]`  
**Explicação**: Não há dígitos pares, então nenhum número par pode ser formado.

---

### Conclusão

Este problema envolve lógica combinatória simples com restrição de uso de dígitos. Ao invés de gerar todas as permutações possíveis (que seria custoso), optamos por iterar sobre todos os números pares de 3 dígitos e verificar se podemos construí-los com os dígitos fornecidos. A abordagem é eficiente e evita redundâncias.

---

## [EN]

### The Problem

You are given an integer array `digits`, where each element is a digit (0 to 9). The array may contain duplicates.

You must return **unique three-digit integers** that can be formed using any three elements from the array following these rules:

1. The number must not have leading zeros.
2. The number must be even.
3. Each digit used must appear at least as many times as it appears in the number.

Return the list of such numbers sorted in ascending order.

---

### Reasoning

1. **Iterate over all even 3-digit numbers**:
   - All valid 3-digit numbers range from `100` to `999`
   - Only even numbers are allowed → use step size `2`

2. **Check whether we can construct the number with available digits**:
   - For each number, extract its digits: hundreds, tens, and units
   - Verify that we have enough of each digit in the input
   - Take into account how many times each digit appears in the input

3. **Avoid duplicates**:
   - Use a `Set<Int>` to store results uniquely

4. **Return sorted list**:
   - Convert the set to an array and sort before returning

---

### Complexity Analysis

- **Time**: $O(1)$ — There are only 450 possible even 3-digit numbers → constant number of iterations
- **Space**: $O(1)$ — Maximum number of unique results is limited

---

### Code Solution (comments in English)

```swift
class Solution {
    func findEvenNumbers(_ digits: [Int]) -> [Int] {
        // Count how many times each digit appears
        var counts = [Int](repeating: 0, count: 10)
        for digit in digits {
            counts[digit] += 1
        }
        
        // Use a set to collect unique results
        var result = Set<Int>()
        
        // Iterate all even 3-digit numbers
        for num in stride(from: 100, through: 999, by: 2) {
            let hundreds = num / 100       // First digit (hundreds place)
            let tens = (num / 10) % 10     // Second digit (tens place)
            let units = num % 10           // Third digit (units place)
            
            // Check if we have these digits available
            guard counts[hundreds] > 0 else { continue }
            guard counts[tens] > 0 else { continue }
            guard counts[units] > 0 else { continue }
            
            // Make a temporary copy to verify usage
            var tempCounts = counts
            tempCounts[hundreds] -= 1
            tempCounts[tens] -= 1
            tempCounts[units] -= 1
            
            // If all digits are still valid after subtraction, add to result
            if tempCounts[hundreds] >= 0 && tempCounts[tens] >= 0 && tempCounts[units] >= 0 {
                result.insert(num)
            }
        }
        
        // Return sorted result
        return Array(result).sorted()
    }
}
```

---

### Examples

#### Example 1:
**Input**: `digits = [2,1,3,0]`  
**Output**: `[102,120,130,132,210,230,302,310,312,320]`  
**Explanation**: All numbers are even, have no leading zeros, and are made from the available digits.

#### Example 2:
**Input**: `digits = [2,2,8,8,2]`  
**Output**: `[222,228,282,288,822,828,882]`  
**Explanation**: Digit `2` appears 3 times, so it can be used up to 3 times in any number.

#### Example 3:
**Input**: `digits = [3,7,5]`  
**Output**: `[]`  
**Explanation**: No even digits are available, so no even numbers can be formed.

---

### Conclusion

This problem involves simple combinatorial logic with constraints on digit reuse. Instead of generating all permutations (which would be inefficient), we iterate through all possible 3-digit even numbers and check whether they can be built from the available digits. This approach is efficient and avoids redundancy.