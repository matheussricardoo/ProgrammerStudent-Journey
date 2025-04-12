## [PT/BR]

### O Problema

Dados dois inteiros positivos `n` e `k`, precisamos contar quantos números "bons" existem com `n` dígitos. Um número é considerado bom se:

1. Seus dígitos podem ser rearranjados para formar um número k-palindrômico
2. Um número é k-palindrômico se:
   - É um palíndromo (lê-se igual de trás para frente)
   - É divisível por k
3. Números não podem ter zeros à esquerda, nem antes nem depois do rearranjo

### Raciocínio

1. **Geração de Palíndromos**:
   - Geramos todos os possíveis palíndromos com `n` dígitos
   - Para números com quantidade ímpar de dígitos, o dígito do meio é compartilhado

2. **Verificação de Divisibilidade**:
   - Verificamos se o palíndromo gerado é divisível por `k`
   - Se for, armazenamos a contagem de dígitos desse palíndromo

3. **Cálculo de Permutações Válidas**:
   - Para cada palíndromo válido, calculamos quantos números podem ser formados com seus dígitos
   - Descontamos permutações que começam com zero

4. **Otimização**:
   - Usamos memoização para armazenar fatoriais pré-calculados
   - Evitamos recálculos desnecessários de permutações

### Análise da Complexidade

- **Tempo**: O(10^(n/2)) - Para gerar todos os possíveis palíndromos
- **Espaço**: O(1) - Usamos estruturas de tamanho constante

### Solução em Código

```swift
import Foundation

class Solution {
    // Pré-calcula fatoriais de 0 a 10
    let factorial: [Int] = {
        var fact = [1] 
        for i in 1...10 {
            guard fact.last! <= Int.max / i else {
                return [] 
            }
            fact.append(fact.last! * i)
        }
        return fact
    }()

    // Calcula permutações com repetição
    private func calculatePerms(numDigits: Int, counts: [Int]) -> Int {
        guard numDigits >= 0 && numDigits < factorial.count else { return 0 }
        guard counts.count == 10 else { return 0 }

        let numerator = factorial[numDigits]
        var denominator = 1

        for i in 0...9 {
            let count = counts[i]
            guard count >= 0 && count < factorial.count else { return 0 } 
            
            let fact_ci = factorial[count]
            guard fact_ci > 0 else { return 0 } 
            
            guard denominator <= Int.max / fact_ci else { return 0 }
            denominator *= fact_ci
        }
        
        guard denominator > 0 else { return 0 } 
        
        return numerator / denominator
    }

    func countGoodIntegers(_ n: Int, _ k: Int) -> Int {
        guard n >= 1 && n <= 10 else { return 0 }
        guard !factorial.isEmpty else { return 0 } 

        var uniqueMultisets = Set<[Int]>() // Armazena contagens de dígitos únicas
        
        let m = (n + 1) / 2 // Metade do comprimento do palíndromo
        
        // Gera números para a primeira metade do palíndromo
        var startHalf = 1
        if m > 1 {
            for _ in 1..<m { 
                guard startHalf <= Int.max / 10 else { return 0 } 
                startHalf *= 10 
            }
        }
        
        var endHalf = 1
        for _ in 1...m { 
            guard endHalf <= Int.max / 10 else { return 0 } 
            endHalf *= 10 
        }
        guard endHalf >= 1 else { return 0 } 
        endHalf -= 1
        
        guard startHalf <= endHalf else { return 0 }

        // Gera todos os possíveis palíndromos
        for half in startHalf...endHalf {
            let halfStr = String(half)
            let xStr: String 
            
            if n % 2 == 1 { // Número ímpar de dígitos
                if m == 1 { 
                    xStr = halfStr 
                } else {
                    let prefix = halfStr.prefix(m - 1)
                    xStr = halfStr + String(prefix.reversed())
                }
            } else { // Número par de dígitos
                xStr = halfStr + String(halfStr.reversed())
            }

            guard let x = Int(xStr) else { continue } 

            // Verifica se é divisível por k
            if x % k == 0 {
                var counts = Array(repeating: 0, count: 10)
                var validCounts = true
                for char in xStr {
                    guard let digit = char.wholeNumberValue else {
                        validCounts = false; break 
                    }
                    guard digit >= 0 && digit <= 9 else {
                        validCounts = false; break 
                    }
                    counts[digit] += 1
                }
                
                if validCounts { 
                    uniqueMultisets.insert(counts)
                }
            }
        }

        // Calcula o total de números bons
        var totalGoodCount = 0
        for counts in uniqueMultisets {
            let totalPerms = calculatePerms(numDigits: n, counts: counts)

            // Desconta permutações que começam com zero
            var zeroPerms = 0
            if counts[0] > 0 { 
                var countsZero = counts 
                countsZero[0] -= 1      
                zeroPerms = calculatePerms(numDigits: n - 1, counts: countsZero)
            }
            
            let validPerms = totalPerms - zeroPerms
            
            guard totalGoodCount <= Int.max - validPerms else { 
                return Int.max 
            }
            totalGoodCount += validPerms
        }

        return totalGoodCount
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `n = 3`, `k = 5`  
**Output**: `27`  
**Explicação**:
- Palíndromos válidos incluem 505, 515, 525, etc.
- Total de números bons que podem ser rearranjados para esses palíndromos: 27

#### Exemplo 2:
**Input**: `n = 1`, `k = 4`  
**Output**: `2`  
**Explicação**:
- Apenas 4 e 8 são divisíveis por 4 e palíndromos de 1 dígito
- Total: 2

#### Exemplo 3:
**Input**: `n = 5`, `k = 6`  
**Output**: `2468`  
**Explicação**:
- Muitos palíndromos de 5 dígitos divisíveis por 6
- Total de números bons que podem ser rearranjados: 2468

### Conclusão

Esta solução eficiente conta números bons gerando todos os possíveis palíndromos, verificando sua divisibilidade por k, e calculando quantos números podem ser formados com os mesmos dígitos (descontando aqueles que começam com zero). A abordagem é otimizada para o intervalo dado (n ≤ 10).