## [PT/BR]

### O Problema

Dadas duas strings `str1` e `str2`, precisamos encontrar a string mais curta que tenha ambas `str1` e `str2` como subsequências.

Uma string `s` é uma **subsequência** de uma string `t` se for possível obter `s` removendo zero ou mais caracteres de `t`, sem alterar a ordem dos caracteres restantes.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: Se encontrarmos a Longest Common Subsequence (LCS) das duas strings, podemos usá-la como base para construir a supersequência mais curta.

2. **Abordagem por programação dinâmica**: Primeiro calculamos a LCS usando uma matriz de programação dinâmica.

3. **Construção eficiente**: Ao construir a supersequência, incluímos cada caractere da LCS apenas uma vez, enquanto mantemos todos os outros caracteres de ambas as strings.

4. **Implementação**:
   - Primeiro criamos uma matriz DP para encontrar o comprimento da LCS
   - Depois percorremos a matriz de trás para frente para construir a supersequência
   - Quando encontramos caracteres iguais (parte da LCS), incluímos apenas uma vez
   - Quando encontramos caracteres diferentes, incluímos os caracteres de ambas as strings

5. **Otimização**: A construção da supersequência é feita em uma única passagem pela matriz DP.

### Análise da Complexidade

- **Complexidade de tempo**: O(m×n), onde m é o comprimento de str1 e n é o comprimento de str2
  - O cálculo da matriz DP requer O(m×n)
  - A construção da supersequência requer O(m+n)
  
- **Complexidade de espaço**: O(m×n)
  - Precisamos armazenar a matriz DP completa

### Solução em Código

```python
def shortestCommonSupersequence(self, str1: str, str2: str) -> str:
    # Etapa 1: Encontre a Maior Subsequência Comum (LCS)
    m, n = len(str1), len(str2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    # Preencha a tabela dp
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if str1[i - 1] == str2[j - 1]:
                dp[i][j] = dp[i - 1][j - 1] + 1
            else:
                dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
    
    # Etapa 2: Construa a menor supersequência comum usando o LCS
    result = []
    i, j = m, n
    
    while i > 0 and j > 0:
        if str1[i - 1] == str2[j - 1]:
            # Personagem atual faz parte do LCS
            result.append(str1[i - 1])
            i -= 1
            j -= 1
        elif dp[i - 1][j] > dp[i][j - 1]:
            # Mover para a direção do valor maior na tabela dp
            result.append(str1[i - 1])
            i -= 1
        else:
            result.append(str2[j - 1])
            j -= 1
    
    # Incluir quaisquer caracteres restantes de qualquer string
    while i > 0:
        result.append(str1[i - 1])
        i -= 1
    while j > 0:
        result.append(str2[j - 1])
        j -= 1
    
    # Inverta o resultado (já que o construímos ao contrário)
    return ''.join(result[::-1])
```

### Exemplos

#### Exemplo 1:
**Input**: str1 = "abac", str2 = "cab"
**Output**: "cabac"
**Explicação**: 
- str1 = "abac" é uma subsequência de "cabac" pois podemos remover o primeiro "c".
- str2 = "cab" é uma subsequência de "cabac" pois podemos remover o último "ac".
- Esta é a string mais curta que tem ambas como subsequências.

Passo a passo da construção:
1. A matriz DP indica que a LCS é "a" (ou possivelmente "c" ou "b", dependendo do caminho).
2. Começando do final (i=4, j=3):
   - str1[3] = 'c' e str2[2] = 'b' são diferentes -> seguimos para dp[3][3]
   - str1[2] = 'a' e str2[2] = 'b' são diferentes -> seguimos para dp[3][2]
   - str1[2] = 'a' e str2[1] = 'a' são iguais -> adicionamos 'a' e seguimos para dp[2][1]
   - ... e assim por diante

#### Exemplo 2:
**Input**: str1 = "aaaaaaaa", str2 = "aaaaaaaa"
**Output**: "aaaaaaaa"
**Explicação**: Quando as strings são idênticas, a supersequência mais curta é a própria string.

### Conclusão

A solução é eficiente e usa propriedades da LCS para construir a supersequência mais curta. Ao identificar os caracteres comuns e incluí-los apenas uma vez, garantimos que estamos construindo a menor string possível que contém ambas as strings originais como subsequências.

---

## [EN]

### The Problem

Given two strings `str1` and `str2`, we need to find the shortest string that has both `str1` and `str2` as subsequences.

A string `s` is a **subsequence** of a string `t` if `s` can be obtained by deleting some number of characters from `t` (possibly zero) without changing the order of the remaining characters.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: If we find the Longest Common Subsequence (LCS) of the two strings, we can use it as a foundation to build the shortest common supersequence.

2. **Dynamic programming approach**: First, calculate the LCS using a dynamic programming matrix.

3. **Efficient construction**: When building the supersequence, include each character from the LCS only once, while maintaining all other characters from both strings.

4. **Implementation**:
   - First create a DP matrix to find the length of the LCS
   - Then traverse the matrix backwards to build the supersequence
   - When characters match (part of LCS), include only once
   - When characters differ, include characters from both strings

5. **Optimization**: The supersequence construction is done in a single pass through the DP matrix.

### Complexity Analysis

- **Time complexity**: O(m×n), where m is the length of str1 and n is the length of str2
  - Computing the DP matrix requires O(m×n)
  - Building the supersequence requires O(m+n)
  
- **Space complexity**: O(m×n)
  - We need to store the complete DP matrix

### Code Solution

```python
def shortestCommonSupersequence(self, str1: str, str2: str) -> str:
    # Step 1: Find the Longest Common Subsequence (LCS)
    m, n = len(str1), len(str2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    # Fill the dp table
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if str1[i - 1] == str2[j - 1]:
                dp[i][j] = dp[i - 1][j - 1] + 1
            else:
                dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
    
    # Step 2: Build the shortest common supersequence using the LCS
    result = []
    i, j = m, n
    
    while i > 0 and j > 0:
        if str1[i - 1] == str2[j - 1]:
            # Current character is part of LCS
            result.append(str1[i - 1])
            i -= 1
            j -= 1
        elif dp[i - 1][j] > dp[i][j - 1]:
            # Move to the direction of larger value in dp table
            result.append(str1[i - 1])
            i -= 1
        else:
            result.append(str2[j - 1])
            j -= 1
    
    # Include any remaining characters from either string
    while i > 0:
        result.append(str1[i - 1])
        i -= 1
    while j > 0:
        result.append(str2[j - 1])
        j -= 1
    
    # Reverse the result (since we built it backward)
    return ''.join(result[::-1])
```

### Examples

#### Example 1:
**Input**: str1 = "abac", str2 = "cab"
**Output**: "cabac"
**Explanation**: 
- str1 = "abac" is a subsequence of "cabac" because we can delete the first "c".
- str2 = "cab" is a subsequence of "cabac" because we can delete the last "ac".
- This is the shortest string that has both as subsequences.

Step by step construction:
1. The DP matrix indicates that the LCS is "a" (or possibly "c" or "b", depending on the path).
2. Starting from the end (i=4, j=3):
   - str1[3] = 'c' and str2[2] = 'b' are different -> move to dp[3][3]
   - str1[2] = 'a' and str2[2] = 'b' are different -> move to dp[3][2]
   - str1[2] = 'a' and str2[1] = 'a' are the same -> add 'a' and move to dp[2][1]
   - ... and so on

#### Example 2:
**Input**: str1 = "aaaaaaaa", str2 = "aaaaaaaa"
**Output**: "aaaaaaaa"
**Explanation**: When the strings are identical, the shortest common supersequence is the string itself.

### Conclusion

The solution is efficient and uses properties of the LCS to build the shortest common supersequence. By identifying common characters and including them only once, we ensure that we're constructing the shortest possible string that contains both original strings as subsequences.