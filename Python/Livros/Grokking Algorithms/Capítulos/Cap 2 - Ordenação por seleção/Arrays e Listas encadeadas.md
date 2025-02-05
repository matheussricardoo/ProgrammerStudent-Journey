## 📌 Listas Encadeadas vs. Arrays

**Arrays** e **Listas Encadeadas** são estruturas de dados usadas para armazenar coleções de elementos, mas diferem em sua implementação, uso e eficiência.

---
## 📌 Diferenças Principais

|Característica|**Array** (Lista Python `list`)|**Lista Encadeada**|
|---|---|---|
|**Armazenamento**|Contíguo na memória|Elementos espalhados na memória, ligados por ponteiros|
|**Acesso a elementos**|**O(1)** – Acesso direto pelo índice|**O(n)** – Precisa percorrer até encontrar o elemento|
|**Inserção/Remoção**|**O(n)** – Difícil, pois precisa deslocar elementos|**O(1)** na cabeça/tail, **O(n)** se for no meio|
|**Uso de memória**|Usa menos memória (apenas os dados)|Usa mais memória (dados + ponteiros)|
|**Flexibilidade**|Tamanho fixo ou crescimento custoso|Cresce dinamicamente sem realocação|
|**Melhor para**|Acesso rápido por índice, estrutura simples|Inserção/remoção frequente, estrutura dinâmica|

---
## 📌 **Como Funciona Cada Estrutura?**

### 🔹 **Array (Lista Python `list`)**

- Armazena os elementos **em blocos contínuos de memória**.
- Permite acesso direto a qualquer posição usando **índices** (`O(1)`).
- Se precisar crescer além do espaço inicial, o Python realoca para um novo local maior (**custo alto O(n)**).

```python
# Criando um array em Python
array = [10, 20, 30, 40]
print(array[2])  # Acesso rápido ao índice 2 → O(1)
```

📌 **Desvantagens:**  
🔺 Inserir/remover elementos no meio é **lento (O(n))** porque precisa deslocar os outros elementos.  
🔺 Se o array precisar crescer, pode haver **realocação e cópia de todos os elementos**, o que é custoso.

---
### 🔹 **Lista Encadeada**

- Cada **nó** contém um valor e um **ponteiro** para o próximo nó.
- O tamanho cresce dinamicamente sem precisar realocar memória.
- Acesso a um elemento é **O(n)** porque precisa percorrer a lista até achá-lo.
- Inserção e remoção na **cabeça ou cauda são rápidas (O(1))**.

```python
# Implementação de Lista Encadeada em Python
class Node:
    def __init__(self, valor):
        self.valor = valor
        self.proximo = None

class ListaEncadeada:
    def __init__(self):
        self.cabeca = None

    def adicionar_no_inicio(self, valor):
        novo_no = Node(valor)
        novo_no.proximo = self.cabeca
        self.cabeca = novo_no  # Agora a cabeça aponta para o novo nó

    def imprimir_lista(self):
        atual = self.cabeca
        while atual:
            print(atual.valor, end=" -> ")
            atual = atual.proximo
        print("None")

# Testando
lista = ListaEncadeada()
lista.adicionar_no_inicio(10)
lista.adicionar_no_inicio(20)
lista.adicionar_no_inicio(30)
lista.imprimir_lista()  # Saída: 30 -> 20 -> 10 -> None
```

📌 **Desvantagens:**  
🔺 Para acessar o **n-ésimo elemento**, precisa percorrer a lista (**O(n)**).  
🔺 Ocupa mais memória porque precisa armazenar os **ponteiros** além dos valores.

---
## 📌 **Quando Usar Cada Estrutura?**

✅ **Use um Array (Lista Python `list`) quando:**  
✔ Precisa de acesso rápido por índice (**O(1)**).  
✔ O tamanho dos dados é previsível e não muda muito.  
✔ O número de inserções e remoções no meio da estrutura é pequeno.

✅ **Use uma Lista Encadeada quando:**  
✔ Precisa inserir/remover elementos com frequência (especialmente no início ou fim).  
✔ O tamanho da estrutura é **dinâmico** e cresce sem precisar realocar memória.  
✔ O acesso sequencial é mais importante do que o acesso direto.

---
## 📌 **Conclusão**

- **Arrays são rápidos para acesso aleatório**, mas lentos para inserção/remoção no meio.
- **Listas Encadeadas são flexíveis**, mas têm acesso mais lento e usam mais memória.
- A escolha depende do problema: **se precisar de acesso rápido, prefira arrays; se precisar de inserção/remoção frequente, prefira listas encadeadas.**