## [PT/BR]

### O Problema

Dada uma string `word` e um inteiro não negativo `k`, precisamos determinar o número total de substrings de `word` que contêm todas as vogais ('a', 'e', 'i', 'o', 'u') pelo menos uma vez e exatamente `k` consoantes.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: Uma substring válida deve conter todas as cinco vogais pelo menos uma vez e exatamente `k` consoantes. Isso significa que precisamos rastrear a presença de todas as vogais e o número de consoantes em cada substring possível.

2. **Abordagem eficiente**: Utilizei uma técnica de **janela deslizante** combinada com **prefix sums** para contar o número de consoantes em substrings. Além disso, usei um mapa de frequência para rastrear as ocorrências das vogais e garantir que todas estejam presentes na substring.

3. **Implementação**:
   - Criei um array de prefix sums para contar o número de consoantes até cada índice da string.
   - Usei um dicionário para armazenar o último índice onde cada vogal foi vista.
   - Utilizei um mapa de frequência para contar quantas vezes cada número de consoantes aparece em substrings válidas.
   - Iterei pela string, atualizando os últimos índices das vogais e o mapa de frequência, e contando as substrings válidas.

4. **Otimização**: A abordagem é eficiente, com complexidade de tempo \( O(n) \), onde \( n \) é o comprimento da string `word`.

### Análise da Complexidade

- **Complexidade de tempo**: \( O(n) \), pois percorremos a string uma única vez.
- **Complexidade de espaço**: \( O(n) \), devido ao uso do array de prefix sums e do dicionário para armazenar os últimos índices das vogais.

### Solução em Código

```python
from collections import defaultdict

class Solution:
    def countOfSubstrings(self, word: str, k: int) -> int:
        # Definir o conjunto de vogais
        vowels = set('aeiou')
        n = len(word)
        
        # Calcular a soma de prefixo para consoantes
        cons = [0] * n
        if word[0] not in vowels:
            cons[0] = 1
        for j in range(1, n):
            cons[j] = cons[j-1] + (1 if word[j] not in vowels else 0)
        
        # Inicializar os últimos índices vistos das vogais
        last_v = {v: -1 for v in 'aeiou'}
        
        # Mapa de frequência para contagens de consoantes
        freq = defaultdict(int)
        
        answer = 0
        current_max_min_last = -1
        
        # Iterar por cada posição j na string
        for j in range(n):
            # Atualizar o último índice da vogal se aplicável
            if word[j] in vowels:
                last_v[word[j]] = j
            
            # Verificar se todas as vogais foram vistas
            if all(last_v[v] >= 0 for v in 'aeiou'):
                min_last = min(last_v[v] for v in 'aeiou')
                
                # Atualizar o mapa de frequência até min_last - 1
                while current_max_min_last < min_last - 1:
                    current_max_min_last += 1
                    freq[cons[current_max_min_last]] += 1
                
                # Contar substring começando do índice 0
                if cons[j] == k:
                    answer += 1
                
                # Contar substrings começando de i > 0
                if cons[j] - k in freq:
                    answer += freq[cons[j] - k]
        
        return answer
```

### Exemplos

#### Exemplo 1:
**Input**: word = "aeioqq", k = 1  
**Output**: 0  
**Explicação**:  
- Não há substring que contenha todas as vogais e exatamente 1 consoante.

#### Exemplo 2:
**Input**: word = "aeiou", k = 0  
**Output**: 1  
**Explicação**:  
- A única substring que contém todas as vogais e zero consoantes é a própria string "aeiou".

#### Exemplo 3:
**Input**: word = "ieaouqqieaouqq", k = 1  
**Output**: 3  
**Explicação**:  
- As substrings válidas são:  
  1. "ieaouq" (índices 0 a 5)  
  2. "qieaou" (índices 6 a 11)  
  3. "ieaouq" (índices 7 a 12)  

### Conclusão

A solução é eficiente e utiliza técnicas de janela deslizante e prefix sums para contar as substrings válidas. Ao rastrear as vogais e as consoantes de forma otimizada, garantimos que o problema seja resolvido com complexidade de tempo \( O(n) \).

---

## [EN]

### The Problem

Given a string `word` and a non-negative integer `k`, we need to determine the total number of substrings of `word` that contain all five vowels ('a', 'e', 'i', 'o', 'u') at least once and exactly `k` consonants.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: A valid substring must contain all five vowels at least once and exactly `k` consonants. This means we need to track the presence of all vowels and the number of consonants in each possible substring.

2. **Efficient approach**: I used a **sliding window** technique combined with **prefix sums** to count the number of consonants in substrings. Additionally, I used a frequency map to track the occurrences of vowels and ensure all are present in the substring.

3. **Implementation**:
   - Created a prefix sum array to count the number of consonants up to each index in the string.
   - Used a dictionary to store the last index where each vowel was seen.
   - Utilized a frequency map to count how many times each consonant count appears in valid substrings.
   - Iterated through the string, updating the last indices of vowels and the frequency map, and counting valid substrings.

4. **Optimization**: The approach is efficient, with a time complexity of \( O(n) \), where \( n \) is the length of the string `word`.

### Complexity Analysis

- **Time complexity**: \( O(n) \), as we traverse the string once.
- **Space complexity**: \( O(n) \), due to the use of the prefix sum array and the dictionary to store the last indices of vowels.

### Code Solution

```python
from collections import defaultdict

class Solution:
    def countOfSubstrings(self, word: str, k: int) -> int:
        # Define the set of vowels
        vowels = set('aeiou')
        n = len(word)
        
        # Calculate the prefix sum for consonants
        cons = [0] * n
        if word[0] not in vowels:
            cons[0] = 1
        for j in range(1, n):
            cons[j] = cons[j-1] + (1 if word[j] not in vowels else 0)
        
        # Initialize the last seen indices of vowels
        last_v = {v: -1 for v in 'aeiou'}
        
        # Frequency map for consonant counts
        freq = defaultdict(int)
        
        answer = 0
        current_max_min_last = -1
        
        # Iterate through each position j in the string
        for j in range(n):
            # Update the last index of the vowel if applicable
            if word[j] in vowels:
                last_v[word[j]] = j
            
            # Check if all vowels have been seen
            if all(last_v[v] >= 0 for v in 'aeiou'):
                min_last = min(last_v[v] for v in 'aeiou')
                
                # Update the frequency map up to min_last - 1
                while current_max_min_last < min_last - 1:
                    current_max_min_last += 1
                    freq[cons[current_max_min_last]] += 1
                
                # Count substring starting from index 0
                if cons[j] == k:
                    answer += 1
                
                # Count substrings starting from i > 0
                if cons[j] - k in freq:
                    answer += freq[cons[j] - k]
        
        return answer
```

### Examples

#### Example 1:
**Input**: word = "aeioqq", k = 1  
**Output**: 0  
**Explanation**:  
- There is no substring that contains all vowels and exactly 1 consonant.

#### Example 2:
**Input**: word = "aeiou", k = 0  
**Output**: 1  
**Explanation**:  
- The only substring that contains all vowels and zero consonants is the string itself, "aeiou".

#### Example 3:
**Input**: word = "ieaouqqieaouqq", k = 1  
**Output**: 3  
**Explanation**:  
- The valid substrings are:  
  1. "ieaouq" (indices 0 to 5)  
  2. "qieaou" (indices 6 to 11)  
  3. "ieaouq" (indices 7 to 12)  

### Conclusion

The solution is efficient and uses sliding window and prefix sum techniques to count valid substrings. By tracking vowels and consonants optimally, we ensure the problem is solved with a time complexity of \( O(n) \).