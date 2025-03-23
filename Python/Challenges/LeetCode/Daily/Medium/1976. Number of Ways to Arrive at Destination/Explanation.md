## [PT/BR]

### O Problema

Você está em uma cidade com `n` interseções numeradas de 0 a `n - 1`, conectadas por estradas bidirecionais. Cada estrada tem um tempo associado para atravessá-la. Dado o número de interseções `n` e uma lista de estradas `roads`, onde `roads[i] = [ui, vi, timei]` representa uma estrada entre as interseções `ui` e `vi` que leva `timei` minutos para ser atravessada, queremos determinar o número de maneiras diferentes de viajar da interseção 0 à interseção `n-1` no menor tempo possível.

Retorne o número de caminhos mais curtos módulo \( 10^9 + 7 \).

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Representação do Grafo**: Utilizei uma lista de adjacência para representar o grafo, onde cada nó aponta para seus vizinhos junto com o tempo necessário para atravessar a aresta.

2. **Algoritmo de Dijkstra**: Para encontrar o caminho mais curto, utilizei o algoritmo de Dijkstra com uma fila de prioridade (min-heap). Esse algoritmo processa os nós em ordem crescente de distância, garantindo que sempre encontraremos o caminho mais curto primeiro.

3. **Contagem de Caminhos Mais Curtos**: Além de calcular o tempo mínimo para chegar a cada nó, também contei o número de maneiras diferentes de alcançar cada nó no menor tempo. Isso foi feito mantendo dois arrays:
   - `dist`: Armazena o menor tempo para alcançar cada nó.
   - `ways`: Armazena o número de maneiras de alcançar cada nó no menor tempo.

4. **Atualização dos Arrays**: Durante a execução do algoritmo:
   - Se encontrarmos um caminho mais curto para um nó, atualizamos sua distância e reinicializamos o contador de maneiras.
   - Se encontrarmos outro caminho com o mesmo tempo mínimo, incrementamos o contador de maneiras para esse nó.

5. **Resultado Final**: Após processar todos os nós, o valor em `ways[n-1]` representa o número de maneiras de chegar ao destino no menor tempo.

### Análise da Complexidade

- **Complexidade de tempo**:
  - Construção da lista de adjacência: \( O(E) \), onde \( E \) é o número de estradas.
  - Algoritmo de Dijkstra: \( O((V + E) \cdot \log V) \), onde \( V \) é o número de interseções. A operação de inserção/remoção na fila de prioridade custa \( O(\log V) \).
  - Total: \( O(V + E \cdot \log V) \).

- **Complexidade de espaço**: \( O(V + E) \), devido ao armazenamento da lista de adjacência e das estruturas auxiliares (`dist` e `ways`).

### Solução em Código

```python
import heapq
from typing import List

class Solution:
    def countPaths(self, n: int, roads: List[List[int]]) -> int:
        MOD = 10**9 + 7
        
        # Construir a lista de adjacência
        adj = [[] for _ in range(n)]
        for u, v, t in roads:
            adj[u].append((v, t))
            adj[v].append((u, t))
        
        # Inicializar distâncias e contadores de maneiras
        dist = [float('inf')] * n
        ways = [0] * n
        dist[0] = 0
        ways[0] = 1
        
        # Fila de prioridade para Dijkstra
        heap = []
        heapq.heappush(heap, (0, 0))  # (tempo, nó)
        
        while heap:
            current_time, u = heapq.heappop(heap)
            
            # Ignorar nós já processados com distância maior
            if current_time > dist[u]:
                continue
            
            # Processar os vizinhos
            for v, t in adj[u]:
                new_time = current_time + t
                
                # Se encontrarmos um caminho mais curto
                if new_time < dist[v]:
                    dist[v] = new_time
                    ways[v] = ways[u]
                    heapq.heappush(heap, (new_time, v))
                
                # Se encontrarmos outro caminho com o mesmo tempo mínimo
                elif new_time == dist[v]:
                    ways[v] = (ways[v] + ways[u]) % MOD
        
        return ways[n-1] % MOD
```

### Exemplos

#### Exemplo 1:
**Input**:  
```plaintext
n = 7
roads = [[0,6,7],[0,1,2],[1,2,3],[1,3,3],[6,3,3],[3,5,1],[6,5,1],[2,5,1],[0,4,5],[4,6,2]]
```
**Output**:  
```plaintext
4
```
**Explicação**:
1. O menor tempo para ir da interseção 0 à interseção 6 é 7 minutos.
2. Existem 4 maneiras de chegar ao destino no menor tempo:
   - 0 ➝ 6
   - 0 ➝ 4 ➝ 6
   - 0 ➝ 1 ➝ 2 ➝ 5 ➝ 6
   - 0 ➝ 1 ➝ 3 ➝ 5 ➝ 6

#### Exemplo 2:
**Input**:  
```plaintext
n = 2
roads = [[1,0,10]]
```
**Output**:  
```plaintext
1
```
**Explicação**:
1. Há apenas uma maneira de ir da interseção 0 à interseção 1, e isso leva 10 minutos.

### Conclusão

A solução utiliza o algoritmo de Dijkstra com uma fila de prioridade para encontrar o caminho mais curto e contar o número de maneiras de alcançar o destino no menor tempo. Ao manter arrays para distâncias e contagem de maneiras, garantimos que o problema seja resolvido de forma eficiente. A complexidade de tempo \( O(V + E \cdot \log V) \) torna a solução adequada para entradas razoáveis.

---

## [EN]

### The Problem

You are in a city with `n` intersections numbered from 0 to `n - 1`, connected by bidirectional roads. Each road has an associated time to traverse it. Given the number of intersections `n` and a list of roads `roads`, where `roads[i] = [ui, vi, timei]` represents a road between intersections `ui` and `vi` that takes `timei` minutes to traverse, we want to determine the number of different ways to travel from intersection 0 to intersection `n-1` in the shortest possible time.

Return the number of shortest paths modulo \( 10^9 + 7 \).

### Reasoning

To solve this problem, I followed this reasoning:

1. **Graph Representation**: I used an adjacency list to represent the graph, where each node points to its neighbors along with the time required to traverse the edge.

2. **Dijkstra's Algorithm**: To find the shortest path, I used Dijkstra's algorithm with a priority queue (min-heap). This algorithm processes nodes in increasing order of distance, ensuring that we always find the shortest path first.

3. **Counting Shortest Paths**: In addition to calculating the minimum time to reach each node, I also counted the number of ways to reach each node in the shortest time. This was done using two arrays:
   - `dist`: Stores the shortest time to reach each node.
   - `ways`: Stores the number of ways to reach each node in the shortest time.

4. **Updating Arrays**: During the execution of the algorithm:
   - If a shorter path is found for a node, update its distance and reset the count of ways.
   - If another path with the same minimum time is found, increment the count of ways for that node.

5. **Final Result**: After processing all nodes, the value in `ways[n-1]` represents the number of ways to reach the destination in the shortest time.

### Complexity Analysis

- **Time complexity**:
  - Building the adjacency list: \( O(E) \), where \( E \) is the number of roads.
  - Dijkstra's algorithm: \( O((V + E) \cdot \log V) \), where \( V \) is the number of intersections. Insertion/removal in the priority queue costs \( O(\log V) \).
  - Total: \( O(V + E \cdot \log V) \).

- **Space complexity**: \( O(V + E) \), due to storage of the adjacency list and auxiliary structures (`dist` and `ways`).

### Code Solution

```python
import heapq
from typing import List

class Solution:
    def countPaths(self, n: int, roads: List[List[int]]) -> int:
        MOD = 10**9 + 7
        
        # Build adjacency list
        adj = [[] for _ in range(n)]
        for u, v, t in roads:
            adj[u].append((v, t))
            adj[v].append((u, t))
        
        # Initialize distances and ways count
        dist = [float('inf')] * n
        ways = [0] * n
        dist[0] = 0
        ways[0] = 1
        
        # Priority queue for Dijkstra
        heap = []
        heapq.heappush(heap, (0, 0))  # (time, node)
        
        while heap:
            current_time, u = heapq.heappop(heap)
            
            # Skip already processed nodes with larger distances
            if current_time > dist[u]:
                continue
            
            # Process neighbors
            for v, t in adj[u]:
                new_time = current_time + t
                
                # If a shorter path is found
                if new_time < dist[v]:
                    dist[v] = new_time
                    ways[v] = ways[u]
                    heapq.heappush(heap, (new_time, v))
                
                # If another path with the same minimum time is found
                elif new_time == dist[v]:
                    ways[v] = (ways[v] + ways[u]) % MOD
        
        return ways[n-1] % MOD
```

### Examples

#### Example 1:
**Input**:  
```plaintext
n = 7
roads = [[0,6,7],[0,1,2],[1,2,3],[1,3,3],[6,3,3],[3,5,1],[6,5,1],[2,5,1],[0,4,5],[4,6,2]]
```
**Output**:  
```plaintext
4
```
**Explanation**:
1. The shortest time to go from intersection 0 to intersection 6 is 7 minutes.
2. There are 4 ways to reach the destination in the shortest time:
   - 0 ➝ 6
   - 0 ➝ 4 ➝ 6
   - 0 ➝ 1 ➝ 2 ➝ 5 ➝ 6
   - 0 ➝ 1 ➝ 3 ➝ 5 ➝ 6

#### Example 2:
**Input**:  
```plaintext
n = 2
roads = [[1,0,10]]
```
**Output**:  
```plaintext
1
```
**Explanation**:
1. There is only one way to go from intersection 0 to intersection 1, and it takes 10 minutes.

### Conclusion

The solution uses Dijkstra's algorithm with a priority queue to find the shortest path and count the number of ways to reach the destination in the shortest time. By maintaining arrays for distances and ways count, we ensure the problem is solved efficiently. The time complexity \( O(V + E \cdot \log V) \) makes the solution suitable for reasonable inputs.