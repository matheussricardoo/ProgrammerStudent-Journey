## [PT/BR]

### O Problema

Dada uma string `blocks` de comprimento \( n \), onde cada caractere `blocks[i]` é 'W' ou 'B', representando a cor do bloco na posição \( i \) (branco ou preto, respectivamente), e um inteiro \( k \), que representa o número desejado de blocos pretos consecutivos, precisamos determinar o número mínimo de operações necessárias para obter pelo menos \( k \) blocos pretos consecutivos. Cada operação consiste em recolocar um bloco branco ('W') para preto ('B').

Retorne o número mínimo de operações necessárias.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: Precisamos encontrar uma janela de tamanho \( k \) na string `blocks` que contenha o menor número possível de blocos brancos ('W'). Isso porque cada 'W' na janela precisa ser convertido em 'B' para que a janela contenha \( k \) blocos pretos consecutivos.

2. **Abordagem eficiente**: Utilizei a técnica de **janela deslizante** para percorrer a string e calcular o número de 'W's em cada janela de tamanho \( k \). A cada passo, a janela é deslocada para a direita, e o número de 'W's é atualizado subtraindo o 'W' que saiu da janela e adicionando o 'W' que entrou.

3. **Implementação**:
   - Inicializei o número de 'W's na primeira janela de tamanho \( k \).
   - Usei um loop para deslizar a janela pela string, atualizando o número de 'W's a cada passo.
   - Mantive o controle do menor número de 'W's encontrado em qualquer janela, que corresponde ao número mínimo de operações necessárias.

4. **Otimização**: A abordagem é eficiente, com complexidade de tempo \( O(n) \), onde \( n \) é o comprimento da string `blocks`.

### Análise da Complexidade

- **Complexidade de tempo**: \( O(n) \), pois percorremos a string uma única vez com a janela deslizante.
- **Complexidade de espaço**: \( O(1) \), pois usamos apenas algumas variáveis para armazenar o número de 'W's e o mínimo encontrado.

### Solução em Código

```python
class Solution:
    def minimumRecolors(self, blocks: str, k: int) -> int:
        n = len(blocks)
        # Conta o número de 'W's na primeira janela de tamanho k
        current_w = sum(1 for c in blocks[:k] if c == 'W')
        min_w = current_w  # Inicializa o mínimo com o valor da primeira janela
        
        # Desliza a janela pela string
        for i in range(1, n - k + 1):
            # Bloco que sai da janela
            outgoing = blocks[i - 1]
            # Bloco que entra na janela
            incoming = blocks[i + k - 1]
            
            # Atualiza o número de 'W's na janela
            if outgoing == 'W':
                current_w -= 1
            if incoming == 'W':
                current_w += 1
            
            # Atualiza o mínimo de 'W's encontrado
            if current_w < min_w:
                min_w = current_w
        
        return min_w
```

### Exemplos

#### Exemplo 1:
**Input**: blocks = "WBBWWBBWBW", k = 7  
**Output**: 3  
**Explicação**:  
- A janela de tamanho 7 com o menor número de 'W's é "BBWWBBW", que contém 3 'W's.  
- Portanto, são necessárias 3 operações para converter esses 'W's em 'B's e obter 7 blocos pretos consecutivos.

#### Exemplo 2:
**Input**: blocks = "WBWBBBW", k = 2  
**Output**: 0  
**Explicação**:  
- Já existe uma janela de tamanho 2 com 0 'W's ("BB").  
- Nenhuma operação é necessária.

### Conclusão

A solução é eficiente e utiliza a técnica de janela deslizante para encontrar o número mínimo de operações necessárias. Ao percorrer a string uma única vez e atualizar o número de 'W's em cada janela, garantimos que o problema seja resolvido com complexidade de tempo \( O(n) \).

---

## [EN]

### The Problem

Given a string `blocks` of length \( n \), where each character `blocks[i]` is either 'W' or 'B' (representing white or black blocks, respectively), and an integer \( k \), which is the desired number of consecutive black blocks, we need to determine the minimum number of operations required to obtain at least \( k \) consecutive black blocks. Each operation consists of recoloring a white block ('W') to black ('B').

Return the minimum number of operations needed.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: We need to find a window of size \( k \) in the string `blocks` that contains the smallest number of white blocks ('W'). This is because each 'W' in the window needs to be converted to 'B' to achieve \( k \) consecutive black blocks.

2. **Efficient approach**: I used the **sliding window** technique to traverse the string and calculate the number of 'W's in each window of size \( k \). At each step, the window is shifted to the right, and the number of 'W's is updated by subtracting the 'W' that left the window and adding the 'W' that entered.

3. **Implementation**:
   - I initialized the number of 'W's in the first window of size \( k \).
   - I used a loop to slide the window across the string, updating the number of 'W's at each step.
   - I kept track of the smallest number of 'W's found in any window, which corresponds to the minimum number of operations needed.

4. **Optimization**: The approach is efficient, with a time complexity of \( O(n) \), where \( n \) is the length of the string `blocks`.

### Complexity Analysis

- **Time complexity**: \( O(n) \), as we traverse the string once with the sliding window.
- **Space complexity**: \( O(1) \), as we only use a few variables to store the number of 'W's and the minimum found.

### Code Solution

```python
class Solution:
    def minimumRecolors(self, blocks: str, k: int) -> int:
        n = len(blocks)
        # Count the number of 'W's in the first window of size k
        current_w = sum(1 for c in blocks[:k] if c == 'W')
        min_w = current_w  # Initialize the minimum with the value of the first window
        
        # Slide the window across the string
        for i in range(1, n - k + 1):
            # Block that leaves the window
            outgoing = blocks[i - 1]
            # Block that enters the window
            incoming = blocks[i + k - 1]
            
            # Update the number of 'W's in the window
            if outgoing == 'W':
                current_w -= 1
            if incoming == 'W':
                current_w += 1
            
            # Update the minimum number of 'W's found
            if current_w < min_w:
                min_w = current_w
        
        return min_w
```

### Examples

#### Example 1:
**Input**: blocks = "WBBWWBBWBW", k = 7  
**Output**: 3  
**Explanation**:  
- The window of size 7 with the smallest number of 'W's is "BBWWBBW", which contains 3 'W's.  
- Therefore, 3 operations are needed to convert these 'W's to 'B's and achieve 7 consecutive black blocks.

#### Example 2:
**Input**: blocks = "WBWBBBW", k = 2  
**Output**: 0  
**Explanation**:  
- There is already a window of size 2 with 0 'W's ("BB").  
- No operations are needed.

### Conclusion

The solution is efficient and uses the sliding window technique to find the minimum number of operations needed. By traversing the string once and updating the number of 'W's in each window, we ensure the problem is solved with a time complexity of \( O(n) \).