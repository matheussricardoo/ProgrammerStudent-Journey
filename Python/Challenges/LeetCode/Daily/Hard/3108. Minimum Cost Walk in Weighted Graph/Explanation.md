## [PT/BR]

### O Problema

Dado um grafo não direcionado com `n` vértices numerados de 0 a `n - 1`, onde cada aresta possui um peso associado, queremos calcular o custo mínimo de uma caminhada entre dois vértices. O custo de uma caminhada é definido como o **bitwise AND** dos pesos das arestas percorridas.

Você recebe:
- Um inteiro `n` representando o número de vértices.
- Uma lista de arestas `edges`, onde `edges[i] = [ui, vi, wi]` indica que há uma aresta entre os vértices `ui` e `vi` com peso `wi`.
- Uma lista de consultas `query`, onde `query[i] = [si, ti]` representa uma consulta para encontrar o custo mínimo da caminhada entre os vértices `si` e `ti`.

Se não houver nenhuma caminhada possível entre `si` e `ti`, retorne `-1` para essa consulta.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Conexão entre vértices**: Para que exista uma caminhada entre dois vértices, eles devem estar na mesma componente conexa do grafo. Utilizei uma estrutura **Disjoint Set Union (DSU)** para identificar as componentes conexas do grafo.

2. **Propriedade do bitwise AND**: O custo de uma caminhada em uma componente conexa é determinado pelo **bitwise AND** de todos os pesos das arestas dessa componente. Isso ocorre porque o operador bitwise AND entre números só pode diminuir ou manter o valor, nunca aumentá-lo. Portanto, o custo mínimo de qualquer caminhada em uma componente é o AND de todos os pesos das arestas da componente.

3. **Pré-processamento**: Após identificar as componentes conexas, calculei o **bitwise AND** de todas as arestas pertencentes a cada componente e armazenei esse valor em um dicionário. Esse pré-processamento permite responder rapidamente às consultas.

4. **Processamento das consultas**: Para cada consulta `[si, ti]`, verifiquei se `si` e `ti` estão na mesma componente conexa. Se estiverem, retornei o valor pré-computado do bitwise AND da componente. Caso contrário, retornei `-1`.

### Análise da Complexidade

- **Complexidade de tempo**:
  - Construção da DSU: \( O(E \cdot \alpha(n)) \), onde \( E \) é o número de arestas e \( \alpha(n) \) é a função inversa de Ackermann (praticamente constante para entradas razoáveis).
  - Pré-processamento do bitwise AND: \( O(E) \), pois iteramos sobre todas as arestas.
  - Processamento das consultas: \( O(Q \cdot \alpha(n)) \), onde \( Q \) é o número de consultas.
  - Total: \( O(E + Q \cdot \alpha(n)) \).

- **Complexidade de espaço**: \( O(n + E) \), devido ao armazenamento da DSU e das arestas.

### Solução em Código

```python
from collections import defaultdict

class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [1] * n
    
    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]
    
    def union(self, x, y):
        x_root = self.find(x)
        y_root = self.find(y)
        if x_root == y_root:
            return
        if self.rank[x_root] < self.rank[y_root]:
            self.parent[x_root] = y_root
        else:
            self.parent[y_root] = x_root
            if self.rank[x_root] == self.rank[y_root]:
                self.rank[x_root] += 1

class Solution:
    def minimumCost(self, n: int, edges: List[List[int]], query: List[List[int]]) -> List[int]:
        dsu = DSU(n)
        
        # União das arestas
        for u, v, w in edges:
            dsu.union(u, v)
        
        # Agrupar arestas por componente
        edges_dict = defaultdict(list)
        for u, v, w in edges:
            root = dsu.find(u)
            edges_dict[root].append(w)
        
        # Calcular o bitwise AND para cada componente
        component_and = {}
        for root in edges_dict:
            and_val = edges_dict[root][0]
            for w in edges_dict[root][1:]:
                and_val &= w
            component_and[root] = and_val
        
        # Processar as consultas
        answer = []
        for s, t in query:
            s_root = dsu.find(s)
            t_root = dsu.find(t)
            if s_root != t_root:
                answer.append(-1)
            else:
                answer.append(component_and[s_root])
        
        return answer
```

### Exemplos

#### Exemplo 1:
**Input**:  
```plaintext
n = 5
edges = [[0, 1, 7], [1, 3, 7], [1, 2, 1]]
query = [[0, 3], [3, 4]]
```
**Output**:  
```plaintext
[1, -1]
```
**Explicação**:
1. Para a consulta `[0, 3]`, os vértices 0 e 3 estão na mesma componente conexa. O bitwise AND de todas as arestas na componente é `7 & 7 & 1 = 1`. Portanto, o custo mínimo é 1.
2. Para a consulta `[3, 4]`, os vértices 3 e 4 estão em componentes diferentes. Não há caminhada possível, então o resultado é `-1`.

#### Exemplo 2:
**Input**:  
```plaintext
n = 3
edges = [[0, 2, 7], [0, 1, 15], [1, 2, 6], [1, 2, 1]]
query = [[1, 2]]
```
**Output**:  
```plaintext
[0]
```
**Explicação**:
1. Para a consulta `[1, 2]`, os vértices 1 e 2 estão na mesma componente conexa. O bitwise AND de todas as arestas na componente é `15 & 6 & 1 = 0`. Portanto, o custo mínimo é 0.

### Conclusão

A solução utiliza uma abordagem eficiente baseada em DSU para identificar componentes conexas e pré-processar o bitwise AND de suas arestas. Isso permite responder rapidamente às consultas, garantindo um desempenho adequado mesmo para grandes entradas. A complexidade de tempo \( O(E + Q \cdot \alpha(n)) \) torna a solução escalável.

---

## [EN]

### The Problem

Given an undirected graph with `n` vertices numbered from 0 to `n - 1`, where each edge has an associated weight, we want to compute the minimum cost of a walk between two vertices. The cost of a walk is defined as the **bitwise AND** of the weights of the edges traversed.

You are given:
- An integer `n` representing the number of vertices.
- A list of edges `edges`, where `edges[i] = [ui, vi, wi]` indicates that there is an edge between vertices `ui` and `vi` with weight `wi`.
- A list of queries `query`, where `query[i] = [si, ti]` represents a query to find the minimum cost of a walk between vertices `si` and `ti`.

If there is no walk possible between `si` and `ti`, return `-1` for that query.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Vertex connectivity**: For a walk to exist between two vertices, they must belong to the same connected component of the graph. I used a **Disjoint Set Union (DSU)** structure to identify connected components.

2. **Bitwise AND property**: The cost of a walk within a connected component is determined by the **bitwise AND** of all edge weights in that component. This is because the bitwise AND operation can only decrease or maintain the value, never increase it. Therefore, the minimum cost of any walk in a component is the AND of all edge weights in that component.

3. **Preprocessing**: After identifying connected components, I computed the **bitwise AND** of all edges belonging to each component and stored the result in a dictionary. This preprocessing allows queries to be answered quickly.

4. **Query processing**: For each query `[si, ti]`, I checked if `si` and `ti` are in the same connected component. If they are, I returned the precomputed bitwise AND value for that component. Otherwise, I returned `-1`.

### Complexity Analysis

- **Time complexity**:
  - DSU construction: \( O(E \cdot \alpha(n)) \), where \( E \) is the number of edges and \( \alpha(n) \) is the inverse Ackermann function (practically constant for reasonable inputs).
  - Preprocessing bitwise AND: \( O(E) \), as we iterate over all edges.
  - Query processing: \( O(Q \cdot \alpha(n)) \), where \( Q \) is the number of queries.
  - Total: \( O(E + Q \cdot \alpha(n)) \).

- **Space complexity**: \( O(n + E) \), due to storage of DSU and edges.

### Code Solution

```python
from collections import defaultdict

class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [1] * n
    
    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]
    
    def union(self, x, y):
        x_root = self.find(x)
        y_root = self.find(y)
        if x_root == y_root:
            return
        if self.rank[x_root] < self.rank[y_root]:
            self.parent[x_root] = y_root
        else:
            self.parent[y_root] = x_root
            if self.rank[x_root] == self.rank[y_root]:
                self.rank[x_root] += 1

class Solution:
    def minimumCost(self, n: int, edges: List[List[int]], query: List[List[int]]) -> List[int]:
        dsu = DSU(n)
        
        # Union of edges
        for u, v, w in edges:
            dsu.union(u, v)
        
        # Group edges by component
        edges_dict = defaultdict(list)
        for u, v, w in edges:
            root = dsu.find(u)
            edges_dict[root].append(w)
        
        # Compute bitwise AND for each component
        component_and = {}
        for root in edges_dict:
            and_val = edges_dict[root][0]
            for w in edges_dict[root][1:]:
                and_val &= w
            component_and[root] = and_val
        
        # Process queries
        answer = []
        for s, t in query:
            s_root = dsu.find(s)
            t_root = dsu.find(t)
            if s_root != t_root:
                answer.append(-1)
            else:
                answer.append(component_and[s_root])
        
        return answer
```

### Examples

#### Example 1:
**Input**:  
```plaintext
n = 5
edges = [[0, 1, 7], [1, 3, 7], [1, 2, 1]]
query = [[0, 3], [3, 4]]
```
**Output**:  
```plaintext
[1, -1]
```
**Explanation**:
1. For the query `[0, 3]`, vertices 0 and 3 are in the same connected component. The bitwise AND of all edges in the component is `7 & 7 & 1 = 1`. Thus, the minimum cost is 1.
2. For the query `[3, 4]`, vertices 3 and 4 are in different components. No walk is possible, so the result is `-1`.

#### Example 2:
**Input**:  
```plaintext
n = 3
edges = [[0, 2, 7], [0, 1, 15], [1, 2, 6], [1, 2, 1]]
query = [[1, 2]]
```
**Output**:  
```plaintext
[0]
```
**Explanation**:
1. For the query `[1, 2]`, vertices 1 and 2 are in the same connected component. The bitwise AND of all edges in the component is `15 & 6 & 1 = 0`. Thus, the minimum cost is 0.

### Conclusion

The solution uses an efficient approach based on DSU to identify connected components and preprocess the bitwise AND of their edges. This allows queries to be answered quickly, ensuring scalability even for large inputs. The time complexity \( O(E + Q \cdot \alpha(n)) \) makes the solution suitable for large datasets.