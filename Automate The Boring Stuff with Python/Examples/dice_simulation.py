import random

# Pergunta ao usuário qual dado ele quer rolar
sides = int(input("Escolha o número de lados do dado (ex: 6, 10, 20): "))

# Pergunta se o jogador quer jogar "melhor de 3"
rodadas = 3 if input("Quer jogar melhor de 3? (sim/não): ").lower() == 'sim' else 1

# Inicializa os placares
placar_jogador = 0
placar_computador = 0

# Loop do jogo
for _ in range(rodadas):
    dado_jogador = random.randint(1, sides)
    dado_computador = random.randint(1, sides)

    # Exibe o resultado de cada rodada
    print(f"\n🎲 Você rolou: {dado_jogador} | Computador rolou: {dado_computador}")

    if dado_jogador > dado_computador:
        print("🎉 Você venceu a rodada!")
        placar_jogador += 1
    elif dado_jogador < dado_computador:
        print("😢 O computador venceu a rodada.")
        placar_computador += 1
    else:
        print("😐 Empate na rodada!")

# Exibe o placar final
if placar_jogador > placar_computador:
    print(f"\n🏆 Você venceu o jogo! Placar final: {placar_jogador} a {placar_computador}")
elif placar_jogador < placar_computador:
    print(f"\n😢 O computador venceu o jogo! Placar final: {placar_computador} a {placar_jogador}")
else:
    print(f"\n😐 Empate! Placar final: {placar_jogador} a {placar_computador}")
