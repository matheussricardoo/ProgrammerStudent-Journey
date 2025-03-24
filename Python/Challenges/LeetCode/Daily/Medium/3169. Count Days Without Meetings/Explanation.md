## [PT/BR]

### O Problema

Você recebe um número inteiro positivo `days`, representando o número total de dias em que um funcionário está disponível para trabalhar (começando do dia 1). Além disso, você recebe uma lista de reuniões `meetings`, onde cada reunião é representada por `[start_i, end_i]`, indicando o intervalo de dias (inclusive) em que a reunião ocorre.

O objetivo é determinar quantos dias o funcionário está disponível para trabalhar, mas não há nenhuma reunião agendada.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Ordenação das Reuniões**: Primeiro, ordene as reuniões com base no dia de início (`start_i`). Isso garante que possamos processar as reuniões em ordem cronológica, facilitando a fusão de intervalos sobrepostos ou adjacentes.

2. **Fusão de Intervalos**: Ao iterar pelas reuniões ordenadas, verifique se a próxima reunião se sobrepõe ou é adjacente à reunião atual. Se sim, combine essas reuniões em um único intervalo contínuo. Caso contrário, adicione a reunião atual à lista de intervalos fundidos e continue com a próxima reunião.

3. **Cálculo dos Dias Cobertos**: Após fundir todos os intervalos, calcule o número total de dias cobertos por esses intervalos. Para cada intervalo `[start, end]`, o número de dias cobertos é `end - start + 1`.

4. **Dias Disponíveis**: Subtraia o total de dias cobertos pelo número total de dias disponíveis (`days`) para obter o número de dias em que o funcionário está livre de reuniões.

5. **Resultado Final**: Retorne o número de dias disponíveis para trabalho sem reuniões.

### Análise da Complexidade

- **Complexidade de tempo**:
  - Ordenação das reuniões: \( O(n \log n) \), onde \( n \) é o número de reuniões.
  - Fusão dos intervalos: \( O(n) \), pois percorremos a lista de reuniões uma vez.
  - Total: \( O(n \log n) \).

- **Complexidade de espaço**: \( O(n) \), devido ao armazenamento dos intervalos fundidos.

### Solução em Código

```python
class Solution:
    def countDays(self, days: int, meetings: List[List[int]]) -> int:
        # Ordena as reuniões com base no dia de início
        meetings.sort()
        
        # Inicializa a lista de intervalos fundidos
        merged = []
        current_start, current_end = meetings[0]
        
        for meet in meetings[1:]:
            start, end = meet
            if start <= current_end:
                # Funde os intervalos se houver sobreposição ou adjacência
                current_end = max(current_end, end)
            else:
                merged.append((current_start, current_end))
                current_start, current_end = start, end
        
        # Adiciona o último intervalo fundido
        merged.append((current_start, current_end))
        
        # Calcula o total de dias cobertos por reuniões
        total_covered = 0
        for s, e in merged:
            total_covered += e - s + 1
        
        # Retorna o número de dias disponíveis para trabalho sem reuniões
        return days - total_covered
```

### Exemplos

#### Exemplo 1:
**Input**:  
```plaintext
days = 10
meetings = [[5,7],[1,3],[9,10]]
```
**Output**:  
```plaintext
2
```
**Explicação**:
1. Após ordenar e fundir os intervalos, temos os intervalos: `[1, 3]`, `[5, 7]`, `[9, 10]`.
2. O total de dias cobertos por reuniões é `(3 - 1 + 1) + (7 - 5 + 1) + (10 - 9 + 1) = 8`.
3. O número de dias disponíveis para trabalho sem reuniões é `10 - 8 = 2` (dias 4 e 8).

#### Exemplo 2:
**Input**:  
```plaintext
days = 5
meetings = [[2,4],[1,3]]
```
**Output**:  
```plaintext
1
```
**Explicação**:
1. Após ordenar e fundir os intervalos, temos o intervalo: `[1, 4]`.
2. O total de dias cobertos por reuniões é `(4 - 1 + 1) = 4`.
3. O número de dias disponíveis para trabalho sem reuniões é `5 - 4 = 1` (dia 5).

#### Exemplo 3:
**Input**:  
```plaintext
days = 6
meetings = [[1,6]]
```
**Output**:  
```plaintext
0
```
**Explicação**:
1. A única reunião cobre todos os dias de 1 a 6.
2. O total de dias cobertos por reuniões é `(6 - 1 + 1) = 6`.
3. Não há dias disponíveis para trabalho sem reuniões.

### Conclusão

A solução utiliza uma abordagem eficiente para ordenar e fundir intervalos de reuniões, garantindo que o cálculo dos dias cobertos seja preciso. A complexidade de tempo \( O(n \log n) \) torna a solução adequada para entradas razoáveis, mesmo com até 100.000 reuniões.

---

## [EN]

### The Problem

You are given a positive integer `days`, representing the total number of days an employee is available to work (starting from day 1). Additionally, you are given a list of meetings `meetings`, where each meeting is represented by `[start_i, end_i]`, indicating the range of days (inclusive) during which the meeting occurs.

The goal is to determine how many days the employee is available to work but has no meetings scheduled.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Sorting Meetings**: First, sort the meetings based on their start times (`start_i`). This ensures that we can process the meetings in chronological order, making it easier to merge overlapping or adjacent intervals.

2. **Merging Intervals**: As we iterate through the sorted meetings, check if the next meeting overlaps or is adjacent to the current meeting. If so, merge these meetings into a single continuous interval. Otherwise, add the current meeting to the list of merged intervals and proceed with the next meeting.

3. **Calculating Covered Days**: After merging all intervals, calculate the total number of days covered by these intervals. For each interval `[start, end]`, the number of days covered is `end - start + 1`.

4. **Available Days**: Subtract the total number of covered days from the total number of available days (`days`) to obtain the number of days when the employee is free from meetings.

5. **Final Result**: Return the number of days available for work without meetings.

### Complexity Analysis

- **Time complexity**:
  - Sorting the meetings: \( O(n \log n) \), where \( n \) is the number of meetings.
  - Merging intervals: \( O(n) \), as we traverse the list of meetings once.
  - Total: \( O(n \log n) \).

- **Space complexity**: \( O(n) \), due to storage of the merged intervals.

### Code Solution

```python
class Solution:
    def countDays(self, days: int, meetings: List[List[int]]) -> int:
        # Sort meetings based on start times
        meetings.sort()
        
        # Initialize the list of merged intervals
        merged = []
        current_start, current_end = meetings[0]
        
        for meet in meetings[1:]:
            start, end = meet
            if start <= current_end:
                # Merge intervals if there is overlap or adjacency
                current_end = max(current_end, end)
            else:
                merged.append((current_start, current_end))
                current_start, current_end = start, end
        
        # Add the last merged interval
        merged.append((current_start, current_end))
        
        # Calculate the total number of days covered by meetings
        total_covered = 0
        for s, e in merged:
            total_covered += e - s + 1
        
        # Return the number of days available for work without meetings
        return days - total_covered
```

### Examples

#### Example 1:
**Input**:  
```plaintext
days = 10
meetings = [[5,7],[1,3],[9,10]]
```
**Output**:  
```plaintext
2
```
**Explanation**:
1. After sorting and merging intervals, we have: `[1, 3]`, `[5, 7]`, `[9, 10]`.
2. The total number of days covered by meetings is `(3 - 1 + 1) + (7 - 5 + 1) + (10 - 9 + 1) = 8`.
3. The number of days available for work without meetings is `10 - 8 = 2` (days 4 and 8).

#### Example 2:
**Input**:  
```plaintext
days = 5
meetings = [[2,4],[1,3]]
```
**Output**:  
```plaintext
1
```
**Explanation**:
1. After sorting and merging intervals, we have: `[1, 4]`.
2. The total number of days covered by meetings is `(4 - 1 + 1) = 4`.
3. The number of days available for work without meetings is `5 - 4 = 1` (day 5).

#### Example 3:
**Input**:  
```plaintext
days = 6
meetings = [[1,6]]
```
**Output**:  
```plaintext
0
```
**Explanation**:
1. The only meeting covers all days from 1 to 6.
2. The total number of days covered by meetings is `(6 - 1 + 1) = 6`.
3. There are no days available for work without meetings.

### Conclusion

The solution uses an efficient approach to sort and merge meeting intervals, ensuring accurate calculation of the covered days. The time complexity \( O(n \log n) \) makes the solution suitable for reasonable inputs, even with up to 100,000 meetings.