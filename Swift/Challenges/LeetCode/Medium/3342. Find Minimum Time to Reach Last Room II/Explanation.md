## [PT/BR]

### O Problema

Temos um calabouço representado por uma grade n x m, onde cada sala `(i, j)` tem um tempo mínimo `moveTime[i][j]` que indica quando podemos começar a nos mover para essa sala. Começamos na sala `(0, 0)` no tempo `t = 0` e podemos nos mover para salas adjacentes (cima, baixo, esquerda, direita), com o tempo de movimento alternando entre 1 e 2 segundos (o primeiro movimento leva 1 segundo, o próximo 2 segundos, e assim por diante). Precisamos encontrar o tempo mínimo para chegar à sala `(n-1, m-1)`.

### Raciocínio

1. **Busca pelo Caminho Mínimo**:
   - Usamos o algoritmo de Dijkstra adaptado para considerar os tempos mínimos de movimento e a alternância nos tempos de deslocamento
   - Cada estado no heap inclui a posição `(x, y)`, o tempo acumulado `t` e um indicador `p` que alterna entre 1 e 0 para controlar o tempo do próximo movimento

2. **Heap Mínimo**:
   - Priorizamos a exploração de caminhos com menor tempo acumulado
   - Mantemos um registro dos melhores tempos encontrados para cada sala

3. **Condição de Movimento**:
   - O tempo para entrar em uma sala adjacente é calculado como:
     - `max(tempo_atual, moveTime[y][x]) + (1 se p == 1, 2 se p == 0)`
   - Alternamos o valor de `p` após cada movimento

### Análise da Complexidade

- **Tempo**: O(n*m log(n*m)) - Cada sala pode ser processada no heap, com operações logarítmicas
- **Espaço**: O(n*m) - Para armazenar os tempos mínimos visitados

### Solução em Código

```swift
class Solution {
    struct HeapItem: Comparable {
        var x: Int
        var y: Int
        var t: Int  // tempo acumulado
        var p: Int  // próximo tempo de movimento (1 ou 0 para alternar entre 1 e 2 segundos)
        
        var tuple: (Int, Int, Int, Int) { (x, y, t, p) }
        
        static func < (a: HeapItem, b: HeapItem) -> Bool {
            return a.t < b.t
        }
    }

    func minTimeToReach(_ moveTime: [[Int]]) -> Int {
        let (n, m) = (moveTime.count, moveTime[0].count)
        var heap = Heap<HeapItem>()
        heap.insert(HeapItem(x: 0, y: 0, t: 0, p: 1))
        
        // Cria uma cópia mutável de moveTime para marcar salas visitadas
        var moveTime = moveTime
        
        while let current = heap.popMin() {
            let (x, y, t, p) = current.tuple
            
            // Verifica se chegou ao destino
            if x == m - 1 && y == n - 1 {
                return t
            }
            
            // Movimentos possíveis (direita, esquerda, baixo, cima)
            let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
            
            for (dx, dy) in directions {
                let newX = x + dx
                let newY = y + dy
                
                // Verifica se a nova posição está dentro dos limites
                guard newX >= 0 && newX < m && newY >= 0 && newY < n else { continue }
                
                // Verifica se a sala já foi visitada
                guard moveTime[newY][newX] >= 0 else { continue }
                
                // Calcula o tempo para entrar na nova sala
                let moveDuration = p == 1 ? 1 : 2
                let newTime = max(t, moveTime[newY][newX]) + moveDuration
                
                // Insere no heap e marca como visitada
                heap.insert(HeapItem(x: newX, y: newY, t: newTime, p: p ^ 1))
                moveTime[newY][newX] = -1  // Marca como visitada
            }
        }
        
        return 0  // Nunca deve chegar aqui se houver caminho para o destino
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `moveTime = [[0,4],[4,4]]`  
**Output**: `7`  
**Explicação**:
- Em t=0: começa em (0,0)
- Em t=4: move para (1,0) em 1 segundo (tempo atual 4 ≥ moveTime[1][0]=4)
- Em t=5: move para (1,1) em 2 segundos (próximo movimento alternado)
- Total: 7 segundos

#### Exemplo 2:
**Input**: `moveTime = [[0,0,0,0],[0,0,0,0]]`  
**Output**: `6`  
**Explicação**:
- Movimentos alternados:
  - (0,0)→(1,0): 1s (t=1)
  - (1,0)→(1,1): 2s (t=3)
  - (1,1)→(1,2): 1s (t=4)
  - (1,2)→(1,3): 2s (t=6)
- Total: 6 segundos

### Conclusão

Esta solução eficiente utiliza uma abordagem de busca pelo caminho mínimo adaptada para considerar tanto os tempos mínimos de movimento de cada sala quanto a alternância nos tempos de deslocamento. O algoritmo garante que encontraremos o caminho mais rápido possível para o destino, mesmo em grades grandes.

---

## [EN]

### The Problem

We have a dungeon represented by an n x m grid, where each room `(i, j)` has a minimum time `moveTime[i][j]` indicating when we can start moving to that room. We start at room `(0, 0)` at time `t = 0` and can move to adjacent rooms (up, down, left, right), with movement time alternating between 1 and 2 seconds (first move takes 1 second, next 2 seconds, and so on). We need to find the minimum time to reach room `(n-1, m-1)`.

### Reasoning

1. **Minimum Path Search**:
   - Use Dijkstra's algorithm adapted to consider minimum movement times and alternating movement durations
   - Each state in the heap includes position `(x, y)`, accumulated time `t`, and a toggle `p` alternating between 1 and 0 to control next move duration

2. **Min-Heap**:
   - Prioritize exploring paths with least accumulated time
   - Track best times found for each room

3. **Movement Condition**:
   - Time to enter adjacent room is calculated as:
     - `max(current_time, moveTime[y][x]) + (1 if p == 1, 2 if p == 0)`
   - Toggle `p` after each move

### Complexity Analysis

- **Time**: O(n*m log(n*m)) - Each room may be processed in heap with log operations
- **Space**: O(n*m) - To store minimum visited times

### Code Solution

```swift
class Solution {
    struct HeapItem: Comparable {
        var x: Int
        var y: Int
        var t: Int  // accumulated time
        var p: Int  // next move duration (1 or 0 to alternate between 1 and 2 seconds)
        
        var tuple: (Int, Int, Int, Int) { (x, y, t, p) }
        
        static func < (a: HeapItem, b: HeapItem) -> Bool {
            return a.t < b.t
        }
    }

    func minTimeToReach(_ moveTime: [[Int]]) -> Int {
        let (n, m) = (moveTime.count, moveTime[0].count)
        var heap = Heap<HeapItem>()
        heap.insert(HeapItem(x: 0, y: 0, t: 0, p: 1))
        
        // Create mutable copy of moveTime to mark visited rooms
        var moveTime = moveTime
        
        while let current = heap.popMin() {
            let (x, y, t, p) = current.tuple
            
            // Check if reached destination
            if x == m - 1 && y == n - 1 {
                return t
            }
            
            // Possible moves (right, left, down, up)
            let directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
            
            for (dx, dy) in directions {
                let newX = x + dx
                let newY = y + dy
                
                // Check if new position is within bounds
                guard newX >= 0 && newX < m && newY >= 0 && newY < n else { continue }
                
                // Check if room hasn't been visited
                guard moveTime[newY][newX] >= 0 else { continue }
                
                // Calculate time to enter new room
                let moveDuration = p == 1 ? 1 : 2
                let newTime = max(t, moveTime[newY][newX]) + moveDuration
                
                // Insert into heap and mark as visited
                heap.insert(HeapItem(x: newX, y: newY, t: newTime, p: p ^ 1))
                moveTime[newY][newX] = -1  // Mark as visited
            }
        }
        
        return 0  // Should never reach here if path exists
    }
}
```

### Examples

#### Example 1:
**Input**: `moveTime = [[0,4],[4,4]]`  
**Output**: `7`  
**Explanation**:
- At t=0: start at (0,0)
- At t=4: move to (1,0) in 1s (current time 4 ≥ moveTime[1][0]=4)
- At t=5: move to (1,1) in 2s (next move alternated)
- Total: 7 seconds

#### Example 2:
**Input**: `moveTime = [[0,0,0,0],[0,0,0,0]]`  
**Output**: `6`  
**Explanation**:
- Alternating moves:
  - (0,0)→(1,0): 1s (t=1)
  - (1,0)→(1,1): 2s (t=3)
  - (1,1)→(1,2): 1s (t=4)
  - (1,2)→(1,3): 2s (t=6)
- Total: 6 seconds

### Conclusion

This efficient solution uses an adapted minimum path search approach that considers both room movement time constraints and alternating movement durations. The algorithm guarantees finding the fastest possible path to the destination, even in large grids.