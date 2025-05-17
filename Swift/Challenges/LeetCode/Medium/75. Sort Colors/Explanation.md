## [PT/BR]

### O Problema

Você recebe um array `nums` contendo inteiros que representam cores:

- `0` → Vermelho  
- `1` → Branco  
- `2` → Azul  

O objetivo é **ordenar o array in-place**, de forma que os elementos fiquem agrupados por cor, na ordem vermelho, branco e azul.

Além disso, **você não pode usar funções de ordenação da biblioteca padrão**.

---

### Raciocínio

1. **Objetivo**:
   - Reorganizar o array para ficar na ordem: todos os `0`s primeiro, depois os `1`s, e então os `2`s.
   - A solução deve ser **in-place** (sem usar memória extra além de algumas variáveis).
   - Idealmente, resolver com **um único passo** pelo array (`one-pass`) e **espaço constante**.

2. **Estratégia – Algoritmo Dutch National Flag (de Edsger Dijkstra)**:
   - Usamos três ponteiros:
     - `low`: aponta para o final da região de 0s
     - `mid`: usado para percorrer o array
     - `high`: aponta para o início da região de 2s
   - À medida que movemos `mid`, fazemos as seguintes operações:
     - Se `nums[mid] == 0`: trocamos com `nums[low]`, incrementando ambos
     - Se `nums[mid] == 1`: apenas avançamos `mid`
     - Se `nums[mid] == 2`: trocamos com `nums[high]`, decrementamos `high`

3. **Por que isso funciona?**
   - Mantemos invariantes claras:
     - Tudo antes de `low` é `0`
     - Tudo entre `low` e `mid` é `1`
     - Tudo após `high` é `2`

4. **Vantagens**:
   - Tempo: $O(n)$ — Um único passo pelo array
   - Espaço: $O(1)$ — Sem alocação adicional

---

### Análise da Complexidade

- **Tempo**: $O(n)$ — Percorre o array uma única vez
- **Espaço**: $O(1)$ — Usa poucas variáveis auxiliares

---

### Solução em Código (comentários em português)

```swift
class Solution {
    func sortColors(_ nums: inout [Int]) {
        var low = 0
        var mid = 0
        var high = nums.count - 1

        // Enquanto mid não ultrapassar high
        while mid <= high {
            switch nums[mid] {
            case 0:
                // Troca com low e move low e mid
                nums.swapAt(low, mid)
                low += 1
                mid += 1
            case 1:
                // Apenas move mid
                mid += 1
            case 2:
                // Troca com high e reduz high
                nums.swapAt(mid, high)
                high -= 1
            default:
                break
            }
        }
    }
}
```

---

### Exemplos

#### Exemplo 1:
**Input**: `nums = [2,0,2,1,1,0]`  
**Output**: `[0,0,1,1,2,2]`

#### Exemplo 2:
**Input**: `nums = [2,0,1]`  
**Output**: `[0,1,2]`

---

### Conclusão

Este problema ilustra bem um caso clássico onde um algoritmo inteligente (**Dutch National Flag**) resolve o problema com eficiência.

A abordagem de três ponteiros permite ordenar os elementos em **um único passo**, mantendo a complexidade mínima tanto no tempo quanto no espaço.

---

## [EN]

### The Problem

You are given an array `nums` with `n` elements representing colors:

- `0` → Red  
- `1` → White  
- `2` → Blue  

You must sort the array in-place such that colors appear in order: red, white, then blue.

You **must not use built-in sorting functions**.

---

### Reasoning

1. **Goal**:
   - Sort the array so all `0`s come first, followed by `1`s, and then `2`s
   - Use constant space and one pass through the array

2. **Strategy – Dutch National Flag Algorithm**:
   - Use three pointers:
     - `low`: everything before it is `0`
     - `mid`: current element being inspected
     - `high`: everything after it is `2`
   - As we iterate:
     - If `nums[mid] == 0`: swap with `low`, increment both
     - If `nums[mid] == 1`: just move `mid`
     - If `nums[mid] == 2`: swap with `high`, decrement `high`

3. **Why it works**:
   - Maintains clear invariants:
     - All elements before `low` are `0`
     - Elements between `low` and `mid` are `1`
     - All elements after `high` are `2`

4. **Advantages**:
   - Time: $O(n)$ — Single pass
   - Space: $O(1)$ — Constant space

---

### Complexity Analysis

- **Time**: $O(n)$ — One pass through the array
- **Space**: $O(1)$ — Few variables used only

---

### Code Solution (comments in English)

```swift
class Solution {
    func sortColors(_ nums: inout [Int]) {
        var low = 0
        var mid = 0
        var high = nums.count - 1

        while mid <= high {
            switch nums[mid] {
            case 0:
                nums.swapAt(low, mid)
                low += 1
                mid += 1
            case 1:
                mid += 1
            case 2:
                nums.swapAt(mid, high)
                high -= 1
            default:
                break
            }
        }
    }
}
```

---

### Examples

#### Example 1:
**Input**: `nums = [2,0,2,1,1,0]`  
**Output**: `[0,0,1,1,2,2]`

#### Example 2:
**Input**: `nums = [2,0,1]`  
**Output**: `[0,1,2]`

---

### Conclusion

This problem demonstrates an elegant use of the **Dutch National Flag algorithm**, which allows us to sort the array in linear time and constant space. It’s a great example of how clever pointer manipulation can solve what might otherwise seem like a simple but constrained sorting problem.