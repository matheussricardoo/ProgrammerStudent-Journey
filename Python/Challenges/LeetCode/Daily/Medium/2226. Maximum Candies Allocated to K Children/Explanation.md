## [PT/BR]

### O Problema

Dado um array `candies`, onde cada elemento `candies[i]` representa uma pilha de doces, e um inteiro `k`, que representa o número de crianças, precisamos alocar as pilhas de doces para as crianças de forma que cada criança receba a mesma quantidade de doces. Cada criança só pode receber doces de uma única pilha, e algumas pilhas podem não ser usadas.

O objetivo é retornar o **número máximo de doces** que cada criança pode receber.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: Precisamos dividir as pilhas de doces em subpilhas de tamanho igual, de modo que o número total de subpilhas seja pelo menos `k`. O número máximo de doces por criança é o maior valor possível que permite essa divisão.

2. **Abordagem eficiente**: Utilizei a **busca binária** para determinar o número máximo de doces que cada criança pode receber. A busca binária é aplicada no intervalo de valores possíveis para o número de doces por criança (de 1 até a soma total de doces dividida por `k`).

3. **Verificação de viabilidade**: Para cada candidato de valor durante a busca binária, verifiquei se é possível dividir as pilhas de doces em pelo menos `k` subpilhas, onde cada subpilha tem pelo menos o valor candidato de doces. Isso foi feito somando o número de subpilhas que cada pilha pode contribuir e verificando se o total é maior ou igual a `k`.

4. **Otimização**: A busca binária garante uma complexidade de tempo \( O(n \log(\text{sum\_candies} / k)) \), onde \( n \) é o número de pilhas e \( \text{sum\_candies} \) é a soma total de doces.

### Análise da Complexidade

- **Complexidade de tempo**: \( O(n \log(\text{sum\_candies} / k)) \), onde \( n \) é o número de pilhas e \( \text{sum\_candies} \) é a soma total de doces.
- **Complexidade de espaço**: \( O(1) \), pois usamos apenas algumas variáveis para armazenar os resultados intermediários.

### Solução em Código

```python
class Solution:
    def maximumCandies(self, candies: List[int], k: int) -> int:
        total = sum(candies)  # Soma total de doces
        if total < k:  # Se a soma total for menor que k, é impossível
            return 0
        
        left = 1  # Menor valor possível para doces por criança
        right = total // k  # Maior valor possível para doces por criança
        ans = 0  # Inicializa a resposta
        
        while left <= right:
            mid = (left + right) // 2  # Candidato de valor
            s = sum(c // mid for c in candies)  # Soma das subpilhas possíveis
            if s >= k:  # Se for possível dividir em pelo menos k subpilhas
                ans = mid  # Atualiza a resposta
                left = mid + 1  # Tenta um valor maior
            else:
                right = mid - 1  # Tenta um valor menor
        
        return ans
```

### Exemplos

#### Exemplo 1:
**Input**: candies = [5, 8, 6], k = 3  
**Output**: 5  
**Explicação**:  
- Podemos dividir a pilha de 8 doces em duas subpilhas de 5 e 3.  
- Podemos dividir a pilha de 6 doces em duas subpilhas de 5 e 1.  
- Agora temos cinco subpilhas: [5, 5, 3, 5, 1].  
- Alocamos três subpilhas de 5 doces para as três crianças.  
- Portanto, o número máximo de doces por criança é 5.

#### Exemplo 2:
**Input**: candies = [2, 5], k = 11  
**Output**: 0  
**Explicação**:  
- Há 11 crianças, mas apenas 7 doces no total.  
- É impossível garantir que cada criança receba pelo menos um doce.  
- Portanto, o número máximo de doces por criança é 0.

### Conclusão

A solução é eficiente e utiliza busca binária para determinar o número máximo de doces que cada criança pode receber. Ao verificar cada candidato de valor de forma otimizada, garantimos que o problema seja resolvido com complexidade de tempo \( O(n \log(\text{sum\_candies} / k)) \).

---

## [EN]

### The Problem

Given an array `candies`, where each element `candies[i]` represents a pile of candies, and an integer `k`, representing the number of children, we need to allocate the piles of candies to the children such that each child receives the same number of candies. Each child can only receive candies from one pile, and some piles may remain unused.

The goal is to return the **maximum number of candies** each child can receive.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: We need to divide the piles of candies into sub-piles of equal size, such that the total number of sub-piles is at least `k`. The maximum number of candies per child is the largest possible value that allows this division.

2. **Efficient approach**: I used **binary search** to determine the maximum number of candies each child can receive. The binary search is applied on the range of possible values for the number of candies per child (from 1 to the total sum of candies divided by `k`).

3. **Feasibility check**: For each candidate value during the binary search, I checked if it is possible to divide the piles of candies into at least `k` sub-piles, where each sub-pile has at least the candidate value of candies. This was done by summing the number of sub-piles each pile can contribute and checking if the total is greater than or equal to `k`.

4. **Optimization**: The binary search ensures a time complexity of \( O(n \log(\text{sum\_candies} / k)) \), where \( n \) is the number of piles and \( \text{sum\_candies} \) is the total sum of candies.

### Complexity Analysis

- **Time complexity**: \( O(n \log(\text{sum\_candies} / k)) \), where \( n \) is the number of piles and \( \text{sum\_candies} \) is the total sum of candies.
- **Space complexity**: \( O(1) \), as we only use a few variables to store intermediate results.

### Code Solution

```python
class Solution:
    def maximumCandies(self, candies: List[int], k: int) -> int:
        total = sum(candies)  # Total sum of candies
        if total < k:  # If the total sum is less than k, it's impossible
            return 0
        
        left = 1  # Smallest possible value for candies per child
        right = total // k  # Largest possible value for candies per child
        ans = 0  # Initialize the answer
        
        while left <= right:
            mid = (left + right) // 2  # Candidate value
            s = sum(c // mid for c in candies)  # Sum of possible sub-piles
            if s >= k:  # If it's possible to divide into at least k sub-piles
                ans = mid  # Update the answer
                left = mid + 1  # Try a larger value
            else:
                right = mid - 1  # Try a smaller value
        
        return ans
```

### Examples

#### Example 1:
**Input**: candies = [5, 8, 6], k = 3  
**Output**: 5  
**Explanation**:  
- We can divide the pile of 8 candies into two sub-piles of 5 and 3.  
- We can divide the pile of 6 candies into two sub-piles of 5 and 1.  
- Now we have five sub-piles: [5, 5, 3, 5, 1].  
- We allocate three sub-piles of 5 candies to the three children.  
- Therefore, the maximum number of candies per child is 5.

#### Example 2:
**Input**: candies = [2, 5], k = 11  
**Output**: 0  
**Explanation**:  
- There are 11 children, but only 7 candies in total.  
- It is impossible to ensure each child receives at least one candy.  
- Therefore, the maximum number of candies per child is 0.

### Conclusion

The solution is efficient and uses binary search to determine the maximum number of candies each child can receive. By checking each candidate value optimally, we ensure the problem is solved with a time complexity of \( O(n \log(\text{sum\_candies} / k)) \).
