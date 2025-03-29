## [PT/BR]

### O Problema

Dado um array de inteiros `nums` e um inteiro `k`, o objetivo é maximizar uma pontuação. A pontuação é calculada multiplicando os valores de `k` elementos escolhidos de `nums`. Para escolher um elemento `nums[i]`, todos os elementos em um subarray que inclui `nums[i]` devem ter uma pontuação primária menor ou igual à pontuação primária de `nums[i]`. A pontuação primária de um número é definida como o número de seus fatores primos distintos.

Retorne a pontuação máxima possível módulo \( 10^9 + 7 \).

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1.  **Entender a Pontuação Primária**: Primeiro, precisamos de uma função para calcular a pontuação primária de um número. Esta função (`getPrimeScore`) itera de 2 até a raiz quadrada do número para encontrar seus fatores primos distintos.

2.  **Identificar Subarrays Válidos**: Para cada elemento `nums[i]`, precisamos encontrar o maior subarray contendo `nums[i]` onde `nums[i]` tem a pontuação primária máxima. Isso significa encontrar o índice mais à esquerda (`lPrimeIndex`) e o índice mais à direita (`rPrimeIndex`) tal que todos os elementos entre eles (inclusive) tenham uma pontuação primária menor ou igual à de `nums[i]`.

3.  **Contagem de Subarrays**: Uma vez que temos `lPrimeIndex[i]` e `rPrimeIndex[i]` para cada `i`, podemos calcular o número de subarrays onde `nums[i]` tem a pontuação primária máxima. Se o índice esquerdo for `L` e o índice direito for `R`, então o número de subarrays é `(i - L + 1) * (R - i + 1)`.

4.  **Estratégia Gananciosa**: Para maximizar a pontuação, devemos escolher os números com os maiores valores o maior número de vezes possível. Portanto, calculamos o número de vezes que cada número em `nums` pode ser o "máximo" em um subarray (com base na sua pontuação primária) e armazenamos essas informações em `offers`.

5.  **Ordenar as Ofertas**: Ordenamos as `offers` em ordem decrescente com base no valor do número. Isso nos permite considerar primeiro os números maiores.

6.  **Calcular a Pontuação Máxima**: Iteramos pelas `offers` ordenadas. Para cada oferta (valor e contagem), multiplicamos a pontuação atual pelo valor elevado à potência do número de vezes que podemos usar esse valor (limitado pela contagem disponível para esse valor e o número restante de elementos `k` que precisamos escolher). Todas as operações de multiplicação são realizadas módulo \( 10^9 + 7 \).

7.  **Função de Potência Modular**: Uma função auxiliar `power` é usada para calcular a potência modular de forma eficiente.

### Análise da Complexidade

-   **Complexidade de tempo**:
    -   `getPrimeScore`: No pior caso, a iteração vai até a raiz quadrada de `x`, então a complexidade é aproximadamente \( O(\sqrt{\max(nums)}) \). Como essa função é chamada para cada elemento em `nums`, a contribuição total é \( O(n \sqrt{\max(nums)}) \).
    -   Cálculo de `lPrimeIndex` e `rPrimeIndex`: Cada elemento é adicionado e removido da pilha no máximo uma vez, resultando em uma complexidade de \( O(n) \) para cada um.
    -   Geração de `offers`: Iteramos por `nums` uma vez, então a complexidade é \( O(n) \).
    -   Ordenação de `offers`: No pior caso, `offers` pode ter até `n` elementos, então a complexidade da ordenação é \( O(n \log n) \).
    -   Cálculo da pontuação máxima: Iteramos por `offers`, e para cada oferta, usamos a função `power`. A função `power` tem uma complexidade de \( O(\log k) \) no pior caso (onde `k` é o número de escolhas). A iteração por `offers` é no máximo `n`.
    -   A complexidade de tempo geral é dominada por \( O(n \sqrt{\max(nums)}) + O(n \log n) \).

-   **Complexidade de espaço**:
    -   `primeScores`, `lPrimeIndex`, `rPrimeIndex`: Cada um usa espaço \( O(n) \).
    -   `offers`: No pior caso, pode armazenar até `n` tuplas, usando espaço \( O(n) \).
    -   A pilha usada para calcular `lPrimeIndex` e `rPrimeIndex` pode ter no máximo `n` elementos, usando espaço \( O(n) \).
    -   A complexidade de espaço geral é \( O(n) \).

### Solução em Código

```swift
import Foundation

class Solution {
    func getPrimeScore(_ x: Int) -> Int {
        if x == 1 {
            return 0
        }
        var score = 0
        var num = x
        var d = 2
        while d * d <= num {
            if num % d == 0 {
                score += 1
                while num % d == 0 {
                    num /= d
                }
            }
            d += 1
        }
        if num > 1 {
            score += 1
        }
        return score
    }

    func maximumScore(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var primeScores = [Int](repeating: 0, count: n)
        for i in 0..<n {
            primeScores[i] = getPrimeScore(nums[i])
        }

        var lPrimeIndex = [Int](repeating: -1, count: n)
        var stack = [Int]()
        for i in 0..<n {
            while !stack.isEmpty && primeScores[stack.last!] < primeScores[i] {
                stack.removeLast()
            }
            if !stack.isEmpty {
                lPrimeIndex[i] = stack.last!
            }
            stack.append(i)
        }

        var rPrimeIndex = [Int](repeating: n, count: n)
        stack.removeAll()
        for i in (0..<n).reversed() {
            while !stack.isEmpty && primeScores[stack.last!] <= primeScores[i] {
                stack.removeLast()
            }
            if !stack.isEmpty {
                rPrimeIndex[i] = stack.last!
            }
            stack.append(i)
        }

        var offers: [(value: Int, count: Int)] = []
        for i in 0..<n {
            let L = lPrimeIndex[i] == -1 ? 0 : lPrimeIndex[i] + 1
            let R = rPrimeIndex[i] == n ? n - 1 : rPrimeIndex[i] - 1
            let count = (i - L + 1) * (R - i + 1)
            if count > 0 {
                offers.append((value: nums[i], count: count))
            }
        }

        offers.sort(by: { $0.value > $1.value })

        var score: Int = 1
        var kRemaining = k
        let modulo = 1000000007

        for offer in offers {
            if kRemaining == 0 {
                break
            }
            let uses = min(offer.count, kRemaining)
            score = (score * power(offer.value, uses, modulo)) % modulo
            kRemaining -= uses
        }

        return score
    }

    private func power(_ base: Int, _ exp: Int, _ modulus: Int) -> Int {
        var res = 1
        var a = base % modulus
        var b = exp
        while b > 0 {
            if b % 2 == 1 {
                res = (res * a) % modulus
            }
            a = (a * a) % modulus
            b /= 2
        }
        return res
    }
}
```

### Exemplos

Para fornecer exemplos concretos, precisaríamos de entradas específicas para `nums` e `k`. Como o problema não forneceu exemplos, vamos criar um cenário hipotético para ilustrar o raciocínio.

**Exemplo Hipotético:**

**Input**: `nums = [2, 3, 5]`, `k = 2`

1.  **Pontuações Primárias**:
    -   `getPrimeScore(2)` = 1 (fator primo: 2)
    -   `getPrimeScore(3)` = 1 (fator primo: 3)
    -   `getPrimeScore(5)` = 1 (fator primo: 5)
    -   `primeScores = [1, 1, 1]`

2.  **`lPrimeIndex` e `rPrimeIndex`**:
    -   Para `nums[0] = 2`: `lPrimeIndex[0] = -1`, `rPrimeIndex[0] = 1` (índice de 3) -> Contagem = `(0 - (-1) + 1) * (1 - 0 + 1) = 2 * 2 = 4` (Subarrays: `[2]`, `[2, 3]`) - *Erro na lógica aqui, `rPrimeIndex` deveria ser o primeiro índice com pontuação estritamente maior para a esquerda e maior ou igual para a direita.*

    Vamos corrigir o cálculo de `lPrimeIndex` e `rPrimeIndex`.

    -   `lPrimeIndex`:
        -   Para `i = 0` (valor 2, score 1): pilha vazia, `lPrimeIndex[0] = -1`, pilha = `[0]`
        -   Para `i = 1` (valor 3, score 1): `primeScores[0] < primeScores[1]` é falso, `lPrimeIndex[1] = 0`, pilha = `[0, 1]`
        -   Para `i = 2` (valor 5, score 1): `primeScores[1] < primeScores[2]` é falso, `lPrimeIndex[2] = 1`, pilha = `[0, 1, 2]`
        -   `lPrimeIndex = [-1, 0, 1]`

    -   `rPrimeIndex`:
        -   Para `i = 2` (valor 5, score 1): pilha vazia, `rPrimeIndex[2] = 3`, pilha = `[2]`
        -   Para `i = 1` (valor 3, score 1): `primeScores[2] <= primeScores[1]` é falso, `rPrimeIndex[1] = 2`, pilha = `[2, 1]`
        -   Para `i = 0` (valor 2, score 1): `primeScores[1] <= primeScores[0]` é falso, `rPrimeIndex[0] = 1`, pilha = `[2, 1, 0]`
        -   `rPrimeIndex = [1, 2, 3]`

3.  **`offers`**:
    -   Para `i = 0`: `L = 0`, `R = 0`, `count = (0 - 0 + 1) * (0 - 0 + 1) = 1`. Offer: `(value: 2, count: 1)`
    -   Para `i = 1`: `L = 1`, `R = 1`, `count = (1 - 1 + 1) * (1 - 1 + 1) = 1`. Offer: `(value: 3, count: 1)`
    -   Para `i = 2`: `L = 2`, `R = 2`, `count = (2 - 2 + 1) * (2 - 2 + 1) = 1`. Offer: `(value: 5, count: 1)`
    -   `offers = [(value: 2, count: 1), (value: 3, count: 1), (value: 5, count: 1)]`

4.  **Ordenar `offers`**:
    -   `offers = [(value: 5, count: 1), (value: 3, count: 1), (value: 2, count: 1)]`

5.  **Calcular a Pontuação Máxima**:
    -   `kRemaining = 2`, `score = 1`
    -   Offer `(value: 5, count: 1)`: `uses = min(1, 2) = 1`, `score = (1 * 5^1) % mod = 5`, `kRemaining = 1`
    -   Offer `(value: 3, count: 1)`: `uses = min(1, 1) = 1`, `score = (5 * 3^1) % mod = 15`, `kRemaining = 0`
    -   Resultado: `15`

Este exemplo ilustra como a função processa as entradas para chegar à pontuação máxima. A lógica envolve encontrar os intervalos onde cada número tem a pontuação primária máxima e, em seguida, usar uma abordagem gananciosa para selecionar os números com os maiores valores dentro desses intervalos.

### Conclusão

A solução apresentada utiliza uma combinação de cálculo de pontuação primária, identificação de intervalos e uma estratégia gananciosa para determinar a pontuação máxima. Ao pré-calcular as pontuações primárias e os limites dos intervalos, a função consegue calcular eficientemente o número de vezes que cada elemento pode contribuir para a pontuação final, permitindo a seleção dos elementos mais valiosos dentro das restrições dadas. A utilização da aritmética modular garante que o resultado permaneça dentro dos limites especificados.

---

## [EN]

### The Problem

Given an array of integers `nums` and an integer `k`, the goal is to maximize a score. The score is calculated by multiplying the values of `k` chosen elements from `nums`. To choose an element `nums[i]`, all elements in a subarray that includes `nums[i]` must have a prime score less than or equal to the prime score of `nums[i]`. The prime score of a number is defined as the number of its distinct prime factors.

Return the maximum possible score modulo \( 10^9 + 7 \).

### Reasoning

To solve this problem, I followed this reasoning:

1.  **Understand Prime Score**: First, we need a function to calculate the prime score of a number. This function (`getPrimeScore`) iterates from 2 up to the square root of the number to find its distinct prime factors.

2.  **Identify Valid Subarrays**: For each element `nums[i]`, we need to find the largest subarray containing `nums[i]` where `nums[i]` has the maximum prime score. This involves finding the leftmost index (`lPrimeIndex`) and the rightmost index (`rPrimeIndex`) such that all elements between them (inclusive) have a prime score less than or equal to that of `nums[i]`.

3.  **Count Subarrays**: Once we have `lPrimeIndex[i]` and `rPrimeIndex[i]` for each `i`, we can calculate the number of subarrays where `nums[i]` has the maximum prime score. If the left index is `L` and the right index is `R`, then the number of such subarrays is `(i - L + 1) * (R - i + 1)`.

4.  **Greedy Strategy**: To maximize the score, we should choose the numbers with the highest values as many times as possible. Therefore, we calculate the number of times each number in `nums` can be the "maximum" in a subarray (based on its prime score) and store this information in `offers`.

5.  **Sort the Offers**: We sort the `offers` in descending order based on the value of the number. This allows us to consider the larger numbers first.

6.  **Calculate Maximum Score**: We iterate through the sorted `offers`. For each offer (value and count), we multiply the current score by the value raised to the power of the number of times we can use this value (limited by the count available for this value and the remaining number of elements `k` we need to choose). All multiplication operations are performed modulo \( 10^9 + 7 \).

7.  **Modular Power Function**: An auxiliary function `power` is used to efficiently calculate the modular exponentiation.

### Complexity Analysis

-   **Time complexity**:
    -   `getPrimeScore`: In the worst case, the iteration goes up to the square root of `x`, so the complexity is approximately \( O(\sqrt{\max(nums)}) \). Since this function is called for each element in `nums`, the total contribution is \( O(n \sqrt{\max(nums)}) \).
    -   Calculation of `lPrimeIndex` and `rPrimeIndex`: Each element is added and removed from the stack at most once, resulting in a complexity of \( O(n) \) for each.
    -   Generation of `offers`: We iterate through `nums` once, so the complexity is \( O(n) \).
    -   Sorting of `offers`: In the worst case, `offers` can have up to `n` elements, so the sorting complexity is \( O(n \log n) \).
    -   Calculation of the maximum score: We iterate through `offers`, and for each offer, we use the `power` function. The `power` function has a complexity of \( O(\log k) \) in the worst case (where `k` is the number of choices). The iteration through `offers` is at most `n`.
    -   The overall time complexity is dominated by \( O(n \sqrt{\max(nums)}) + O(n \log n) \).

-   **Space complexity**:
    -   `primeScores`, `lPrimeIndex`, `rPrimeIndex`: Each uses \( O(n) \) space.
    -   `offers`: In the worst case, it can store up to `n` tuples, using \( O(n) \) space.
    -   The stack used for calculating `lPrimeIndex` and `rPrimeIndex` can have at most `n` elements, using \( O(n) \) space.
    -   The overall space complexity is \( O(n) \).

### Code Solution

```swift
import Foundation

class Solution {
    func getPrimeScore(_ x: Int) -> Int {
        if x == 1 {
            return 0
        }
        var score = 0
        var num = x
        var d = 2
        while d * d <= num {
            if num % d == 0 {
                score += 1
                while num % d == 0 {
                    num /= d
                }
            }
            d += 1
        }
        if num > 1 {
            score += 1
        }
        return score
    }

    func maximumScore(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var primeScores = [Int](repeating: 0, count: n)
        for i in 0..<n {
            primeScores[i] = getPrimeScore(nums[i])
        }

        var lPrimeIndex = [Int](repeating: -1, count: n)
        var stack = [Int]()
        for i in 0..<n {
            while !stack.isEmpty && primeScores[stack.last!] < primeScores[i] {
                stack.removeLast()
            }
            if !stack.isEmpty {
                lPrimeIndex[i] = stack.last!
            }
            stack.append(i)
        }

        var rPrimeIndex = [Int](repeating: n, count: n)
        stack.removeAll()
        for i in (0..<n).reversed() {
            while !stack.isEmpty && primeScores[stack.last!] <= primeScores[i] {
                stack.removeLast()
            }
            if !stack.isEmpty {
                rPrimeIndex[i] = stack.last!
            }
            stack.append(i)
        }

        var offers: [(value: Int, count: Int)] = []
        for i in 0..<n {
            let L = lPrimeIndex[i] == -1 ? 0 : lPrimeIndex[i] + 1
            let R = rPrimeIndex[i] == n ? n - 1 : rPrimeIndex[i] - 1
            let count = (i - L + 1) * (R - i + 1)
            if count > 0 {
                offers.append((value: nums[i], count: count))
            }
        }

        offers.sort(by: { $0.value > $1.value })

        var score: Int = 1
        var kRemaining = k
        let modulo = 1000000007

        for offer in offers {
            if kRemaining == 0 {
                break
            }
            let uses = min(offer.count, kRemaining)
            score = (score * power(offer.value, uses, modulo)) % modulo
            kRemaining -= uses
        }

        return score
    }

    private func power(_ base: Int, _ exp: Int, _ modulus: Int) -> Int {
        var res = 1
        var a = base % modulus
        var b = exp
        while b > 0 {
            if b % 2 == 1 {
                res = (res * a) % modulus
            }
            a = (a * a) % modulus
            b /= 2
        }
        return res
    }
}
```

### Examples

To provide concrete examples, we would need specific inputs for `nums` and `k`. As the problem description did not include examples, let's consider a hypothetical scenario to illustrate the reasoning.

**Hypothetical Example:**

**Input**: `nums = [2, 3, 5]`, `k = 2`

1.  **Prime Scores**:
    -   `getPrimeScore(2)` = 1 (prime factor: 2)
    -   `getPrimeScore(3)` = 1 (prime factor: 3)
    -   `getPrimeScore(5)` = 1 (prime factor: 5)
    -   `primeScores = [1, 1, 1]`

2.  **`lPrimeIndex` and `rPrimeIndex`**:
    -   `lPrimeIndex = [-1, 0, 1]`
    -   `rPrimeIndex = [1, 2, 3]`

3.  **`offers`**:
    -   For `i = 0`: `L = 0`, `R = 0`, `count = (0 - 0 + 1) * (0 - 0 + 1) = 1`. Offer: `(value: 2, count: 1)`
    -   For `i = 1`: `L = 1`, `R = 1`, `count = (1 - 1 + 1) * (1 - 1 + 1) = 1`. Offer: `(value: 3, count: 1)`
    -   For `i = 2`: `L = 2`, `R = 2`, `count = (2 - 2 + 1) * (2 - 2 + 1) = 1`. Offer: `(value: 5, count: 1)`
    -   `offers = [(value: 2, count: 1), (value: 3, count: 1), (value: 5, count: 1)]`

4.  **Sort `offers`**:
    -   `offers = [(value: 5, count: 1), (value: 3, count: 1), (value: 2, count: 1)]`

5.  **Calculate Maximum Score**:
    -   `kRemaining = 2`, `score = 1`
    -   Offer `(value: 5, count: 1)`: `uses = min(1, 2) = 1`, `score = (1 * 5^1) % 1000000007 = 5`, `kRemaining = 1`
    -   Offer `(value: 3, count: 1)`: `uses = min(1, 1) = 1`, `score = (5 * 3^1) % 1000000007 = 15`, `kRemaining = 0`
    -   Result: `15`

This example illustrates how the function processes the inputs to arrive at the maximum score. The logic involves finding the ranges where each number has the maximum prime score and then using a greedy approach to select the numbers with the highest values within those ranges.

### Conclusion

The provided Swift solution effectively addresses the problem by first calculating the prime score for each number in the input array. It then identifies the left and right boundaries for each number such that it has the maximum prime score within those boundaries. This information is used to determine the number of subarrays in which each number can be the chosen element. By sorting these "offers" based on the value of the number and applying a greedy strategy, the algorithm maximizes the score by selecting the largest numbers the maximum possible number of times, while adhering to the problem's constraints. The use of modular arithmetic ensures that the final score remains within the specified range.