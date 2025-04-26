## [PT/BR]

### O Problema

Dados dois inteiros positivos `low` e `high`, precisamos contar quantos números inteiros simétricos existem no intervalo [low, high]. Um número é considerado simétrico quando:

1. Possui um número par de dígitos (2n dígitos)
2. A soma dos primeiros n dígitos é igual à soma dos últimos n dígitos

### Raciocínio

1. **Verificação de Dígitos Pares**:
   - Números com quantidade ímpar de dígitos são automaticamente descartados
   - Focamos em números com 2 ou 4 dígitos (já que o limite superior é 10^4)

2. **Verificação de Simetria**:
   - Para números de 2 dígitos: verifica se os dois dígitos são iguais
   - Para números de 4 dígitos: verifica se a soma dos dois primeiros dígitos é igual à soma dos dois últimos

3. **Otimização**:
   - Pulamos números com 1 ou 3 dígitos diretamente
   - Extraímos dígitos individualmente para fazer as comparações necessárias

### Análise da Complexidade

- **Tempo**: O(n) - Onde n é o tamanho do intervalo [low, high]
- **Espaço**: O(1) - Usamos apenas variáveis auxiliares constantes

### Solução em Código

```swift
import Foundation

class Solution {
    func countSymmetricIntegers(_ low: Int, _ high: Int) -> Int {
        var count = 0
        
        for num in low...high {
            // Pula números com 1 ou 3 dígitos
            if num < 10 || (num > 99 && num < 1000) {
                continue
            }

            // Verifica números de 2 dígitos
            if num < 100 {
                let firstDigit = num / 10
                let secondDigit = num % 10
                if firstDigit == secondDigit {
                    count += 1
                }
                continue
            }

            // Verifica números de 4 dígitos
            if num < 10000 {
                let firstPair = (num / 1000) + ((num / 100) % 10)
                let secondPair = ((num / 10) % 10) + (num % 10)
                if firstPair == secondPair {
                    count += 1
                }
            }
        }
        
        return count
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `low = 1`, `high = 100`  
**Output**: `9`  
**Explicação**:
- Números simétricos: 11, 22, 33, 44, 55, 66, 77, 88, 99
- Total: 9

#### Exemplo 2:
**Input**: `low = 1200`, `high = 1230`  
**Output**: `4`  
**Explicação**:
- Números simétricos: 1203 (1+2 = 0+3), 1212 (1+2 = 1+2), 1221 (1+2 = 2+1), 1230 (1+2 = 3+0)
- Total: 4

### Conclusão

Esta solução eficiente conta números simétricos verificando apenas os casos relevantes (números com 2 ou 4 dígitos) e comparando as somas dos pares de dígitos correspondentes. A abordagem é direta e otimizada para o intervalo dado.

---

## [EN]

### The Problem

Given two positive integers `low` and `high`, we need to count how many symmetric integers exist in the range [low, high]. A number is considered symmetric when:

1. It has an even number of digits (2n digits)
2. The sum of the first n digits equals the sum of the last n digits

### Reasoning

1. **Even Digit Check**:
   - Numbers with odd digit counts are automatically discarded
   - We focus on numbers with 2 or 4 digits (since upper limit is 10^4)

2. **Symmetry Verification**:
   - For 2-digit numbers: check if both digits are equal
   - For 4-digit numbers: check if sum of first two digits equals sum of last two

3. **Optimization**:
   - Skip numbers with 1 or 3 digits directly
   - Extract digits individually for necessary comparisons

### Complexity Analysis

- **Time**: O(n) - Where n is the size of range [low, high]
- **Space**: O(1) - Uses only constant auxiliary variables

### Code Solution

```swift
import Foundation

class Solution {
    func countSymmetricIntegers(_ low: Int, _ high: Int) -> Int {
        var count = 0
        
        for num in low...high {
            // Skip numbers with 1 or 3 digits
            if num < 10 || (num > 99 && num < 1000) {
                continue
            }

            // Check 2-digit numbers
            if num < 100 {
                let firstDigit = num / 10
                let secondDigit = num % 10
                if firstDigit == secondDigit {
                    count += 1
                }
                continue
            }

            // Check 4-digit numbers
            if num < 10000 {
                let firstPair = (num / 1000) + ((num / 100) % 10)
                let secondPair = ((num / 10) % 10) + (num % 10)
                if firstPair == secondPair {
                    count += 1
                }
            }
        }
        
        return count
    }
}
```

### Examples

#### Example 1:
**Input**: `low = 1`, `high = 100`  
**Output**: `9`  
**Explanation**:
- Symmetric numbers: 11, 22, 33, 44, 55, 66, 77, 88, 99
- Total: 9

#### Example 2:
**Input**: `low = 1200`, `high = 1230`  
**Output**: `4`  
**Explanation**:
- Symmetric numbers: 1203 (1+2 = 0+3), 1212 (1+2 = 1+2), 1221 (1+2 = 2+1), 1230 (1+2 = 3+0)
- Total: 4

### Conclusion

This efficient solution counts symmetric numbers by checking only relevant cases (numbers with 2 or 4 digits) and comparing sums of corresponding digit pairs. The approach is straightforward and optimized for the given range.