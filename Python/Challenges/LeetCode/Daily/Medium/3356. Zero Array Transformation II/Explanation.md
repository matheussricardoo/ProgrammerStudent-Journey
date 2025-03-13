## [PT/BR]

### O Problema

Dado um array `nums` de comprimento \( n \) e um array 2D `queries`, onde cada `queries[i] = [li, ri, vali]`, precisamos determinar o menor número \( k \) de consultas iniciais que, quando aplicadas em sequência, transformam `nums` em um array zero (todos os elementos iguais a zero). Cada consulta permite decrementar os valores no intervalo `[li, ri]` por no máximo `vali`. Se não for possível transformar `nums` em um array zero, retornamos -1.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: Precisamos aplicar as consultas de forma que cada elemento do array seja reduzido a zero. Como as consultas podem ser aplicadas de forma independente em cada índice, precisamos garantir que o efeito cumulativo das consultas atinja ou exceda o valor de cada elemento.

2. **Abordagem eficiente**: Utilizei a **busca binária** para determinar o menor número de consultas \( k \) necessário. Para cada candidato \( k \), apliquei as primeiras \( k \) consultas e verifiquei se o efeito cumulativo é suficiente para zerar todos os elementos.

3. **Técnica do array de diferenças**: Para aplicar as consultas de forma eficiente, usei um array de diferenças. Essa técnica permite atualizar intervalos em \( O(1) \) e calcular o efeito cumulativo em \( O(n) \).

4. **Verificação de validade**: Após aplicar as consultas, verifiquei se o efeito cumulativo atende ou excede o valor de cada elemento em `nums`. Se sim, \( k \) é um candidato válido; caso contrário, tentamos um \( k \) maior.

### Análise da Complexidade

- **Complexidade de tempo**: \( O(q \log q) \), onde \( q \) é o número de consultas. A busca binária reduz o número de verificações para \( O(\log q) \), e cada verificação usa a técnica do array de diferenças em \( O(n) \).
- **Complexidade de espaço**: \( O(n) \), devido ao uso do array de diferenças.

### Solução em Código

```python
class Solution:
    def minZeroArray(self, nums: List[int], queries: List[List[int]]) -> int:
        n = len(nums)
        q = len(queries)
        low, high = 0, q
        answer = -1
        
        # Pré-processa as consultas para eficiência
        queries_list = [(l, r, val) for l, r, val in queries]
        
        # Array de diferenças reutilizável
        diff = [0] * (n + 1)
        
        while low <= high:
            mid = (low + high) // 2
            # Reinicializa o array de diferenças
            for i in range(n + 1):
                diff[i] = 0
            
            # Aplica as primeiras 'mid' consultas
            for j in range(mid):
                l, r, val = queries_list[j]
                diff[l] += val
                if r + 1 < n:
                    diff[r + 1] -= val
            
            # Calcula a soma prefixada e verifica a validade
            current_sum = 0
            valid = True
            for i in range(n):
                current_sum += diff[i]
                if current_sum < nums[i]:
                    valid = False
                    break  # Saída antecipada se algum elemento for inválido
            
            if valid:
                answer = mid
                high = mid - 1
            else:
                low = mid + 1
        
        return answer if answer != -1 else -1
```

### Exemplos

#### Exemplo 1:
**Input**: nums = [2, 0, 2], queries = [[0, 2, 1], [0, 2, 1], [1, 1, 3]]  
**Output**: 2  
**Explicação**:  
- Após aplicar as primeiras 2 consultas, o array se torna [0, 0, 0], que é um array zero.  
- Portanto, o menor \( k \) é 2.

#### Exemplo 2:
**Input**: nums = [4, 3, 2, 1], queries = [[1, 3, 2], [0, 2, 1]]  
**Output**: -1  
**Explicação**:  
- Mesmo após aplicar todas as consultas, o array não se torna um array zero.  
- Portanto, retornamos -1.

### Conclusão

A solução é eficiente e utiliza busca binária combinada com a técnica do array de diferenças para determinar o menor número de consultas necessário. Ao verificar cada candidato \( k \) de forma otimizada, garantimos que o problema seja resolvido com complexidade de tempo \( O(q \log q) \).

---

## [EN]

### The Problem

Given an array `nums` of length \( n \) and a 2D array `queries`, where each `queries[i] = [li, ri, vali]`, we need to determine the smallest number \( k \) of initial queries that, when applied in sequence, transform `nums` into a zero array (all elements equal to zero). Each query allows decrementing values in the range `[li, ri]` by at most `vali`. If it is not possible to transform `nums` into a zero array, we return -1.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: We need to apply the queries such that each element in the array is reduced to zero. Since the queries can be applied independently to each index, we need to ensure that the cumulative effect of the queries meets or exceeds the value of each element.

2. **Efficient approach**: I used **binary search** to determine the smallest number of queries \( k \) required. For each candidate \( k \), I applied the first \( k \) queries and checked if the cumulative effect is sufficient to zero out all elements.

3. **Difference array technique**: To efficiently apply the queries, I used a difference array. This technique allows updating ranges in \( O(1) \) and computing the cumulative effect in \( O(n) \).

4. **Validity check**: After applying the queries, I checked if the cumulative effect meets or exceeds the value of each element in `nums`. If so, \( k \) is a valid candidate; otherwise, we try a larger \( k \).

### Complexity Analysis

- **Time complexity**: \( O(q \log q) \), where \( q \) is the number of queries. Binary search reduces the number of checks to \( O(\log q) \), and each check uses the difference array technique in \( O(n) \).
- **Space complexity**: \( O(n) \), due to the use of the difference array.

### Code Solution

```python
class Solution:
    def minZeroArray(self, nums: List[int], queries: List[List[int]]) -> int:
        n = len(nums)
        q = len(queries)
        low, high = 0, q
        answer = -1
        
        # Preprocess queries for efficiency
        queries_list = [(l, r, val) for l, r, val in queries]
        
        # Reusable difference array
        diff = [0] * (n + 1)
        
        while low <= high:
            mid = (low + high) // 2
            # Reset the difference array
            for i in range(n + 1):
                diff[i] = 0
            
            # Apply the first 'mid' queries
            for j in range(mid):
                l, r, val = queries_list[j]
                diff[l] += val
                if r + 1 < n:
                    diff[r + 1] -= val
            
            # Compute prefix sum and check validity
            current_sum = 0
            valid = True
            for i in range(n):
                current_sum += diff[i]
                if current_sum < nums[i]:
                    valid = False
                    break  # Early exit if any element is invalid
            
            if valid:
                answer = mid
                high = mid - 1
            else:
                low = mid + 1
        
        return answer if answer != -1 else -1
```

### Examples

#### Example 1:
**Input**: nums = [2, 0, 2], queries = [[0, 2, 1], [0, 2, 1], [1, 1, 3]]  
**Output**: 2  
**Explanation**:  
- After applying the first 2 queries, the array becomes [0, 0, 0], which is a zero array.  
- Therefore, the smallest \( k \) is 2.

#### Example 2:
**Input**: nums = [4, 3, 2, 1], queries = [[1, 3, 2], [0, 2, 1]]  
**Output**: -1  
**Explanation**:  
- Even after applying all queries, the array does not become a zero array.  
- Therefore, we return -1.

### Conclusion

The solution is efficient and uses binary search combined with the difference array technique to determine the smallest number of queries required. By checking each candidate \( k \) optimally, we ensure the problem is solved with a time complexity of \( O(q \log q) \).