Em Go, o controle de visibilidade (o que é frequentemente chamado de "público" ou "privado" em outras linguagens) é determinado pela **capitalização do primeiro caractere do identificador** (nome de variáveis, constantes, funções, tipos, campos de struct, etc.).

Não existem palavras-chave como `public`, `private` ou `protected` em Go. A regra é simples e elegante:

- **Maiúscula (Exportado/Público):** Se um identificador começa com uma letra maiúscula, ele é **exportado**. Isso significa que ele é visível e pode ser acessado por outros pacotes que importam o pacote onde ele foi definido.
- **Minúscula (Não Exportado/Privado ao Pacote):** Se um identificador começa com uma letra minúscula, ele é **não exportado**. Isso significa que ele é visível e acessível apenas dentro do mesmo pacote em que foi definido. Ele não pode ser acessado diretamente por código em outros pacotes.

Vamos a um exemplo para ilustrar:

Suponha que você tenha um pacote chamado `utils`:

**Arquivo `utils/helpers.go`:**


```Go
package utils

import "fmt"

// Pi é uma constante exportada porque começa com 'P' maiúsculo.
const Pi = 3.14159

// piInterno é uma constante não exportada (privada ao pacote utils)
// porque começa com 'p' minúsculo.
const piInterno = 3.14

// FuncaoPublica é uma função exportada.
func FuncaoPublica() {
	fmt.Println("Esta é uma função pública do pacote utils.")
	funcaoPrivada() // Pode chamar funções privadas do mesmo pacote
}

// funcaoPrivada é uma função não exportada.
func funcaoPrivada() {
	fmt.Println("Esta é uma função privada do pacote utils.")
}

// TipoPublico é um tipo exportado.
type TipoPublico struct {
	CampoPublico   string // Campo exportado
	campoPrivado string // Campo não exportado (privado ao pacote utils)
}

// MetodoPublico é um método exportado para TipoPublico.
func (tp *TipoPublico) MetodoPublico(valor string) {
	tp.CampoPublico = valor
	tp.campoPrivado = "valor interno alterado publicamente" // Acessível dentro do mesmo pacote
	fmt.Println("Método Público chamado:", tp.CampoPublico, "e o privado é:", tp.campoPrivado)
}

// metodoPrivado é um método não exportado para TipoPublico.
func (tp *TipoPublico) metodoPrivado() {
	fmt.Println("Método Privado chamado. Campo privado:", tp.campoPrivado)
}

// ConstrutorPublico cria uma instância de TipoPublico.
// Frequentemente se usa construtores para controlar a inicialização de campos privados.
func ConstrutorPublico(publico, privado string) *TipoPublico {
	return &TipoPublico{
		CampoPublico: publico,
		campoPrivado: privado, // Pode inicializar campos privados aqui
	}
}
```

Agora, vamos tentar usar este pacote `utils` em um pacote `main`:

**Arquivo `main.go` (em um diretório diferente, que importa `utils`):**


```Go
package main

import (
	"fmt"
	"seu_modulo/utils" // Assumindo que 'seu_modulo' é o nome do seu módulo Go
)

func main() {
	// Acessando identificadores exportados do pacote utils
	fmt.Println("Valor de Pi (público):", utils.Pi)
	utils.FuncaoPublica()

	// Tentativa de acessar identificadores não exportados (resultará em erro de compilação)
	// fmt.Println(utils.piInterno)  // Erro: utils.piInterno is not exported
	// utils.funcaoPrivada()        // Erro: utils.funcaoPrivada is not exported

	// Usando um tipo exportado e seus campos/métodos
	meuTipo := utils.TipoPublico{
		CampoPublico: "Olá Mundo",
		// campoPrivado: "isso não funciona", // Erro: utils.TipoPublico.campoPrivado is not exported
	}
	fmt.Println("Campo Público do struct:", meuTipo.CampoPublico)
	// fmt.Println(meuTipo.campoPrivado) // Erro: meuTipo.campoPrivado is not exported

	meuTipo.MetodoPublico("Novo Valor")
	// meuTipo.metodoPrivado() // Erro: meuTipo.metodoPrivado is not exported

	// Usando o construtor público para inicializar o struct, inclusive campos privados
	outroTipo := utils.ConstrutorPublico("Valor Público via Construtor", "Valor Privado via Construtor")
	fmt.Println("Instância via construtor:", outroTipo.CampoPublico)
	// Ainda não podemos acessar o campo privado diretamente de fora do pacote
	// fmt.Println(outroTipo.campoPrivado) // Erro
	// Mas o pacote utils pôde manipulá-lo internamente através do construtor e métodos públicos.
	outroTipo.MetodoPublico("Testando de novo")
}
```

**Pontos Chave a Anotar:**

1. **Escopo de Pacote:** "Privado" em Go significa privado ao pacote, não privado a uma `struct` ou arquivo específico dentro do pacote. Qualquer código no mesmo pacote pode acessar identificadores não exportados de outros arquivos dentro desse mesmo pacote.
2. **Simplicidade:** Essa convenção torna o código Go mais fácil de ler e entender em relação à visibilidade, pois não há necessidade de procurar por palavras-chave adicionais.
3. **Encapsulamento:** Embora não haja `private` explícito, a capitalização permite um bom nível de encapsulamento. Você expõe apenas o que é necessário para a API pública do seu pacote e mantém os detalhes de implementação internos (não exportados).
4. **Campos de Struct:** A mesma regra se aplica a campos dentro de `structs`. Se um campo de uma `struct` exportada começa com letra minúscula, ele não pode ser acessado diretamente de fora do pacote, mesmo que a `struct` em si seja exportada. Para manipular esses campos privados de fora, você normalmente fornece métodos exportados (getters/setters, se necessário, ou outras funções que operem sobre eles).
5. **Construtores:** É uma prática comum ter funções construtoras exportadas (como `ConstrutorPublico` no exemplo, ou mais comumente `NewNomeDoTipo`) que permitem a criação e inicialização de structs que podem ter campos não exportados.

Essa abordagem baseada em nomenclatura é uma das características distintivas e idiomáticas de Go. É simples, eficaz e promove um design de pacote claro.