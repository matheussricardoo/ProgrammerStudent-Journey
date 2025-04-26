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
