## [PT/BR]

### O Problema

Dado um número inteiro \( n \), precisamos determinar se é possível representar \( n \) como a soma de potências distintas de três. Caso contrário, retornamos `false`.

Uma potência de três é um número da forma \( 3^x \), onde \( x \) é um inteiro não negativo.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Característica chave**: Se \( n \) pode ser representado como a soma de potências distintas de três, sua representação na base 3 (ternária) não pode conter o dígito 2. Isso porque o dígito 2 implicaria que uma mesma potência de três está sendo usada mais de uma vez, o que viola a condição de "distintas".

2. **Abordagem eficiente**: Podemos converter \( n \) para a base 3 e verificar se algum dígito é igual a 2. Se sim, a resposta é `false`; caso contrário, é `true`.

3. **Implementação**:
   - Dividimos \( n \) por 3 repetidamente e verificamos o resto da divisão.
   - Se o resto for 2, retornamos `false`.
   - Se o loop terminar sem encontrar nenhum resto igual a 2, retornamos `true`.

4. **Otimização**: Essa abordagem é eficiente, pois converte \( n \) para a base 3 em tempo \( O(\log_3 n) \).

### Análise da Complexidade

- **Complexidade de tempo**: \( O(\log_3 n) \), onde \( n \) é o número dado.
  - O número de divisões necessárias é proporcional ao número de dígitos na representação ternária de \( n \).
  
- **Complexidade de espaço**: \( O(1) \)
  - Usamos apenas algumas variáveis para armazenar o resto e o quociente durante as divisões.

### Solução em Código

```python
class Solution:
    def checkPowersOfThree(self, n: int) -> bool:
        while n > 0:
            remainder = n % 3  # Calcula o resto da divisão por 3
            if remainder == 2:  # Se o resto for 2, não é possível
                return False
            n = n // 3  # Divide n por 3 para continuar o processo
        return True  # Se o loop terminar sem encontrar resto 2, é possível
```

### Exemplos

#### Exemplo 1:
**Input**: n = 12  
**Output**: true  
**Explicação**:  
12 pode ser representado como \( 3^1 + 3^2 = 3 + 9 = 12 \).  
A representação ternária de 12 é 110, que não contém o dígito 2.

#### Exemplo 2:
**Input**: n = 91  
**Output**: true  
**Explicação**:  
91 pode ser representado como \( 3^0 + 3^2 + 3^4 = 1 + 9 + 81 = 91 \).  
A representação ternária de 91 é 10101, que não contém o dígito 2.

#### Exemplo 3:
**Input**: n = 21  
**Output**: false  
**Explicação**:  
21 não pode ser representado como a soma de potências distintas de três.  
A representação ternária de 21 é 210, que contém o dígito 2.

### Conclusão

A solução é eficiente e utiliza uma abordagem simples baseada na conversão de \( n \) para a base 3. Ao verificar a ausência do dígito 2 na representação ternária, garantimos que \( n \) pode ser representado como a soma de potências distintas de três.

---

## [EN]

### The Problem

Given an integer \( n \), we need to determine if it is possible to represent \( n \) as the sum of distinct powers of three. Otherwise, return `false`.

A power of three is a number of the form \( 3^x \), where \( x \) is a non-negative integer.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Key insight**: If \( n \) can be represented as the sum of distinct powers of three, its base-3 (ternary) representation must not contain the digit 2. This is because the digit 2 would imply that the same power of three is being used more than once, which violates the "distinct" condition.

2. **Efficient approach**: We can convert \( n \) to base 3 and check if any digit is equal to 2. If so, the answer is `false`; otherwise, it is `true`.

3. **Implementation**:
   - Repeatedly divide \( n \) by 3 and check the remainder.
   - If the remainder is 2, return `false`.
   - If the loop completes without finding any remainder equal to 2, return `true`.

4. **Optimization**: This approach is efficient, as it converts \( n \) to base 3 in \( O(\log_3 n) \) time.

### Complexity Analysis

- **Time complexity**: \( O(\log_3 n) \), where \( n \) is the given number.
  - The number of divisions required is proportional to the number of digits in the ternary representation of \( n \).
  
- **Space complexity**: \( O(1) \)
  - We only use a few variables to store the remainder and quotient during the divisions.

### Code Solution

```python
class Solution:
    def checkPowersOfThree(self, n: int) -> bool:
        while n > 0:
            remainder = n % 3  # Calculate the remainder when divided by 3
            if remainder == 2:  # If the remainder is 2, it's not possible
                return False
            n = n // 3  # Divide n by 3 to continue the process
        return True  # If the loop completes without finding remainder 2, it's possible
```

### Examples

#### Example 1:
**Input**: n = 12  
**Output**: true  
**Explanation**:  
12 can be represented as \( 3^1 + 3^2 = 3 + 9 = 12 \).  
The ternary representation of 12 is 110, which does not contain the digit 2.

#### Example 2:
**Input**: n = 91  
**Output**: true  
**Explanation**:  
91 can be represented as \( 3^0 + 3^2 + 3^4 = 1 + 9 + 81 = 91 \).  
The ternary representation of 91 is 10101, which does not contain the digit 2.

#### Example 3:
**Input**: n = 21  
**Output**: false  
**Explanation**:  
21 cannot be represented as the sum of distinct powers of three.  
The ternary representation of 21 is 210, which contains the digit 2.

### Conclusion

The solution is efficient and uses a simple approach based on converting \( n \) to base 3. By checking for the absence of the digit 2 in the ternary representation, we ensure that \( n \) can be represented as the sum of distinct powers of three.
