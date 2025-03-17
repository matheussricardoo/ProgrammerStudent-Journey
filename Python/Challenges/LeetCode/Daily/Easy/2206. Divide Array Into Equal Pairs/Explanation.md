## [PT/BR]

### O Problema

Dado um array `nums` de inteiros com \( 2 \times n \) elementos, precisamos dividir `nums` em \( n \) pares de forma que:

1. Cada elemento pertença a exatamente um par.
2. Os elementos em cada par sejam iguais.

Retorne `true` se for possível dividir `nums` em \( n \) pares que satisfaçam essas condições. Caso contrário, retorne `false`.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: Para que os elementos possam ser divididos em pares iguais, cada elemento deve aparecer um número par de vezes no array. Isso porque cada par requer dois elementos iguais.

2. **Abordagem eficiente**: Utilizei um contador de frequência para contar quantas vezes cada elemento aparece no array. Em seguida, verifiquei se todas as frequências são pares. Se todas forem pares, é possível formar os pares; caso contrário, não é possível.

3. **Implementação**:
   - Usei a classe `Counter` do módulo `collections` para contar as frequências dos elementos.
   - Iterei sobre os valores do contador e verifiquei se todos são pares.

4. **Otimização**: A abordagem é eficiente, com complexidade de tempo \( O(n) \), onde \( n \) é o número de elementos no array.

### Análise da Complexidade

- **Complexidade de tempo**: \( O(n) \), pois percorremos o array uma vez para contar as frequências e outra vez para verificar as frequências.
- **Complexidade de espaço**: \( O(n) \), devido ao uso do contador de frequências.

### Solução em Código

```python
from collections import Counter

class Solution:
    def divideArray(self, nums: List[int]) -> bool:
        count = Counter(nums)  # Conta a frequência de cada elemento
        for v in count.values():
            if v % 2 != 0:  # Se alguma frequência for ímpar, retorna False
                return False
        return True  # Se todas as frequências forem pares, retorna True
```

### Exemplos

#### Exemplo 1:
**Input**: nums = [3, 2, 3, 2, 2, 2]  
**Output**: true  
**Explicação**:  
- O array pode ser dividido em pares: (2, 2), (3, 3), e (2, 2).  
- Todos os elementos aparecem um número par de vezes.  
- Portanto, a resposta é `true`.

#### Exemplo 2:
**Input**: nums = [1, 2, 3, 4]  
**Output**: false  
**Explicação**:  
- Não é possível dividir o array em pares de elementos iguais.  
- Os elementos 1, 2, 3 e 4 aparecem apenas uma vez.  
- Portanto, a resposta é `false`.

### Conclusão

A solução é eficiente e utiliza um contador de frequências para verificar se todos os elementos aparecem um número par de vezes. Ao garantir que todas as frequências sejam pares, podemos concluir que é possível dividir o array em pares de elementos iguais. A complexidade de tempo \( O(n) \) torna a solução adequada para os limites do problema.

---

## [EN]

### The Problem

Given an integer array `nums` of \( 2 \times n \) elements, we need to divide `nums` into \( n \) pairs such that:

1. Each element belongs to exactly one pair.
2. The elements in each pair are equal.

Return `true` if it is possible to divide `nums` into \( n \) pairs that satisfy these conditions. Otherwise, return `false`.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: For the elements to be divided into equal pairs, each element must appear an even number of times in the array. This is because each pair requires two equal elements.

2. **Efficient approach**: I used a frequency counter to count how many times each element appears in the array. Then, I checked if all frequencies are even. If all are even, it is possible to form the pairs; otherwise, it is not.

3. **Implementation**:
   - I used the `Counter` class from the `collections` module to count the frequencies of the elements.
   - I iterated over the values of the counter and checked if all are even.

4. **Optimization**: The approach is efficient, with a time complexity of \( O(n) \), where \( n \) is the number of elements in the array.

### Complexity Analysis

- **Time complexity**: \( O(n) \), as we traverse the array once to count frequencies and once to check the frequencies.
- **Space complexity**: \( O(n) \), due to the use of the frequency counter.

### Code Solution

```python
from collections import Counter

class Solution:
    def divideArray(self, nums: List[int]) -> bool:
        count = Counter(nums)  # Count the frequency of each element
        for v in count.values():
            if v % 2 != 0:  # If any frequency is odd, return False
                return False
        return True  # If all frequencies are even, return True
```

### Examples

#### Example 1:
**Input**: nums = [3, 2, 3, 2, 2, 2]  
**Output**: true  
**Explanation**:  
- The array can be divided into pairs: (2, 2), (3, 3), and (2, 2).  
- All elements appear an even number of times.  
- Therefore, the answer is `true`.

#### Example 2:
**Input**: nums = [1, 2, 3, 4]  
**Output**: false  
**Explanation**:  
- It is not possible to divide the array into pairs of equal elements.  
- The elements 1, 2, 3, and 4 appear only once.  
- Therefore, the answer is `false`.

### Conclusion

The solution is efficient and uses a frequency counter to check if all elements appear an even number of times. By ensuring that all frequencies are even, we can conclude that it is possible to divide the array into pairs of equal elements. The time complexity of \( O(n) \) makes the solution suitable for the problem constraints.