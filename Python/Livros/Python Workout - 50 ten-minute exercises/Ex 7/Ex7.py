def ubii_dubbi():
    word = input('Digite uma palavra: ')
    result = ''
    for letter in word:
        if letter in 'aeiouAEIOU':  
            result += 'ub' + letter  
        else:
            result += letter  
    print(result)

ubii_dubbi()