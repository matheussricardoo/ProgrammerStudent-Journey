import random
import string
import time

# Solicitação das quantidades ao usuário
qtd_crc = int(input('🔠 Quantos caracteres você deseja?: '))
qtd_num = int(input('🔢 Quantos números você deseja?: '))
qtd_simb = int(input('🔣 Quantos símbolos você deseja?: '))

# Listas de caracteres, números e símbolos
letters = string.ascii_letters  # Letras maiúsculas e minúsculas
digits = string.digits  # Números
symbols = string.punctuation  # Símbolos

# Gerando as escolhas de caracteres, números e símbolos
ch_crc = random.choices(letters, k=qtd_crc)
ch_num = random.choices(digits, k=qtd_num)
ch_simb = random.choices(symbols, k=qtd_simb)

# Criando a senha e embaralhando os caracteres
password = ch_crc + ch_num + ch_simb
random.shuffle(password)

# Efeito de suspense
print("\n⏳ Criando sua senha...", end="", flush=True)
time.sleep(1)  # Pausa de 1 segundo
print(" 🔐")

# Exibindo a senha gerada
print("\n✅ Sua senha segura foi gerada: ", *password, sep="")

# Desafio extra: Perguntar se o usuário quer salvar em um arquivo
if input("\nQuer salvar sua senha em um arquivo? (sim/não): ").lower() == 'sim':
    with open('senha_gerada.txt', 'w') as f:
        f.write(''.join(password))
    print("✅ Sua senha foi salva no arquivo 'senha_gerada.txt'.")
