## [PT/BR]

### O Problema

Dados dois números inteiros positivos `left` e `right`, precisamos encontrar dois números inteiros `num1` e `num2` tais que:
1. \( \text{left} \leq \text{num1} < \text{num2} \leq \text{right} \).
2. Ambos `num1` e `num2` são números primos.
3. A diferença \( \text{num2} - \text{num1} \) é a menor possível entre todos os pares que satisfazem as condições acima.

Retorne um array de inteiros `ans = [num1, num2]`. Se houver múltiplos pares que satisfazem as condições, retorne o par com o menor valor de `num1`. Se não existirem tais números, retorne `[-1, -1]`.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Geração eficiente de números primos**: Utilizei o algoritmo **Crivo de Eratóstenes** para gerar todos os números primos até o valor de `right`. Esse algoritmo é eficiente e permite identificar rapidamente quais números são primos.

2. **Coleta de primos no intervalo**: Após gerar os números primos, coletei apenas aqueles que estão no intervalo \([\text{left}, \text{right}]\).

3. **Encontrar o par mais próximo**: Iterei sobre a lista de primos coletados para encontrar o par de primos consecutivos com a menor diferença. Se houver múltiplos pares com a mesma diferença mínima, o primeiro par encontrado (com o menor `num1`) é escolhido.

4. **Verificação de casos especiais**: Se houver menos de dois primos no intervalo, retorne `[-1, -1]`.

### Análise da Complexidade

- **Complexidade de tempo**: \( O(n \log \log n) \), onde \( n = \text{right} \). O Crivo de Eratóstenes tem essa complexidade para gerar todos os primos até `right`.
- **Complexidade de espaço**: \( O(n) \), devido ao uso de um array para armazenar os números primos.

### Solução em Código

```python
class Solution:
    def closestPrimes(self, left: int, right: int) -> List[int]:
        if right < 2:
            return [-1, -1]
        
        # Crivo de Eratóstenes para encontrar todos os primos até 'right'
        sieve = [True] * (right + 1)
        sieve[0] = sieve[1] = False
        for i in range(2, int(right ** 0.5) + 1):
            if sieve[i]:
                sieve[i*i : right+1 : i] = [False] * len(sieve[i*i : right+1 : i])
        
        # Coletar primos no intervalo [left, right]
        primes = [num for num in range(left, right + 1) if sieve[num]]
        
        # Se houver menos de 2 primos, retornar [-1, -1]
        if len(primes) < 2:
            return [-1, -1]
        
        min_diff = float('inf')  # Inicializar a menor diferença como infinito
        res = [primes[0], primes[1]]  # Inicializar o resultado com o primeiro par
        
        # Encontrar o par com a menor diferença
        for i in range(len(primes) - 1):
            current_diff = primes[i+1] - primes[i]
            if current_diff < min_diff:
                min_diff = current_diff
                res = [primes[i], primes[i+1]]
                if min_diff == 2:  # Saída antecipada, pois 2 é a menor diferença possível
                    break
        
        return res
```

### Exemplos

#### Exemplo 1:
**Input**: left = 10, right = 19  
**Output**: [11, 13]  
**Explicação**:  
- Os números primos entre 10 e 19 são: 11, 13, 17, 19.  
- A menor diferença entre pares consecutivos é 2, que ocorre em [11, 13] e [17, 19].  
- Como 11 é menor que 17, o par [11, 13] é retornado.

#### Exemplo 2:
**Input**: left = 4, right = 6  
**Output**: [-1, -1]  
**Explicação**:  
- Há apenas um número primo no intervalo (5), então não é possível formar um par.  
- Retornamos `[-1, -1]`.

### Conclusão

A solução é eficiente e utiliza o Crivo de Eratóstenes para gerar números primos de maneira otimizada. Ao coletar os primos no intervalo e encontrar o par com a menor diferença, garantimos que o problema seja resolvido com complexidade de tempo \( O(n \log \log n) \).

---

## [EN]

### The Problem

Given two positive integers `left` and `right`, we need to find two integers `num1` and `num2` such that:
1. \( \text{left} \leq \text{num1} < \text{num2} \leq \text{right} \).
2. Both `num1` and `num2` are prime numbers.
3. The difference \( \text{num2} - \text{num1} \) is the smallest possible among all pairs satisfying the above conditions.

Return an integer array `ans = [num1, num2]`. If there are multiple pairs satisfying the conditions, return the pair with the smallest `num1`. If no such numbers exist, return `[-1, -1]`.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Efficient prime generation**: I used the **Sieve of Eratosthenes** algorithm to generate all prime numbers up to `right`. This algorithm is efficient and allows quick identification of prime numbers.

2. **Collecting primes in the range**: After generating the primes, I collected only those within the range \([\text{left}, \text{right}]\).

3. **Finding the closest pair**: I iterated over the collected primes to find the pair of consecutive primes with the smallest difference. If there are multiple pairs with the same minimum difference, the first pair encountered (with the smallest `num1`) is chosen.

4. **Handling edge cases**: If there are fewer than two primes in the range, return `[-1, -1]`.

### Complexity Analysis

- **Time complexity**: \( O(n \log \log n) \), where \( n = \text{right} \). The Sieve of Eratosthenes has this complexity for generating all primes up to `right`.
- **Space complexity**: \( O(n) \), due to the use of an array to store the primes.

### Code Solution

```python
class Solution:
    def closestPrimes(self, left: int, right: int) -> List[int]:
        if right < 2:
            return [-1, -1]
        
        # Sieve of Eratosthenes to find all primes up to 'right'
        sieve = [True] * (right + 1)
        sieve[0] = sieve[1] = False
        for i in range(2, int(right ** 0.5) + 1):
            if sieve[i]:
                sieve[i*i : right+1 : i] = [False] * len(sieve[i*i : right+1 : i])
        
        # Collect primes in the range [left, right]
        primes = [num for num in range(left, right + 1) if sieve[num]]
        
        # If there are fewer than 2 primes, return [-1, -1]
        if len(primes) < 2:
            return [-1, -1]
        
        min_diff = float('inf')  # Initialize the smallest difference as infinity
        res = [primes[0], primes[1]]  # Initialize the result with the first pair
        
        # Find the pair with the smallest difference
        for i in range(len(primes) - 1):
            current_diff = primes[i+1] - primes[i]
            if current_diff < min_diff:
                min_diff = current_diff
                res = [primes[i], primes[i+1]]
                if min_diff == 2:  # Early exit, as 2 is the smallest possible difference
                    break
        
        return res
```

### Examples

#### Example 1:
**Input**: left = 10, right = 19  
**Output**: [11, 13]  
**Explanation**:  
- The prime numbers between 10 and 19 are: 11, 13, 17, 19.  
- The smallest difference between consecutive pairs is 2, which occurs in [11, 13] and [17, 19].  
- Since 11 is smaller than 17, the pair [11, 13] is returned.

#### Example 2:
**Input**: left = 4, right = 6  
**Output**: [-1, -1]  
**Explanation**:  
- There is only one prime number in the range (5), so no pair can be formed.  
- We return `[-1, -1]`.

### Conclusion

The solution is efficient and uses the Sieve of Eratosthenes to generate prime numbers optimally. By collecting primes in the range and finding the pair with the smallest difference, we ensure the problem is solved with a time complexity of \( O(n \log \log n) \).