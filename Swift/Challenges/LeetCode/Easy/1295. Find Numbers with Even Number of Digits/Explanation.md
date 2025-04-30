## [PT/BR]

### O Problema

Dado um array de inteiros `nums`, precisamos contar quantos números no array possuem um número par de dígitos.

### Raciocínio

1. **Identificação de Números com Dígitos Pares**:
   - Números com 2 dígitos: entre 10 e 99
   - Números com 4 dígitos: entre 1000 e 9999
   - Número com 6 dígitos: 100000 (único número de 6 dígitos no intervalo dado)

2. **Verificação Direta**:
   - Para cada número no array, verificamos se ele está em um dos intervalos que garantem um número par de dígitos
   - Não precisamos converter para string ou calcular logaritmos, o que torna a solução mais eficiente

3. **Contagem**:
   - Incrementamos o contador sempre que um número satisfaz uma das condições acima

### Análise da Complexidade

- **Tempo**: O(n) - Percorremos o array uma única vez
- **Espaço**: O(1) - Usamos apenas uma variável auxiliar para a contagem

### Solução em Código

```swift
class Solution {
    func findNumbers(_ nums: [Int]) -> Int {
        var count = 0
        
        for num in nums {
            if (10...99 ~= num) || 
               (1000...9999 ~= num) || 
               num == 100000 {
                count += 1
            }
        }
        
        return count
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [12,345,2,6,7896]`  
**Output**: `2`  
**Explicação**:
- 12 (2 dígitos) → par
- 345 (3 dígitos) → ímpar
- 2 (1 dígito) → ímpar
- 6 (1 dígito) → ímpar
- 7896 (4 dígitos) → par
- Total: 2 números com dígitos pares

#### Exemplo 2:
**Input**: `nums = [555,901,482,1771]`  
**Output**: `1`  
**Explicação**:
- 555 (3 dígitos) → ímpar
- 901 (3 dígitos) → ímpar
- 482 (3 dígitos) → ímpar
- 1771 (4 dígitos) → par
- Total: 1 número com dígitos pares

### Conclusão

Esta solução eficiente verifica diretamente os intervalos numéricos que correspondem a números com quantidade par de dígitos, evitando conversões desnecessárias e mantendo a complexidade linear.

---

## [EN]

### The Problem

Given an array of integers `nums`, we need to count how many numbers in the array contain an even number of digits.

### Reasoning

1. **Identifying Even-Digit Numbers**:
   - 2-digit numbers: between 10 and 99
   - 4-digit numbers: between 1000 and 9999
   - 6-digit number: 100000 (only 6-digit number in given range)

2. **Direct Verification**:
   - For each number in array, check if it falls into one of the ranges that guarantee even digit count
   - No need for string conversion or logarithm calculation, making solution more efficient

3. **Counting**:
   - Increment counter whenever a number satisfies one of the above conditions

### Complexity Analysis

- **Time**: O(n) - Single pass through the array
- **Space**: O(1) - Uses only one helper variable for counting

### Code Solution

```swift
class Solution {
    func findNumbers(_ nums: [Int]) -> Int {
        var count = 0
        
        for num in nums {
            if (10...99 ~= num) || 
               (1000...9999 ~= num) || 
               num == 100000 {
                count += 1
            }
        }
        
        return count
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [12,345,2,6,7896]`  
**Output**: `2`  
**Explanation**:
- 12 (2 digits) → even
- 345 (3 digits) → odd
- 2 (1 digit) → odd
- 6 (1 digit) → odd
- 7896 (4 digits) → even
- Total: 2 even-digit numbers

#### Example 2:
**Input**: `nums = [555,901,482,1771]`  
**Output**: `1`  
**Explanation**:
- 555 (3 digits) → odd
- 901 (3 digits) → odd
- 482 (3 digits) → odd
- 1771 (4 digits) → even
- Total: 1 even-digit number

### Conclusion

This efficient solution directly checks numeric ranges corresponding to even-digit numbers, avoiding unnecessary conversions and maintaining linear complexity.