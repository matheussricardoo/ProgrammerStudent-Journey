## [PT/BR]

### O Problema

Dada uma permutação baseada em zero `nums` (indexada a partir de 0), precisamos construir um novo array `ans` do mesmo tamanho onde cada elemento `ans[i] = nums[nums[i]]` para cada índice `i` válido. Uma permutação baseada em zero significa que `nums` contém números distintos de `0` até `nums.length - 1`.

### Raciocínio

1. **Solução com Espaço O(N)**:
   - Criamos um novo array `ans` do mesmo tamanho de `nums`
   - Para cada índice `i`, atribuímos `ans[i] = nums[nums[i]]`
   - Esta abordagem é direta e fácil de entender, mas utiliza espaço adicional

2. **Solução com Espaço O(1)** (Follow-up):
   - Modificamos o array original para armazenar temporariamente os novos valores
   - Usamos um truque matemático para codificar dois valores em um mesmo elemento:
     - Primeira passada: Codificamos `nums[i] + n * nums[nums[i]]` em cada posição
     - Segunda passada: Extraímos o valor codificado dividindo por `n`
   - Esta abordagem evita usar espaço adicional, mas modifica temporariamente o array de entrada

### Análise da Complexidade

- **Solução O(N) Espaço**:
  - Tempo: O(n) - Percorremos o array uma vez
  - Espaço: O(n) - Criamos um novo array do mesmo tamanho

- **Solução O(1) Espaço**:
  - Tempo: O(n) - Percorremos o array duas vezes
  - Espaço: O(1) - Modificamos o array original (em Swift, criamos uma cópia temporária)

### Solução em Código

```swift
import Foundation 

class Solution {
    // Solução com espaço O(N)
    func buildArray(_ nums: [Int]) -> [Int] {
        return nums.indices.map { i in
            nums[nums[i]]
        }
    }

    // Solução com espaço O(1) (conceitualmente)
    func buildArray_O1_Space(_ nums: [Int]) -> [Int] {
        guard !nums.isEmpty else { return [] }
        var tempNums = nums
        let n = nums.count

        // Primeira passada: Codificação
        for i in 0..<n {
            let encodedValue = tempNums[tempNums[i]] % n
            tempNums[i] += encodedValue * n
        }

        // Segunda passada: Decodificação
        for i in 0..<n {
            tempNums[i] /= n
        }

        return tempNums
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums = [0,2,1,5,3,4]`  
**Output**: `[0,1,2,4,5,3]`  
**Explicação**:
- ans[0] = nums[nums[0]] = nums[0] = 0
- ans[1] = nums[nums[1]] = nums[2] = 1
- ans[2] = nums[nums[2]] = nums[1] = 2
- ans[3] = nums[nums[3]] = nums[5] = 4
- ans[4] = nums[nums[4]] = nums[3] = 5
- ans[5] = nums[nums[5]] = nums[4] = 3

#### Exemplo 2:
**Input**: `nums = [5,0,1,2,3,4]`  
**Output**: `[4,5,0,1,2,3]`  
**Explicação**:
- ans[0] = nums[nums[0]] = nums[5] = 4
- ans[1] = nums[nums[1]] = nums[0] = 5
- ans[2] = nums[nums[2]] = nums[1] = 0
- ans[3] = nums[nums[3]] = nums[2] = 1
- ans[4] = nums[nums[4]] = nums[3] = 2
- ans[5] = nums[nums[5]] = nums[4] = 3

### Conclusão

Ambas as soluções resolvem o problema eficientemente. A primeira abordagem é mais simples e direta, enquanto a segunda atende ao desafio de usar espaço constante, demonstrando um truque inteligente de codificação/decodificação de valores. A escolha entre elas depende dos requisitos específicos de espaço na aplicação.

---

## [EN]

### The Problem

Given a zero-based permutation `nums` (0-indexed), we need to build a new array `ans` of the same length where each element `ans[i] = nums[nums[i]]` for each valid index `i`. A zero-based permutation means `nums` contains distinct integers from `0` to `nums.length - 1`.

### Reasoning

1. **O(N) Space Solution**:
   - Create a new array `ans` of same length as `nums`
   - For each index `i`, assign `ans[i] = nums[nums[i]]`
   - This approach is straightforward but uses additional space

2. **O(1) Space Solution** (Follow-up):
   - Modify the original array to temporarily store new values
   - Use a mathematical trick to encode two values in one element:
     - First pass: Encode `nums[i] + n * nums[nums[i]]` in each position
     - Second pass: Extract the encoded value by dividing by `n`
   - This approach avoids extra space but temporarily modifies input

### Complexity Analysis

- **O(N) Space Solution**:
  - Time: O(n) - Single pass through array
  - Space: O(n) - Create new array of same size

- **O(1) Space Solution**:
  - Time: O(n) - Two passes through array
  - Space: O(1) - Modifies original array (in Swift, creates temp copy)

### Code Solution

```swift
import Foundation 

class Solution {
    // O(N) Space solution
    func buildArray(_ nums: [Int]) -> [Int] {
        return nums.indices.map { i in
            nums[nums[i]]
        }
    }

    // O(1) Space solution (conceptually)
    func buildArray_O1_Space(_ nums: [Int]) -> [Int] {
        guard !nums.isEmpty else { return [] }
        var tempNums = nums
        let n = nums.count

        // First pass: Encoding
        for i in 0..<n {
            let encodedValue = tempNums[tempNums[i]] % n
            tempNums[i] += encodedValue * n
        }

        // Second pass: Decoding
        for i in 0..<n {
            tempNums[i] /= n
        }

        return tempNums
    }
}
```

### Examples

#### Example 1:
**Input**: `nums = [0,2,1,5,3,4]`  
**Output**: `[0,1,2,4,5,3]`  
**Explanation**:
- ans[0] = nums[nums[0]] = nums[0] = 0
- ans[1] = nums[nums[1]] = nums[2] = 1
- ans[2] = nums[nums[2]] = nums[1] = 2
- ans[3] = nums[nums[3]] = nums[5] = 4
- ans[4] = nums[nums[4]] = nums[3] = 5
- ans[5] = nums[nums[5]] = nums[4] = 3

#### Example 2:
**Input**: `nums = [5,0,1,2,3,4]`  
**Output**: `[4,5,0,1,2,3]`  
**Explanation**:
- ans[0] = nums[nums[0]] = nums[5] = 4
- ans[1] = nums[nums[1]] = nums[0] = 5
- ans[2] = nums[nums[2]] = nums[1] = 0
- ans[3] = nums[nums[3]] = nums[2] = 1
- ans[4] = nums[nums[4]] = nums[3] = 2
- ans[5] = nums[nums[5]] = nums[4] = 3

### Conclusion

Both solutions efficiently solve the problem. The first approach is simpler and more straightforward, while the second meets the challenge of using constant space, demonstrating an intelligent encoding/decoding trick. The choice between them depends on specific space requirements in the application.