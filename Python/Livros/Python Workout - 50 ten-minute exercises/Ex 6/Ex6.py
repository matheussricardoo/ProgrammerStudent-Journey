def pl_sentence(palavra):
    words = palavra.split(" ")

    pig_latin_words = []

    for word in words:
        if word[0] in "aeiou":
            pig_latin_word = word + "ay"
        else:
            pig_latin_word = word[1:] + word[0] + "ay"

        pig_latin_words.append(pig_latin_word)

    return " ".join(pig_latin_words)


print(pl_sentence("this is a test translation"))
