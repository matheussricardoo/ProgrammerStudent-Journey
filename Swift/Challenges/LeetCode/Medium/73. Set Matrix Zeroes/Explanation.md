## [PT/BR]

### O Problema

Você recebe uma matriz `m x n` de números inteiros.

Se um elemento for `0`, você deve definir toda a sua linha e coluna como `0`.

A solução deve ser feita **in-place**, ou seja, sem usar memória adicional além de poucas variáveis.

---

### Raciocínio

1. **Objetivo**:
   - Para cada zero na matriz, zerar toda a linha e coluna correspondentes
   - Fazer isso **sem usar estruturas extras para marcar as linhas e colunas a zerar**

2. **Estratégia – Usar primeira linha e primeira coluna como marcadores**:
   - Percorremos a matriz e, se encontrarmos `matrix[i][j] == 0`, marcamos:
     - `matrix[i][0] = 0` → indica que essa linha inteira deve ser zerada
     - `matrix[0][j] = 0` → indica que essa coluna inteira deve ser zerada
   - Tratamos a **primeira linha e coluna separadamente**, pois elas são usadas como marcadores

3. **Passos principais**:
   - Verificar se a **primeira linha ou coluna contém zeros**
   - Marcar quaisquer outras linhas e colunas que devem ser zeradas usando a primeira linha/coluna
   - Zerar todas as células nas linhas e colunas marcadas
   - Finalmente, zerar a primeira linha e coluna se necessário

4. **Vantagens da abordagem**:
   - Usa **espaço constante (O(1))**
   - Complexidade total: $O(m \cdot n)$ — percorre a matriz algumas vezes

---

### Análise da Complexidade

- **Tempo**: $O(m \cdot n)$ — Percorre a matriz várias vezes, mas linearmente
- **Espaço**: $O(1)$ — Não usa memória extra além de algumas variáveis

---

### Solução em Código (comentários em português)

```swift
class Solution {
    func setZeroes(_ matrix: inout [[Int]]) {
        let m = matrix.count
        let n = matrix[0].count
        
        // Verifica se a primeira linha tem algum zero
        var firstRowHasZero = false
        for j in 0..<n {
            if matrix[0][j] == 0 {
                firstRowHasZero = true
                break
            }
        }
        
        // Verifica se a primeira coluna tem algum zero
        var firstColHasZero = false
        for i in 0..<m {
            if matrix[i][0] == 0 {
                firstColHasZero = true
                break
            }
        }
        
        // Marca quais linhas e colunas devem ser zeradas
        for i in 1..<m {
            for j in 1..<n {
                if matrix[i][j] == 0 {
                    matrix[i][0] = 0
                    matrix[0][j] = 0
                }
            }
        }
        
        // Zera as linhas marcadas
        for i in 1..<m {
            if matrix[i][0] == 0 {
                for j in 0..<n {
                    matrix[i][j] = 0
                }
            }
        }
        
        // Zera as colunas marcadas
        for j in 1..<n {
            if matrix[0][j] == 0 {
                for i in 0..<m {
                    matrix[i][j] = 0
                }
            }
        }
        
        // Zera a primeira linha, se necessário
        if firstRowHasZero {
            for j in 0..<n {
                matrix[0][j] = 0
            }
        }
        
        // Zera a primeira coluna, se necessário
        if firstColHasZero {
            for i in 0..<m {
                matrix[i][0] = 0
            }
        }
    }
}
```

---

### Exemplos

#### Exemplo 1:
**Input**:  
`matrix = [[1,1,1],[1,0,1],[1,1,1]]`  
**Output**:  
`[[1,0,1],[0,0,0],[1,0,1]]`

#### Exemplo 2:
**Input**:  
`matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]`  
**Output**:  
`[[0,0,0,0],[0,4,5,0],[0,3,1,0]]`

---

### Conclusão

Este é um problema clássico de manipulação de matrizes com restrições de espaço.

Usando uma abordagem inteligente — onde usamos a própria matriz para armazenar marcações — conseguimos resolver o problema com **espaço constante** e eficiência máxima.

Essa técnica é muito útil em entrevistas técnicas e testa seu conhecimento sobre otimização de espaço.

---

## [EN]

### The Problem

You are given an `m x n` integer matrix.

If an element is `0`, you must set its entire row and column to `0`s.

You must do it **in-place**, without using additional memory beyond a few variables.

---

### Reasoning

1. **Goal**:
   - For each zero in the matrix, set all elements in that row and column to zero
   - Do it **without using extra space**

2. **Efficient Strategy – Use First Row and Column as Markers**:
   - If `matrix[i][j] == 0`, mark:
     - `matrix[i][0] = 0` → this row should be zeroed
     - `matrix[0][j] = 0` → this column should be zeroed
   - Special handling for the **first row and column**, since they're used as markers

3. **Steps**:
   - Check if the first row or column contains any zeros
   - Mark rows and columns to be zeroed using the first row/column
   - Apply the zeroing logic based on marks
   - Finally, zero out the first row and column if needed

---

### Complexity Analysis

- **Time**: $O(m \cdot n)$ — Traverse the matrix multiple times
- **Space**: $O(1)$ — Constant extra space used

---

### Code Solution (comments in English)

```swift
class Solution {
    func setZeroes(_ matrix: inout [[Int]]) {
        let m = matrix.count
        let n = matrix[0].count
        
        // Track if first row has any zeros
        var firstRowHasZero = false
        for j in 0..<n {
            if matrix[0][j] == 0 {
                firstRowHasZero = true
                break
            }
        }
        
        // Track if first column has any zeros
        var firstColHasZero = false
        for i in 0..<m {
            if matrix[i][0] == 0 {
                firstColHasZero = true
                break
            }
        }
        
        // Use first row and column as markers
        for i in 1..<m {
            for j in 1..<n {
                if matrix[i][j] == 0 {
                    matrix[i][0] = 0
                    matrix[0][j] = 0
                }
            }
        }
        
        // Zero out rows based on marker
        for i in 1..<m {
            if matrix[i][0] == 0 {
                for j in 0..<n {
                    matrix[i][j] = 0
                }
            }
        }
        
        // Zero out columns based on marker
        for j in 1..<n {
            if matrix[0][j] == 0 {
                for i in 0..<m {
                    matrix[i][j] = 0
                }
            }
        }
        
        // Zero out first row if needed
        if firstRowHasZero {
            for j in 0..<n {
                matrix[0][j] = 0
            }
        }
        
        // Zero out first column if needed
        if firstColHasZero {
            for i in 0..<m {
                matrix[i][0] = 0
            }
        }
    }
}
```

---

### Examples

#### Example 1:
**Input**:  
`matrix = [[1,1,1],[1,0,1],[1,1,1]]`  
**Output**:  
`[[1,0,1],[0,0,0],[1,0,1]]`

#### Example 2:
**Input**:  
`matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]`  
**Output**:  
`[[0,0,0,0],[0,4,5,0],[0,3,1,0]]`

---

### Conclusion

This problem tests your ability to manipulate matrices with strict space constraints.

By cleverly reusing the matrix’s own structure to store information about which rows and columns to zero out, we achieve an optimal solution with **constant space** and **linear time** complexity.

It's a great example of how to optimize both time and space in matrix manipulation problems.