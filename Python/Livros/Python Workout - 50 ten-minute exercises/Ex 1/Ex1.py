import random


def guessing_game():
    numero = random.randint(0, 100)
    print("Bem-vindo ao jogo de adivinhação!")
    print("O computador pensou em um número entre 0 e 100.")

    while True:
        try:
            choice = int(input("Qual é o número? "))

            if choice > numero:
                print("Muito alto! Tente novamente.")
            elif choice < numero:
                print("Muito baixo! Tente novamente.")
            else:
                print("Parabéns! Você acertou!")
                break
        except ValueError:
            print("Por favor, insira um número válido.")


if __name__ == "__main__":
    guessing_game()
