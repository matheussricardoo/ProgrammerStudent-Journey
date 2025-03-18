## [PT/BR]

### O Problema

Dado um array `nums` de inteiros positivos, definimos um subarray como "nice" (agradável) se o AND bit a bit de cada par de elementos em posições diferentes no subarray for igual a 0.

O objetivo é retornar o comprimento do subarray "nice" mais longo.

Observação: Subarrays de comprimento 1 sempre são considerados "nice".

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: Para que um subarray seja "nice", qualquer par de elementos em posições diferentes deve ter AND bit a bit igual a 0. Isso significa que não podem ter bits 1 em posições comuns em sua representação binária.

2. **Abordagem eficiente**: Utilizei a técnica de janela deslizante, mantendo um conjunto de bits já usados na janela atual. Quando um novo número é adicionado, verifico se ele tem algum bit em comum com os bits já usados.

3. **Implementação**:
   - Usei uma variável `used_bits` para rastrear quais bits já estão sendo usados no subarray atual.
   - Se um novo número tiver bits em comum com `used_bits`, reduzo a janela pela esquerda até eliminar o conflito.
   - Mantenho o comprimento máximo encontrado durante o processo.

4. **Otimização**: A abordagem é eficiente, com complexidade de tempo O(n), onde n é o número de elementos no array.

### Análise da Complexidade

- **Complexidade de tempo**: O(n), pois cada elemento é processado no máximo duas vezes (uma vez pelo ponteiro direito e uma vez pelo ponteiro esquerdo).
- **Complexidade de espaço**: O(1), utilizamos apenas algumas variáveis para rastrear o estado atual.

### Solução em Código

```python
def longestNiceSubarray(self, nums: List[int]) -> int:
    max_length = 1  # Comprimento mínimo é 1 (subarrays de tamanho 1 são sempre "nice")
    used_bits = 0   # Rastreia quais bits estão sendo usados na janela atual
    left = 0        # Ponteiro esquerdo da janela deslizante
    
    for right in range(len(nums)):
        # Enquanto o número atual tem bits que se sobrepõem aos nossos bits usados
        while left < right and (used_bits & nums[right]) != 0:
            # Remove os bits do número mais à esquerda
            used_bits ^= nums[left]
            left += 1
        
        # Adiciona os bits do número atual aos nossos bits usados
        used_bits |= nums[right]
        
        # Atualiza o comprimento máximo
        max_length = max(max_length, right - left + 1)
    
    return max_length
```

### Exemplos

#### Exemplo 1:
**Input**: nums = [1, 3, 8, 48, 10]  
**Output**: 3  
**Explicação**:  
- O subarray "nice" mais longo é [3, 8, 48].
- 3 AND 8 = 0 (011 & 1000 = 0).
- 3 AND 48 = 0 (011 & 110000 = 0).
- 8 AND 48 = 0 (1000 & 110000 = 0).
- Não é possível obter um subarray "nice" maior, portanto retornamos 3.

#### Exemplo 2:
**Input**: nums = [3, 1, 5, 11, 13]  
**Output**: 1  
**Explicação**:  
- Não é possível formar um subarray "nice" com mais de um elemento.
- Qualquer subarray de comprimento 1 é sempre considerado "nice".
- Portanto, a resposta é 1.

### Conclusão

A solução utiliza eficientemente o conceito de janela deslizante para encontrar o subarray "nice" mais longo. Ao manter um registro dos bits já utilizados e ajustar a janela quando necessário, conseguimos identificar o subarray onde todos os pares de elementos têm AND bit a bit igual a zero. A complexidade de tempo O(n) torna a solução adequada para os limites do problema.

---

## [EN]

### The Problem

Given an array `nums` of positive integers, we define a subarray as "nice" if the bitwise AND of every pair of elements in different positions in the subarray is equal to 0.

The goal is to return the length of the longest "nice" subarray.

Note: Subarrays of length 1 are always considered "nice".

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: For a subarray to be "nice", any pair of elements in different positions must have a bitwise AND equal to 0. This means they cannot have any overlapping 1-bits in their binary representation.

2. **Efficient approach**: I used a sliding window technique, keeping track of which bits are already used in the current window. When a new number is added, I check if it has any bits in common with the already used bits.

3. **Implementation**:
   - I used a variable `used_bits` to track which bits are already being used in the current subarray.
   - If a new number has bits in common with `used_bits`, I shrink the window from the left until the conflict is eliminated.
   - I keep track of the maximum length found during the process.

4. **Optimization**: The approach is efficient, with a time complexity of O(n), where n is the number of elements in the array.

### Complexity Analysis

- **Time complexity**: O(n), as each element is processed at most twice (once by the right pointer and once by the left pointer).
- **Space complexity**: O(1), as we only use a few variables to track the current state.

### Code Solution

```python
def longestNiceSubarray(self, nums: List[int]) -> int:
    max_length = 1  # Minimum length is 1 (subarrays of length 1 are always nice)
    used_bits = 0   # Track which bits are used in current window
    left = 0        # Left pointer of sliding window
    
    for right in range(len(nums)):
        # While the current number has bits that overlap with our used bits
        while left < right and (used_bits & nums[right]) != 0:
            # Remove leftmost number's bits from our used bits
            used_bits ^= nums[left]
            left += 1
        
        # Add current number's bits to our used bits
        used_bits |= nums[right]
        
        # Update max length
        max_length = max(max_length, right - left + 1)
    
    return max_length
```

### Examples

#### Example 1:
**Input**: nums = [1, 3, 8, 48, 10]  
**Output**: 3  
**Explanation**:  
- The longest nice subarray is [3, 8, 48].
- 3 AND 8 = 0 (011 & 1000 = 0).
- 3 AND 48 = 0 (011 & 110000 = 0).
- 8 AND 48 = 0 (1000 & 110000 = 0).
- It can be proven that no longer nice subarray can be obtained, so we return 3.

#### Example 2:
**Input**: nums = [3, 1, 5, 11, 13]  
**Output**: 1  
**Explanation**:  
- It is not possible to form a nice subarray with more than one element.
- Any subarray of length 1 is always considered nice.
- Therefore, the answer is 1.

### Conclusion

The solution efficiently uses the sliding window concept to find the longest nice subarray. By keeping track of the bits already used and adjusting the window as needed, we can identify the subarray where all pairs of elements have a bitwise AND equal to zero. The O(n) time complexity makes the solution suitable for the problem constraints.