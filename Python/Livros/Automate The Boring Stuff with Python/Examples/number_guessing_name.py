import random

# Pergunta ao jogador qual nível de dificuldade ele deseja (fácil, médio ou difícil)
nivel = input("Escolha um nível de dificuldade (fácil, médio, difícil): ").lower()

# Define o intervalo com base no nível
if nivel == 'fácil':
    limite = 10
elif nivel == 'médio':
    limite = 50
else:
    limite = 100

# O computador escolhe um número aleatório dentro do intervalo
numero_computador = random.randint(1, limite)

# Inicia o contador de tentativas
tentativas = 0

print(f"🕹️ O computador escolheu um número entre 1 e {limite}. Tente adivinhar!")

while True:
    tentativas += 1
    # Solicita a entrada do jogador
    sua_escolha = int(input(f"Tentativa {tentativas}: Digite seu palpite: "))
    
    if sua_escolha < numero_computador:
        print("❌ Errado! O número é maior.")
    elif sua_escolha > numero_computador:
        print("❌ Errado! O número é menor.")
    else:
        print(f"🎉 Parabéns! Você acertou o número após {tentativas} tentativas!")
        break
