## [PT/BR]

### O Problema

Temos um calabouço representado por uma grade n x m, onde cada sala `(i, j)` tem um tempo mínimo `moveTime[i][j]` que indica quando podemos começar a nos mover para essa sala. Começamos na sala `(0, 0)` no tempo `t = 0` e podemos nos mover para salas adjacentes (cima, baixo, esquerda, direita) em exatamente 1 segundo. Precisamos encontrar o tempo mínimo para chegar à sala `(n-1, m-1)`.

### Raciocínio

1. **Busca pelo Caminho Mínimo**:
   - Usamos o algoritmo de Dijkstra adaptado para considerar os tempos mínimos de movimento
   - Cada sala é um nó no grafo, e as arestas são os movimentos para salas adjacentes

2. **Heap Mínimo**:
   - Priorizamos a exploração de caminhos com menor tempo acumulado
   - Mantemos um registro dos melhores tempos encontrados para cada sala

3. **Condição de Movimento**:
   - Só podemos entrar em uma sala quando o tempo atual for maior ou igual ao `moveTime` da sala
   - O tempo para chegar em uma sala adjacente é o máximo entre:
     - Tempo atual + 1 segundo
     - `moveTime` da sala adjacente + 1 segundo

### Análise da Complexidade

- **Tempo**: O(n*m log(n*m)) - Cada sala pode ser processada no heap, com operações logarítmicas
- **Espaço**: O(n*m) - Para armazenar os tempos mínimos visitados

### Solução em Código

```swift
import Collections

class Solution {
    func minTimeToReach(_ moveTime: [[Int]]) -> Int {
        let rows = moveTime.count
        let cols = moveTime[0].count
        var minHeap = Heap<Path>()
        var visitedWithTime = Array(repeating: Array(repeating: Int.max, count: cols), count: rows)
        
        // Começa na posição (0,0) no tempo 0
        minHeap.insert(Path(r: 0, c: 0, timePassed: 0))
        
        while let currPath = minHeap.popMin() {
            // Chegou no destino
            if currPath.r == rows - 1 && currPath.c == cols - 1 {
                return currPath.timePassed
            }
            
            // Movimentos possíveis (cima, baixo, esquerda, direita)
            for (dR, dC) in [(-1,0), (1,0), (0,-1), (0,1)] {
                let newRow = currPath.r + dR
                let newCol = currPath.c + dC
                
                // Verifica se a nova posição está dentro dos limites
                guard (0..<rows).contains(newRow) && (0..<cols).contains(newCol) else { continue }
                
                // Calcula o tempo para entrar na nova sala
                let timeAtNewCell = max(currPath.timePassed + 1, moveTime[newRow][newCol] + 1)
                
                // Só continua se encontrarmos um tempo melhor
                guard timeAtNewCell < visitedWithTime[newRow][newCol] else { continue }
                
                // Atualiza o tempo mínimo para esta sala
                visitedWithTime[newRow][newCol] = timeAtNewCell
                minHeap.insert(Path(r: newRow, c: newCol, timePassed: timeAtNewCell))
            }
        }
        
        // Se não encontrou caminho (não deveria acontecer conforme o problema)
        return -1
    }
}

// Estrutura para representar um caminho no heap
struct Path: Comparable {
    let r: Int  // linha
    let c: Int  // coluna
    let timePassed: Int  // tempo acumulado
    
    static func == (lhs: Path, rhs: Path) -> Bool {
        return lhs.r == rhs.r && lhs.c == rhs.c && lhs.timePassed == rhs.timePassed
    }
    
    static func < (lhs: Path, rhs: Path) -> Bool {
        if lhs.timePassed == rhs.timePassed {
            if lhs.r == rhs.r {
                return lhs.c < rhs.c
            }
            return lhs.r < rhs.r
        }
        return lhs.timePassed < rhs.timePassed
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `moveTime = [[0,4],[4,4]]`  
**Output**: `6`  
**Explicação**:
- Em t=0: começa em (0,0)
- Em t=4: move para (1,0) (tempo atual 4 >= moveTime[1][0]=4)
- Em t=5: move para (1,1) (tempo atual 5 >= moveTime[1][1]=4)
- Total: 6 segundos

#### Exemplo 2:
**Input**: `moveTime = [[0,0,0],[0,0,0]]`  
**Output**: `3`  
**Explicação**:
- Movimentos a cada segundo: (0,0)→(1,0)→(1,1)→(1,2)
- Total: 3 segundos

### Conclusão

Esta solução utiliza uma abordagem eficiente de busca pelo caminho mínimo, considerando as restrições de tempo de cada sala. O algoritmo garante que encontraremos o caminho mais rápido possível para o destino, mesmo em grades grandes.

---

## [EN]

### The Problem

We have a dungeon represented by an n x m grid, where each room `(i, j)` has a minimum time `moveTime[i][j]` indicating when we can start moving to that room. We start at room `(0, 0)` at time `t = 0` and can move to adjacent rooms (up, down, left, right) in exactly 1 second. We need to find the minimum time to reach room `(n-1, m-1)`.

### Reasoning

1. **Minimum Path Search**:
   - Use Dijkstra's algorithm adapted to consider minimum movement times
   - Each room is a node in the graph, and edges are movements to adjacent rooms

2. **Min-Heap**:
   - Prioritize exploring paths with least accumulated time
   - Keep track of best times found for each room

3. **Movement Condition**:
   - Can only enter a room when current time ≥ room's `moveTime`
   - Time to reach adjacent room is maximum between:
     - Current time + 1 second
     - Adjacent room's `moveTime` + 1 second

### Complexity Analysis

- **Time**: O(n*m log(n*m)) - Each room may be processed in heap with log operations
- **Space**: O(n*m) - To store minimum visited times

### Code Solution

```swift
import Collections

class Solution {
    func minTimeToReach(_ moveTime: [[Int]]) -> Int {
        let rows = moveTime.count
        let cols = moveTime[0].count
        var minHeap = Heap<Path>()
        var visitedWithTime = Array(repeating: Array(repeating: Int.max, count: cols), count: rows)
        
        // Start at (0,0) at time 0
        minHeap.insert(Path(r: 0, c: 0, timePassed: 0))
        
        while let currPath = minHeap.popMin() {
            // Reached destination
            if currPath.r == rows - 1 && currPath.c == cols - 1 {
                return currPath.timePassed
            }
            
            // Possible moves (up, down, left, right)
            for (dR, dC) in [(-1,0), (1,0), (0,-1), (0,1)] {
                let newRow = currPath.r + dR
                let newCol = currPath.c + dC
                
                // Check if new position is within bounds
                guard (0..<rows).contains(newRow) && (0..<cols).contains(newCol) else { continue }
                
                // Calculate time to enter new room
                let timeAtNewCell = max(currPath.timePassed + 1, moveTime[newRow][newCol] + 1)
                
                // Only continue if found better time
                guard timeAtNewCell < visitedWithTime[newRow][newCol] else { continue }
                
                // Update minimum time for this room
                visitedWithTime[newRow][newCol] = timeAtNewCell
                minHeap.insert(Path(r: newRow, c: newCol, timePassed: timeAtNewCell))
            }
        }
        
        // If no path found (shouldn't happen per problem constraints)
        return -1
    }
}

// Structure to represent a path in the heap
struct Path: Comparable {
    let r: Int  // row
    let c: Int  // column
    let timePassed: Int  // accumulated time
    
    static func == (lhs: Path, rhs: Path) -> Bool {
        return lhs.r == rhs.r && lhs.c == rhs.c && lhs.timePassed == rhs.timePassed
    }
    
    static func < (lhs: Path, rhs: Path) -> Bool {
        if lhs.timePassed == rhs.timePassed {
            if lhs.r == rhs.r {
                return lhs.c < rhs.c
            }
            return lhs.r < rhs.r
        }
        return lhs.timePassed < rhs.timePassed
    }
}
```

### Examples

#### Example 1:
**Input**: `moveTime = [[0,4],[4,4]]`  
**Output**: `6`  
**Explanation**:
- At t=0: start at (0,0)
- At t=4: move to (1,0) (current time 4 ≥ moveTime[1][0]=4)
- At t=5: move to (1,1) (current time 5 ≥ moveTime[1][1]=4)
- Total: 6 seconds

#### Example 2:
**Input**: `moveTime = [[0,0,0],[0,0,0]]`  
**Output**: `3`  
**Explanation**:
- Moves each second: (0,0)→(1,0)→(1,1)→(1,2)
- Total: 3 seconds

### Conclusion

This solution uses an efficient minimum path search approach, considering each room's time constraints. The algorithm guarantees finding the fastest possible path to the destination, even in large grids.