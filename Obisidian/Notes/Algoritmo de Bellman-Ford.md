#### **O que é?**

O **Algoritmo de Bellman-Ford** é um algoritmo que também encontra o caminho mais curto de um vértice inicial até todos os outros vértices em um grafo ponderado. Ele é mais robusto que o Dijkstra porque **suporta arestas com pesos negativos** , mas tem um custo computacional maior.

#### **Principais características:**

- **Entrada:** Um grafo ponderado G=(V,E), onde V é o conjunto de vértices e E é o conjunto de arestas, com pesos que podem ser positivos ou negativos.
- **Saída:** As distâncias mínimas do vértice inicial até todos os outros vértices.
- **Capacidade:** Detecta ciclos de peso negativo no grafo (caso existam).

#### **Como funciona?**

1. Inicialize as distâncias:
    - A distância do vértice inicial para ele mesmo é 0.
    - A distância para todos os outros vértices é inicializada como infinito (∞).
2. Relaxe todas as arestas ∣V∣−1 vezes:
    - Para cada aresta (u,v), verifique se a distância para v pode ser reduzida passando por u. Se sim, atualize a distância.
3. Após ∣V∣−1 iterações, verifique novamente todas as arestas:
    - Se ainda for possível reduzir alguma distância, significa que há um ciclo de peso negativo no grafo.

#### **Complexidade:**

- **Tempo:** O(V⋅E), onde V é o número de vértices e E é o número de arestas.
- **Espaço:** O(V), pois armazena as distâncias para todos os vértices.

#### **Exemplo de Aplicação:**

- Sistemas financeiros: Detectar oportunidades de arbitragem em mercados de câmbio (onde as taxas de conversão podem ser modeladas como pesos negativos).
- Redes de transporte: Encontrar rotas ótimas em sistemas onde alguns trechos podem ter custos negativos (ex.: descontos ou incentivos).

#### **Limitações:**

- É mais lento que o Dijkstra em grafos grandes, especialmente quando há muitas arestas.
- Requer mais iterações para garantir a correção, mesmo em grafos sem ciclos negativos.