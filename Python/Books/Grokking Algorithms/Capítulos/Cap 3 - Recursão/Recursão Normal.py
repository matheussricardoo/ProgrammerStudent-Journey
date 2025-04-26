def fatorial(n):
    if n == 0 or n == 1:  # Caso base
        return 1
    return n * fatorial(n - 1)  # Caso recursivo NÃO otimizado
