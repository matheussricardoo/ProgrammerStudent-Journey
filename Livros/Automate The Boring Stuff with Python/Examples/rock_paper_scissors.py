import time
from random import choice

# Lista com as opções do computador
computador = ['pedra', 'papel', 'tesoura']

# Inicializando o placar
placar_jogador = 0
placar_computador = 0

# Pergunta quantas rodadas o jogador quer jogar
rodadas = int(input("Quantas rodadas você quer jogar? "))

# Loop principal do jogo
for _ in range(rodadas):
    # Escolha aleatória do computador
    escolha_computador = choice(computador)

    # Boas-vindas
    print("\n🔥 Bem-vindo ao Pedra, Papel e Tesoura! 🔥\n")
    print("🎮 Regras:")
    print("🪨 Pedra bate em ✂️ Tesoura")
    print("✂️ Tesoura bate em 📄 Papel")
    print("📄 Papel bate em 🪨 Pedra")

    # Solicita a escolha do jogador
    sua_escolha = input("\n🤔 Digite sua escolha (pedra, papel, tesoura): ").lower()

    # Verifica se a escolha do jogador é válida
    if sua_escolha not in computador:
        print('⚠ Escolha inválida! Por favor, selecione pedra, papel ou tesoura.')
        continue

    # Exibe as escolhas
    print("\n🧑 Sua escolha:      ", sua_escolha.capitalize())  
    print("🤖 Escolha do computador: ", escolha_computador.capitalize(), "\n")  
    time.sleep(1)  # Pausa para suspense

    # Verifica o resultado com a estrutura match
    match (sua_escolha, escolha_computador):
        case ('pedra', 'tesoura') | ('papel', 'pedra') | ('tesoura', 'papel'):
            print("🎉 Você venceu!")
            placar_jogador += 1
        case ('pedra', 'pedra') | ('papel', 'papel') | ('tesoura', 'tesoura'):
            print("😐 Empate!")
        case _:
            print("😢 Você perdeu!")
            placar_computador += 1

    # Exibe o placar após cada rodada
    print(f"\n🧑 Placar Jogador: {placar_jogador} | 🤖 Placar Computador: {placar_computador}")

# Exibe o placar final
if placar_jogador > placar_computador:
    print("\n🎉 Você venceu o jogo! Parabéns! 🏆")
elif placar_jogador < placar_computador:
    print("\n😢 O computador venceu o jogo. Tente novamente! 🤖")
else:
    print("\n😐 Empate! Ambos ganharam a mesma quantidade de rodadas.")
