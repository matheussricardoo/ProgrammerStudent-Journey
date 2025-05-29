Go é uma linguagem estaticamente tipada, o que significa que o tipo de cada variável deve ser conhecido em tempo de compilação. Isso ajuda a prevenir erros e melhora a performance do programa.

Existem basicamente **dois tipos principais de declarações de variáveis** em Go:

1. **Declaração explícita com `var`**
2. **Declaração curta com `:=`**

Além disso, podemos falar sobre:

- Tipos básicos
- Tipos compostos (arrays, slices, maps, structs)
- Tipos definidos pelo usuário
- Ponteiros

Vamos ver cada um com exemplos.

---

## 1️⃣ Declaração de variáveis

### 🔹 Usando `var`

```go
var nome string = "João"
var idade int = 30
```

Ou declarando sem inicializar:

```go
var altura float64
altura = 1.75
```

### 🔹 Usando declaração curta `:=`

Só pode ser usada dentro de funções.

```go
nome := "Maria"
idade := 25
```

Go infere automaticamente o tipo com base no valor atribuído.

---

## 2️⃣ Tipos Básicos em Go

Go possui uma variedade de tipos primitivos embutidos:

| Tipo        | Descrição                           |
|-------------|-------------------------------------|
| `bool`      | Valores booleanos (`true`, `false`) |
| `string`    | Sequências de caracteres            |
| `int`       | Inteiro (tamanho depende da arquitetura) |
| `int8`, `int16`, `int32`, `int64` | Tamanhos específicos de inteiros |
| `uint`, `uint8`, etc. | Inteiros sem sinal |
| `float32`, `float64` | Números de ponto flutuante |
| `complex64`, `complex128` | Números complexos |
| `byte`      | Alias para `uint8`                  |
| `rune`      | Alias para `int32` (representa Unicode code points) |

---

## 3️⃣ Tipos Compostos / Estruturados

### 🔹 Arrays

Tamanho fixo, tipo fixo.

```go
var numeros [3]int = [3]int{1, 2, 3}
```

### 🔹 Slices

Arrays dinâmicos (mais usados que arrays).

```go
numeros := []int{1, 2, 3}
```

### 🔹 Maps

Dicionários ou tabelas hash.

```go
usuario := map[string]string{
    "nome": "Carlos",
    "email": "carlos@example.com",
}
```

### 🔹 Structs

Estruturas de dados customizadas.

```go
type Pessoa struct {
    Nome  string
    Idade int
}

p := Pessoa{Nome: "Ana", Idade: 28}
```

---

## 4️⃣ Ponteiros

Ponteiros armazenam endereços de memória de outras variáveis.

```go
x := 10
p := &x // p é um ponteiro para x
fmt.Println(*p) // imprime 10
```

---

## 5️⃣ Tipos Definidos Pelo Usuário

Você pode criar novos tipos com `type`.

```go
type Celsius float64

var temperatura Celsius = 36.5
```

Isso ajuda na legibilidade e segurança de tipos.

---

## ✅ Dicas Úteis

- Use `:=` quando possível (dentro de funções).
- Use `var` para variáveis de escopo maior (fora de funções).
- Evite usar `var` com tipo e valor na mesma linha se não for necessário.
- Sempre declare apenas o necessário — Go incentiva simplicidade.

---

## 🧪 Exemplo Completo

```go
package main

import "fmt"

func main() {
    var nome string = "Pedro"
    idade := 40
    altura := 1.80
    ehCasado := true

    fmt.Printf("Nome: %s\n", nome)
    fmt.Printf("Idade: %d\n", idade)
    fmt.Printf("Altura: %.2f\n", altura)
    fmt.Printf("Casado? %t\n", ehCasado)

    // Struct
    type Usuario struct {
        login string
        nivel int
    }

    u := Usuario{"admin", 5}
    fmt.Println(u.login, "- nível:", u.nivel)
}
```

