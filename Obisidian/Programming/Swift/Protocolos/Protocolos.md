**Protocolos** em Swift são uma das funcionalidades mais poderosas e fundamentais da linguagem. Eles definem um "contrato" ou um "plano" de métodos, propriedades e outros requisitos que um tipo (seja uma `class`, `struct` ou `enum`) deve implementar se quiser "adotar" ou "conformar" a esse protocolo.

Pense em um protocolo como um conjunto de regras ou uma descrição de habilidades. Ele diz _o que_ um tipo deve ser capaz de fazer, mas não _como_ ele deve fazer.

---

### Para que servem os Protocolos?

Os protocolos são usados para alcançar vários objetivos importantes na programação:

1. **Abstração:** Permitem definir funcionalidades de forma abstrata, sem se preocupar com a implementação específica. Você pode escrever código que interage com um "tipo que sabe voar" sem saber se é um pássaro, um avião ou um drone.
2. **Polimorfismo:** Permitem que diferentes tipos sejam tratados de maneira uniforme se conformarem ao mesmo protocolo. Você pode ter uma coleção de objetos de tipos diferentes, mas todos eles podem responder às mesmas chamadas de método se conformarem ao mesmo protocolo.
    - Exemplo: Uma lista `[Veiculo]` onde `Carro`, `Moto` e `Bicicleta` conformam ao protocolo `Veiculo`.
3. **Desacoplamento e Reutilização de Código:** Tornam seu código mais flexível e modular. Componentes que dependem de protocolos em vez de tipos concretos são mais fáceis de substituir e testar.
4. **Delegação (Delegation):** Um padrão de design muito comum em Swift e Cocoa, onde um objeto (o delegador) transfere algumas de suas responsabilidades para outro objeto (o delegado). Essa comunicação é frequentemente definida por um protocolo.
5. **"Herança Múltipla" de Comportamento:** Diferente de classes que só podem herdar de uma superclasse, um tipo pode conformar a múltiplos protocolos, "herdando" assim múltiplos conjuntos de requisitos de comportamento.
6. **Testabilidade:** Facilitam a criação de "mocks" (objetos falsos) para testes unitários, pois você pode criar um mock que conforma a um protocolo em vez de depender de uma classe complexa.

---

### Como Definir um Protocolo

Você define um protocolo usando a palavra-chave `protocol`:


```Swift
protocol NomeDoProtocolo {
    // requisitos (propriedades, métodos, inicializadores, etc.)
}
```

**Requisitos que um protocolo pode definir:**

- **Propriedades:**
    
    - Você especifica o nome, o tipo e se a propriedade deve ser apenas de leitura (`{ get }`) ou de leitura e escrita (`{ get set }`).
    - Não se especifica se é uma propriedade armazenada ou computada; isso é decisão do tipo que conforma.
    
    
    ```Swift
    protocol Identificavel {
        var id: String { get set } // Propriedade de leitura e escrita
        static var tipoDeIdentificador: String { get } // Propriedade de tipo, apenas leitura
    }
    ```
    
- **Métodos:**
    
    - Você define a assinatura do método (nome, parâmetros, tipo de retorno).
    - Para métodos que modificam a instância de um tipo de valor (struct, enum), use `mutating`.
    
    
    ```Swift
    protocol PodeVoar {
        func decolar()
        func pousar()
        mutating func ajustarAltitude(novaAltitude: Double) // Para structs/enums
    }
    ```
    
- **Inicializadores:**
    
    - Você pode exigir que os tipos conformantes implementem inicializadores específicos.
    - Classes conformantes devem marcar esses inicializadores com `required` (a menos que a classe seja `final`).
    
    
    ```Swift
    protocol Nomeavel {
        init(nome: String)
    }
    ```
    
- **Subscripts:**
    
    
    ```Swift
    protocol ColecaoComIndice {
        subscript(index: Int) -> String { get set }
    }
    ```
    
- **Tipos Associados (`associatedtype`):**
    
    - Permitem criar protocolos genéricos, onde alguns dos tipos usados na definição do protocolo são especificados pelo tipo que conforma.
    
    
    ```Swift
    protocol Container {
        associatedtype Item // Um placeholder para o tipo do item
        mutating func adicionar(_ item: Item)
        var contador: Int { get }
        subscript(i: Int) -> Item { get }
    }
    ```
    

---

### Como um Tipo Conforma a um Protocolo

Para declarar que um tipo conforma a um protocolo, você lista o nome do protocolo após o nome do tipo, separado por dois pontos (`:`). Se for uma classe herdando de uma superclasse, a superclasse vem primeiro.


```Swift
struct Pessoa: Identificavel, Nomeavel { // Conforma a dois protocolos
    var id: String
    static var tipoDeIdentificador: String = "CPF"

    // Implementação do requisito de Nomeavel
    required init(nome: String) { // 'required' não é estritamente necessário para structs, mas é bom para consistência com classes
        self.id = "ID_Inicial_Para_" + nome // Exemplo
        // ... inicializa outras propriedades ...
        print("Pessoa \(nome) criada.")
    }
}

class Passaro: PodeVoar {
    var altitudeAtual: Double = 0

    func decolar() {
        print("Pássaro decolando...")
        altitudeAtual = 10
    }

    func pousar() {
        print("Pássaro pousando...")
        altitudeAtual = 0
    }

    func ajustarAltitude(novaAltitude: Double) { // 'mutating' não é usado em classes para métodos que alteram propriedades
        self.altitudeAtual = novaAltitude
        print("Altitude do pássaro ajustada para \(altitudeAtual)m")
    }
}
```

O tipo conformante deve fornecer uma implementação concreta para todos os requisitos do protocolo.

---

### Usando Protocolos

Uma vez que os tipos conformam a protocolos, você pode:

- **Usar o protocolo como um tipo:**
    
    
    ```Swift
    var alguemIdentificavel: Identificavel
    alguemIdentificavel = Pessoa(nome: "Ana")
    print(alguemIdentificavel.id)
    
    let voadores: [PodeVoar] = [Passaro(), Aviao()] // Aviao também conformaria a PodeVoar
    
    func fazerVoar(coisaVoadora: PodeVoar) {
        coisaVoadora.decolar()
        // coisaVoadora.ajustarAltitude(novaAltitude: 100) // Se 'coisaVoadora' for let, e o tipo real for struct, isso daria erro.
                                                        // Para chamar métodos mutating, a variável precisa ser 'var'.
    }
    ```
    
- **Verificar Conformidade e Fazer Cast:**
    
    
    ```Swift
    if let pessoa = alguemIdentificavel as? Pessoa {
        print("É uma pessoa!")
    }
    
    if alguemIdentificavel is Pessoa {
        print("Conforma a Pessoa (que por sua vez conforma a Identificavel).")
    }
    ```
    
- **Herança de Protocolos:** Um protocolo pode herdar de outros.
    
    
    ```Swift
    protocol VeiculoTerrestre: Identificavel { // Herda de Identificavel
        var numeroDeRodas: Int { get }
    }
    ```
    
- **Composição de Protocolos:** Exigir que um tipo conforme a múltiplos protocolos.
    
    
    ```Swift
    func registrarEntidade(entidade: Identificavel & Nomeavel) {
        print("Registrando \(entidade.id) com nome inicial via init.")
    }
    ```
    
- **Tipos Opacos (`some Protocolo`) e Tipos de Protocolo Existenciais (`any Protocolo`):**
    
    - `some Protocolo`: Usado como tipo de retorno de função ou tipo de propriedade, garante que um tipo concreto específico que conforma ao protocolo é retornado/usado, mas o chamador não precisa saber qual é esse tipo concreto. O tipo é fixo em tempo de compilação.
    - `any Protocolo`: Representa um valor de qualquer tipo que conforma ao protocolo. Permite heterogeneidade (diferentes tipos concretos em uma coleção, por exemplo) de forma mais explícita do que antes. O tipo pode variar em tempo de execução.

---

### Extensões de Protocolo

Você pode estender protocolos para fornecer implementações padrão para métodos e propriedades computadas. Isso é extremamente útil:


```Swift
protocol Descrevivel {
    func descrever() -> String
}

// Extensão para fornecer uma implementação padrão
extension Descrevivel {
    func descrever() -> String {
        return "Este é um item descrevível."
    }
}

struct Caixa: Descrevivel {
    // Não precisa implementar descrever(), já tem uma padrão.
}

struct Esfera: Descrevivel {
    // Pode sobrescrever a implementação padrão
    func descrever() -> String {
        return "Esta é uma esfera redonda."
    }
}

let caixa = Caixa()
print(caixa.descrever()) // Output: Este é um item descrevível.

let esfera = Esfera()
print(esfera.descrever()) // Output: Esta é uma esfera redonda.
```

Você também pode adicionar novos métodos (não definidos no protocolo original) a todos os tipos que conformam a ele através de extensões.

---

Protocolos são um pilar da "Programação Orientada a Protocolos" (POP), um paradigma que o Swift incentiva fortemente. Eles promovem flexibilidade, reutilização e um design de código mais limpo e testável. Exemplos comuns de protocolos na biblioteca padrão do Swift incluem `Equatable` (para igualdade `==`), `Comparable` (para ordenação `<`, `>`), `Codable` (para serialização/desserialização), `Identifiable` (comum em SwiftUI) e `CustomStringConvertible` (para representação em string).