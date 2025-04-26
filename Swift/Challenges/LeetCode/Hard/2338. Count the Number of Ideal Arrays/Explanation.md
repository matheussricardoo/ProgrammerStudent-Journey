## [PT/BR]

### O Problema

Dados dois inteiros `n` e `maxValue`, que descrevem um array ideal, precisamos contar quantos arrays distintos de tamanho `n` são considerados ideais. Um array é ideal se:
1. Todos elementos estão entre 1 e `maxValue`
2. Cada elemento `arr[i]` é divisível pelo elemento anterior `arr[i-1]`

### Raciocínio

1. **Pré-processamento**:
   - Usamos o crivo de Eratóstenes para fatoração rápida
   - Pré-computamos combinações usando programação dinâmica

2. **Contagem de Arrays**:
   - Para cada valor `x` de 1 a `maxValue`:
     - Fatoramos `x` em seus primos
     - Calculamos as combinações possíveis para cada expoente primo
     - Multiplicamos as combinações para obter o total de arrays começando com `x`

3. **Otimização**:
   - Usamos matemática combinatória para evitar gerar todos arrays
   - Aplicamos módulo 10^9+7 para lidar com números grandes

### Análise da Complexidade

- **Tempo**: O(maxValue log maxValue + n) - Para pré-processamento e contagem
- **Espaço**: O(maxValue) - Para armazenar fatores primos e combinações

### Solução em Código

```swift
import Foundation

let MOD = Int(1e9 + 7)
let MAX_N = 10010  
let MAX_P = 15     

var sieve = [Int](repeating: 0, count: MAX_N)

for i in 2..<MAX_N {
    if sieve[i] == 0 {
        for j in stride(from: i, to: MAX_N, by: i) {
            sieve[j] = i
        }
    }
}

var ps = [[Int]](repeating: [], count: MAX_N)
for i in 2..<MAX_N {
    var x = i
    while x > 1 {
        let p = sieve[x]
        var count = 0
        while x % p == 0 {
            x /= p
            count += 1
        }
        ps[i].append(count)
    }
}

var c = [[Int]](
    repeating: [Int](repeating: 0, count: MAX_P + 1),
    count: MAX_N + MAX_P
)

c[0][0] = 1
for i in 1..<MAX_N + MAX_P {
    c[i][0] = 1
    for j in 1...min(i, MAX_P) {
        c[i][j] = (c[i - 1][j] + c[i - 1][j - 1]) % MOD
    }
}

class Solution {
    func idealArrays(_ n: Int, _ maxValue: Int) -> Int {
        var ans = 0
        for x in 1...maxValue {
            var mul = 1
            for p in ps[x] {
                mul = mul * c[n + p - 1][p] % MOD
            }
            ans = (ans + mul) % MOD
        }
        return ans
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `n = 2`, `maxValue = 5`  
**Output**: `10`  
**Explicação**:
- Arrays começando com 1: 5 possibilidades
- Arrays começando com 2: 2 possibilidades
- Arrays começando com 3,4,5: 1 possibilidade cada
- Total: 5 + 2 + 1 + 1 + 1 = 10

#### Exemplo 2:
**Input**: `n = 5`, `maxValue = 3`  
**Output**: `11`  
**Explicação**:
- Arrays começando com 1: 9 possibilidades
- Arrays começando com 2,3: 1 possibilidade cada
- Total: 9 + 1 + 1 = 11

### Conclusão

Esta solução eficiente usa fatoração prima e combinatória para contar arrays ideais sem gerá-los explicitamente, sendo ideal para os limites do problema.

---

## [EN]

### The Problem

Given two integers `n` and `maxValue` describing an ideal array, we need to count how many distinct arrays of size `n` are considered ideal. An array is ideal if:
1. All elements are between 1 and `maxValue`
2. Each element `arr[i]` is divisible by the previous element `arr[i-1]`

### Reasoning

1. **Preprocessing**:
   - Use Sieve of Eratosthenes for fast factorization
   - Precompute combinations using dynamic programming

2. **Array Counting**:
   - For each value `x` from 1 to `maxValue`:
     - Factorize `x` into primes
     - Calculate possible combinations for each prime exponent
     - Multiply combinations to get total arrays starting with `x`

3. **Optimization**:
   - Use combinatorics to avoid generating all arrays
   - Apply modulo 10^9+7 for large numbers

### Complexity Analysis

- **Time**: O(maxValue log maxValue + n) - For preprocessing and counting
- **Space**: O(maxValue) - To store prime factors and combinations

### Code Solution

```swift
import Foundation

let MOD = Int(1e9 + 7)
let MAX_N = 10010  
let MAX_P = 15     

var sieve = [Int](repeating: 0, count: MAX_N)

for i in 2..<MAX_N {
    if sieve[i] == 0 {
        for j in stride(from: i, to: MAX_N, by: i) {
            sieve[j] = i
        }
    }
}

var ps = [[Int]](repeating: [], count: MAX_N)
for i in 2..<MAX_N {
    var x = i
    while x > 1 {
        let p = sieve[x]
        var count = 0
        while x % p == 0 {
            x /= p
            count += 1
        }
        ps[i].append(count)
    }
}

var c = [[Int]](
    repeating: [Int](repeating: 0, count: MAX_P + 1),
    count: MAX_N + MAX_P
)

c[0][0] = 1
for i in 1..<MAX_N + MAX_P {
    c[i][0] = 1
    for j in 1...min(i, MAX_P) {
        c[i][j] = (c[i - 1][j] + c[i - 1][j - 1]) % MOD
    }
}

class Solution {
    func idealArrays(_ n: Int, _ maxValue: Int) -> Int {
        var ans = 0
        for x in 1...maxValue {
            var mul = 1
            for p in ps[x] {
                mul = mul * c[n + p - 1][p] % MOD
            }
            ans = (ans + mul) % MOD
        }
        return ans
    }
}
```

### Examples

#### Example 1:
**Input**: `n = 2`, `maxValue = 5`  
**Output**: `10`  
**Explanation**:
- Arrays starting with 1: 5 possibilities
- Arrays starting with 2: 2 possibilities
- Arrays starting with 3,4,5: 1 possibility each
- Total: 5 + 2 + 1 + 1 + 1 = 10

#### Example 2:
**Input**: `n = 5`, `maxValue = 3`  
**Output**: `11`  
**Explanation**:
- Arrays starting with 1: 9 possibilities
- Arrays starting with 2,3: 1 possibility each
- Total: 9 + 1 + 1 = 11

### Conclusion

This efficient solution uses prime factorization and combinatorics to count ideal arrays without explicitly generating them, making it ideal for the problem constraints.