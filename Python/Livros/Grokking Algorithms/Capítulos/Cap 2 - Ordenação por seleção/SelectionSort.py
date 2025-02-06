def selection_sort(lista):
    n = len(lista)
    for i in range(n - 1):
        min_index = i
        for j in range(i + 1, n):
            if lista[j] < lista[min_index]:
                min_index = j  # Atualiza o índice do menor elemento
        lista[i], lista[min_index] = lista[min_index], lista[i]  # Troca os valores

# Exemplo de uso
nums = [7, 3, 9, 1, 5]
selection_sort(nums)
print(nums)  # Saída: [1, 3, 5, 7, 9]
