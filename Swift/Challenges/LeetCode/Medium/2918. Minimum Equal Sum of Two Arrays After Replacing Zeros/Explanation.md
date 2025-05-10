## [PT/BR]

### O Problema

Dado dois arrays `nums1` e `nums2` contendo inteiros positivos e possivelmente zeros, precisamos substituir todos os zeros por **números positivos (≥ 1)** de forma que as somas dos dois arrays sejam **iguais**.

O objetivo é retornar a **menor soma possível** para a qual isso pode acontecer. Se for **impossível**, devemos retornar `-1`.

---

### Raciocínio

1. **Entendendo o Problema**:
   - Cada zero nos arrays pode ser substituído por qualquer número ≥ 1.
   - A soma final dos dois arrays deve ser igual.
   - Devemos minimizar essa soma comum.

2. **Estratégia Geral**:
   - Para cada array, calculamos:
     - A soma atual dos elementos não-zero.
     - Quantos zeros existem (pois cada um contribui no mínimo com 1).
   - A soma mínima possível para cada array é:  
     `soma_atual + quantidade_de_zeros`

3. **Casos Especiais**:
   - Se **ambos os arrays não têm zeros**, só podemos ter soma igual se as somas atuais forem iguais.
   - Se **apenas um array tem zeros**, ele deve poder alcançar a soma do outro array após substituição dos zeros (lembrando que cada zero vale pelo menos 1).
   - Se **ambos têm zeros**, sempre conseguimos ajustar os valores para que as somas sejam iguais → resposta será o **máximo entre as somas mínimas possíveis**.

4. **Impossibilidade**:
   - Quando um array sem zeros tem soma menor que a soma mínima do outro array, é **impossível** igualar as somas.

---

### Análise da Complexidade

- **Tempo**: $O(n + m)$ — Percorremos os dois arrays uma única vez.
- **Espaço**: $O(1)$ — Usamos apenas algumas variáveis auxiliares.

---

### Solução em Código 

```swift
class Solution {
    func minSum(_ nums1: [Int], _ nums2: [Int]) -> Int {
        // Variáveis para armazenar a soma atual e quantidade de zeros em cada array
        var sum1 = 0, zeros1 = 0
        for num in nums1 {
            if num == 0 {
                zeros1 += 1
            } else {
                sum1 += num
            }
        }

        var sum2 = 0, zeros2 = 0
        for num in nums2 {
            if num == 0 {
                zeros2 += 1
            } else {
                sum2 += num
            }
        }

        // Caso 1: nenhum array tem zeros
        if zeros1 == 0 && zeros2 == 0 {
            return sum1 == sum2 ? sum1 : -1
        }
        
        // Caso 2: nums1 não tem zeros, mas nums2 tem
        else if zeros1 == 0 {
            // Soma mínima de nums2: sum2 + zeros2
            // nums1 tem soma fixa, precisa ser >= soma mínima de nums2
            return sum1 >= sum2 + zeros2 ? sum1 : -1
        }
        
        // Caso 3: nums2 não tem zeros, mas nums1 tem
        else if zeros2 == 0 {
            return sum2 >= sum1 + zeros1 ? sum2 : -1
        }
        
        // Caso 4: ambos os arrays têm zeros
        else {
            // Podemos ajustar os zeros para igualar as somas
            // Resposta é o máximo entre as somas mínimas possíveis
            return max(sum1 + zeros1, sum2 + zeros2)
        }
    }
}
```

---

### Exemplos

#### Exemplo 1:
**Input**: `nums1 = [3,2,0,1,0]`, `nums2 = [6,5,0]`  
**Output**: `12`  
**Explicação**:
- Substituímos os zeros por valores mínimos (1 ou mais), obtendo:
  - `nums1 = [3,2,2,1,4]` → soma = 12
  - `nums2 = [6,5,1]` → soma = 12

#### Exemplo 2:
**Input**: `nums1 = [2,0,2,0]`, `nums2 = [1,4]`  
**Output**: `-1`  
**Explicação**:
- `sum1 = 4`, `zeros1 = 2` → soma mínima = 6
- `sum2 = 5`, `zeros2 = 0` → soma fixa = 5
- Impossível igualar → retorna `-1`

---

### Conclusão

Este problema é baseado em lógica simples e análise de casos. Com uma abordagem linear, conseguimos resolver eficientemente mesmo para entradas grandes. A chave é entender como os zeros influenciam a soma mínima possível e verificar se a igualdade é viável com base nas restrições.

---

## [EN]

### The Problem

Given two arrays `nums1` and `nums2` consisting of positive integers and possibly zeros, we must replace all the zeros with **positive integers (≥ 1)** such that the **sums of both arrays become equal**.

We are to return the **minimum possible equal sum**, or `-1` if it is not achievable.

---

### Reasoning

1. **Understanding the Problem**:
   - Each zero can be replaced by any number ≥ 1.
   - We aim to make the total sums of both arrays equal using the smallest possible value.

2. **General Strategy**:
   - Compute:
     - Current non-zero sum of each array (`sum1`, `sum2`)
     - Number of zeros in each array (`zeros1`, `zeros2`)
   - Minimum sum possible after replacement:
     - `sum1 + zeros1`
     - `sum2 + zeros2`

3. **Special Cases**:
   - If **no array has zeros**, they must already have equal sums.
   - If one array has no zeros but the other does:
     - The fixed-sum array must be reachable by the other through minimal replacements.

4. **Minimum Equal Sum Calculation**:
   - When both arrays have zeros, we can always adjust their values to balance the sums.
   - Return the **maximum** of the minimum possible sums.

5. **Impossible Case**:
   - If one array’s sum is less than the other’s plus its minimum zero contribution, it's impossible to balance.

---

### Complexity Analysis

- **Time**: $O(n + m)$ — Linear pass over both arrays.
- **Space**: $O(1)$ — Constant extra space used.

---

### Code Solution 

```swift
class Solution {
    func minSum(_ nums1: [Int], _ nums2: [Int]) -> Int {
        // Track sum and zero count for nums1
        var sum1 = 0, zeros1 = 0
        for num in nums1 {
            if num == 0 {
                zeros1 += 1
            } else {
                sum1 += num
            }
        }

        // Track sum and zero count for nums2
        var sum2 = 0, zeros2 = 0
        for num in nums2 {
            if num == 0 {
                zeros2 += 1
            } else {
                sum2 += num
            }
        }

        // Case 1: No zeros in either array
        if zeros1 == 0 && zeros2 == 0 {
            return sum1 == sum2 ? sum1 : -1
        }
        
        // Case 2: nums1 has no zeros, but nums2 does
        else if zeros1 == 0 {
            return sum1 >= sum2 + zeros2 ? sum1 : -1
        }
        
        // Case 3: nums2 has no zeros, but nums1 does
        else if zeros2 == 0 {
            return sum2 >= sum1 + zeros1 ? sum2 : -1
        }
        
        // Case 4: Both arrays have zeros
        else {
            return max(sum1 + zeros1, sum2 + zeros2)
        }
    }
}
```

---

### Examples

#### Example 1:
**Input**: `nums1 = [3,2,0,1,0]`, `nums2 = [6,5,0]`  
**Output**: `12`  
**Explanation**:
- Replace zeros with values ≥ 1:
  - `nums1 = [3,2,2,1,4]` → sum = 12
  - `nums2 = [6,5,1]` → sum = 12

#### Example 2:
**Input**: `nums1 = [2,0,2,0]`, `nums2 = [1,4]`  
**Output**: `-1`  
**Explanation**:
- `sum1 = 4`, `zeros1 = 2` → min sum = 6
- `sum2 = 5`, `zeros2 = 0` → fixed sum = 5
- Not equalable → return `-1`

---

### Conclusion

This problem involves careful condition checking and basic math. With a linear-time approach, we efficiently determine whether balancing is possible and find the minimal equal sum. The solution handles large inputs well and avoids unnecessary computation.
