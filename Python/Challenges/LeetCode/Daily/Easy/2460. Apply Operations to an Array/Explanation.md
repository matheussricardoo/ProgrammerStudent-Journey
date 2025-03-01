## [PT/BR]

### O Problema

Dado um array `nums` de tamanho `n` contendo inteiros não-negativos, precisamos aplicar `n - 1` operações ao array, onde na operação `i` (indexada a partir de 0):
- Se `nums[i] == nums[i + 1]`, multiplicamos `nums[i]` por 2 e definimos `nums[i + 1]` como 0.
- Caso contrário, pulamos esta operação.

Após realizar todas as operações, deslocamos todos os zeros para o final do array, mantendo a ordem relativa dos elementos não-zero.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Processo sequencial**: As operações devem ser aplicadas uma após a outra, não todas de uma vez, o que significa que cada operação pode afetar as operações subsequentes.

2. **Duas fases distintas**: O problema pode ser dividido em duas fases claras:
   - Aplicar as `n-1` operações sequencialmente
   - Deslocar todos os zeros para o final

3. **Implementação eficiente**:
   - Para a primeira fase, percorremos o array e aplicamos as regras conforme indicado
   - Para a segunda fase, usamos uma técnica de dois ponteiros para mover todos os elementos não-zero para o início do array

4. **Otimização**: Realizamos as operações in-place para minimizar o uso de memória adicional.

### Análise da Complexidade

- **Complexidade de tempo**: O(n), onde n é o tamanho do array
  - A primeira fase requer n-1 verificações (uma para cada par adjacente)
  - A segunda fase requer n operações para mover os elementos não-zero e preencher o resto com zeros
  
- **Complexidade de espaço**: O(1)
  - Todas as operações são realizadas in-place, sem usar estruturas de dados adicionais além de algumas variáveis

### Solução em Código

```python
def applyOperations(self, nums: List[int]) -> List[int]:
    n = len(nums)
    
    # Fase 1: Aplicar operações sequencialmente
    for i in range(n-1):
        if nums[i] == nums[i+1]:
            nums[i] *= 2
            nums[i+1] = 0
    
    # Fase 2: Deslocar todos os zeros para o final
    # Movemos todos os elementos não-zero para o início
    non_zero_idx = 0
    for i in range(n):
        if nums[i] != 0:
            nums[non_zero_idx] = nums[i]
            non_zero_idx += 1
    
    # Preenchemos o restante com zeros
    for i in range(non_zero_idx, n):
        nums[i] = 0
    
    return nums
```

### Exemplos

#### Exemplo 1:
**Input**: nums = [1,2,2,1,1,0]
**Output**: [1,4,2,0,0,0]
**Explicação**: 
1. i = 0: nums[0] e nums[1] não são iguais, então pulamos.
2. i = 1: nums[1] e nums[2] são iguais, multiplicamos nums[1] por 2 e mudamos nums[2] para 0. O array fica [1,4,0,1,1,0].
3. i = 2: nums[2] e nums[3] não são iguais, então pulamos.
4. i = 3: nums[3] e nums[4] são iguais, multiplicamos nums[3] por 2 e mudamos nums[4] para 0. O array fica [1,4,0,2,0,0].
5. i = 4: nums[4] e nums[5] são iguais, multiplicamos nums[4] por 2 e mudamos nums[5] para 0. O array continua [1,4,0,2,0,0].
Depois, deslocamos os zeros para o final, resultando em [1,4,2,0,0,0].

#### Exemplo 2:
**Input**: nums = [0,1]
**Output**: [1,0]
**Explicação**: Nenhuma operação pode ser aplicada, apenas deslocamos o 0 para o final.

### Conclusão

A solução é eficiente tanto em tempo quanto em espaço, aproveitando a natureza sequencial das operações e usando uma técnica de dois ponteiros para deslocar os zeros. Ao dividir o problema em duas fases distintas, conseguimos uma implementação clara e direta.

---

## [EN]

### The Problem

Given a 0-indexed array `nums` of size `n` consisting of non-negative integers, we need to apply `n - 1` operations to this array where, in the `ith` operation (0-indexed):
- If `nums[i] == nums[i + 1]`, then multiply `nums[i]` by 2 and set `nums[i + 1]` to 0.
- Otherwise, skip this operation.

After performing all the operations, shift all the 0's to the end of the array, maintaining the relative order of the non-zero elements.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Sequential process**: The operations must be applied one after another, not all at once, which means each operation can affect subsequent operations.

2. **Two distinct phases**: The problem can be divided into two clear phases:
   - Apply the `n-1` operations sequentially
   - Shift all zeros to the end

3. **Efficient implementation**:
   - For the first phase, we iterate through the array and apply the rules as indicated
   - For the second phase, we use a two-pointer technique to move all non-zero elements to the front of the array

4. **Optimization**: We perform the operations in-place to minimize additional memory usage.

### Complexity Analysis

- **Time complexity**: O(n), where n is the size of the array
  - The first phase requires n-1 checks (one for each adjacent pair)
  - The second phase requires n operations to move non-zero elements and fill the rest with zeros
  
- **Space complexity**: O(1)
  - All operations are performed in-place, without using additional data structures beyond a few variables

### Code Solution

```python
def applyOperations(self, nums: List[int]) -> List[int]:
    n = len(nums)
    
    # Phase 1: Apply operations sequentially
    for i in range(n-1):
        if nums[i] == nums[i+1]:
            nums[i] *= 2
            nums[i+1] = 0
    
    # Phase 2: Shift all zeros to the end
    # Move all non-zero elements to the front
    non_zero_idx = 0
    for i in range(n):
        if nums[i] != 0:
            nums[non_zero_idx] = nums[i]
            non_zero_idx += 1
    
    # Fill the rest with zeros
    for i in range(non_zero_idx, n):
        nums[i] = 0
    
    return nums
```

### Examples

#### Example 1:
**Input**: nums = [1,2,2,1,1,0]
**Output**: [1,4,2,0,0,0]
**Explanation**: 
1. i = 0: nums[0] and nums[1] are not equal, so we skip.
2. i = 1: nums[1] and nums[2] are equal, we multiply nums[1] by 2 and change nums[2] to 0. The array becomes [1,4,0,1,1,0].
3. i = 2: nums[2] and nums[3] are not equal, so we skip.
4. i = 3: nums[3] and nums[4] are equal, we multiply nums[3] by 2 and change nums[4] to 0. The array becomes [1,4,0,2,0,0].
5. i = 4: nums[4] and nums[5] are equal, we multiply nums[4] by 2 and change nums[5] to 0. The array remains [1,4,0,2,0,0].
After that, we shift the 0's to the end, which gives the array [1,4,2,0,0,0].

#### Example 2:
**Input**: nums = [0,1]
**Output**: [1,0]
**Explanation**: No operation can be applied, we just shift the 0 to the end.

### Conclusion

The solution is efficient in both time and space, leveraging the sequential nature of the operations and using a two-pointer technique to shift the zeros. By dividing the problem into two distinct phases, we achieve a clear and straightforward implementation.