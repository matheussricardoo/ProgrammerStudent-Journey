### O Operador `:=` (Operador de Declaração Curta de Variável)

O operador `:=` é uma forma concisa de **declarar e inicializar** uma variável ao mesmo tempo, exclusivamente dentro de funções. Ele faz duas coisas simultaneamente:

1. **Declara a variável:** Infere o tipo da variável com base no valor do lado direito da atribuição.
2. **Inicializa a variável:** Atribui o valor do lado direito à variável recém-declarada.

**Exemplo:**


```Go
package main

import "fmt"

func main() {
	// Usando := para declarar e inicializar 'mensagem'
	mensagem := "Olá, Go!" // 'mensagem' é inferida como tipo string
	numero := 42           // 'numero' é inferido como tipo int
	pi := 3.14             // 'pi' é inferido como tipo float64
	ativo := true          // 'ativo' é inferido como tipo bool

	fmt.Println(mensagem, numero, pi, ativo)

	// Comparação com a forma tradicional usando 'var':
	var outraMensagem string
	outraMensagem = "Tchau, Go!"

	var outroNumero int
	outroNumero = 100

	fmt.Println(outraMensagem, outroNumero)
}
```

**Principais Características e Regras do `:=`:**

1. **Apenas Dentro de Funções:** O operador `:=` só pode ser usado dentro do corpo de uma função. Para declarar variáveis no nível do pacote (fora de qualquer função), você deve usar a palavra-chave `var`.
    
    
    ```Go
    package main
    
    // var nomeGlobal string = "Sou Global" // Correto
    // nomeGlobal := "Sou Global"          // INCORRETO no nível do pacote
    
    func main() {
        nomeLocal := "Sou Local" // Correto
        fmt.Println(nomeLocal)
    }
    ```
    
2. **Declaração e Inicialização:** Ele sempre declara e inicializa. Você não pode usar `:=` com uma variável que já foi declarada no mesmo escopo.
    
    
    ```Go
    func main() {
        idade := 30
        // idade := 31 // INCORRETO: 'no new variables on left side of :=' - idade já foi declarada
        idade = 31    // CORRETO: Atribuição a uma variável existente
        fmt.Println(idade)
    }
    ```
    
3. **Pelo Menos Uma Nova Variável à Esquerda:** Em uma atribuição com `:=`, pelo menos uma das variáveis do lado esquerdo deve ser nova (ainda não declarada naquele escopo). As outras podem já existir, e nesse caso, elas são apenas reatribuídas.
    
    
    ```Go
    func main() {
        a := 10
        // b := 20 // Suponha que 'b' não foi declarado ainda
    
        // 'a' já existe, mas 'b' é nova, então é válido. 'a' será reatribuído.
        a, b := 100, 200
        fmt.Println(a, b)
    
        // a, b := 1, 2 // INCORRETO: 'no new variables on left side of :=' se 'a' e 'b' já foram declarados antes no mesmo escopo
    }
    ```
    
4. **Inferência de Tipo:** O tipo da variável é inferido automaticamente pelo compilador Go a partir do valor fornecido na inicialização. Isso torna o código mais enxuto.
    

**Por que usar `:=`?**

- **Concisão:** Reduz a verbosidade do código, tornando-o mais rápido de escrever e, muitas vezes, mais fácil de ler para declarações simples.
- **Idiomático:** É uma prática comum e idiomática em Go usar `:=` para declarações locais sempre que possível.