**Closures** são um dos conceitos mais importantes e poderosos em Swift.

Vamos começar com uma analogia simples.

Imagine que você tem uma **mochila com instruções**.

- As **instruções** são um pedaço de código, uma tarefa a ser feita (ex: "faça um sanduíche").
- Dentro da **mochila**, você também coloca todos os **ingredientes** necessários que estavam ao seu redor quando você preparou a mochila (pão, queijo, presunto).

Uma **closure** é exatamente isso: é um bloco de código (as instruções) que "captura" e carrega consigo o ambiente onde foi criado (os ingredientes). Você pode então passar essa "mochila" para outra parte do seu programa, que pode "abrir a mochila" e executar as instruções com os ingredientes que estavam dentro, quando e onde for necessário.

---

### Definição Mais Formal

Uma **closure** é um **bloco de código autocontido que pode ser passado como um valor e usado em seu código**.

Elas são semelhantes a "blocos" em C e Objective-C, ou "lambdas" em outras linguagens de programação.

Em Swift, closures têm três formas principais:

1. **Funções Globais:** Funções que você define no escopo principal. Elas têm um nome, mas não capturam nenhum valor.
2. **Funções Aninhadas (Nested Functions):** Funções que você define dentro de outra função. Elas têm um nome e podem capturar valores do ambiente da função que as contém.
3. **Closure Expressions:** Blocos de código sem nome, escritos em uma sintaxe leve. É isso que a maioria das pessoas quer dizer quando fala "closure" em Swift. Elas podem capturar valores de seu contexto.

A grande força das closures vem de sua capacidade de **capturar e armazenar referências a quaisquer constantes e variáveis do contexto em que são definidas**. Isso é chamado de _closing over_ (daí o nome _closure_).

---

### **A Sintaxe: Do Longo ao Curto**

A sintaxe das closures em Swift é muito flexível, o que pode ser confuso no início. Vamos usar a função `sorted` (ordenar) de um array para ver a evolução.

Imagine que temos uma lista de nomes e queremos ordená-la do mais longo para o mais curto.


```Swift
let nomes = ["Beatriz", "Ana", "Carlos", "Daniela", "Eva"]
```

#### **Versão 1: Usando uma Função Normal (para comparação)**

Primeiro, vamos resolver isso com uma função normal. `sorted(by:)` espera uma função que recebe duas strings e retorna `true` se a primeira deve vir antes da segunda.


```Swift
func ordenarDoMaiorParaOMenor(s1: String, s2: String) -> Bool {
    return s1.count > s2.count
}
let nomesOrdenados = nomes.sorted(by: ordenarDoMaiorParaOMenor)
// Resultado: ["Daniela", "Beatriz", "Carlos", "Ana", "Eva"]
```

#### **Versão 2: A Closure Explícita**

Agora, vamos reescrever a função `ordenarDoMaiorParaOMenor` como uma _closure expression_ diretamente dentro da chamada `sorted(by:)`.


```Swift
let nomesOrdenados = nomes.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1.count > s2.count
})
```

- `{ ... }`: Delimita o início e o fim da closure.
- `(s1: String, s2: String) -> Bool`: A assinatura, definindo os parâmetros e o tipo de retorno.
- `in`: Palavra-chave que separa a assinatura do corpo da closure.

#### **Versão 3: Inferência de Tipo**

O Swift sabe que `sorted(by:)` em um array de `String` precisa de uma função `(String, String) -> Bool`. Portanto, podemos omitir os tipos.


```Swift
let nomesOrdenados = nomes.sorted(by: { s1, s2 in return s1.count > s2.count })
```

#### **Versão 4: Retorno Implícito**

Se a closure tem apenas uma única expressão, a palavra `return` pode ser omitida.


```Swift
let nomesOrdenados = nomes.sorted(by: { s1, s2 in s1.count > s2.count })
```

#### **Versão 5: Nomes de Argumentos Abreviados (`$0`, `$1`)**

Swift fornece nomes automáticos para os parâmetros: `$0` para o primeiro, `$1` para o segundo, e assim por diante. Se usarmos esses nomes, podemos remover `s1, s2 in`.


```Swift
let nomesOrdenados = nomes.sorted(by: { $0.count > $1.count })
```

#### **Versão 6: Sintaxe de Operador**

Para operadores como `>` e `+`, que já são funções que recebem dois parâmetros e retornam um valor, podemos passar apenas o operador.


```Swift
// Apenas para comparação, se quiséssemos ordenar alfabeticamente:
// let nomesOrdenados = nomes.sorted(by: <)

// No nosso caso de contar caracteres, a versão 5 é a mais curta.
```

#### **Versão 7: Trailing Closure**

Se uma closure é o **último** argumento de uma função, você pode escrevê-la **fora** dos parênteses. Esta é a forma mais comum e idiomática em Swift.


```Swift
let nomesOrdenados = nomes.sorted { $0.count > $1.count }
```

---

### **Captura de Valores: O Exemplo Clássico**

Este é o conceito mais importante. Uma closure pode "lembrar" e acessar variáveis e constantes de seu contexto, mesmo que esse contexto não exista mais.


```Swift
func criarIncrementador(incremento: Int) -> () -> Int {
    var total = 0 // 'total' é uma variável local de criarIncrementador

    // Definindo a closure que será retornada
    let incrementador: () -> Int = {
        // A closure 'captura' as variáveis 'total' e 'incremento'
        total += incremento
        return total
    }

    return incrementador
}

// Criamos uma "mochila" que sabe incrementar de 10 em 10
let incrementarDe10 = criarIncrementador(incremento: 10)

print(incrementarDe10()) // Output: 10
print(incrementarDe10()) // Output: 20 (ela lembrou do valor anterior de 'total')
print(incrementarDe10()) // Output: 30

// Criamos OUTRA "mochila", totalmente independente
let incrementarDe5 = criarIncrementador(incremento: 5)
print(incrementarDe5()) // Output: 5 (começou do zero de novo)
print(incrementarDe10()) // Output: 40 (a primeira mochila não foi afetada)
```

Cada closure (`incrementarDe10` e `incrementarDe5`) capturou sua própria cópia do ambiente (`total` e `incremento`), provando que elas são blocos de código verdadeiramente autocontidos.

### **Onde Closures São Usadas?**

- **Funções de Ordem Superior:** Como `map`, `filter`, `sorted`.
- **Completion Handlers (Manipuladores de Conclusão):** Para código assíncrono. Ex: "Faça essa chamada de rede e, _quando terminar_, execute esta closure".
- **Callbacks e Delegates:** Para responder a eventos, como o clique de um botão em SwiftUI.
- **APIs do Swift:** Em todo lugar! São fundamentais para a programação moderna em Swift.