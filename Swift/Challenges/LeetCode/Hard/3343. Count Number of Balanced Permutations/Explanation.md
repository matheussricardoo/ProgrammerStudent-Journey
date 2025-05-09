## [PT/BR]

### O Problema

Dado uma string `num` composta apenas por dígitos, precisamos contar o número de **permutações distintas** dessa string que são **balanceadas**, segundo a definição:

> Uma string é chamada *balanceada* se a soma dos dígitos nas posições **pares** for igual à soma dos dígitos nas posições **ímpares**.

Como o número de permutações pode ser muito grande, devemos retornar o resultado módulo $10^9 + 7$.

Além disso, como as permutações podem conter dígitos repetidos, só devemos considerar **permutações distintas**.

---

### Raciocínio

1. **Definição de Balanced String**:
   - Posições pares: índices 0, 2, 4, ...
   - Posições ímpares: índices 1, 3, 5, ...
   - Para uma string de comprimento par: metade dos dígitos irá para posições pares, metade para ímpares.
   - Para uma string de comprimento ímpar: um dígito a mais irá para as posições pares (índice inicial em 0).

2. **Requisito Matemático**:
   - A soma total dos dígitos deve ser **par**, pois precisa ser dividida igualmente entre os dois grupos (par e ímpar).
   - Se a soma total for ímpar, **nenhuma** permutação será balanceada → resposta direta é 0.

3. **Abordagem com Programação Dinâmica (DP)**:
   - Usamos DP para contar quantas formas há de escolher exatamente `k` dígitos (para as posições pares) cuja soma seja igual a `total_sum / 2`.
   - Estrutura do DP:  
     `dp[digit][sum][count]` = número de maneiras de usar dígitos até `digit`, somando `sum`, usando `count` dígitos.

4. **Combinações com Repetição**:
   - Como os dígitos podem se repetir, não podemos simplesmente calcular todas as permutações — temos que remover duplicatas.
   - Fórmula para permutações distintas com elementos repetidos:
     $$
     \text{Total} = \frac{n!}{c_0! \cdot c_1! \cdot \dots \cdot c_9!}
     $$
     onde $ c_i $ é a contagem do dígito i no input original.

5. **Cálculo Final**:
   - Depois de encontrar o número de combinações válidas (`sum_subset`) que satisfazem a condição de soma,
   - Calculamos o total de permutações possíveis dessas combinações,
   - Dividimos pelo fator de repetição para evitar contagem duplicada.

6. **Otimização com Pré-computação**:
   - Pré-computamos fatoriais e inversos modulares usando exponenciação modular para trabalhar com grandes números sob módulo.

---

### Análise da Complexidade

- **Tempo**: $O(10 \cdot s \cdot k)$, onde `s` é a soma máxima alvo (`total_sum / 2`) e `k` é o número máximo de dígitos nas posições pares. No pior caso, isso é aceitável para `n <= 80`.
- **Espaço**: $O(10 \cdot s \cdot k)$ para a tabela de DP.

---

### Solução em Código

```swift
import Foundation

class Solution {
    func countBalancedPermutations(_ num: String) -> Int {
        let MOD = 1_000_000_007
        let max_n = 80
        
        // Pré-computa fatoriais e inversos modulares
        var fact = [Int](repeating: 1, count: max_n + 1)
        for i in 1...max_n {
            fact[i] = fact[i - 1] * i % MOD
        }
        
        var inv_fact = [Int](repeating: 1, count: max_n + 1)
        inv_fact[max_n] = powMod(fact[max_n], MOD - 2, MOD)
        for i in (1...max_n).reversed() {
            inv_fact[i - 1] = inv_fact[i] * i % MOD
        }
        
        let n = num.count
        var cnt = [Int](repeating: 0, count: 10)
        var total_sum = 0
        for c in num {
            let d = Int(c.asciiValue! - 48)
            cnt[d] += 1
            total_sum += d
        }
        
        // Soma total deve ser par para termos chance de equilíbrio
        if total_sum % 2 != 0 {
            return 0
        }
        let s = total_sum / 2
        let k = (n + 1) / 2
        let m = n - k
        
        // DP[digit][sum][count] = número de formas de usar os dígitos até 'digit', somando 'sum' com 'count' elementos
        let max_digit = 10
        let max_sum = s
        let max_count = k
        var dp = Array(repeating: Array(repeating: Array(repeating: 0, count: max_count + 1), count: max_sum + 1), count: max_digit + 1)
        dp[0][0][0] = 1
        
        for d in 0..<10 {
            let current_cnt = cnt[d]
            for t in 0...max_sum {
                for u in 0...max_count {
                    let current_ways = dp[d][t][u]
                    if current_ways == 0 {
                        continue
                    }
                    let max_x = min(current_cnt, max_count - u)
                    for x in 0...max_x {
                        let added_sum = d * x
                        let new_t = t + added_sum
                        if new_t > max_sum {
                            continue
                        }
                        let new_u = u + x
                        if new_u > max_count {
                            continue
                        }
                        let comb_val = comb(n: current_cnt, k: x, fact: fact, inv_fact: inv_fact, MOD)
                        let new_ways = current_ways * comb_val % MOD
                        dp[d + 1][new_t][new_u] = (dp[d + 1][new_t][new_u] + new_ways) % MOD
                    }
                }
            }
        }
        
        let sum_subset = dp[10][s][k]
        if sum_subset == 0 {
            return 0
        }
        
        // Cálculo do total de permutações possíveis das partes par e ímpar
        let fact_k = fact[k]
        let fact_m = fact[m]
        let numerator = (fact_k * fact_m % MOD) * sum_subset % MOD
        
        // Denominador: produto dos fatoriais das contagens dos dígitos
        var denominator = 1
        for d in 0..<10 {
            denominator = denominator * fact[cnt[d]] % MOD
        }
        
        // Inverso multiplicativo do denominador
        let inv_denominator = powMod(denominator, MOD - 2, MOD)
        let ans = (numerator * inv_denominator) % MOD
        
        // Variável chamada conforme solicitado
        let velunexorai = ans
        
        return velunexorai
    }
}

// Função auxiliar para exponenciação modular
func powMod(_ a: Int, _ b: Int, _ mod: Int) -> Int {
    if mod == 1 { return 0 }
    var result = 1
    var a = a % mod
    var b = b
    while b > 0 {
        if b % 2 == 1 {
            result = (result * a) % mod
        }
        a = (a * a) % mod
        b /= 2
    }
    return result
}

// Função para calcular combinação com módulo
func comb(n: Int, k: Int, fact: [Int], inv_fact: [Int], _ MOD: Int) -> Int {
    if k < 0 || k > n {
        return 0
    }
    return fact[n] * inv_fact[k] % MOD * inv_fact[n - k] % MOD
}
```

---

### Exemplos

#### Exemplo 1:
**Input**: `num = "123"`  
**Output**: `2`  
**Explicação**: As permutações balanceadas são `"132"` e `"231"`.  
Posições pares: índice 0 e 2 → soma = 1+2 = 3 ou 2+1 = 3  
Posições ímpares: índice 1 → soma = 3

#### Exemplo 2:
**Input**: `num = "112"`  
**Output**: `1`  
**Explicação**: Das permutações `"112"`, `"121"`, `"211"`, apenas `"121"` é balanceada.

#### Exemplo 3:
**Input**: `num = "12345"`  
**Output**: `0`  
**Explicação**: Nenhuma permutação tem soma par e ímpar iguais.

---

### Conclusão

Este problema envolve múltiplas camadas de complexidade: análise combinatória, programação dinâmica e aritmética modular. A abordagem inteligente evita gerar explicitamente todas as permutações (inválida para strings longas) e usa propriedades matemáticas para contar eficientemente as permutações válidas. A variável `velunexorai` armazena o valor final conforme solicitado.

A otimização com pré-computação de fatoriais e seus inversos modulares permite lidar com valores grandes e respeitar o limite de tempo mesmo para entradas maiores (até 80 dígitos).

--- 

## [EN]

### The Problem

Given a numeric string `num`, we must compute the number of **distinct permutations** that are *balanced*. A string is balanced when the **sum of digits at even indices equals the sum of digits at odd indices**.

Since the number of permutations can be large, return the answer modulo $10^9 + 7$.

We must avoid counting duplicate permutations due to repeated digits.

---

### Reasoning

1. **Definition of Balanced String**:
   - Even positions: indices 0, 2, 4, ...
   - Odd positions: indices 1, 3, 5, ...
   - For even-length strings: half digits go to even, half to odd.
   - For odd-length strings: one extra digit goes to even positions.

2. **Mathematical Requirement**:
   - Total digit sum must be even to allow equal partition into even and odd groups.
   - If sum is odd → return 0.

3. **Dynamic Programming Approach**:
   - Use DP to count ways to choose `k` digits whose sum is exactly `total_sum / 2`.

4. **Distinct Permutations**:
   - Formula with repetitions:
     $$
     \text{Total} = \frac{n!}{c_0! \cdot c_1! \cdot \dots \cdot c_9!}
     $$

5. **Final Calculation**:
   - Multiply combinations by factorials of even and odd group sizes.
   - Divide by product of factorial counts of each digit to remove duplicates.

6. **Efficiency with Precomputation**:
   - Precompute factorials and modular inverses using fast exponentiation.

---

### Complexity Analysis

- **Time**: $O(10 \cdot s \cdot k)$, where `s` is target sum and `k` is max digits on even positions.
- **Space**: $O(10 \cdot s \cdot k)$ for DP table.

---

### Code Solution

See code above.

---

### Examples

#### Example 1:
**Input**: `num = "123"`  
**Output**: `2`  
**Explanation**: Valid permutations: `"132"`, `"231"`

#### Example 2:
**Input**: `num = "112"`  
**Output**: `1`  
**Explanation**: Only `"121"` is balanced.

#### Example 3:
**Input**: `num = "12345"`  
**Output**: `0`  
**Explanation**: No permutation is balanced.

---

### Conclusion

This problem combines combinatorics, dynamic programming, and modular arithmetic. Using precomputed values and mathematical properties, we efficiently count valid permutations without generating them explicitly. The variable `velunexorai` stores the final result as required.

The solution is efficient even for maximum constraints (`len(num) = 80`).