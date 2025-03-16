## [PT/BR]

### O Problema

Dado um array `ranks`, onde cada elemento `ranks[i]` representa a classificação de um mecânico, e um inteiro `cars`, que representa o número total de carros que precisam ser reparados, precisamos determinar o **tempo mínimo** necessário para que todos os carros sejam reparados. Um mecânico com classificação \( r \) pode reparar \( n \) carros em \( r \times n^2 \) minutos. Todos os mecânicos podem trabalhar simultaneamente.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: O tempo necessário para reparar os carros depende da classificação do mecânico e do número de carros que ele repara. Quanto maior a classificação, mais tempo o mecânico leva para reparar os carros. Precisamos encontrar o menor tempo possível que permita que todos os carros sejam reparados.

2. **Abordagem eficiente**: Utilizei a **busca binária** para determinar o tempo mínimo necessário. A busca binária é aplicada no intervalo de valores possíveis para o tempo (de 1 até o tempo necessário se todos os carros fossem reparados pelo mecânico com a menor classificação).

3. **Verificação de viabilidade**: Para cada candidato de tempo durante a busca binária, verifiquei se é possível reparar todos os carros dentro desse tempo. Isso foi feito calculando o número máximo de carros que cada mecânico pode reparar no tempo candidato e somando esses valores para ver se o total atende ou excede o número de carros.

4. **Otimização**: A busca binária garante uma complexidade de tempo \( O(n \log(\text{max\_time})) \), onde \( n \) é o número de mecânicos e \( \text{max\_time} \) é o tempo máximo inicial.

### Análise da Complexidade

- **Complexidade de tempo**: \( O(n \log(\text{max\_time})) \), onde \( n \) é o número de mecânicos e \( \text{max\_time} \) é o tempo máximo inicial.
- **Complexidade de espaço**: \( O(1) \), pois usamos apenas algumas variáveis para armazenar os resultados intermediários.

### Solução em Código

```python
import math

class Solution:
    def repairCars(self, ranks: List[int], cars: int) -> int:
        min_rank = min(ranks)  # Menor classificação entre os mecânicos
        left = 1  # Menor tempo possível
        right = min_rank * cars * cars  # Maior tempo possível (melhor mecânico reparando todos os carros)
        ans = right  # Inicializa a resposta com o maior tempo possível
        
        def is_feasible(T):
            total = 0
            for r in ranks:
                max_cars = math.isqrt(T // r)  # Máximo de carros que o mecânico pode reparar em tempo T
                total += max_cars
                if total >= cars:  # Se o total de carros reparados já atende, retorna True
                    return True
            return total >= cars  # Verifica se o total atende ao número de carros
        
        while left <= right:
            mid = (left + right) // 2  # Candidato de tempo
            if is_feasible(mid):  # Se for possível reparar todos os carros em tempo mid
                ans = mid  # Atualiza a resposta
                right = mid - 1  # Tenta um tempo menor
            else:
                left = mid + 1  # Tenta um tempo maior
        
        return ans
```

### Exemplos

#### Exemplo 1:
**Input**: ranks = [4, 2, 3, 1], cars = 10  
**Output**: 16  
**Explicação**:  
- O primeiro mecânico repara 2 carros em \( 4 \times 2^2 = 16 \) minutos.  
- O segundo mecânico repara 2 carros em \( 2 \times 2^2 = 8 \) minutos.  
- O terceiro mecânico repara 2 carros em \( 3 \times 2^2 = 12 \) minutos.  
- O quarto mecânico repara 4 carros em \( 1 \times 4^2 = 16 \) minutos.  
- O tempo mínimo necessário é 16 minutos.

#### Exemplo 2:
**Input**: ranks = [5, 1, 8], cars = 6  
**Output**: 16  
**Explicação**:  
- O primeiro mecânico repara 1 carro em \( 5 \times 1^2 = 5 \) minutos.  
- O segundo mecânico repara 4 carros em \( 1 \times 4^2 = 16 \) minutos.  
- O terceiro mecânico repara 1 carro em \( 8 \times 1^2 = 8 \) minutos.  
- O tempo mínimo necessário é 16 minutos.

### Conclusão

A solução é eficiente e utiliza busca binária para determinar o tempo mínimo necessário para reparar todos os carros. Ao verificar cada candidato de tempo de forma otimizada, garantimos que o problema seja resolvido com complexidade de tempo \( O(n \log(\text{max\_time})) \).

---

## [EN]

### The Problem

Given an array `ranks`, where each element `ranks[i]` represents the rank of a mechanic, and an integer `cars`, representing the total number of cars that need to be repaired, we need to determine the **minimum time** required for all cars to be repaired. A mechanic with rank \( r \) can repair \( n \) cars in \( r \times n^2 \) minutes. All mechanics can work simultaneously.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: The time required to repair the cars depends on the mechanic's rank and the number of cars they repair. The higher the rank, the more time the mechanic takes to repair the cars. We need to find the smallest possible time that allows all cars to be repaired.

2. **Efficient approach**: I used **binary search** to determine the minimum required time. The binary search is applied on the range of possible values for the time (from 1 to the time required if all cars were repaired by the mechanic with the lowest rank).

3. **Feasibility check**: For each candidate time during the binary search, I checked if it is possible to repair all cars within that time. This was done by calculating the maximum number of cars each mechanic can repair in the candidate time and summing these values to see if the total meets or exceeds the number of cars.

4. **Optimization**: The binary search ensures a time complexity of \( O(n \log(\text{max\_time})) \), where \( n \) is the number of mechanics and \( \text{max\_time} \) is the initial maximum time.

### Complexity Analysis

- **Time complexity**: \( O(n \log(\text{max\_time})) \), where \( n \) is the number of mechanics and \( \text{max\_time} \) is the initial maximum time.
- **Space complexity**: \( O(1) \), as we only use a few variables to store intermediate results.

### Code Solution

```python
import math

class Solution:
    def repairCars(self, ranks: List[int], cars: int) -> int:
        min_rank = min(ranks)  # Lowest rank among the mechanics
        left = 1  # Smallest possible time
        right = min_rank * cars * cars  # Largest possible time (best mechanic repairing all cars)
        ans = right  # Initialize the answer with the largest possible time
        
        def is_feasible(T):
            total = 0
            for r in ranks:
                max_cars = math.isqrt(T // r)  # Maximum cars the mechanic can repair in time T
                total += max_cars
                if total >= cars:  # If the total repaired cars already meet, return True
                    return True
            return total >= cars  # Check if the total meets the number of cars
        
        while left <= right:
            mid = (left + right) // 2  # Candidate time
            if is_feasible(mid):  # If it's possible to repair all cars in time mid
                ans = mid  # Update the answer
                right = mid - 1  # Try a smaller time
            else:
                left = mid + 1  # Try a larger time
        
        return ans
```

### Examples

#### Example 1:
**Input**: ranks = [4, 2, 3, 1], cars = 10  
**Output**: 16  
**Explanation**:  
- The first mechanic repairs 2 cars in \( 4 \times 2^2 = 16 \) minutes.  
- The second mechanic repairs 2 cars in \( 2 \times 2^2 = 8 \) minutes.  
- The third mechanic repairs 2 cars in \( 3 \times 2^2 = 12 \) minutes.  
- The fourth mechanic repairs 4 cars in \( 1 \times 4^2 = 16 \) minutes.  
- The minimum required time is 16 minutes.

#### Example 2:
**Input**: ranks = [5, 1, 8], cars = 6  
**Output**: 16  
**Explanation**:  
- The first mechanic repairs 1 car in \( 5 \times 1^2 = 5 \) minutes.  
- The second mechanic repairs 4 cars in \( 1 \times 4^2 = 16 \) minutes.  
- The third mechanic repairs 1 car in \( 8 \times 1^2 = 8 \) minutes.  
- The minimum required time is 16 minutes.

### Conclusion

The solution is efficient and uses binary search to determine the minimum time required to repair all cars. By checking each candidate time optimally, we ensure the problem is solved with a time complexity of \( O(n \log(\text{max\_time})) \).