## [PT/BR]

### O Problema

Dada uma string `s`, precisamos determinar o número total de substrings que contêm pelo menos uma ocorrência de cada um dos caracteres 'a', 'b' e 'c'. A string `s` consiste apenas desses três caracteres.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: Uma substring válida deve conter pelo menos um 'a', um 'b' e um 'c'. Isso significa que precisamos rastrear a última ocorrência de cada um desses caracteres para determinar quantas substrings válidas podem ser formadas até cada posição da string.

2. **Abordagem eficiente**: Utilizei uma técnica de **janela deslizante** para rastrear as últimas ocorrências de 'a', 'b' e 'c'. A cada passo, verifico se todos os três caracteres já apareceram na string até o momento. Se sim, calculo o número de substrings válidas que terminam na posição atual.

3. **Implementação**:
   - Inicializei variáveis para armazenar as últimas ocorrências de 'a', 'b' e 'c' como -1.
   - Iterei pela string, atualizando as últimas ocorrências de cada caractere.
   - Quando todos os três caracteres tiverem aparecido pelo menos uma vez, calculei o número de substrings válidas que terminam na posição atual.

4. **Otimização**: A abordagem é eficiente, com complexidade de tempo \( O(n) \), onde \( n \) é o comprimento da string `s`.

### Análise da Complexidade

- **Complexidade de tempo**: \( O(n) \), pois percorremos a string uma única vez.
- **Complexidade de espaço**: \( O(1) \), pois usamos apenas algumas variáveis para armazenar as últimas ocorrências dos caracteres.

### Solução em Código

```python
class Solution:
    def numberOfSubstrings(self, s: str) -> int:
        last_a = last_b = last_c = -1  # Inicializa as últimas ocorrências de 'a', 'b' e 'c'
        answer = 0                     # Inicializa a resposta como 0
        
        for j in range(len(s)):        # Itera por cada caractere da string
            if s[j] == 'a':
                last_a = j             # Atualiza a última ocorrência de 'a'
            elif s[j] == 'b':
                last_b = j             # Atualiza a última ocorrência de 'b'
            elif s[j] == 'c':
                last_c = j             # Atualiza a última ocorrência de 'c'
            
            # Verifica se todos os três caracteres já apareceram
            if last_a >= 0 and last_b >= 0 and last_c >= 0:
                min_last = min(last_a, last_b, last_c)  # Encontra a menor última ocorrência
                answer += min_last + 1                  # Adiciona o número de substrings válidas
                
        return answer
```

### Exemplos

#### Exemplo 1:
**Input**: s = "abcabc"  
**Output**: 10  
**Explicação**:  
- As substrings válidas são:  
  1. "abc" (índices 0 a 2)  
  2. "abca" (índices 0 a 3)  
  3. "abcab" (índices 0 a 4)  
  4. "abcabc" (índices 0 a 5)  
  5. "bca" (índices 1 a 3)  
  6. "bcab" (índices 1 a 4)  
  7. "bcabc" (índices 1 a 5)  
  8. "cab" (índices 2 a 4)  
  9. "cabc" (índices 2 a 5)  
  10. "abc" (índices 3 a 5)  

#### Exemplo 2:
**Input**: s = "aaacb"  
**Output**: 3  
**Explicação**:  
- As substrings válidas são:  
  1. "aaacb" (índices 0 a 4)  
  2. "aacb" (índices 1 a 4)  
  3. "acb" (índices 2 a 4)  

#### Exemplo 3:
**Input**: s = "abc"  
**Output**: 1  
**Explicação**:  
- A única substring válida é "abc" (índices 0 a 2).

### Conclusão

A solução é eficiente e utiliza a técnica de janela deslizante para contar as substrings válidas. Ao rastrear as últimas ocorrências de 'a', 'b' e 'c', garantimos que o problema seja resolvido com complexidade de tempo \( O(n) \).

---

## [EN]

### The Problem

Given a string `s`, we need to determine the total number of substrings that contain at least one occurrence of each of the characters 'a', 'b', and 'c'. The string `s` consists only of these three characters.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: A valid substring must contain at least one 'a', one 'b', and one 'c'. This means we need to track the last occurrence of each of these characters to determine how many valid substrings can be formed up to each position in the string.

2. **Efficient approach**: I used a **sliding window** technique to track the last occurrences of 'a', 'b', and 'c'. At each step, I check if all three characters have appeared in the string so far. If they have, I calculate the number of valid substrings ending at the current position.

3. **Implementation**:
   - Initialized variables to store the last occurrences of 'a', 'b', and 'c' as -1.
   - Iterated through the string, updating the last occurrences of each character.
   - When all three characters have appeared at least once, I calculated the number of valid substrings ending at the current position.

4. **Optimization**: The approach is efficient, with a time complexity of \( O(n) \), where \( n \) is the length of the string `s`.

### Complexity Analysis

- **Time complexity**: \( O(n) \), as we traverse the string once.
- **Space complexity**: \( O(1) \), as we only use a few variables to store the last occurrences of the characters.

### Code Solution

```python
class Solution:
    def numberOfSubstrings(self, s: str) -> int:
        last_a = last_b = last_c = -1  # Initialize the last occurrences of 'a', 'b', and 'c'
        answer = 0                     # Initialize the answer as 0
        
        for j in range(len(s)):        # Iterate through each character in the string
            if s[j] == 'a':
                last_a = j             # Update the last occurrence of 'a'
            elif s[j] == 'b':
                last_b = j             # Update the last occurrence of 'b'
            elif s[j] == 'c':
                last_c = j             # Update the last occurrence of 'c'
            
            # Check if all three characters have appeared
            if last_a >= 0 and last_b >= 0 and last_c >= 0:
                min_last = min(last_a, last_b, last_c)  # Find the smallest last occurrence
                answer += min_last + 1                  # Add the number of valid substrings
                
        return answer
```

### Examples

#### Example 1:
**Input**: s = "abcabc"  
**Output**: 10  
**Explanation**:  
- The valid substrings are:  
  1. "abc" (indices 0 to 2)  
  2. "abca" (indices 0 to 3)  
  3. "abcab" (indices 0 to 4)  
  4. "abcabc" (indices 0 to 5)  
  5. "bca" (indices 1 to 3)  
  6. "bcab" (indices 1 to 4)  
  7. "bcabc" (indices 1 to 5)  
  8. "cab" (indices 2 to 4)  
  9. "cabc" (indices 2 to 5)  
  10. "abc" (indices 3 to 5)  

#### Example 2:
**Input**: s = "aaacb"  
**Output**: 3  
**Explanation**:  
- The valid substrings are:  
  1. "aaacb" (indices 0 to 4)  
  2. "aacb" (indices 1 to 4)  
  3. "acb" (indices 2 to 4)  

#### Example 3:
**Input**: s = "abc"  
**Output**: 1  
**Explanation**:  
- The only valid substring is "abc" (indices 0 to 2).

### Conclusion

The solution is efficient and uses the sliding window technique to count valid substrings. By tracking the last occurrences of 'a', 'b', and 'c', we ensure the problem is solved with a time complexity of \( O(n) \).