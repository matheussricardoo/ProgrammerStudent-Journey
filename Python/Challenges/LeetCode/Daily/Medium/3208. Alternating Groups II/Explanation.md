## [PT/BR]

### O Problema

Dado um círculo de blocos coloridos de vermelho e azul, representado por um array `colors` de inteiros, onde:
- `colors[i] == 0` significa que o bloco \( i \) é vermelho.
- `colors[i] == 1` significa que o bloco \( i \) é azul.

Além disso, é dado um inteiro \( k \), que representa o tamanho de um grupo de blocos consecutivos. Um grupo alternado é definido como \( k \) blocos consecutivos onde as cores dos blocos alternam entre vermelho e azul (ou seja, cada bloco no grupo, exceto o primeiro e o último, tem uma cor diferente de seus blocos adjacentes à esquerda e à direita).

Devido à natureza circular do array, o primeiro e o último bloco são considerados adjacentes.

Retorne o número de grupos alternados de tamanho \( k \).

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: Um grupo alternado de tamanho \( k \) requer que todos os \( k-1 \) pares de blocos consecutivos no grupo tenham cores diferentes. Isso significa que, para um grupo de \( k \) blocos, precisamos verificar se todos os \( k-1 \) pares consecutivos alternam entre vermelho e azul.

2. **Abordagem eficiente**: Utilizei a técnica de **janela deslizante** para verificar cada possível grupo de \( k \) blocos. Para lidar com a natureza circular do array, dupliquei o array de verificações de pares válidos, permitindo que a janela deslize de forma contínua.

3. **Implementação**:
   - Criei um array `valid` onde cada elemento indica se dois blocos consecutivos têm cores diferentes.
   - Dupliquei o array `valid` para tratar a circularidade do array original.
   - Usei uma janela deslizante de tamanho \( k-1 \) para contar quantos grupos de \( k \) blocos têm todos os \( k-1 \) pares consecutivos válidos.

4. **Otimização**: A abordagem é eficiente, com complexidade de tempo \( O(n) \), onde \( n \) é o comprimento do array `colors`.

### Análise da Complexidade

- **Complexidade de tempo**: \( O(n) \), pois percorremos o array uma única vez com a janela deslizante.
- **Complexidade de espaço**: \( O(n) \), devido ao uso do array `valid` e sua duplicação.

### Solução em Código

```python
class Solution:
    def numberOfAlternatingGroups(self, colors: List[int], k: int) -> int:
        n = len(colors)
        if k < 3 or k > n:
            return 0
        
        # Cria o array 'valid' onde cada elemento verifica se as cores consecutivas são diferentes
        valid = []
        for i in range(n):
            next_i = (i + 1) % n
            valid.append(1 if colors[i] != colors[next_i] else 0)
        
        window_size = k - 1
        doubled = valid * 2  # Trata a circularidade duplicando o array
        
        current_sum = sum(doubled[:window_size])  # Soma dos primeiros 'window_size' elementos
        count = 0
        
        # Desliza a janela pelo array
        for i in range(n):
            if current_sum == window_size:
                count += 1
            # Atualiza a soma removendo o elemento que sai e adicionando o que entra
            current_sum -= doubled[i]
            current_sum += doubled[i + window_size]
        
        return count
```

### Exemplos

#### Exemplo 1:
**Input**: colors = [0,1,0,1,0], k = 3  
**Output**: 3  
**Explicação**:  
- Os grupos alternados de tamanho 3 são:  
  1. [0,1,0] (índices 0,1,2)  
  2. [1,0,1] (índices 1,2,3)  
  3. [0,1,0] (índices 2,3,4)  
- Portanto, há 3 grupos alternados.

#### Exemplo 2:
**Input**: colors = [0,1,0,0,1,0,1], k = 6  
**Output**: 2  
**Explicação**:  
- Os grupos alternados de tamanho 6 são:  
  1. [0,1,0,0,1,0] (índices 0,1,2,3,4,5)  
  2. [1,0,0,1,0,1] (índices 1,2,3,4,5,6)  
- Portanto, há 2 grupos alternados.

#### Exemplo 3:
**Input**: colors = [1,1,0,1], k = 4  
**Output**: 0  
**Explicação**:  
- Não há grupos alternados de tamanho 4, pois não é possível ter 4 blocos consecutivos com cores alternadas.

### Conclusão

A solução é eficiente e utiliza a técnica de janela deslizante para contar os grupos alternados de tamanho \( k \). Ao tratar a circularidade do array e verificar os pares consecutivos, garantimos que o problema seja resolvido com complexidade de tempo \( O(n) \).

---

## [EN]

### The Problem

Given a circle of red and blue tiles, represented by an array `colors` of integers, where:
- `colors[i] == 0` means that tile \( i \) is red.
- `colors[i] == 1` means that tile \( i \) is blue.

Additionally, an integer \( k \) is given, representing the size of a group of consecutive tiles. An alternating group is defined as \( k \) consecutive tiles where the colors of the tiles alternate between red and blue (i.e., each tile in the group, except the first and last, has a different color from its left and right adjacent tiles).

Due to the circular nature of the array, the first and last tiles are considered adjacent.

Return the number of alternating groups of size \( k \).

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: An alternating group of size \( k \) requires that all \( k-1 \) pairs of consecutive tiles in the group have different colors. This means that, for a group of \( k \) tiles, we need to check if all \( k-1 \) consecutive pairs alternate between red and blue.

2. **Efficient approach**: I used the **sliding window** technique to check each possible group of \( k \) tiles. To handle the circular nature of the array, I doubled the array of valid pair checks, allowing the window to slide continuously.

3. **Implementation**:
   - Created a `valid` array where each element indicates whether two consecutive tiles have different colors.
   - Doubled the `valid` array to handle the circularity of the original array.
   - Used a sliding window of size \( k-1 \) to count how many groups of \( k \) tiles have all \( k-1 \) consecutive pairs valid.

4. **Optimization**: The approach is efficient, with a time complexity of \( O(n) \), where \( n \) is the length of the `colors` array.

### Complexity Analysis

- **Time complexity**: \( O(n) \), as we traverse the array once with the sliding window.
- **Space complexity**: \( O(n) \), due to the use of the `valid` array and its duplication.

### Code Solution

```python
class Solution:
    def numberOfAlternatingGroups(self, colors: List[int], k: int) -> int:
        n = len(colors)
        if k < 3 or k > n:
            return 0
        
        # Create the 'valid' array where each element checks if consecutive colors are different
        valid = []
        for i in range(n):
            next_i = (i + 1) % n
            valid.append(1 if colors[i] != colors[next_i] else 0)
        
        window_size = k - 1
        doubled = valid * 2  # Handle circularity by doubling the array
        
        current_sum = sum(doubled[:window_size])  # Sum of the first 'window_size' elements
        count = 0
        
        # Slide the window across the array
        for i in range(n):
            if current_sum == window_size:
                count += 1
            # Update the sum by removing the outgoing element and adding the incoming element
            current_sum -= doubled[i]
            current_sum += doubled[i + window_size]
        
        return count
```

### Examples

#### Example 1:
**Input**: colors = [0,1,0,1,0], k = 3  
**Output**: 3  
**Explanation**:  
- The alternating groups of size 3 are:  
  1. [0,1,0] (indices 0,1,2)  
  2. [1,0,1] (indices 1,2,3)  
  3. [0,1,0] (indices 2,3,4)  
- Therefore, there are 3 alternating groups.

#### Example 2:
**Input**: colors = [0,1,0,0,1,0,1], k = 6  
**Output**: 2  
**Explanation**:  
- The alternating groups of size 6 are:  
  1. [0,1,0,0,1,0] (indices 0,1,2,3,4,5)  
  2. [1,0,0,1,0,1] (indices 1,2,3,4,5,6)  
- Therefore, there are 2 alternating groups.

#### Example 3:
**Input**: colors = [1,1,0,1], k = 4  
**Output**: 0  
**Explanation**:  
- There are no alternating groups of size 4, as it is not possible to have 4 consecutive tiles with alternating colors.

### Conclusion

The solution is efficient and uses the sliding window technique to count the alternating groups of size \( k \). By handling the circularity of the array and checking consecutive pairs, we ensure the problem is solved with a time complexity of \( O(n) \).
