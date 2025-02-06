def fatorial_tail(n, acumulador=1):
    if n == 0 or n == 1:  # Caso base
        return acumulador
    return fatorial_tail(n - 1, n * acumulador)  # Caso recursivo em cauda
