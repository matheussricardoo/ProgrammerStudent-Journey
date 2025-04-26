## [PT/BR]

### O Problema

Dado um array de inteiros `arr` e três inteiros `a`, `b` e `c`, precisamos encontrar o número de "triplets bons". Um triplet `(arr[i], arr[j], arr[k])` é considerado bom se as seguintes condições forem verdadeiras:

1. `0 <= i < j < k < arr.length`
2. `|arr[i] - arr[j]| <= a`
3. `|arr[j] - arr[k]| <= b`
4. `|arr[i] - arr[k]| <= c`

Onde `|x|` denota o valor absoluto de `x`.

### Raciocínio

1. **Entendendo Triplets Bons**:
   - Um triplet é uma combinação de três elementos do array em ordem crescente de índices (`i < j < k`)
   - Precisamos verificar três condições de diferença absoluta entre os elementos do triplet
   - O desafio é contar todos os triplets que satisfazem todas as condições simultaneamente

2. **Abordagem Direta**:
   - A solução mais direta é verificar todos os triplets possíveis no array
   - Para cada triplet válido (`i < j < k`), verificamos as três condições
   - Se todas forem satisfeitas, incrementamos o contador

3. **Otimizações**:
   - Podemos parar antecipadamente a verificação se alguma condição não for satisfeita
   - Por exemplo, se `|arr[i] - arr[j]| > a`, não precisamos verificar os valores de `k`

### Análise da Complexidade

- **Tempo**: O(n³) - No pior caso, verificamos todos os triplets possíveis (n escolhe 3)
- **Espaço**: O(1) - Usamos apenas um contador e algumas variáveis temporárias

### Solução em Código

```swift
class Solution {
    func countGoodTriplets(_ arr: [Int], _ a: Int, _ b: Int, _ c: Int) -> Int {
        var count = 0
        let n = arr.count

        for i in 0..<(n - 2) { 
            let val_i = arr[i] 
            for j in (i + 1)..<(n - 1) { 
                let val_j = arr[j]
                if abs(val_i - val_j) <= a {
                    for k in (j + 1)..<n { 
                        let val_k = arr[k]
                        if abs(val_j - val_k) <= b && abs(val_i - val_k) <= c {
                            count += 1
                        }
                    }
                }
            }
        }

        return count
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `arr = [3,0,1,1,9,7]`, `a = 7`, `b = 2`, `c = 3`  
**Output**: `4`  
**Explicação**:
- Os triplets bons são:
  1. (3, 0, 1): |3-0|=3≤7, |0-1|=1≤2, |3-1|=2≤3
  2. (3, 0, 1) [o segundo 1]
  3. (3, 1, 1)
  4. (0, 1, 1)

#### Exemplo 2:
**Input**: `arr = [1,1,2,2,3]`, `a = 0`, `b = 0`, `c = 1`  
**Output**: `0`  
**Explicação**:
- Nenhum triplet satisfaz todas as condições simultaneamente:
  - Para ter |arr[i]-arr[j]|≤0, precisamos arr[i]==arr[j]
  - Para ter |arr[j]-arr[k]|≤0, precisamos arr[j]==arr[k]
  - Mas então |arr[i]-arr[k]|=0≤1, porém não existem três elementos iguais consecutivos no array

### Conclusão

Esta solução utiliza uma abordagem direta de força bruta para verificar todos os triplets possíveis. Embora a complexidade seja cúbica, é aceitável dado o tamanho máximo do array (100 elementos), resultando em no máximo cerca de 160.000 operações.

---

## [EN]

### The Problem

Given an array of integers `arr` and three integers `a`, `b`, and `c`, we need to find the number of "good triplets". A triplet `(arr[i], arr[j], arr[k])` is considered good if the following conditions are true:

1. `0 <= i < j < k < arr.length`
2. `|arr[i] - arr[j]| <= a`
3. `|arr[j] - arr[k]| <= b`
4. `|arr[i] - arr[k]| <= c`

Where `|x|` denotes the absolute value of `x`.

### Reasoning

1. **Understanding Good Triplets**:
   - A triplet is a combination of three array elements in increasing index order (`i < j < k`)
   - We need to check three absolute difference conditions between the triplet elements
   - The challenge is to count all triplets that satisfy all conditions simultaneously

2. **Direct Approach**:
   - The most straightforward solution is to check all possible triplets in the array
   - For each valid triplet (`i < j < k`), we check the three conditions
   - If all are satisfied, we increment the counter

3. **Optimizations**:
   - We can early-stop the verification if any condition fails
   - For example, if `|arr[i] - arr[j]| > a`, we don't need to check `k` values

### Complexity Analysis

- **Time**: O(n³) - In the worst case, we check all possible triplets (n choose 3)
- **Space**: O(1) - We use only a counter and some temporary variables

### Code Solution

```swift
class Solution {
    func countGoodTriplets(_ arr: [Int], _ a: Int, _ b: Int, _ c: Int) -> Int {
        var count = 0
        let n = arr.count

        for i in 0..<(n - 2) { 
            let val_i = arr[i] 
            for j in (i + 1)..<(n - 1) { 
                let val_j = arr[j]
                if abs(val_i - val_j) <= a {
                    for k in (j + 1)..<n { 
                        let val_k = arr[k]
                        if abs(val_j - val_k) <= b && abs(val_i - val_k) <= c {
                            count += 1
                        }
                    }
                }
            }
        }

        return count
    }
}
```

### Examples

#### Example 1:
**Input**: `arr = [3,0,1,1,9,7]`, `a = 7`, `b = 2`, `c = 3`  
**Output**: `4`  
**Explanation**:
- The good triplets are:
  1. (3, 0, 1): |3-0|=3≤7, |0-1|=1≤2, |3-1|=2≤3
  2. (3, 0, 1) [the second 1]
  3. (3, 1, 1)
  4. (0, 1, 1)

#### Example 2:
**Input**: `arr = [1,1,2,2,3]`, `a = 0`, `b = 0`, `c = 1`  
**Output**: `0`  
**Explanation**:
- No triplet satisfies all conditions simultaneously:
  - To have |arr[i]-arr[j]|≤0, we need arr[i]==arr[j]
  - To have |arr[j]-arr[k]|≤0, we need arr[j]==arr[k]
  - But then |arr[i]-arr[k]|=0≤1, however there are no three consecutive equal elements in the array

### Conclusion

This solution uses a straightforward brute-force approach to check all possible triplets. While the complexity is cubic, it's acceptable given the maximum array size (100 elements), resulting in at most about 160,000 operations.