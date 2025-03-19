## [PT/BR]

### O Problema

Dado um array binário `nums`, podemos realizar a seguinte operação qualquer número de vezes (possivelmente zero):

- Escolher quaisquer 3 elementos consecutivos do array e inverter todos eles. Inverter um elemento significa mudar seu valor de 0 para 1 ou de 1 para 0.

O objetivo é retornar o **número mínimo de operações** necessárias para transformar todos os elementos do array em 1. Se for impossível, retorne -1.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: A operação de inversão afeta 3 elementos consecutivos. Portanto, para transformar um 0 em 1, precisamos aplicar a operação de inversão em uma janela que inclua esse 0. No entanto, a operação também afeta os dois elementos à direita, o que pode criar novos 0s que precisam ser corrigidos.

2. **Abordagem eficiente**: Utilizei uma estratégia **gulosa** para processar o array da esquerda para a direita. Para cada elemento, se ele for 0 (considerando os efeitos das inversões anteriores), aplico a operação de inversão começando na posição atual. Isso garante que cada 0 seja corrigido à medida que avançamos no array.

3. **Rastreamento de inversões**: Usei uma **fila dupla (deque)** para rastrear as posições onde as inversões foram aplicadas. Isso permite gerenciar eficientemente o efeito das inversões anteriores no elemento atual.

4. **Verificação de impossibilidade**: Se a aplicação de uma inversão em uma posição levar a um índice fora dos limites do array, retorno -1, indicando que é impossível transformar todos os elementos em 1.

### Análise da Complexidade

- **Complexidade de tempo**: \( O(n) \), onde \( n \) é o comprimento do array. Isso ocorre porque processamos cada elemento uma única vez e as operações na deque são amortizadas \( O(1) \).
- **Complexidade de espaço**: \( O(n) \), devido ao uso da deque para rastrear as inversões.

### Solução em Código

```python
from collections import deque

class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        flips = deque()  # Deque para rastrear as posições das inversões
        result = 0  # Contador de operações
        
        for i in range(n):
            # Remove inversões que não afetam mais o elemento atual
            while flips and flips[0] + 2 < i:
                flips.popleft()
            
            # Calcula o valor atual do bit, considerando as inversões anteriores
            current_bit = nums[i] ^ (len(flips) % 2)
            
            if current_bit == 0:
                # Se a inversão for necessária, mas não for possível, retorna -1
                if i + 2 >= n:
                    return -1
                # Registra a inversão na posição atual
                flips.append(i)
                result += 1  # Incrementa o contador de operações
        
        return result
```

### Exemplos

#### Exemplo 1:
**Input**: nums = [0, 1, 1, 1, 0, 0]  
**Output**: 3  
**Explicação**:  
1. Aplicamos a inversão nos índices 0, 1 e 2. O array se torna [1, 0, 0, 1, 0, 0].  
2. Aplicamos a inversão nos índices 1, 2 e 3. O array se torna [1, 1, 1, 0, 0, 0].  
3. Aplicamos a inversão nos índices 3, 4 e 5. O array se torna [1, 1, 1, 1, 1, 1].  
- O número mínimo de operações é 3.

#### Exemplo 2:
**Input**: nums = [0, 1, 1, 1]  
**Output**: -1  
**Explicação**:  
- Não é possível aplicar a operação de inversão sem ultrapassar os limites do array.  
- Portanto, é impossível transformar todos os elementos em 1, e a resposta é -1.

### Conclusão

A solução é eficiente e utiliza uma estratégia gulosa para corrigir os 0s no array, aplicando inversões apenas quando necessário. Ao rastrear as inversões com uma deque, garantimos que o efeito das operações anteriores seja considerado corretamente. A complexidade de tempo \( O(n) \) torna a solução adequada para grandes entradas.

---

## [EN]

### The Problem

Given a binary array `nums`, we can perform the following operation any number of times (possibly zero):

- Choose any 3 consecutive elements from the array and flip all of them. Flipping an element means changing its value from 0 to 1 or from 1 to 0.

The goal is to return the **minimum number of operations** required to turn all elements of the array into 1s. If it is impossible, return -1.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: The flip operation affects 3 consecutive elements. Therefore, to turn a 0 into 1, we need to apply the flip operation on a window that includes that 0. However, the operation also affects the two elements to the right, which may create new 0s that need to be corrected.

2. **Efficient approach**: I used a **greedy strategy** to process the array from left to right. For each element, if it is 0 (considering the effects of previous flips), I apply the flip operation starting at the current position. This ensures that each 0 is corrected as we progress through the array.

3. **Flip tracking**: I used a **deque** to track the positions where flips have been applied. This allows efficient management of the effect of previous flips on the current element.

4. **Impossibility check**: If applying a flip at the current position would go out of bounds, I return -1, indicating that it is impossible to turn all elements into 1s.

### Complexity Analysis

- **Time complexity**: \( O(n) \), where \( n \) is the length of the array. This is because we process each element once, and the deque operations are amortized \( O(1) \).
- **Space complexity**: \( O(n) \), due to the use of the deque to track flips.

### Code Solution

```python
from collections import deque

class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        flips = deque()  # Deque to track flip positions
        result = 0  # Operation counter
        
        for i in range(n):
            # Remove flips that no longer affect the current element
            while flips and flips[0] + 2 < i:
                flips.popleft()
            
            # Calculate the current bit value, considering previous flips
            current_bit = nums[i] ^ (len(flips) % 2)
            
            if current_bit == 0:
                # If a flip is needed but not possible, return -1
                if i + 2 >= n:
                    return -1
                # Record the flip at the current position
                flips.append(i)
                result += 1  # Increment the operation counter
        
        return result
```

### Examples

#### Example 1:
**Input**: nums = [0, 1, 1, 1, 0, 0]  
**Output**: 3  
**Explanation**:  
1. Apply the flip at indices 0, 1, and 2. The array becomes [1, 0, 0, 1, 0, 0].  
2. Apply the flip at indices 1, 2, and 3. The array becomes [1, 1, 1, 0, 0, 0].  
3. Apply the flip at indices 3, 4, and 5. The array becomes [1, 1, 1, 1, 1, 1].  
- The minimum number of operations is 3.

#### Example 2:
**Input**: nums = [0, 1, 1, 1]  
**Output**: -1  
**Explanation**:  
- It is impossible to apply the flip operation without going out of bounds.  
- Therefore, it is impossible to turn all elements into 1s, and the answer is -1.

### Conclusion

The solution is efficient and uses a greedy strategy to correct 0s in the array, applying flips only when necessary. By tracking flips with a deque, we ensure that the effect of previous operations is correctly considered. The time complexity of \( O(n) \) makes the solution suitable for large inputs.