## [PT/BR]

### O Problema

Dados dois arrays `nums1` e `nums2` de comprimento `n`, ambos permutações de `[0, 1, ..., n-1]`, precisamos contar o número de "triplets bons". Um triplet `(x, y, z)` é considerado bom se:
1. As posições de `x`, `y`, `z` em `nums1` estão em ordem crescente (`pos1x < pos1y < pos1z`)
2. As posições de `x`, `y`, `z` em `nums2` também estão em ordem crescente (`pos2x < pos2y < pos2z`)

### Raciocínio

1. **Mapeamento de Posições**:
   - Criamos um dicionário para armazenar a posição de cada elemento em `nums2`
   - Transformamos `nums1` em um array onde cada elemento é sua posição em `nums2`

2. **Contagem Eficiente**:
   - Usamos uma lista ordenada para acompanhar elementos processados
   - Para cada elemento `y` no array transformado:
     - Calculamos quantos elementos menores que `y` já foram processados (`left`)
     - Calculamos quantos elementos maiores que `y` estão à frente (`right`)
     - O número de triplets bons com `y` como elemento do meio é `left * right`

3. **Otimização**:
   - Utilizamos busca binária para manter a lista ordenada
   - Isso reduz a complexidade de O(n³) para O(n log n)

### Análise da Complexidade

- **Tempo**: O(n log n) - Para cada elemento, realizamos operações de busca e inserção em O(log n)
- **Espaço**: O(n) - Armazenamos posições e mantemos uma lista ordenada

### Solução em Código

```swift
class Solution {
    func goodTriplets(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let n = nums1.count
        var posInNums2 = [Int](repeating: 0, count: n)
        for (i, num) in nums2.enumerated() {
            posInNums2[num] = i
        }
        
        var nums = [Int]()
        for num in nums1 {
            nums.append(posInNums2[num])
        }
        
        var res = 0
        var sorted = [Int]()
        
        for (i, num) in nums.enumerated() {
            let left = bisectLeft(sorted, num)
            let right = nums.count - 1 - i - (num - left)
            res += left * right
            insert(&sorted, num)
        }
        
        return res
    }
    
    private func bisectLeft(_ arr: [Int], _ target: Int) -> Int {
        var left = 0
        var right = arr.count
        while left < right {
            let mid = left + (right - left) / 2
            if arr[mid] < target {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return left
    }
    
    private func insert(_ arr: inout [Int], _ num: Int) {
        let pos = bisectLeft(arr, num)
        arr.insert(num, at: pos)
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `nums1 = [2,0,1,3]`, `nums2 = [0,1,2,3]`  
**Output**: `1`  
**Explicação**:
- Mapeamento em nums2: {0:0, 1:1, 2:2, 3:3}
- Array transformado: [2,0,1,3] (posições em nums2)
- Triplet válido: (0,1,3) com posições 1 < 2 < 3 em ambos arrays

#### Exemplo 2:
**Input**: `nums1 = [4,0,1,3,2]`, `nums2 = [4,1,0,2,3]`  
**Output**: `4`  
**Explicação**:
- Mapeamento em nums2: {4:0, 1:1, 0:2, 2:3, 3:4}
- Array transformado: [0,2,1,4,3]
- Triplets válidos: (4,0,3), (4,0,2), (4,1,3), (4,1,2)

### Conclusão

Esta solução inteligente aproveita propriedades de ordenação e busca binária para contar triplets bons de forma eficiente, sendo capaz de lidar com os limites superiores de tamanho de entrada (n ≤ 10^5).

---

## [EN]

### The Problem

Given two 0-indexed arrays `nums1` and `nums2` of length `n`, both permutations of `[0, 1, ..., n-1]`, we need to count the number of "good triplets". A triplet `(x, y, z)` is good if:
1. The positions of `x`, `y`, `z` in `nums1` are in increasing order (`pos1x < pos1y < pos1z`)
2. The positions of `x`, `y`, `z` in `nums2` are also in increasing order (`pos2x < pos2y < pos2z`)

### Reasoning

1. **Position Mapping**:
   - Create a dictionary to store each element's position in `nums2`
   - Transform `nums1` into an array where each element is its position in `nums2`

2. **Efficient Counting**:
   - Use a sorted list to track processed elements
   - For each element `y` in the transformed array:
     - Count how many smaller elements were processed (`left`)
     - Count how many larger elements remain (`right`)
     - The number of good triplets with `y` as middle is `left * right`

3. **Optimization**:
   - Use binary search to maintain sorted order
   - Reduces complexity from O(n³) to O(n log n)

### Complexity Analysis

- **Time**: O(n log n) - For each element, perform O(log n) search/insert operations
- **Space**: O(n) - Store positions and maintain sorted list

### Code Solution

```swift
class Solution {
    func goodTriplets(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let n = nums1.count
        var posInNums2 = [Int](repeating: 0, count: n)
        for (i, num) in nums2.enumerated() {
            posInNums2[num] = i
        }
        
        var nums = [Int]()
        for num in nums1 {
            nums.append(posInNums2[num])
        }
        
        var res = 0
        var sorted = [Int]()
        
        for (i, num) in nums.enumerated() {
            let left = bisectLeft(sorted, num)
            let right = nums.count - 1 - i - (num - left)
            res += left * right
            insert(&sorted, num)
        }
        
        return res
    }
    
    private func bisectLeft(_ arr: [Int], _ target: Int) -> Int {
        var left = 0
        var right = arr.count
        while left < right {
            let mid = left + (right - left) / 2
            if arr[mid] < target {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return left
    }
    
    private func insert(_ arr: inout [Int], _ num: Int) {
        let pos = bisectLeft(arr, num)
        arr.insert(num, at: pos)
    }
}
```

### Examples

#### Example 1:
**Input**: `nums1 = [2,0,1,3]`, `nums2 = [0,1,2,3]`  
**Output**: `1`  
**Explanation**:
- nums2 mapping: {0:0, 1:1, 2:2, 3:3}
- Transformed array: [2,0,1,3]
- Valid triplet: (0,1,3) with positions 1 < 2 < 3 in both arrays

#### Example 2:
**Input**: `nums1 = [4,0,1,3,2]`, `nums2 = [4,1,0,2,3]`  
**Output**: `4`  
**Explanation**:
- nums2 mapping: {4:0, 1:1, 0:2, 2:3, 3:4}
- Transformed array: [0,2,1,4,3]
- Valid triplets: (4,0,3), (4,0,2), (4,1,3), (4,1,2)

### Conclusion

This clever solution leverages sorting properties and binary search to efficiently count good triplets, capable of handling upper input size limits (n ≤ 10^5).