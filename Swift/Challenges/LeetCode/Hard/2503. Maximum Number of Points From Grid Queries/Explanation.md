## [PT/BR]

### O Problema

Dada uma matriz `grid` de tamanho `m x n` e uma lista de consultas `queries` de tamanho `k`, para cada consulta `queries[i]`, começamos na célula superior esquerda da matriz e seguimos o seguinte processo:

1. Se `queries[i]` for estritamente maior que o valor da célula atual, ganhamos um ponto se for a primeira vez que visitamos essa célula e podemos nos mover para qualquer célula adjacente nas quatro direções (cima, baixo, esquerda, direita).
2. Caso contrário, não ganhamos pontos e o processo termina.

O objetivo é retornar um array `answer` onde `answer[i]` é o número máximo de pontos que podemos obter para a consulta `queries[i]`.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Ordenação e Processamento Incremental**: 
   - Ordenamos as células da matriz pelo valor em ordem crescente.
   - Ordenamos as consultas pelo valor em ordem crescente.
   - Processamos as consultas em ordem crescente, ativando células da matriz conforme seus valores são menores que a consulta atual.

2. **Union-Find (Disjoint Set Union - DSU)**:
   - Utilizamos a estrutura de dados Union-Find para gerenciar conjuntos de células conectadas.
   - Cada célula ativada é unida às suas células adjacentes já ativadas, formando conjuntos conectados.
   - A célula inicial (0,0) é sempre a primeira a ser considerada. Se estiver ativada, o tamanho do conjunto ao qual pertence é o número de pontos obtidos.

3. **Eficiência**:
   - A ordenação das células e consultas permite processar cada consulta em tempo linear relativo ao número de células ativadas até então.
   - O Union-Find garante operações quase constantes para união e busca, tornando o algoritmo eficiente.

### Análise da Complexidade

- **Tempo**:
  - Ordenação das células: `O(mn log mn)`.
  - Ordenação das consultas: `O(k log k)`.
  - Processamento das consultas e ativação das células: `O(mn α(mn))`, onde `α` é a função inversa de Ackermann (praticamente constante).
  - **Total**: `O(mn log mn + k log k + mn α(mn))`.

- **Espaço**:
  - `O(mn)` para armazenar as células ordenadas, estruturas Union-Find e matriz de ativação.

### Solução em Código

```swift
class Solution {
    func maxPoints(_ grid: [[Int]], _ queries: [Int]) -> [Int] {
        let m = grid.count
        let n = grid[0].count
        var sortedCells: [(value: Int, row: Int, col: Int)] = []
        for r in 0..<m {
            for c in 0..<n {
                sortedCells.append((grid[r][c], r, c))
            }
        }
        sortedCells.sort(by: {$0.value < $1.value})
        
        let k = queries.count
        var sortedQueries: [(value: Int, originalIndex: Int)] = []
        for i in 0..<k {
            sortedQueries.append((queries[i], i))
        }
        sortedQueries.sort(by: {$0.value < $1.value})
        
        var answer = [Int](repeating: 0, count: k)
        var parent = [Int](repeating: 0, count: m * n)
        var size = [Int](repeating: 1, count: m * n)
        var active = [[Bool]](repeating: [Bool](repeating: false, count: n), count: m)
        for i in 0..<m * n {
            parent[i] = i
        }
        
        func findSet(_ i: Int) -> Int {
            if parent[i] == i {
                return i
            }
            parent[i] = findSet(parent[i])
            return parent[i]
        }
        
        func uniteSets(_ i: Int, _ j: Int) {
            let rootI = findSet(i)
            let rootJ = findSet(j)
            if rootI != rootJ {
                if size[rootI] < size[rootJ] {
                    parent[rootI] = rootJ
                    size[rootJ] += size[rootI]
                } else {
                    parent[rootJ] = rootI
                    size[rootI] += size[rootJ]
                }
            }
        }
        
        var cellsIndex = 0
        for (q, originalIndex) in sortedQueries {
            while cellsIndex < m * n && sortedCells[cellsIndex].value < q {
                let cell = sortedCells[cellsIndex]
                let r = cell.row
                let c = cell.col
                if !active[r][c] {
                    active[r][c] = true
                    let u = r * n + c
                    let neighbors = [(r - 1, c), (r + 1, c), (r, c - 1), (r, c + 1)]
                    for (nr, nc) in neighbors {
                        if nr >= 0 && nr < m && nc >= 0 && nc < n && active[nr][nc] {
                            let v = nr * n + nc
                            uniteSets(u, v)
                        }
                    }
                }
                cellsIndex += 1
            }
            if active[0][0] {
                answer[originalIndex] = size[findSet(0)]
            } else {
                answer[originalIndex] = 0
            }
        }
        
        return answer
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**:  
`grid = [[1,2,3],[2,5,7],[3,5,1]]`, `queries = [5,6,2]`.  
**Output**: `[5,8,1]`.  
**Explicação**:  
- Para `queries[0] = 5`: Ativamos células com valor < 5. O conjunto conectado à célula (0,0) tem tamanho 5.  
- Para `queries[1] = 6`: Ativamos mais células. O conjunto conectado tem tamanho 8.  
- Para `queries[2] = 2`: Apenas a célula (0,0) é ativada, resultando em 1 ponto.

#### Exemplo 2:
**Input**:  
`grid = [[5,2,1],[1,1,2]]`, `queries = [3]`.  
**Output**: `[0]`.  
**Explicação**:  
- A célula (0,0) tem valor 5, que é maior que 3. Nenhuma célula é ativada, resultando em 0 pontos.

### Conclusão

A solução utiliza ordenação e Union-Find para processar consultas de forma eficiente, garantindo que cada consulta seja respondida em tempo quase linear. A abordagem é ideal para matrizes grandes e múltiplas consultas, mantendo a eficiência computacional.

---

## [EN]

### The Problem

Given an `m x n` integer matrix `grid` and a list of queries `queries` of size `k`, for each query `queries[i]`, we start at the top-left cell of the matrix and follow this process:

1. If `queries[i]` is strictly greater than the value of the current cell, we earn a point if it's our first time visiting this cell and can move to any adjacent cell in four directions (up, down, left, right).
2. Otherwise, we earn no points and the process ends.

The goal is to return an array `answer` where `answer[i]` is the maximum number of points we can earn for the query `queries[i]`.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Sorting and Incremental Processing**:
   - Sort the matrix cells by their values in ascending order.
   - Sort the queries by their values in ascending order.
   - Process queries in ascending order, activating matrix cells as their values are less than the current query.

2. **Union-Find (Disjoint Set Union - DSU)**:
   - Use the Union-Find data structure to manage connected sets of cells.
   - Each activated cell is united with its adjacent activated cells, forming connected sets.
   - The starting cell (0,0) is always considered first. If activated, the size of its set is the number of points earned.

3. **Efficiency**:
   - Sorting cells and queries allows processing each query in linear time relative to the number of cells activated so far.
   - Union-Find ensures near-constant time operations for union and find, making the algorithm efficient.

### Complexity Analysis

- **Time**:
  - Sorting cells: `O(mn log mn)`.
  - Sorting queries: `O(k log k)`.
  - Processing queries and activating cells: `O(mn α(mn))`, where `α` is the inverse Ackermann function (effectively constant).
  - **Total**: `O(mn log mn + k log k + mn α(mn))`.

- **Space**:
  - `O(mn)` for storing sorted cells, Union-Find structures, and activation matrix.

### Code Solution

```swift
class Solution {
    func maxPoints(_ grid: [[Int]], _ queries: [Int]) -> [Int] {
        let m = grid.count
        let n = grid[0].count
        var sortedCells: [(value: Int, row: Int, col: Int)] = []
        for r in 0..<m {
            for c in 0..<n {
                sortedCells.append((grid[r][c], r, c))
            }
        }
        sortedCells.sort(by: {$0.value < $1.value})
        
        let k = queries.count
        var sortedQueries: [(value: Int, originalIndex: Int)] = []
        for i in 0..<k {
            sortedQueries.append((queries[i], i))
        }
        sortedQueries.sort(by: {$0.value < $1.value})
        
        var answer = [Int](repeating: 0, count: k)
        var parent = [Int](repeating: 0, count: m * n)
        var size = [Int](repeating: 1, count: m * n)
        var active = [[Bool]](repeating: [Bool](repeating: false, count: n), count: m)
        for i in 0..<m * n {
            parent[i] = i
        }
        
        func findSet(_ i: Int) -> Int {
            if parent[i] == i {
                return i
            }
            parent[i] = findSet(parent[i])
            return parent[i]
        }
        
        func uniteSets(_ i: Int, _ j: Int) {
            let rootI = findSet(i)
            let rootJ = findSet(j)
            if rootI != rootJ {
                if size[rootI] < size[rootJ] {
                    parent[rootI] = rootJ
                    size[rootJ] += size[rootI]
                } else {
                    parent[rootJ] = rootI
                    size[rootI] += size[rootJ]
                }
            }
        }
        
        var cellsIndex = 0
        for (q, originalIndex) in sortedQueries {
            while cellsIndex < m * n && sortedCells[cellsIndex].value < q {
                let cell = sortedCells[cellsIndex]
                let r = cell.row
                let c = cell.col
                if !active[r][c] {
                    active[r][c] = true
                    let u = r * n + c
                    let neighbors = [(r - 1, c), (r + 1, c), (r, c - 1), (r, c + 1)]
                    for (nr, nc) in neighbors {
                        if nr >= 0 && nr < m && nc >= 0 && nc < n && active[nr][nc] {
                            let v = nr * n + nc
                            uniteSets(u, v)
                        }
                    }
                }
                cellsIndex += 1
            }
            if active[0][0] {
                answer[originalIndex] = size[findSet(0)]
            } else {
                answer[originalIndex] = 0
            }
        }
        
        return answer
    }
}
```

### Examples

#### Example 1:
**Input**:  
`grid = [[1,2,3],[2,5,7],[3,5,1]]`, `queries = [5,6,2]`.  
**Output**: `[5,8,1]`.  
**Explanation**:  
- For `queries[0] = 5`: Activate cells with value < 5. The connected set size is 5.  
- For `queries[1] = 6`: Activate more cells. The connected set size is 8.  
- For `queries[2] = 2`: Only cell (0,0) is activated, resulting in 1 point.

#### Example 2:
**Input**:  
`grid = [[5,2,1],[1,1,2]]`, `queries = [3]`.  
**Output**: `[0]`.  
**Explanation**:  
- Cell (0,0) has value 5, which is greater than 3. No cells are activated, resulting in 0 points.

### Conclusion

The solution uses sorting and Union-Find to process queries efficiently, ensuring each query is answered in near-linear time. This approach is ideal for large matrices and multiple queries, maintaining computational efficiency.