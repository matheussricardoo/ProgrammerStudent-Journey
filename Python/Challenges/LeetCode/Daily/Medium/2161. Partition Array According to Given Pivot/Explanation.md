## [PT/BR]

### O Problema

Dado um array de inteiros `nums` e um inteiro `pivot`, precisamos reorganizar `nums` de forma que:
1. Todos os elementos menores que `pivot` apareçam antes dos elementos maiores que `pivot`.
2. Todos os elementos iguais a `pivot` apareçam entre os elementos menores e maiores que `pivot`.
3. A ordem relativa dos elementos menores que `pivot` e dos elementos maiores que `pivot` seja mantida.

Mais formalmente, para quaisquer dois elementos `nums[i]` e `nums[j]` onde `i < j`, se ambos forem menores (ou maiores) que `pivot`, então a posição de `nums[i]` no array reorganizado deve ser menor que a posição de `nums[j]`.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: A reorganização deve preservar a ordem relativa dos elementos menores e maiores que `pivot`. Isso sugere que não podemos simplesmente ordenar o array, pois isso alteraria a ordem relativa.

2. **Abordagem eficiente**: Podemos dividir o array em três partes:
   - Elementos menores que `pivot`.
   - Elementos iguais a `pivot`.
   - Elementos maiores que `pivot`.

3. **Manutenção da ordem**: Para manter a ordem relativa, podemos iterar pelo array uma vez e adicionar os elementos às suas respectivas listas (menores, iguais, maiores) na ordem em que aparecem.

4. **Concatenar as listas**: Após a divisão, concatenamos as três listas na ordem correta: menores, iguais, maiores.

5. **Eficiência**: Essa abordagem é eficiente, pois percorre o array uma única vez e utiliza espaço adicional proporcional ao tamanho do array.

### Análise da Complexidade

- **Complexidade de tempo**: O(n), onde n é o comprimento do array.
  - Percorremos o array uma vez para dividir os elementos.
  - A concatenação das listas é feita em tempo constante.
  
- **Complexidade de espaço**: O(n)
  - Utilizamos três listas para armazenar os elementos menores, iguais e maiores que `pivot`.

### Solução em Código

```python
def pivotArray(self, nums: List[int], pivot: int) -> List[int]:
    # Listas para armazenar elementos menores, iguais e maiores que o pivô
    less = []
    equal = []
    greater = []
    
    # Iterar sobre cada elemento no array
    for num in nums:
        if num < pivot:
            less.append(num)  # Adicionar à lista de menores
        elif num == pivot:
            equal.append(num)  # Adicionar à lista de iguais
        else:
            greater.append(num)  # Adicionar à lista de maiores
    
    # Concatenar as listas na ordem correta: menores, iguais, maiores
    return less + equal + greater
```

### Exemplos

#### Exemplo 1:
**Input**: nums = [9,12,5,10,14,3,10], pivot = 10
**Output**: [9,5,3,10,10,12,14]
**Explicação**:
1. Elementos menores que 10: [9,5,3]
2. Elementos iguais a 10: [10,10]
3. Elementos maiores que 10: [12,14]
4. Concatenando: [9,5,3,10,10,12,14]

#### Exemplo 2:
**Input**: nums = [-3,4,3,2], pivot = 2
**Output**: [-3,2,4,3]
**Explicação**:
1. Elementos menores que 2: [-3]
2. Elementos iguais a 2: [2]
3. Elementos maiores que 2: [4,3]
4. Concatenando: [-3,2,4,3]

### Conclusão

A solução é eficiente e utiliza uma abordagem simples para reorganizar o array de acordo com as condições dadas. Ao dividir os elementos em três listas e concatená-las, garantimos que a ordem relativa seja mantida e que os requisitos do problema sejam atendidos com complexidade de tempo O(n).

---

## [EN]

### The Problem

Given a 0-indexed integer array `nums` and an integer `pivot`, we need to rearrange `nums` such that:
1. Every element less than `pivot` appears before every element greater than `pivot`.
2. Every element equal to `pivot` appears between the elements less than and greater than `pivot`.
3. The relative order of the elements less than `pivot` and the elements greater than `pivot` is maintained.

More formally, for any two elements `nums[i]` and `nums[j]` where `i < j`, if both are smaller (or larger) than `pivot`, then the position of `nums[i]` in the rearranged array must be less than the position of `nums[j]`.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: The rearrangement must preserve the relative order of elements smaller and larger than `pivot`. This suggests that we cannot simply sort the array, as that would alter the relative order.

2. **Efficient approach**: We can divide the array into three parts:
   - Elements smaller than `pivot`.
   - Elements equal to `pivot`.
   - Elements larger than `pivot`.

3. **Maintaining order**: To preserve the relative order, we can iterate through the array once and add elements to their respective lists (smaller, equal, larger) in the order they appear.

4. **Concatenating lists**: After dividing, we concatenate the three lists in the correct order: smaller, equal, larger.

5. **Efficiency**: This approach is efficient, as it traverses the array once and uses additional space proportional to the size of the array.

### Complexity Analysis

- **Time complexity**: O(n), where n is the length of the array.
  - We traverse the array once to divide the elements.
  - Concatenating the lists is done in constant time.
  
- **Space complexity**: O(n)
  - We use three lists to store elements smaller, equal, and larger than `pivot`.

### Code Solution

```python
def pivotArray(self, nums: List[int], pivot: int) -> List[int]:
    # Lists to store elements smaller than, equal to, and greater than the pivot
    less = []
    equal = []
    greater = []
    
    # Iterate over each element in the array
    for num in nums:
        if num < pivot:
            less.append(num)  # Add to the smaller list
        elif num == pivot:
            equal.append(num)  # Add to the equal list
        else:
            greater.append(num)  # Add to the greater list
    
    # Concatenate the lists in the correct order: smaller, equal, greater
    return less + equal + greater
```

### Examples

#### Example 1:
**Input**: nums = [9,12,5,10,14,3,10], pivot = 10
**Output**: [9,5,3,10,10,12,14]
**Explanation**:
1. Elements smaller than 10: [9,5,3]
2. Elements equal to 10: [10,10]
3. Elements larger than 10: [12,14]
4. Concatenating: [9,5,3,10,10,12,14]

#### Example 2:
**Input**: nums = [-3,4,3,2], pivot = 2
**Output**: [-3,2,4,3]
**Explanation**:
1. Elements smaller than 2: [-3]
2. Elements equal to 2: [2]
3. Elements larger than 2: [4,3]
4. Concatenating: [-3,2,4,3]

### Conclusion

The solution is efficient and uses a simple approach to rearrange the array according to the given conditions. By dividing the elements into three lists and concatenating them, we ensure that the relative order is maintained and that the problem's requirements are met with O(n) time complexity.