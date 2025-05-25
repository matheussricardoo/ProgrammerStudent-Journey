### `@propertyWrapper`: O Conceito Geral

A anotação `@propertyWrapper` é usada para definir um tipo (struct, class ou enum) que atuará como um "embrulho" para uma propriedade. Esse tipo deve, no mínimo, expor uma propriedade chamada `wrappedValue`.

**Como funciona:**

1. **Definição:** Você cria um struct (ou classe/enum) e o anota com `@propertyWrapper`.
2. **`wrappedValue`:** Dentro desse wrapper, você define uma propriedade chamada `wrappedValue`. É essa propriedade que armazena o valor real da propriedade que está sendo embrulhada. Você pode adicionar lógica personalizada no `get` e `set` de `wrappedValue`.
3. **`projectedValue` (Opcional):** Um property wrapper também pode expor uma segunda propriedade chamada `projectedValue` (geralmente acessada com o prefixo `$`). Isso permite que o wrapper forneça uma interface ou funcionalidade adicional relacionada à propriedade embrulhada.

**Benefícios:**

- **Reutilização de Código:** Evita a duplicação de lógica comum (validação, formatação, logging, notificação de mudanças, etc.).
- **Abstração:** Esconde a complexidade do gerenciamento da propriedade.
- **Declarativo:** Torna a intenção da propriedade mais clara na sua declaração.

**Exemplo Básico (Teórico):**

``` Swift
@propertyWrapper
struct PositiveNumber {
    private var number: Int
    var wrappedValue: Int {
        get { number }
        set { number = max(0, newValue) } // Garante que o número seja sempre >= 0
    }

    init(wrappedValue: Int) {
        self.number = max(0, wrappedValue)
    }
}

struct Player {
    @PositiveNumber var score: Int = 0
    @PositiveNumber var health: Int = 100
}

var player = Player()
player.score = 10
print(player.score) // Output: 10

player.score = -5
print(player.score) // Output: 0 (devido à lógica no PositiveNumber)
```

---

Agora, vamos aos Property Wrappers específicos:

### `@Capitalized` (Exemplo de Property Wrapper Customizado)

Este não é um Property Wrapper padrão do Swift ou SwiftUI, mas podemos facilmente criar um como exemplo para ilustrar o conceito.

**Propósito:** Garantir que uma propriedade `String` seja sempre armazenada e retornada com a primeira letra de cada palavra em maiúscula.

**Implementação:**

```Swift

@propertyWrapper
struct Capitalized {
    private var value: String
    var wrappedValue: String {
        get { value }
        set { value = newValue.capitalized } // Transforma a string para o formato capitalizado
    }

    init(wrappedValue: String) {
        self.value = wrappedValue.capitalized
    }
}

// Exemplo de uso:
struct Book {
    @Capitalized var title: String
    @Capitalized var author: String
}

var myBook = Book(title: "o pequeno príncipe", author: "antoine de saint-exupéry")
print(myBook.title)  // Output: O Pequeno Príncipe
print(myBook.author) // Output: Antoine De Saint-Exupéry

myBook.title = "a revolução dos bichos"
print(myBook.title)  // Output: A Revolução Dos Bichos
```

---

### `@Binding` (SwiftUI)

**Propósito:** Criar uma conexão de duas vias (two-way binding) entre uma propriedade que armazena dados (geralmente um `@State` em uma view pai) e uma view que exibe e pode modificar esses dados (geralmente uma subview).

Como funciona:

@Binding não armazena o dado em si. Em vez disso, ele mantém uma referência à fonte original dos dados. Quando a view com @Binding modifica o valor, a mudança é refletida de volta na fonte original, e vice-versa.

Ele usa o projectedValue (acessado com $) para fornecer o próprio Binding, que é a estrutura que permite essa conexão.

**Contexto:** Principalmente usado em SwiftUI para passar dados mutáveis para subviews.

**Exemplo:**

``` Swift
import SwiftUI

struct ToggleView: View {
    // @Binding cria uma referência mutável para um Bool em outro lugar
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) { // $isOn passa o Binding<Bool> para o Toggle
            Text(isOn ? "Ligado" : "Desligado")
        }
    }
}

struct ContentView_Binding: View {
    // @State é a fonte da verdade para 'isToggleOn'
    @State private var isToggleOn: Bool = false

    var body: some View {
        VStack {
            Text(isToggleOn ? "O interruptor está LIGADO" : "O interruptor está DESLIGADO")
            // Passamos um Binding para isToggleOn para a ToggleView
            ToggleView(isOn: $isToggleOn) // $isToggleOn cria um Binding<Bool>
        }
        .padding()
    }
}
```

No exemplo acima, `ToggleView` pode modificar `isToggleOn` que está em `ContentView_Binding`.

---

### `@Environment` (SwiftUI)

**Propósito:** Permitir que uma view leia valores do "ambiente" da aplicação. O ambiente pode conter dados fornecidos pelo sistema (como esquema de cores, tamanho da fonte, locale) ou dados personalizados injetados na hierarquia de views.

Como funciona:

Uma view pode declarar uma propriedade com @Environment e especificar a chave do valor ambiental que deseja ler (usando \.keyPath). A view automaticamente se atualiza se o valor ambiental mudar.

**Contexto:** SwiftUI, para acessar dados compartilhados ou configurações do sistema sem passá-los explicitamente por todos os inicializadores de views.

**Exemplo:**

``` Swift
import SwiftUI

struct EnvironmentDemoView: View {
    // Acessa o esquema de cores atual do ambiente
    @Environment(\.colorScheme) var colorScheme
    // Acessa o modo de apresentação para poder dispensar uma view modal, por exemplo
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("O esquema de cores atual é: \(colorScheme == .dark ? "Escuro" : "Claro")")

            Button("Dispensar (se modal)") {
                // Usa o valor do ambiente para dispensar a view
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
        .background(colorScheme == .dark ? Color.black : Color.white)
        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
    }
}

// Para ver o botão "Dispensar" funcionando, você normalmente apresentaria esta view
// como um .sheet ou .fullScreenCover
struct PresentingViewForEnv: View {
    @State private var showSheet = false
    var body: some View {
        Button("Mostrar Environment Demo") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            EnvironmentDemoView()
        }
    }
}
```

---

### `@Published` (Combine / SwiftUI)

**Propósito:** Anunciar automaticamente quando o valor de uma propriedade está prestes a mudar. É um pilar do framework Combine e fundamental para a reatividade em `ObservableObject` no SwiftUI.

Como funciona:

Quando uma propriedade marcada com @Published é modificada, ela emite um evento através de um "Publisher" (do Combine) antes que o novo valor seja atribuído. Classes que conformam com ObservableObject usam @Published para que as views do SwiftUI (ou outros assinantes) possam ser notificadas sobre as mudanças e se atualizarem.

O projectedValue de uma propriedade @Published (acessado com $) é o seu Publisher.

**Contexto:** Usado dentro de classes que conformam com o protocolo `ObservableObject`.

**Exemplo:**



```Swift
import Combine
import SwiftUI // Para ObservableObject

class UserSettings: ObservableObject {
    // Qualquer mudança em 'username' será publicada
    @Published var username: String = "Anônimo"
    @Published var score: Int = 0

    // Não precisa de @Published se não precisa ser observado diretamente pela UI
    var lastLogin: Date = Date()

    func login(name: String) {
        self.username = name // A mudança aqui dispara a publicação
        self.score = 0
    }
}

struct UserView: View {
    // @ObservedObject ou @StateObject para observar o UserSettings
    @StateObject var settings = UserSettings() // @StateObject gerencia o ciclo de vida aqui

    var body: some View {
        VStack {
            Text("Usuário: \(settings.username)") // Atualiza quando settings.username muda
            Text("Pontuação: \(settings.score)")
            Button("Login como João") {
                settings.login(name: "João")
            }
            Button("Aumentar Pontuação") {
                settings.score += 10 // A mudança aqui também dispara a publicação
            }
        }
    }
}
```

---

### `@ObservedObject` (SwiftUI)

**Propósito:** Permitir que uma view do SwiftUI se inscreva (observe) as mudanças em uma instância de uma classe que conforma com o protocolo `ObservableObject`. Quando o objeto observado publica mudanças (geralmente através de suas propriedades `@Published`), a view é invalidada e redesenhada.

Como funciona:

Você marca uma propriedade na sua View com @ObservedObject. Essa propriedade deve ser uma instância de uma classe ObservableObject. A view "escuta" o publisher objectWillChange do objeto.

**Contexto:** SwiftUI. Usado quando a view _não_ é dona do ciclo de vida do objeto observável (ou seja, o objeto é criado em outro lugar e passado para a view, ou é gerenciado por um pai). Se a view _cria e gerencia_ o objeto, `@StateObject` é geralmente preferido.

**Exemplo (complementando o exemplo de `@Published`):**


```Swift
import SwiftUI

// UserSettings definido acima (com @Published)

class ExternalDataSource {
    // Este objeto poderia ser criado e gerenciado fora da view
    let userSettings = UserSettings()

    init() {
        // Simula uma atualização externa
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.userSettings.username = "Usuário VIP"
            self.userSettings.score = 1000
        }
    }
}


struct ProfileView: View {
    // A view recebe e observa um objeto existente.
    // Se ProfileView fosse recriada, ela continuaria observando o *mesmo* objeto
    // (desde que o objeto passado para ela não mude).
    @ObservedObject var settings: UserSettings

    var body: some View {
        VStack {
            Text("Perfil do Usuário (Observado): \(settings.username)")
            Text("Pontuação Atual: \(settings.score)")
        }
    }
}

// Exemplo de como usar ProfileView
struct MainAppView_ObservedObject: View {
    // dataSource poderia ser um singleton, injetado, etc.
    // Aqui, @StateObject é usado para gerenciar o ciclo de vida de ExternalDataSource
    // para que ele não seja recriado desnecessariamente.
    @StateObject private var dataSource = ExternalDataSource()

    var body: some View {
        // Passamos o userSettings do dataSource para ProfileView.
        // ProfileView observará as mudanças em dataSource.userSettings.
        ProfileView(settings: dataSource.userSettings)
    }
}
```

**Resumo dos Property Wrappers de SwiftUI:**

- `@State`: Gerencia o estado local e simples de uma view. A view é a dona dos dados.
- `@Binding`: Cria uma referência mutável para um estado que é de propriedade de outra view (geralmente `@State` ou um item em uma coleção gerenciada por `@State`).
- `@Environment`: Lê valores do ambiente da view (configurações do sistema, dados injetados).
- `@ObservedObject`: Observa um objeto externo (que conforma com `ObservableObject`) para atualizações. A view não é dona do ciclo de vida do objeto.
- `@StateObject`: (Semelhante a `@ObservedObject`) Cria e gerencia o ciclo de vida de um `ObservableObject` dentro da view. A view é a dona do objeto.
- `@EnvironmentObject`: (Semelhante a `@ObservedObject`) Observa um `ObservableObject` que foi injetado no ambiente da view por uma view ancestral.

Os Property Wrappers são uma parte essencial do desenvolvimento moderno em Swift, especialmente em SwiftUI, tornando o código mais limpo, declarativo e poderoso.