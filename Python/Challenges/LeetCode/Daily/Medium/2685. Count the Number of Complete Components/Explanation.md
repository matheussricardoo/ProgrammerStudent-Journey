## [PT/BR]

### O Problema

Dado um grafo não direcionado com `n` vértices numerados de 0 a `n - 1`, queremos determinar o número de **componentes conectados completos** no grafo. Um componente conectado é dito completo se houver uma aresta entre **todos os pares de vértices** dentro do componente.

Você recebe:
- Um inteiro `n` representando o número de vértices.
- Uma lista de arestas `edges`, onde `edges[i] = [ai, bi]` indica que há uma aresta entre os vértices `ai` e `bi`.

Retorne o número de componentes conectados completos no grafo.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Identificação dos Componentes Conectados**: Utilizei uma abordagem baseada em busca (BFS ou DFS) para identificar todos os componentes conectados no grafo. Cada componente é um subgrafo onde todos os vértices estão interconectados por caminhos.

2. **Verificação de Completude**: Para cada componente conectado, verifiquei se ele é completo. Um componente com `m` vértices é completo se contiver exatamente `m * (m - 1) / 2` arestas, que é o número de arestas em um grafo completo com `m` vértices.

3. **Contagem de Arestas em um Componente**: Para verificar a completude, contei o número de arestas presentes no componente e comparei com o valor esperado para um grafo completo.

4. **Resultado Final**: Após processar todos os componentes, retornei o número total de componentes conectados completos.

### Análise da Complexidade

- **Complexidade de tempo**:
  - Construção da lista de adjacência: \( O(E) \), onde \( E \) é o número de arestas.
  - Busca para encontrar componentes conectados: \( O(V + E) \), onde \( V \) é o número de vértices.
  - Verificação de completude: \( O(E) \), pois precisamos iterar sobre todas as arestas para contar aquelas pertencentes a cada componente.
  - Total: \( O(V + E) \).

- **Complexidade de espaço**: \( O(V + E) \), devido ao armazenamento da lista de adjacência e das estruturas auxiliares.

### Solução em Código

```python
from collections import deque
from typing import List

class Solution:
    def countCompleteComponents(self, n: int, edges: List[List[int]]) -> int:
        # Construir a lista de adjacência
        adj = [[] for _ in range(n)]
        for a, b in edges:
            adj[a].append(b)
            adj[b].append(a)
        
        visited = [False] * n
        components = []
        
        # Encontrar todos os componentes conectados usando BFS
        for i in range(n):
            if not visited[i]:
                queue = deque([i])
                visited[i] = True
                component = {i}
                while queue:
                    node = queue.popleft()
                    for neighbor in adj[node]:
                        if not visited[neighbor]:
                            visited[neighbor] = True
                            component.add(neighbor)
                            queue.append(neighbor)
                components.append(component)
        
        result = 0
        
        # Verificar se cada componente é completo
        for comp in components:
            m = len(comp)
            required_edges = m * (m - 1) // 2
            actual_edges = 0
            # Contar as arestas no componente
            for a, b in edges:
                if a in comp and b in comp:
                    actual_edges += 1
            if actual_edges == required_edges:
                result += 1
        
        return result
```

### Exemplos

#### Exemplo 1:
**Input**:  
```plaintext
n = 6
edges = [[0, 1], [0, 2], [1, 2], [3, 4]]
```
**Output**:  
```plaintext
3
```
**Explicação**:
1. Os componentes conectados são:
   - `{0, 1, 2}`: Completo, pois possui 3 vértices e 3 arestas (`3 * (3 - 1) / 2 = 3`).
   - `{3, 4}`: Completo, pois possui 2 vértices e 1 aresta (`2 * (2 - 1) / 2 = 1`).
   - `{5}`: Completo, pois possui apenas 1 vértice (nenhuma aresta é necessária).
2. O total de componentes completos é 3.

#### Exemplo 2:
**Input**:  
```plaintext
n = 6
edges = [[0, 1], [0, 2], [1, 2], [3, 4], [3, 5]]
```
**Output**:  
```plaintext
1
```
**Explicação**:
1. Os componentes conectados são:
   - `{0, 1, 2}`: Completo, pois possui 3 vértices e 3 arestas.
   - `{3, 4, 5}`: Não é completo, pois possui 3 vértices mas apenas 2 arestas (`3 * (3 - 1) / 2 = 3`).
2. O total de componentes completos é 1.

### Conclusão

A solução utiliza uma abordagem eficiente para identificar componentes conectados e verificar sua completude. Ao construir uma lista de adjacência e usar busca para explorar os componentes, garantimos que o problema seja resolvido em tempo linear em relação ao número de vértices e arestas. A complexidade de tempo \( O(V + E) \) torna a solução adequada para entradas razoáveis.

---

## [EN]

### The Problem

Given an undirected graph with `n` vertices numbered from 0 to `n - 1`, we want to determine the number of **completely connected components** in the graph. A connected component is said to be complete if there exists an edge between every pair of vertices within the component.

You are given:
- An integer `n` representing the number of vertices.
- A list of edges `edges`, where `edges[i] = [ai, bi]` indicates that there is an edge between vertices `ai` and `bi`.

Return the number of completely connected components in the graph.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Identification of Connected Components**: I used a BFS or DFS-based approach to identify all connected components in the graph. Each component is a subgraph where all vertices are interconnected by paths.

2. **Completeness Check**: For each connected component, I checked if it is complete. A component with `m` vertices is complete if it contains exactly `m * (m - 1) / 2` edges, which is the number of edges in a complete graph with `m` vertices.

3. **Edge Counting in a Component**: To verify completeness, I counted the number of edges present in the component and compared it with the expected value for a complete graph.

4. **Final Result**: After processing all components, I returned the total number of completely connected components.

### Complexity Analysis

- **Time complexity**:
  - Adjacency list construction: \( O(E) \), where \( E \) is the number of edges.
  - Search for connected components: \( O(V + E) \), where \( V \) is the number of vertices.
  - Completeness verification: \( O(E) \), as we need to iterate over all edges to count those belonging to each component.
  - Total: \( O(V + E) \).

- **Space complexity**: \( O(V + E) \), due to storage of the adjacency list and auxiliary structures.

### Code Solution

```python
from collections import deque
from typing import List

class Solution:
    def countCompleteComponents(self, n: int, edges: List[List[int]]) -> int:
        # Build adjacency list
        adj = [[] for _ in range(n)]
        for a, b in edges:
            adj[a].append(b)
            adj[b].append(a)
        
        visited = [False] * n
        components = []
        
        # Find all connected components using BFS
        for i in range(n):
            if not visited[i]:
                queue = deque([i])
                visited[i] = True
                component = {i}
                while queue:
                    node = queue.popleft()
                    for neighbor in adj[node]:
                        if not visited[neighbor]:
                            visited[neighbor] = True
                            component.add(neighbor)
                            queue.append(neighbor)
                components.append(component)
        
        result = 0
        
        # Check if each component is complete
        for comp in components:
            m = len(comp)
            required_edges = m * (m - 1) // 2
            actual_edges = 0
            # Count edges in the component
            for a, b in edges:
                if a in comp and b in comp:
                    actual_edges += 1
            if actual_edges == required_edges:
                result += 1
        
        return result
```

### Examples

#### Example 1:
**Input**:  
```plaintext
n = 6
edges = [[0, 1], [0, 2], [1, 2], [3, 4]]
```
**Output**:  
```plaintext
3
```
**Explanation**:
1. The connected components are:
   - `{0, 1, 2}`: Complete, as it has 3 vertices and 3 edges (`3 * (3 - 1) / 2 = 3`).
   - `{3, 4}`: Complete, as it has 2 vertices and 1 edge (`2 * (2 - 1) / 2 = 1`).
   - `{5}`: Complete, as it has only 1 vertex (no edges are needed).
2. The total number of complete components is 3.

#### Example 2:
**Input**:  
```plaintext
n = 6
edges = [[0, 1], [0, 2], [1, 2], [3, 4], [3, 5]]
```
**Output**:  
```plaintext
1
```
**Explanation**:
1. The connected components are:
   - `{0, 1, 2}`: Complete, as it has 3 vertices and 3 edges.
   - `{3, 4, 5}`: Not complete, as it has 3 vertices but only 2 edges (`3 * (3 - 1) / 2 = 3`).
2. The total number of complete components is 1.

### Conclusion

The solution uses an efficient approach to identify connected components and verify their completeness. By building an adjacency list and using search to explore components, we ensure the problem is solved in linear time relative to the number of vertices and edges. The time complexity \( O(V + E) \) makes the solution suitable for reasonable inputs.