def hex_output():
    while True:
        hexa = input('Digite o número hexadecimal (enter para encerrar): ').upper()
        qtdHexa = len(hexa)

        decimal = 0
        
        if hexa == '':
            break
        
        hex_map = {'A': 10, 'B': 11, 'C': 12, 'D': 13, 'E': 14, 'F':15}
        
        for i in range(qtdHexa):
            char = hexa[qtdHexa - 1 - i]
            
            if char in hex_map:
                value = hex_map[char]
            else:
                value = int(char)
                
            decimal += value * (16 ** i)
            
        print(f'O valor decimal de {hexa} é {decimal}')
        
hex_output()