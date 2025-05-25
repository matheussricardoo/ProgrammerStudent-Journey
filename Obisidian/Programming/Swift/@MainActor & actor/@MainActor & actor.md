### `actor` (em geral)

Um `actor` em Swift é um tipo de referência (semelhante a uma classe) projetado para proteger seu estado mutável contra "data races" (condições de corrida de dados) em ambientes concorrentes. Data races ocorrem quando múltiplas threads tentam acessar e modificar os mesmos dados ao mesmo tempo, levando a comportamentos imprevisíveis e crashes.

**Como um `actor` protege seus dados?**

A principal característica de um `actor` é que ele **serializa o acesso ao seu estado mutável**. Isso significa que ele garante que apenas uma parte do código possa acessar e modificar suas propriedades `var` (variáveis) por vez. Ele faz isso gerenciando uma "fila" interna de tarefas que querem interagir com seu estado.

**Principais características e como usá-lo:**

1. **Isolamento de Dados:** Todas as propriedades e métodos de um `actor` são, por padrão, isolados dentro dele.
2. **Acesso Interno:** Dentro do próprio `actor` (ou seja, em um método do `actor`), você pode acessar suas propriedades e chamar seus métodos de forma síncrona (sem `await`), pois o `actor` já garante que esse acesso é seguro.
3. **Acesso Externo (Cross-Actor):**
    - Para acessar uma propriedade mutável ou chamar um método de um `actor` a partir de _fora_ dele (de outro `actor`, de uma classe, struct, ou de código síncrono), você **obrigatoriamente** usará `await`.
    - O `await` aqui significa que sua `Task` atual pode ser suspensa enquanto espera sua vez de acessar o `actor`. Isso permite que o `actor` processe outros pedidos ou que o sistema execute outras `Task`s.
4. `nonisolated`: Se um `actor` tem propriedades imutáveis (`let`) ou métodos que não acessam/modificam o estado mutável do `actor`, você pode marcá-los com `nonisolated`. Isso permite que eles sejam acessados de fora do `actor` de forma síncrona (sem `await`), pois não há risco de data race.

**Exemplo de um `actor`:**


```Swift
actor ContadorDePontos {
    private var pontos: Int = 0
    private var nomeDoJogador: String

    init(nomeDoJogador: String) {
        self.nomeDoJogador = nomeDoJogador
    }

    // Método que modifica o estado interno
    func adicionarPontos(_ quantidade: Int) {
        if quantidade > 0 {
            pontos += quantidade
            print("\(nomeDoJogador) agora tem \(pontos) pontos.")
        }
    }

    // Método que lê o estado interno
    func getPontos() -> Int {
        return pontos
    }

    // Propriedade imutável, poderia ser nonisolated
    nonisolated let idDoJogo: String = "JogoAventura2025"

    // Método que não acessa estado mutável e é nonisolated
    nonisolated func regrasDoJogo() -> String {
        return "Acumule o máximo de pontos possível!"
    }
}

// Usando o actor
func simularJogo() async {
    let jogador1 = ContadorDePontos(nomeDoJogador: "Alice")

    // Acessando de fora do actor, precisa de await
    await jogador1.adicionarPontos(10)
    await jogador1.adicionarPontos(5)

    let pontosAtuais = await jogador1.getPontos()
    print("Pontuação final de Alice: \(pontosAtuais)") // Pontuação final de Alice: 15

    // Acesso a membros nonisolated não precisa de await
    print("ID do Jogo: \(jogador1.idDoJogo)")
    print("Regras: \(jogador1.regrasDoJogo())")
}

Task {
    await simularJogo()
}
```

**Por que usar `actor`s?**

Para proteger dados compartilhados que podem ser alterados. Se você tem uma classe com variáveis que várias partes do seu código concorrente podem tentar mudar, um `actor` é uma ótima solução para evitar data races sem ter que gerenciar locks (bloqueios) manualmente, o que pode ser complexo e propenso a erros.

---

### `@MainActor`

`@MainActor` é um tipo especial de `actor`, **global e único**, que representa o **thread principal (main thread)** da sua aplicação. O thread principal é onde todas as atualizações da interface do usuário (UI) devem ocorrer. Tentar atualizar a UI de outro thread pode causar crashes ou comportamentos inesperados.

**Como `@MainActor` funciona e quando usá-lo?**

`@MainActor` garante que qualquer código marcado com ele será executado no thread principal.

1. **Marcação:** Você pode aplicar `@MainActor` a:
    
    - **Classes, structs, ou outros `actor`s inteiros:** Isso faz com que todos os métodos e propriedades daquele tipo sejam executados no thread principal por padrão.
        
        
        ```Swift
        @MainActor
        class MeuViewModel: ObservableObject {
            @Published var nome: String = "Usuário"
        
            func atualizarNome(novoNome: String) {
                // Este código está garantido para rodar no main thread
                self.nome = novoNome
            }
        }
        ```
        
    - **Funções ou métodos individuais:**
        
        
        ```Swift
        class GerenciadorDeDados {
            var dadosImportantes: String = ""
        
            @MainActor
            func atualizarInterfaceComDados() {
                // Este método específico rodará no main thread
                // Ex: someLabel.text = dadosImportantes
            }
        
            func buscarDados() async {
                // ... busca dados em um background thread ...
                let novosDados = "Novos dados da rede"
                // Agora, para atualizar a UI, chamamos o método marcado com @MainActor
                await atualizarInterfaceComDados() // O await é necessário se 'buscarDados' não está no MainActor
            }
        }
        ```
        
    - **Propriedades individuais (incluindo closures):**
        
        
        ```Swift
        @MainActor var textoDeStatusGlobal: String = ""
        ```
        
2. **Garantia de Execução no Main Thread:** Se você chama uma função marcada com `@MainActor` de um contexto que _não_ está no main thread (por exemplo, de uma `Task` em background ou de outro `actor`), você precisará usar `await`. O sistema Swift Concurrency fará a "troca de contexto" automaticamente para o main thread antes de executar o código. Se você já está no main thread, a chamada pode ser síncrona.
    
3. **`MainActor.run { ... }`:** Para executar um bloco de código específico no main thread de forma explícita:
    
    ```Swift
    Task { // Roda em um background thread por padrão
        let resultado = await fazerTrabalhoPesadoEmBackground()
    
        // Agora, atualize a UI no main thread
        await MainActor.run {
            // Este bloco é executado no main thread
            minhaLabel.text = resultado
            print("Interface atualizada no main thread: \(Thread.isMainThread)") // true
        }
    }
    ```
    

**Por que usar `@MainActor`?**

Principalmente para interações com a UI e qualquer outra operação que precise ser executada exclusivamente no thread principal. Ele simplifica muito o gerenciamento do thread principal, eliminando a necessidade de chamadas manuais como `DispatchQueue.main.async { ... }` em muitos casos, e se integra perfeitamente com `async/await`.

---

### Relação e Diferenças:

- **`actor` (geral):** É um mecanismo para criar seus próprios "domínios de sincronização" para proteger dados mutáveis. Você pode ter muitos `actor`s diferentes, cada um protegendo seu próprio conjunto de dados.
- **`@MainActor`:** É um `actor` específico, fornecido pelo sistema. Só existe um `@MainActor`. Sua responsabilidade exclusiva é coordenar o trabalho que deve acontecer no thread principal.

Pense assim: `@MainActor` é um `actor` que o Swift já criou e configurou para você, especificamente para o main thread. Quando você cria seu próprio `actor MeuContador { ... }`, você está definindo um novo "guarda" para os dados dentro de `MeuContador`, que operará independentemente do `@MainActor` (a menos que você marque `MeuContador` com `@MainActor` também, o que o forçaria a rodar no main thread).

Ambos são essenciais para escrever código concorrente moderno, seguro e mais fácil de entender em Swift.