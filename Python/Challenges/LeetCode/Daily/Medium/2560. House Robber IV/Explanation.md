## [PT/BR]

### O Problema

Existem várias casas consecutivas ao longo de uma rua, cada uma com uma determinada quantia de dinheiro. Um ladrão deseja roubar dinheiro dessas casas, mas ele se recusa a roubar de casas adjacentes. A **capacidade** do ladrão é definida como a maior quantia de dinheiro que ele rouba de uma única casa entre todas as casas que ele roubou.

Dado um array `nums`, onde `nums[i]` representa a quantia de dinheiro na \( i \)-ésima casa, e um inteiro \( k \), que representa o número mínimo de casas que o ladrão deve roubar, precisamos determinar a **menor capacidade possível** que o ladrão pode ter ao roubar pelo menos \( k \) casas, sem roubar casas adjacentes.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: Precisamos encontrar a menor capacidade possível (ou seja, o menor valor máximo que o ladrão pode roubar de uma única casa) que permita ao ladrão roubar pelo menos \( k \) casas, sem roubar casas adjacentes.

2. **Abordagem eficiente**: Utilizei a **busca binária** para determinar a menor capacidade possível. A busca binária é aplicada no intervalo de valores possíveis para a capacidade (ou seja, entre o menor e o maior valor no array `nums`).

3. **Verificação de viabilidade**: Para cada candidato de capacidade durante a busca binária, verifiquei se é possível roubar pelo menos \( k \) casas sem roubar casas adjacentes, onde o valor de cada casa roubada é menor ou igual ao candidato de capacidade. Isso foi feito usando uma abordagem de **programação dinâmica** para contar o número máximo de casas que podem ser roubadas sem violar a restrição de não roubar casas adjacentes.

4. **Otimização**: A busca binária garante uma complexidade de tempo \( O(\log(\text{max\_value})) \), e a verificação de viabilidade é feita em \( O(n) \), resultando em uma complexidade total de \( O(n \log(\text{max\_value})) \).

### Análise da Complexidade

- **Complexidade de tempo**: \( O(n \log(\text{max\_value})) \), onde \( n \) é o número de casas e \( \text{max\_value} \) é o maior valor no array `nums`.
- **Complexidade de espaço**: \( O(1) \), pois usamos apenas algumas variáveis para armazenar os resultados intermediários.

### Solução em Código

```python
class Solution:
    def minCapability(self, nums: List[int], k: int) -> int:
        left = min(nums)  # Menor valor possível para a capacidade
        right = max(nums)  # Maior valor possível para a capacidade
        ans = right  # Inicializa a resposta com o maior valor possível
        
        while left <= right:
            mid = (left + right) // 2  # Candidato de capacidade
            prev_prev, prev = 0, 0  # Variáveis para rastrear casas roubadas
            for num in nums:
                if num <= mid:
                    # Se a casa pode ser roubada, atualiza o contador
                    current = max(prev, prev_prev + 1)
                else:
                    # Caso contrário, mantém o contador anterior
                    current = prev
                prev_prev, prev = prev, current  # Atualiza as variáveis
            
            # Verifica se é possível roubar pelo menos k casas
            if prev >= k:
                ans = mid  # Atualiza a resposta
                right = mid - 1  # Tenta um valor menor para a capacidade
            else:
                left = mid + 1  # Tenta um valor maior para a capacidade
        
        return ans
```

### Exemplos

#### Exemplo 1:
**Input**: nums = [2, 3, 5, 9], k = 2  
**Output**: 5  
**Explicação**:  
- O ladrão pode roubar as casas nos índices 0 e 2, com capacidade máxima de 5.  
- Outras combinações resultam em capacidades maiores (9).  
- Portanto, a menor capacidade possível é 5.

#### Exemplo 2:
**Input**: nums = [2, 7, 9, 3, 1], k = 2  
**Output**: 2  
**Explicação**:  
- O ladrão pode roubar as casas nos índices 0 e 4, com capacidade máxima de 2.  
- Essa é a menor capacidade possível para roubar pelo menos 2 casas.

### Conclusão

A solução é eficiente e utiliza busca binária combinada com programação dinâmica para determinar a menor capacidade possível que o ladrão pode ter ao roubar pelo menos \( k \) casas. Ao verificar cada candidato de capacidade de forma otimizada, garantimos que o problema seja resolvido com complexidade de tempo \( O(n \log(\text{max\_value})) \).

---

## [EN]

### The Problem

There are several consecutive houses along a street, each with some amount of money. A robber wants to steal money from these houses, but he refuses to steal from adjacent houses. The **capability** of the robber is defined as the maximum amount of money he steals from a single house among all the houses he robbed.

Given an array `nums`, where `nums[i]` represents the amount of money in the \( i \)-th house, and an integer \( k \), representing the minimum number of houses the robber must steal from, we need to determine the **minimum possible capability** the robber can have while stealing from at least \( k \) houses, without stealing from adjacent houses.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: We need to find the smallest possible capability (i.e., the smallest maximum value the robber can steal from a single house) that allows the robber to steal from at least \( k \) houses, without stealing from adjacent houses.

2. **Efficient approach**: I used **binary search** to determine the smallest possible capability. The binary search is applied on the range of possible values for the capability (i.e., between the smallest and largest values in the array `nums`).

3. **Feasibility check**: For each candidate capability during the binary search, I checked if it is possible to steal from at least \( k \) houses without stealing from adjacent houses, where the value of each stolen house is less than or equal to the candidate capability. This was done using a **dynamic programming** approach to count the maximum number of houses that can be stolen without violating the restriction of not stealing from adjacent houses.

4. **Optimization**: The binary search ensures a time complexity of \( O(\log(\text{max\_value})) \), and the feasibility check is done in \( O(n) \), resulting in an overall time complexity of \( O(n \log(\text{max\_value})) \).

### Complexity Analysis

- **Time complexity**: \( O(n \log(\text{max\_value})) \), where \( n \) is the number of houses and \( \text{max\_value} \) is the largest value in the array `nums`.
- **Space complexity**: \( O(1) \), as we only use a few variables to store intermediate results.

### Code Solution

```python
class Solution:
    def minCapability(self, nums: List[int], k: int) -> int:
        left = min(nums)  # Smallest possible value for capability
        right = max(nums)  # Largest possible value for capability
        ans = right  # Initialize the answer with the largest possible value
        
        while left <= right:
            mid = (left + right) // 2  # Candidate capability
            prev_prev, prev = 0, 0  # Variables to track stolen houses
            for num in nums:
                if num <= mid:
                    # If the house can be stolen, update the counter
                    current = max(prev, prev_prev + 1)
                else:
                    # Otherwise, keep the previous counter
                    current = prev
                prev_prev, prev = prev, current  # Update the variables
            
            # Check if it's possible to steal at least k houses
            if prev >= k:
                ans = mid  # Update the answer
                right = mid - 1  # Try a smaller value for capability
            else:
                left = mid + 1  # Try a larger value for capability
        
        return ans
```

### Examples

#### Example 1:
**Input**: nums = [2, 3, 5, 9], k = 2  
**Output**: 5  
**Explanation**:  
- The robber can steal houses at indices 0 and 2, with a maximum capability of 5.  
- Other combinations result in larger capabilities (9).  
- Therefore, the smallest possible capability is 5.

#### Example 2:
**Input**: nums = [2, 7, 9, 3, 1], k = 2  
**Output**: 2  
**Explanation**:  
- The robber can steal houses at indices 0 and 4, with a maximum capability of 2.  
- This is the smallest possible capability to steal at least 2 houses.

### Conclusion

The solution is efficient and uses binary search combined with dynamic programming to determine the smallest possible capability the robber can have while stealing from at least \( k \) houses. By checking each candidate capability optimally, we ensure the problem is solved with a time complexity of \( O(n \log(\text{max\_value})) \).