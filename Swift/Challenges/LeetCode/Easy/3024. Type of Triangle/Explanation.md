## [PT/BR]

### O Problema

Você recebe um array de 3 inteiros `nums`, representando os três lados de um possível triângulo.

De acordo com as regras da geometria, **um triângulo é válido se a soma dos dois lados menores for maior que o lado maior**.

Além disso, devemos classificar o tipo do triângulo, se possível:

- **Equilátero**: todos os lados são iguais
- **Isósceles**: exatamente dois lados são iguais
- **Escaleno**: todos os lados são diferentes

Se não for possível formar um triângulo com esses valores, devemos retornar `"none"`.

---

### Raciocínio

1. **Verificação da validade do triângulo**:
   - Primeiro ordenamos os números para garantir: `a <= b <= c`
   - Verificamos: `a + b > c` → condição necessária e suficiente para existência do triângulo

2. **Classificação do tipo de triângulo**:
   - Se `a == b == c` → **equilátero**
   - Se **dois lados forem iguais** (`a == b` ou `b == c`) → **isósceles**
   - Se **todos os lados forem diferentes** → **escaleno**

3. **Vantagem da abordagem**:
   - Simples e direta
   - Complexidade constante $O(1)$ — sempre trabalhamos com 3 elementos

---

### Análise da Complexidade

- **Tempo**: $O(1)$ — Ordenamos apenas 3 elementos
- **Espaço**: $O(1)$ — Não usamos memória extra

---

### Solução em Código (comentários em português)

```swift
class Solution {
    func triangleType(_ nums: [Int]) -> String {
        // Ordena os lados para facilitar a verificação
        let sorted = nums.sorted()
        let a = sorted[0]
        let b = sorted[1]
        let c = sorted[2]
        
        // Condição de validade do triângulo
        if a + b <= c {
            return "none"
        }
        
        // Verifica o tipo de triângulo
        if a == b && b == c {
            return "equilateral"
        } else if a == b || b == c {
            return "isosceles"
        } else {
            return "scalene"
        }
    }
}
```

---

### Exemplos

#### Exemplo 1:
**Input**: `nums = [3,3,3]`  
**Output**: `"equilateral"`  
**Explicação**: Todos os lados são iguais → triângulo equilátero

#### Exemplo 2:
**Input**: `nums = [3,4,5]`  
**Output**: `"scalene"`  
**Explicação**: Todos os lados são diferentes → triângulo escaleno

#### Exemplo 3:
**Input**: `nums = [2,2,3]`  
**Output**: `"isosceles"`  
**Explicação**: Dois lados são iguais → triângulo isósceles

#### Exemplo 4:
**Input**: `nums = [1,2,3]`  
**Output**: `"none"`  
**Explicação**: `1 + 2 = 3` → não forma um triângulo válido

---

### Conclusão

Este é um problema clássico de geometria e lógica condicional. A solução é simples, mas cobre importantes conceitos:

- Validação geométrica de triângulos
- Classificação com base em igualdades entre lados
- Uso de ordenação para simplificar comparações

É ideal para iniciantes e também serve como base para problemas mais complexos envolvendo condições múltiplas.

---

## [EN]

### The Problem

You are given a 0-indexed integer array `nums` of size 3, representing the sides of a potential triangle.

A triangle is considered valid **if the sum of any two sides is greater than the third side**.

Additionally, you must classify the type of triangle formed:

- **Equilateral**: all three sides are equal
- **Isosceles**: exactly two sides are equal
- **Scalene**: all sides are different

If it's not possible to form a valid triangle, return `"none"`.

---

### Reasoning

1. **Triangle Validity Check**:
   - First, sort the array so that: `a <= b <= c`
   - Then check: `a + b > c` → necessary and sufficient condition

2. **Classification Logic**:
   - If all sides are equal → return `"equilateral"`
   - If at least two sides are equal → return `"isosceles"`
   - If all sides are different → return `"scalene"`

3. **Efficiency**:
   - Constant time: only sorting 3 elements and checking simple conditions
   - Constant space: no extra memory used

---

### Complexity Analysis

- **Time**: $O(1)$ — Sorting a fixed-size array and basic comparisons
- **Space**: $O(1)$ — No additional data structures used

---

### Code Solution (comments in English)

```swift
class Solution {
    func triangleType(_ nums: [Int]) -> String {
        // Sort the sides to simplify comparison logic
        let sorted = nums.sorted()
        let a = sorted[0]
        let b = sorted[1]
        let c = sorted[2]
        
        // Check if triangle can be formed
        if a + b <= c {
            return "none"
        }
        
        // Determine the type of triangle
        if a == b && b == c {
            return "equilateral"
        } else if a == b || b == c {
            return "isosceles"
        } else {
            return "scalene"
        }
    }
}
```

---

### Examples

#### Example 1:
**Input**: `[3, 3, 3]`  
**Output**: `"equilateral"`  
**Explanation**: All sides are equal → equilateral triangle

#### Example 2:
**Input**: `[3, 4, 5]`  
**Output**: `"scalene"`  
**Explanation**: All sides are different → scalene triangle

#### Example 3:
**Input**: `[2, 2, 3]`  
**Output**: `"isosceles"`  
**Explanation**: Two sides are equal → isosceles triangle

#### Example 4:
**Input**: `[1, 2, 3]`  
**Output**: `"none"`  
**Explanation**: `1 + 2 = 3` → doesn't satisfy triangle inequality

---

### Conclusion

This problem combines geometry with conditional logic. It’s a great exercise for beginners to practice:

- Triangle validity checks
- Classification based on equality
- Using sorting to simplify logic

Despite its simplicity, it reinforces important concepts like edge cases, validation, and classification.