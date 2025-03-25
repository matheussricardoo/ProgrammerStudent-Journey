## [PT/BR]

### O Problema

Você recebe um grid $ n \times n $, onde $ n $ representa as dimensões do grid. Além disso, você recebe uma lista de retângulos não sobrepostos, onde cada retângulo é definido por suas coordenadas `[startx, starty, endx, endy]`. 

A tarefa é determinar se é possível fazer **dois cortes horizontais** ou **dois cortes verticais** no grid de forma que:
1. O grid seja dividido em **três seções**.
2. Cada seção contenha **pelo menos um retângulo**.
3. Cada retângulo pertença **exatamente a uma seção**.

Retorne `True` se for possível realizar os cortes; caso contrário, retorne `False`.

---

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Definição dos Cortes**:
   - Um corte horizontal divide o grid ao longo do eixo y (coordenadas verticais).
   - Um corte vertical divide o grid ao longo do eixo x (coordenadas horizontais).
   - Dois cortes criam três seções no grid, e cada seção deve conter pelo menos um retângulo.

2. **Abordagem Baseada em Gaps**:
   - Para verificar se dois cortes são possíveis, precisamos identificar **gaps** entre os retângulos ao longo de um eixo específico.
   - Um gap ocorre quando há uma lacuna entre o fim de um retângulo e o início do próximo retângulo ao longo do eixo considerado.
   - Se encontrarmos **pelo menos dois gaps** ao longo de um eixo (horizontal ou vertical), significa que podemos fazer dois cortes e satisfazer as condições.

3. **Passos para Identificar Gaps**:
   - Ordene os retângulos com base nas coordenadas de início (`startx` ou `starty`) ao longo do eixo considerado.
   - Percorra os retângulos ordenados e verifique se há gaps entre o fim do retângulo atual e o início do próximo retângulo.
   - Contabilize o número de gaps encontrados. Se houver pelo menos dois gaps, é possível fazer os cortes.

4. **Verificação em Ambas as Dimensões**:
   - Repita o processo descrito acima para ambas as dimensões (horizontal e vertical).
   - Retorne `True` se for possível encontrar pelo menos dois gaps em qualquer dimensão; caso contrário, retorne `False`.

---

### Análise da Complexidade

- **Complexidade de tempo**:
  - Ordenação dos retângulos: $ O(k \log k) $, onde $ k $ é o número de retângulos.
  - Verificação de gaps: $ O(k) $, pois percorremos os retângulos ordenados uma vez.
  - Total: $ O(k \log k) $ para cada dimensão (horizontal e vertical).

- **Complexidade de espaço**:
  - Armazenamento temporário para ordenação: $ O(k) $.

---

### Solução em Código

```python
class Solution:
    def checkValidCuts(self, n: int, rectangles: List[List[int]]) -> bool:
        def check_dimension(dim: int) -> bool:
            # Ordena os retângulos pela coordenada de início na dimensão especificada
            sorted_rects = sorted(rectangles, key=lambda x: x[dim])
            gap_count = 0
            furthest_end = sorted_rects[0][dim + 2]  # Coordenada de fim na mesma dimensão
            
            for rect in sorted_rects[1:]:
                current_start = rect[dim]
                current_end = rect[dim + 2]
                
                # Verifica se há um gap entre o fim do último retângulo e o início do atual
                if current_start >= furthest_end:
                    gap_count += 1
                    if gap_count >= 2:
                        return True  # Saída antecipada se dois gaps forem encontrados
                
                # Atualiza a coordenada de fim mais distante
                furthest_end = max(furthest_end, current_end)
            
            return gap_count >= 2
        
        # Verifica ambas as dimensões (horizontal e vertical)
        return check_dimension(0) or check_dimension(1)
```

---

### Exemplos

#### Exemplo 1:
**Input**:
```plaintext
n = 5
rectangles = [[1,0,5,2],[0,2,2,4],[3,2,5,3],[0,4,4,5]]
```
**Output**:
```plaintext
True
```
**Explicação**:
- Ao verificar os gaps ao longo do eixo y (horizontal):
  - Há gaps entre os retângulos nos intervalos $ y = 2 $ e $ y = 4 $.
  - Portanto, é possível fazer dois cortes horizontais.

#### Exemplo 2:
**Input**:
```plaintext
n = 4
rectangles = [[0,0,1,1],[2,0,3,4],[0,2,2,3],[3,0,4,3]]
```
**Output**:
```plaintext
True
```
**Explicação**:
- Ao verificar os gaps ao longo do eixo x (vertical):
  - Há gaps entre os retângulos nos intervalos $ x = 2 $ e $ x = 3 $.
  - Portanto, é possível fazer dois cortes verticais.

#### Exemplo 3:
**Input**:
```plaintext
n = 4
rectangles = [[0,2,2,4],[1,0,3,2],[2,2,3,4],[3,0,4,2],[3,2,4,4]]
```
**Output**:
```plaintext
False
```
**Explicação**:
- Não há pelo menos dois gaps em nenhuma das dimensões (horizontal ou vertical).
- Portanto, não é possível fazer os cortes.

---

### Conclusão

A solução utiliza uma abordagem eficiente baseada na identificação de gaps entre retângulos ao longo de cada dimensão. A complexidade de tempo $ O(k \log k) $ torna a solução adequada para entradas razoáveis, mesmo com até $ 10^5 $ retângulos. A implementação garante que todas as condições do problema sejam satisfeitas, retornando corretamente `True` ou `False` dependendo da possibilidade de realizar os cortes.

---

## [EN]

### The Problem

You are given an $ n \times n $ grid, where $ n $ represents the dimensions of the grid. Additionally, you are provided with a list of non-overlapping rectangles, where each rectangle is defined by its coordinates `[startx, starty, endx, endy]`.

The task is to determine whether it is possible to make **two horizontal cuts** or **two vertical cuts** on the grid such that:
1. The grid is divided into **three sections**.
2. Each section contains **at least one rectangle**.
3. Each rectangle belongs to **exactly one section**.

Return `True` if such cuts can be made; otherwise, return `False`.

---

### Reasoning

To solve this problem, I followed this reasoning:

1. **Definition of Cuts**:
   - A horizontal cut divides the grid along the y-axis (vertical coordinates).
   - A vertical cut divides the grid along the x-axis (horizontal coordinates).
   - Two cuts create three sections in the grid, and each section must contain at least one rectangle.

2. **Gap-Based Approach**:
   - To verify if two cuts are possible, we need to identify **gaps** between rectangles along a specific axis.
   - A gap occurs when there is a space between the end of one rectangle and the start of the next rectangle along the considered axis.
   - If we find **at least two gaps** along an axis (horizontal or vertical), it means we can make two cuts and satisfy the conditions.

3. **Steps to Identify Gaps**:
   - Sort the rectangles based on their starting coordinates (`startx` or `starty`) along the considered axis.
   - Traverse the sorted rectangles and check for gaps between the end of the current rectangle and the start of the next rectangle.
   - Count the number of gaps found. If there are at least two gaps, the cuts are possible.

4. **Verification in Both Dimensions**:
   - Repeat the process described above for both dimensions (horizontal and vertical).
   - Return `True` if at least two gaps are found in any dimension; otherwise, return `False`.

---

### Complexity Analysis

- **Time complexity**:
  - Sorting the rectangles: $ O(k \log k) $, where $ k $ is the number of rectangles.
  - Gap verification: $ O(k) $, as we traverse the sorted rectangles once.
  - Total: $ O(k \log k) $ for each dimension (horizontal and vertical).

- **Space complexity**:
  - Temporary storage for sorting: $ O(k) $.

---

### Code Solution

```python
class Solution:
    def checkValidCuts(self, n: int, rectangles: List[List[int]]) -> bool:
        def check_dimension(dim: int) -> bool:
            # Sort rectangles by their starting coordinate in the specified dimension
            sorted_rects = sorted(rectangles, key=lambda x: x[dim])
            gap_count = 0
            furthest_end = sorted_rects[0][dim + 2]  # End coordinate in the same dimension
            
            for rect in sorted_rects[1:]:
                current_start = rect[dim]
                current_end = rect[dim + 2]
                
                # Check if there is a gap between the end of the last rectangle and the start of the current one
                if current_start >= furthest_end:
                    gap_count += 1
                    if gap_count >= 2:
                        return True  # Early exit if two gaps are found
                
                # Update the furthest end coordinate
                furthest_end = max(furthest_end, current_end)
            
            return gap_count >= 2
        
        # Check both dimensions (horizontal and vertical)
        return check_dimension(0) or check_dimension(1)
```

---

### Examples

#### Example 1:
**Input**:
```plaintext
n = 5
rectangles = [[1,0,5,2],[0,2,2,4],[3,2,5,3],[0,4,4,5]]
```
**Output**:
```plaintext
True
```
**Explanation**:
- When checking gaps along the y-axis (horizontal):
  - There are gaps between the rectangles at $ y = 2 $ and $ y = 4 $.
  - Therefore, it is possible to make two horizontal cuts.

#### Example 2:
**Input**:
```plaintext
n = 4
rectangles = [[0,0,1,1],[2,0,3,4],[0,2,2,3],[3,0,4,3]]
```
**Output**:
```plaintext
True
```
**Explanation**:
- When checking gaps along the x-axis (vertical):
  - There are gaps between the rectangles at $ x = 2 $ and $ x = 3 $.
  - Therefore, it is possible to make two vertical cuts.

#### Example 3:
**Input**:
```plaintext
n = 4
rectangles = [[0,2,2,4],[1,0,3,2],[2,2,3,4],[3,0,4,2],[3,2,4,4]]
```
**Output**:
```plaintext
False
```
**Explanation**:
- There are not at least two gaps in either dimension (horizontal or vertical).
- Therefore, it is not possible to make the cuts.

---

### Conclusion

The solution uses an efficient approach based on identifying gaps between rectangles along each dimension. The time complexity of $ O(k \log k) $ makes the solution suitable for reasonable inputs, even with up to $ 10^5 $ rectangles. The implementation ensures that all problem conditions are satisfied, correctly returning `True` or `False` depending on the possibility of making the cuts.