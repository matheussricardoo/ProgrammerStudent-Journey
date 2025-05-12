
Todo programador já se deparou com o clássico "Olá, Mundo" ao aprender uma nova linguagem, e aqui não é diferente. Começando a aprender Go, vamos iniciar implementando o "Hello, World!"

```go
// Declara que este arquivo pertence ao pacote 'main'.
// Pacotes 'main' são compilados em programas executáveis.
package main

// Importa o pacote 'fmt', que contém funções para formatação de entrada e saída.
import "fmt"

// Declara a função 'main', o ponto de entrada do programa.
// Esta função é automaticamente executada quando o programa roda.
// Não recebe argumentos () e não retorna valores explicitamente.
func main () {
	// Chama a função 'Println' do pacote 'fmt'.
	// 'Println' imprime a string "Hello, Go!" no console,
	// seguida por um caractere de nova linha.
	fmt.Println("Hello, Go!")
}
```

### `package main`

- **O que é?** Em Go, todo arquivo `.go` pertence a um pacote. Um pacote é uma coleção de arquivos Go no mesmo diretório que são compilados juntos.
- **Por que `main`?** O pacote `main` é especial. Ele informa ao compilador Go que este pacote, quando compilado, deve produzir um programa executável (um arquivo que você pode rodar diretamente). Se você estivesse criando uma biblioteca (um conjunto de código para ser usado por outros programas), você daria um nome diferente ao pacote.
- **Declaração:** A linha `package main` declara que este arquivo pertence ao pacote `main`. É obrigatório que todo programa executável em Go tenha um pacote `main` e uma função `main` (veremos a seguir).

### `import "fmt"`

- **O que é?** A declaração `import` permite que seu programa acesse funcionalidades definidas em outros pacotes. Go possui uma vasta biblioteca padrão com muitos pacotes úteis.
- **Pacote `fmt`:** O pacote `fmt` (abreviação de "format") é um dos pacotes mais comuns da biblioteca padrão de Go. Ele contém funções para formatação de entrada e saída, como imprimir texto no console, ler dados do usuário, formatar strings, etc.
- **Como funciona:** Ao importar `fmt`, você ganha acesso a todas as funções _exportadas_ (aquelas que começam com letra maiúscula) desse pacote. No nosso caso, estamos interessados na função `Println`.
- **Convenção:** Geralmente, as importações são agrupadas no início do arquivo, logo após a declaração do pacote. Se você precisar importar múltiplos pacotes, eles podem ser listados individualmente (`import "pacote1"`, `import "pacote2"`) ou agrupados em parênteses:

```go
import (
  "fmt"
  "math"
) 
  ```

### `func main () { ... }`

- **O que é `func`?** `func` é a palavra-chave usada em Go para declarar uma função. Funções são blocos de código que realizam uma tarefa específica.
- **Função `main`:** Assim como o pacote `main`, a função `main` também é especial. Quando você executa um programa Go compilado, a execução sempre começa pela função `main` dentro do pacote `main`. É o ponto de entrada do seu programa.
- **Estrutura:**
    - `func main()`: Declara uma função chamada `main`. Os parênteses `()` indicam que esta função não recebe nenhum argumento (parâmetro de entrada).
    - `{ ... }`: As chaves delimitam o corpo da função, ou seja, o conjunto de instruções que serão executadas quando a função `main` for chamada (o que acontece automaticamente ao rodar o programa).

### `fmt.Println("Hello, Go!")`

- **Ação:** Esta é a linha que efetivamente faz o trabalho de imprimir o texto no console.
- **`fmt.Println`:**
    - `fmt`: Indica que estamos usando uma função do pacote `fmt` que importamos anteriormente.
    - `.`: O ponto é usado para acessar membros de um pacote (ou de uma struct, que veremos mais tarde).
    - `Println`: É o nome da função. `Println` significa "Print Line" (Imprimir Linha). Ela imprime os argumentos fornecidos, adiciona um espaço entre eles se houver mais de um, e finaliza com um caractere de nova linha (`\n`), movendo o cursor para a próxima linha no console.
- **`"Hello, Go!"`:** Este é o argumento que estamos passando para a função `Println`. É uma _string literal_, ou seja, uma sequência de caracteres delimitada por aspas duplas. A função `Println` receberá essa string e a exibirá na saída padrão (geralmente o seu terminal ou console).

Obs: Caso você esteja utilizando o [Go Playground](https://go.dev/play/), ao clicar em "Run" o código será automaticamente formatado, seguindo boas práticas já integradas ao editor online. Caso esteja usando um editor de texto ou o terminal local, utilize o comando `go fmt nome_do_arquivo.go`, que fará a formatação para você.

