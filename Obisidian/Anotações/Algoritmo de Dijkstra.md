#### **O que é?**

O **Algoritmo de Dijkstra** é um algoritmo guloso usado para encontrar o caminho mais curto de um vértice inicial (chamado de "fonte") até todos os outros vértices em um grafo ponderado **com pesos não negativos** .

#### **Principais características:**

- **Entrada:** Um grafo ponderado G=(V,E), onde V é o conjunto de vértices e E é o conjunto de arestas, com pesos w(u,v)≥0.
- **Saída:** As distâncias mínimas do vértice inicial até todos os outros vértices.
- **Restrição:** Não funciona corretamente se houver arestas com pesos negativos.

#### **Como funciona?**

1. Inicialize as distâncias:
    - A distância do vértice inicial para ele mesmo é 0.
    - A distância para todos os outros vértices é inicializada como infinito (∞).
2. Use uma fila de prioridade (geralmente implementada com um heap mínimo) para selecionar o vértice com a menor distância atual.
3. Para o vértice selecionado, relaxe todas as suas arestas adjacentes:
    - Se a distância atual para um vértice vizinho pode ser reduzida passando pelo vértice atual, atualize a distância.
4. Repita o processo até que todos os vértices tenham sido processados.

#### **Complexidade:**

- **Com lista de adjacência e heap mínimo:** O((V+E)logV), onde V é o número de vértices e E é o número de arestas.
- **Sem heap (implementação simples):** O(V2).

#### **Exemplo de Aplicação:**

- Navegação GPS: Encontrar o caminho mais curto entre duas cidades em um mapa rodoviário.
- Redes de computadores: Determinar a rota mais eficiente para enviar pacotes de dados.

#### **Limitações:**

- Não funciona com grafos que contêm arestas com pesos negativos.
- Pode ser ineficiente em grafos densos (muitas arestas).