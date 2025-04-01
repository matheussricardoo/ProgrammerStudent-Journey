## [PT/BR]

### O Problema

Você recebe um array 2D `questions` onde `questions[i] = [pointsi, brainpoweri]`. O array descreve as questões de uma prova, que devem ser processadas em ordem (começando pela questão 0). Para cada questão, você deve decidir se a resolve ou pula:

- **Resolver a questão i**: Você ganha `pointsi` pontos, mas não poderá resolver as próximas `brainpoweri` questões.
- **Pular a questão i**: Você pode decidir sobre a próxima questão.

O objetivo é retornar a quantidade máxima de pontos que você pode obter na prova.

### Raciocínio

1. **Programação Dinâmica (PD)**:
   - Utilizamos um array `dp` onde `dp[i]` representa a pontuação máxima que pode ser obtida a partir da questão `i` até o final da prova.
   - Inicializamos `dp` com zeros e preenchemos de trás para frente (do final para o início do array `questions`).

2. **Decisão em Cada Questão**:
   - Para cada questão `i`, calculamos duas opções:
     - **Resolver a questão**: Ganhamos `pointsi` pontos e pulamos `brainpoweri` questões, então a próxima questão disponível será `i + brainpoweri + 1`.
     - **Pular a questão**: A pontuação máxima será a mesma da próxima questão (`dp[i + 1]`).
   - Armazenamos em `dp[i]` o máximo entre essas duas opções.

3. **Casos Especiais**:
   - Se `i + brainpoweri + 1` ultrapassar o número total de questões, consideramos que não há mais questões para resolver, então a pontuação adicional é zero.

### Análise da Complexidade

- **Tempo**:
  - Percorremos o array `questions` uma vez, do final para o início: \( O(n) \), onde `n` é o número de questões.
- **Espaço**:
  - Utilizamos um array `dp` de tamanho `n + 1`: \( O(n) \).

### Solução em Código

```swift
import Foundation

class Solution {
    func mostPoints(_ questions: [[Int]]) -> Int {
        let n = questions.count
        var dp = Array(repeating: 0, count: n + 1) // Usamos Int pois a soma pode exceder os limites de Int32

        for i in stride(from: n - 1, through: 0, by: -1) {
            let points = questions[i][0]
            let brainpower = questions[i][1]
            
            let nextQuestionIndex = i + brainpower + 1
            
            // Garantimos que o índice esteja dentro dos limites, mapeando índices fora para dp[n] que é 0
            let pointsIfSolved = points + dp[min(nextQuestionIndex, n)] 
            let pointsIfSkipped = dp[i + 1]

            dp[i] = max(pointsIfSolved, pointsIfSkipped)
        }

        return dp[0]
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `questions = [[3,2],[4,3],[4,4],[2,5]]`  
**Output**: `5`  
**Explicação**:
- Resolver questão 0: Ganha 3 pontos, pula questões 1 e 2.
- Resolver questão 3: Ganha 2 pontos.
- Total: 3 + 2 = 5 pontos.

#### Exemplo 2:
**Input**: `questions = [[1,1],[2,2],[3,3],[4,4],[5,5]]`  
**Output**: `7`  
**Explicação**:
- Pular questão 0.
- Resolver questão 1: Ganha 2 pontos, pula questões 2 e 3.
- Resolver questão 4: Ganha 5 pontos.
- Total: 2 + 5 = 7 pontos.

### Conclusão

A solução utiliza programação dinâmica para calcular eficientemente a pontuação máxima possível, considerando as decisões de resolver ou pular cada questão. A abordagem de preencher o array `dp` de trás para frente garante que todas as possibilidades sejam exploradas de forma ótima, resultando em uma solução eficiente tanto em tempo quanto em espaço.

---

## [EN]

### The Problem

You are given a 0-indexed 2D integer array `questions` where `questions[i] = [pointsi, brainpoweri]`. The array describes the questions of an exam, which must be processed in order (starting from question 0). For each question, you must decide whether to solve or skip it:

- **Solve question i**: You earn `pointsi` points but cannot solve the next `brainpoweri` questions.
- **Skip question i**: You can decide on the next question.

The goal is to return the maximum points you can earn for the exam.

### Reasoning

1. **Dynamic Programming (DP)**:
   - We use a `dp` array where `dp[i]` represents the maximum points that can be earned from question `i` to the end of the exam.
   - Initialize `dp` with zeros and fill it from back to front (from the end to the start of the `questions` array).

2. **Decision at Each Question**:
   - For each question `i`, calculate two options:
     - **Solve the question**: Earn `pointsi` points and skip `brainpoweri` questions, so the next available question will be `i + brainpoweri + 1`.
     - **Skip the question**: The maximum points will be the same as the next question (`dp[i + 1]`).
   - Store in `dp[i]` the maximum of these two options.

3. **Special Cases**:
   - If `i + brainpoweri + 1` exceeds the total number of questions, consider that there are no more questions to solve, so the additional points are zero.

### Complexity Analysis

- **Time**:
  - Traverse the `questions` array once, from back to front: \( O(n) \), where `n` is the number of questions.
- **Space**:
  - Use a `dp` array of size `n + 1`: \( O(n) \).

### Code Solution

```swift
import Foundation

class Solution {
    func mostPoints(_ questions: [[Int]]) -> Int {
        let n = questions.count
        var dp = Array(repeating: 0, count: n + 1) // Use Int as sum can exceed typical Int32 limits

        for i in stride(from: n - 1, through: 0, by: -1) {
            let points = questions[i][0]
            let brainpower = questions[i][1]
            
            let nextQuestionIndex = i + brainpower + 1
            
            // Ensure index stays within bounds, mapping out-of-bounds to dp[n] which is 0
            let pointsIfSolved = points + dp[min(nextQuestionIndex, n)] 
            let pointsIfSkipped = dp[i + 1]

            dp[i] = max(pointsIfSolved, pointsIfSkipped)
        }

        return dp[0]
    }
}
```

### Examples

#### Example 1:
**Input**: `questions = [[3,2],[4,3],[4,4],[2,5]]`  
**Output**: `5`  
**Explanation**:
- Solve question 0: Earn 3 points, skip questions 1 and 2.
- Solve question 3: Earn 2 points.
- Total: 3 + 2 = 5 points.

#### Example 2:
**Input**: `questions = [[1,1],[2,2],[3,3],[4,4],[5,5]]`  
**Output**: `7`  
**Explanation**:
- Skip question 0.
- Solve question 1: Earn 2 points, skip questions 2 and 3.
- Solve question 4: Earn 5 points.
- Total: 2 + 5 = 7 points.

### Conclusion

The solution uses dynamic programming to efficiently calculate the maximum possible points by considering the decisions to solve or skip each question. The approach of filling the `dp` array from back to front ensures that all possibilities are optimally explored, resulting in an efficient solution in both time and space.