## [PT/BR]

### O Problema

Dado um número inteiro positivo \( n \), precisamos determinar o número de células coloridas em uma grade infinita após \( n \) minutos. A grade começa com uma única célula colorida, e a cada minuto, todas as células não coloridas que são adjacentes a qualquer célula colorida também são coloridas.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: A expansão das células coloridas forma um padrão em camadas, onde cada camada adicionada a cada minuto segue uma sequência aritmética. Observando o padrão, podemos derivar uma fórmula matemática para calcular o número total de células coloridas após \( n \) minutos.

2. **Padrão de Expansão**:
   - Após 1 minuto, há 1 célula colorida.
   - Após 2 minutos, há 5 células coloridas (1 + 4).
   - Após 3 minutos, há 13 células coloridas (5 + 8).
   - A cada minuto, o número de novas células coloridas aumenta em 4.

3. **Fórmula Matemática**: O número total de células coloridas após \( n \) minutos pode ser calculado pela fórmula \( 2n(n-1) + 1 \). Essa fórmula é derivada da soma da sequência aritmética que representa as células adicionadas a cada minuto.

4. **Implementação**: Utilizamos a fórmula diretamente para calcular o resultado, evitando a necessidade de simular a expansão minuto a minuto.

### Análise da Complexidade

- **Complexidade de tempo**: \( O(1) \), pois a fórmula calcula o resultado diretamente.
- **Complexidade de espaço**: \( O(1) \), pois usamos apenas algumas variáveis para armazenar o resultado.

### Solução em Código

```python
class Solution:
    def coloredCells(self, n: int) -> int:
        return 2 * n * (n - 1) + 1
```

### Exemplos

#### Exemplo 1:
**Input**: n = 1  
**Output**: 1  
**Explicação**: Após 1 minuto, apenas 1 célula está colorida.  
Cálculo: \( 2 \times 1 \times (1 - 1) + 1 = 1 \).

#### Exemplo 2:
**Input**: n = 2  
**Output**: 5  
**Explicação**: Após 2 minutos, há 5 células coloridas (1 no centro e 4 nas bordas).  
Cálculo: \( 2 \times 2 \times (2 - 1) + 1 = 5 \).

#### Exemplo 3:
**Input**: n = 3  
**Output**: 13  
**Explicação**: Após 3 minutos, há 13 células coloridas.  
Cálculo: \( 2 \times 3 \times (3 - 1) + 1 = 13 \).

### Conclusão

A solução é eficiente e utiliza uma abordagem matemática para calcular o número de células coloridas após \( n \) minutos. Ao derivar a fórmula \( 2n(n-1) + 1 \), evitamos a necessidade de simular a expansão minuto a minuto, garantindo um desempenho ótimo.

---

## [EN]

### The Problem

Given a positive integer \( n \), we need to determine the number of colored cells on an infinite grid after \( n \) minutes. The grid starts with a single colored cell, and every minute, all uncolored cells adjacent to any colored cell are also colored.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: The expansion of colored cells forms a layered pattern, where each layer added every minute follows an arithmetic sequence. By observing the pattern, we can derive a mathematical formula to calculate the total number of colored cells after \( n \) minutes.

2. **Expansion Pattern**:
   - After 1 minute, there is 1 colored cell.
   - After 2 minutes, there are 5 colored cells (1 + 4).
   - After 3 minutes, there are 13 colored cells (5 + 8).
   - Each minute, the number of new colored cells increases by 4.

3. **Mathematical Formula**: The total number of colored cells after \( n \) minutes can be calculated using the formula \( 2n(n-1) + 1 \). This formula is derived from the sum of the arithmetic sequence representing the cells added each minute.

4. **Implementation**: We use the formula directly to compute the result, avoiding the need to simulate the expansion minute by minute.

### Complexity Analysis

- **Time complexity**: \( O(1) \), as the formula computes the result directly.
- **Space complexity**: \( O(1) \), as we only use a few variables to store the result.

### Code Solution

```python
class Solution:
    def coloredCells(self, n: int) -> int:
        return 2 * n * (n - 1) + 1
```

### Examples

#### Example 1:
**Input**: n = 1  
**Output**: 1  
**Explanation**: After 1 minute, only 1 cell is colored.  
Calculation: \( 2 \times 1 \times (1 - 1) + 1 = 1 \).

#### Example 2:
**Input**: n = 2  
**Output**: 5  
**Explanation**: After 2 minutes, there are 5 colored cells (1 in the center and 4 on the edges).  
Calculation: \( 2 \times 2 \times (2 - 1) + 1 = 5 \).

#### Example 3:
**Input**: n = 3  
**Output**: 13  
**Explanation**: After 3 minutes, there are 13 colored cells.  
Calculation: \( 2 \times 3 \times (3 - 1) + 1 = 13 \).

### Conclusion

The solution is efficient and uses a mathematical approach to calculate the number of colored cells after \( n \) minutes. By deriving the formula \( 2n(n-1) + 1 \), we avoid the need to simulate the expansion minute by minute, ensuring optimal performance.