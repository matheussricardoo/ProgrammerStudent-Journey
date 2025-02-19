def pig_latin():
    vowel = ["a", "e", "i", "o", "u"]
    word = input("Digit an a word: ")
    if word[0] in vowel:
        print(word + "way")
    else:
        print(word[1:] + word[0] + "ay")


pig_latin()
