

### PEP 8 : https://peps.python.org/pep-0008/
### Expressoes e Declaracoes 

- Use negacao inline (if a is not b) em vez de negacao de expressoes positivas (if not a is b).
- Nao verifique se há recipientes vazios ou sequencias (como [] ou '' '') comparando o comprimento com zero (if len(somelist) == 0). Use if not somelist e assuma que os valores vazios serao implicitamente avaliados como `False`.
- O mesmo vale para recipientes ou sequencias nao vazias (como [1] ou 'oi'). A instrucao if somelist é implicitamente True para valores nao vazios.
- Evite instrucoes if de linha única, loops for e while e except instrucoes compsotas. Espalhe-os por várias linhas para maior clareza.
- Se nao conseguir ajustar uma expressao numa linha, rodeie-a entre parenteses e adcione quebras de linha e recuo para facilitar a leitura.

Existe uma ferramente de formatacao automática PEP 8: É chamada de black (https://github.com/psf/black), é uum projeto oficial da Python Software Foundation.

### Escrever funcoes auxiliares em vez de expressoes complexas

A boa sintaxe de Python facilita a escrita de expresssoes de linha única que implementam muita lógica. Por exemplo, digamos que eu queria decodificar a cadeia de caracteres de consulta de uma URL de site. Aqui, cada parametro de cadeia de caracteres de consulta representa um valor inteiro:

```python 3
fromurllib.parse importparse_qs

my_values = parse_qs("red=5&blue=0&green=",
					keep_blank_values=True)
print(repr(my_values))

>>>

{'red': ['5'], 'blue': ['0'], 'green': ['']} 
```

Alguns parametros de cadeia de caracteres de consulta podem ter vários valores, alguns podem ter valores únicos, alguns podem estar presentes, mas tem valores em branco, e alguns podem estar totalmente ausentes. Usar o método get no dicionário de resultados retorná valores diferentes em cada circunstancia:

```python
print("Red: ", my_values.get("red"))
print("Green: ", my_values.get("green"))
print("Opacity:", my_values.get("opacity"))

>>>

Red: ['5']
Green: ['']
Opacity: None
```

Seria bom se um valor padrao de 0 fosse atribuído quando um parametro nao é fornecido ou está em branco. Eu poderia inicialmente optar por fazer isso com expressoes booleanas porque parece que essa lógica ainda nao merece um if statement ou funcao auxiliar.

A sintaxe do Python torna essa escolha muito fácil. O truque aqui é que a cadeia de caracteres vazia, a lista vazia e o zero todos avaliam como `False` implicitamente. Assim, as expressoes abaixo serao avaliadas para a subexpressao após o operador `or` quando a primeira subexpressao for `False`:

```python
# For query string 'red=5&blue=0&green='
red = my_values.get("red", [""])[0] or 0
green = my_values.get("green", [""])[0] or 0
opacity = my_values.get("opacity", [""])[0] or 0
print(f"Red: {red!r}")
print(f"Green: {green!r}")
print(f"Opacity: {opacity!r}")

>>>

Red: '5'
Green: 0
Opacity: 0
```

O caso 'red' funciona porque a chave 'red' está presente no dicionário `my_values`. O valor recuperado pelo método `get` é uma lista com um membro: a string `'5'`. Este item é recuperado acessando o índice 0 na lista. Em seguida, a expressao `or` determina que a cadeia de caracteres nao está vazia e, portanto, é o valor resultante dessa operacao. Finalmente, a variável 'red' é atribuída ao valor '5'

O caso 'green' funciona porque o valor no dicionário my_values é uma lista com um membro: uma cadeia de caracteres vazia. O item no índice 0 da lista é recuperado. A expressao or determina que a cadeia de caractertes está vazia e, portanto, seu valor de retorno deve ser o argumento do lado direito para a operacao, que é 0. Finalmente, a variável green é atribuída ao valor 0.

O caso de 'opacity' funciona porque o valor no dicionário my_values está completamente ausente. O comportamento do método get é retornar seu segundo argumento se a chave nao existir no dicionário. O valor padrao neste caso é uma lista com um membro: uma cadeia de caracteres vazia. Assim quando a 'opacity' nao é encontrada no dicionário, esse código faz exatamente a mesma coisa que o caso 'green'.

A expressao complexa com get, [""], [0], e or é difícil de ler, e ainda assim nao faz tudo o que preciso. Também quero garantir que todos os valores de parametros sejam convertido em inteiros para que eu possa usá-los imediatamente em expressoes matemáticas. Para fazer isso, envolvo cada expressao com a funcao `int` para analisar a ccadeia de caracteres como um inteiro:

```python
red = int(my_values.get("red", [""])[0] or 0)
```

Essa lógica é agora extremamente difícil de ler. Há muito ruído visual. O código nao é acessivel. Um novo leitor do código teria que gastar muito tempo separando a expressao para descobrir o que ela realmente faz. Mesmo que seja bom manter as coisas curtas, nao vale a pena tentar encaixar tudo isso em uma linha.

Embora o Python ofereca suporte a expressoes condicionais para comportamento `inline if/else`, usá-las nessa situacao resulta em um código que nao é muito mais claro do que o exemplo de operador booleano acima

```python
red_str = my_values.get("red", [""])
red = int(red_str[0]) if red_str[0] else 0
```

Como alternativa, posso usar uma instrucao if completa em várias linhas para implementar a mesma lógica. Ver todas as etapas espalhadas assim faz com que a versao densa pareca ainda mais complexa:

```python
green_str = my_values.get("green", [""])
if green_str[0]:
	green = int(green_str[0])
else:
	green = 0
```

Agora que essa lógica está espalhada por várias linhas, é um pouco mais difícil copiar e colar para atribuir outras variáveis (por exemplo, `red`). Se eu quiser reutilizar essa funcionlaidade repetidamente, mesmo que apenas duas ou tres vezes, como neste exemplo, escrever uma funcao auxiliar é o caminho a seguir:

```python
def get_first_int(values, key, default=0):
	found = values.get(key, [""])
	if found[0]:
		return int(found[0])
	return default
```

O código de chamada é muito mais claro do que a expressao complexa usando `or` e a versao de duas linhas usando a expressao condicional:

```python
green = get_first_int(my_values, "green")
```

Assim que suas expressoes se complicarem, é hora de considerar dividi-las em partes menores, como variáveis intermediárias, e mover a lógica em funcoes auxiliares. O que voce ganha em legibilidade sempre supera o que a brevidade pode ter lhe proporcionado. Evite deixar que a boa sintaxe do Python para expressoes complexas o coloque em uma confusao como essa. Siga o princípio DRY (Don't repeat yourself) - (Nao se repita).
### Prefira a descompactacao de atribuicoes múltiplas a indexacao

Python tem um tipo de `tupla` embutido que pode ser usado para criar sequencias imutáveis e ordenadas de valores. Uma tupla pode estar vazia ou pode conter um único item:

```python
no_snack = ()
snack = ("chips",)
```

Uma tupla também pode incluir vários itens, como nestes pares chave/valor de um dicionário:

```python
snack_calories = {
	"chips": 140,
	"popcorn": 80,
	"nuts": 190,
}
items = list(snack_calories.items())
print(items)

>>>

[('chips', 140), ('popcorn', 80), ('nuts', 190)]
```

Os membros em tuplas podem ser acessados através de índices numéricos e fatias, assim como em uma lista:

```python
item = ("Peanut butter", "Jelly")
first_item = item[0] # Index
first_half = item[:1] # Slice
print(first_item)
print(first_half)

>>>

Peanut butter
('Peanut butter',)
```

Depois que uma tupla é criada, voce nao pode modificá-la atribuindo um novo valor a um índice:

```python
pair = ("Chocolate", "Peanut butter")
pair[0] = "Honey"

>>>

Traceback ...
TypeError: 'tuple' object does not support item assignment
```

Python também tem sintaxe para descompactar, o que permite atribuir vários valores em uma única instrucao. Os padroes que voce especifica nas tarefas de descompactacao se paremcem muito com tentar mutar tuplas - o que nao é permitido -, mas na verdade funcionam de forma bem diferente. Por exemplo, se voce sabe que uma tupla é um par, em vez de usar índices para acessar seus valores, voce pode atribuí-la a uma tupla de dois nomes de variáveis:

```python
item = ("Peanut butter", "Jelly")
first, second = item # Unpacking
print(first, "and", second)

>>>

Peanut butter and Jelly
```

Descompactar tem menos ruído visual do que acessar os índices da tupla, e muitas vezes, requer menos linhas de código. A mesma sintaxe de correspondencia de padroes de descompactacao funciona ao atribuir a listas, sequencias e vários níveis de iteráveis arbitrários dentro de iteráveis. nao recomendo fazer o seguinte no seu código, mas é importante saber que é possível e como funciona:

```python
favorite_snacks = {
	"salty": ("pretzels", 100),
	"sweet": ("cookies", 180),
	"veggie": ("carrots", 20),
}
((type1, (name1, cals1)),
(type2, (name2, cals2)),
(type3, (name3, cals3))) = favorite_snacks.items()

print(f"Favorite {type1} is {name1} with {cals1} calories")
print(f"Favorite {type2} is {name2} with {cals2} calories")
print(f"Favorite {type3} is {name3} with {cals3} calories")

>>> 

Favorite salty is pretzels with 100 calories
Favorite sweet is cookies with 180 calories
Favorite veggie is carrots with 20 calories
```

Tem como usar o descompactamento para trocar valores no local sem a necessidade criar variáveis temporárias. Aqui eu uso sintaxe típica com índices para trocar os valores entre duas posicoes em uma lista como parte de um algoritmo de classificao de ordem crescente:

```python
def bubble_sort(a):
	for _ in range(len(a)):
		for i in range(1, len(a)):
		if a[i] < a[i -1]:
			temp = a[i]
			a[i] = a[i -1]
			a[i -1] = temp

names = ["pretzels", "carrots", "arugula", "bacon"]
bubble_sort(names)
print(names)

>>>

['arugula', 'bacon', 'carrots', 'pretzels']
```

No entanto, com a sintaxe de descompactacao, é possível trocar índices em uma única linha:

```python
def bubble_sort(a):
	for _ in range(len(a)):
		for i in range(1, len(a)):
			if a[i] < a[i -1]:
				a[i -1], a[i] = a[i], a[i -1] # Swap

names = ["pretzels", "carrots", "arugula", "bacon"]
bubble_sort(names)
print(names)

>>>

['arugula', 'bacon', 'carrots', 'pretzels']
```

A maneira como essa troca funciona é que o lado direito da atribuicao (a[i], a[i-1]) é avaliado primeiro, e seus valores sao colocados em uma nova tupla temporária sem nome (como "carrots", "pretzels") na primeira iteracao dos loops). Em seguida, o padrao de descompactacao do lado esquerdo da atribuicao (a[i-1], a[i]) é usado para receber esse valor de tupla e atribuí-lo aos nomes de variáveis a[i-1] e a[i], respectivamente. Isso substitui "pretzels" por "carrots" no índice 0 e "carrots" por "pretzels" no índice 1. Finalmente, a tupla temporária sem nome desaparece sileciosamente.

Outra aplicacao valiosa do descompactamento está na listas de destino de loops for e construcoes semelhantes, como compreensoes e expressoes geradoras. Por exemplo, aqui eu itero sobre uma lista de lanches sem usar a desembalagem:

```python
snacks = [("bacon", 350), ("donut", 240), ("muffin", 190)]
for i in range(len(snacks)):
	item = snacks[i]
	name = item[0]
	calories = item[1]
	print(f"#{i+1}: {name} has {calories} calories")

>>>

#1: bacon has 350 calories
#2: donut has 240 calories
#3: muffin has 190 calories
```

Isso funciona, mas á muito ruído. Há muito personagens extras necessários para indexar os vários níveis da estrutura snacks. Agora eu obtenho a mesma saída usando descompactar junto com a funcao interna enumerate:

```python
for rank, (name, calories) in enumerate (snacks, 1):
	print(f'#{rank}: {name} has {calories} calories')

>>>

#1: bacon has 350 calories
#2: donut has 240 calories
#3: muffin has 190 calories
```

Essa é a maneira [[Pythonic]] de escrever esse tipo de loop; é curto e fácil de entender. Normalmente, nao há necessidade de acessar nada usando índices.

Usar a descompactacao com sabedoria permitirá que voce evite a indexacao quando possível, resultando em um código Python mais claro e mais limpo. No entando, essas características nao estao isentas de armadilhas a considerar. Descompactar também nao funciona em expressoes de atribuicao.
### Sempre envolva tuplas de elemento único com parenteses

Em Python existem quatro tipos de valores literais de tupla. O primeiro tipo é uma lista separada por vírgulas de itens entre parenteses abertos e fechados:

```python
first = (1, 2, 3)
```

O segundo tipo é exatamente como o primeiro, mas com uma vírgula a direita opcional incluída, o que permite consistencia ao atravessar várias linhas e facilita a edicao:

```python
second = (1, 2, 3,)
second_wrapped = (
	1,
	2,
	3, # Optional comma
)
```

O terceiro tipo é uma lista de itens separados por vírgulas sem parenteses circundantes:

```python
third = 1, 2, 3
```

E , finalmente, o quarto tipo é como o terceiro, mas com uma vírula a direita opciona:

```python
fourth = 1, 2, 3,
```

Python trata todas essas construcoes como o mesmo valor:

```python
assert first == second == third == fourth
```

No entanto, há também tres casos especiais na criacao de tupals que precisam ser considerados. O primeiro caso é a tupla vazia, que é apenas parenteses abertos e fechados:

```python
empty = ()
```

O segundo caso especial é a forma de tuplas de elemento único: voce deve incluir uma vírgula a direita. Se voce deixar de fora a vírgula a direita, entao o que voce tem é uma expressao entre parenteses em vez de uma tupla:

```python
single_with = (1,)
single_without = (1)
assert single_with != single_without
assert single_with[0] == single_without
```

E o terceiro caso especial é semelhante ao segundo, exceto sem os parenteses:

```python
single_parens = (1,)
single_no_parens = 1,
assertsingle_parens == single_no_parens
```

Esse terceiro caso especial - uma vírgula sem parenteses - pode causar problemas inesperados que sao dificeis de diagnosticas. Considere a seguinte chamada de funcao de um site de comércio eletronico que teum um bug difícil de detectar:

```python
to_refund = calculate_refund(
	get_order_value(user, order.id),
	get_tax(user.address, order.dest),
	adjust_discount(user) + 0.1),
```

Voce pode esperar que o tipo de retorno seja um número inteiro, flutuante ou decimal contendo a quantidade de dinheiro a ser reembolsada a um cliente. Mas, na verdade, é uma tupla!

```python
print(type(to_refund))

>>>

<class 'tuple'>
```

O problema é a vírgula estrnha no final da linha final. Remover a vírgula corrige o código: 

```python
to_refund2 = calculate_refund(
	get_order_value(user, order.id),
	get_tax(user.address, order.dest),
	adjust_discount(user) + 0.1) # No trailing comma

print(type(to_refund2))

>>>

<class 'int'>
```

Um caractere de vírgula como este pode ser inserido em seu código por acidente, causando uma mudanca de comportamento que é difícil de rastrear mesmo após uma inspecao minunciosa. O separador errante também pode sobrar da edicao dos itens em uma tupla, lista, conjunto ou chamada de funcao e do esquecimento de remover uma vírugla que sobrou.
### Considerar expressoes condicionais para lógica in-line simples

Python `if` as instrucoes nao sao expressoes. Os blocos `if`, `elif` e `else` cada um pode conter várias instrucoes adicionais. O grupo inteiro de bloco nao avalia para um único valor que pode ser armazenado em uma variável ou passado como um argumento de funcao.

Python também suporta expressoes condicionais que permitem inserir o comportamento `if/elif/else` em praticamente qualquer lugar onde uma expressao é permitida. Por exemplo, aqui eu uso uma expressao condicional para atribuir o valor de uma variável dependendo de um teste booleano:

```python
i = 3
x = "even" if i % 2 == 0 else "odd"
print(x)

>>>

odd
```

Essa estrutura de expressao parece conveniente, especialmente para usos únicos, e é uma reminiscencia do operador ternário que voce pode conhecer de C e outras línguas (por exemplo, condiiton ? true_value : false_value). Para tarefas simples como esta, ou mesmo em listas de argumentos de chamada de funcao (por exemplo, my_func(1 if x else 2)), as expressoes condicioanis podem ser uma boa escolha para equilibirar brevidade com flexibilidade no código.

É importante notar um detalhe importante sobre como as expressoes condicnionais em Python sao diferentes dos operadores ternários em outras linguagens: Em C, a expressao de teste vem primeiro; em Python, a expressao para avaliar quando a expressao de teste é verdadeira vem em primeiro lugar. Por xemplo,voce pode esperar que o código a seguir chame a funcao fail e gere uma excecao; em vez disso, a funcao é Fail nunca é executada porque a condicao de teste é False:

```python
def fail():
	raise Exception('Oops')

x = fail() if False else 20
print(x)

>>>

20
```

`if` as cláusulas em compreensoes Python tiverem sintaxe e comportamento semelhantes para filtragem. Por exemplo, aqui eu uso a cláusula if em uma compreensao de lista para incluir apenas valores pares de x ao calcular a lista resultante:

```python
result = [x / 4 for x in range(10) if x % 2 == 0]
print(result)

>>>

[0.0, 0.5, 1.0, 1.5, 2.0]
```

A expressao a avaliar ( x / 4) vem antes da expressao if (x % 2 == 0), tal como numa expressao condicional.

Antes das expressoes condicionais estarem disponíveis em Python, as pessoas as vezes usavam a lógica booleana para implementar um comportamento semelhante. Por exemplo, a seguinte expressao é equivalente a expressao condicional acima:

```python
x = (i % 2 == 0 and 'even' ) or 'odd'
```

Essa forma de lógica é bastante confusa porque voce precisa saber isso `and` retorna o primeiro valor falso ou o último valor verdadeiro, enquanto `or` retorna o primeiro valor verdadeiro ou o último valor falso.

Além disso, a abordagem de usar operadores booleanos nao funciona se voce quiser reotrnar um valor falso como resultado de uma condicao verdadeira por exemplo:

```python
x = (i % 2 == and []) or [1]
```

Sempre avalia como [1]. É tudo nao óbvio e propenso a erros, o que é parte do motivo pelo qual expressoes condionais foram adiconadas a linguagem em primeiro lugar.

Agora, considere a mesma lógica de uma instrucao if de quatro linhas em vez do exemplo anterior de linha única:

```python
if i % 2 == 0:
	x = 'even'
else:
	x = 'odd'
```

Embora seja mais longo, pode ser melhor por algumas razoes. Primeiro, se mais tarde eu quiser fazer mais dentro de cada uma das ramificacoes de condicao, como imprimir informacoes de depuracao, posso sel atlerar estruturalmenteo código:

```python
if i % 2 == 0:
	x = 'even'
	print('It was even!') # Added
else:
	x = 'odd'
```

Também posso inserir ramificacoes adicionais com blocos elif na mesma instrucao:

```python
if i % 2 == 0:
	x = 'even'
elif i % 3 == 0: # Added
	x = 'divisible by three'
else:
	x = 'odd'
```

Se eu realmente preciso alcancar a brevidade e colocar essa lógica em uma única expressao, posso fazer isso movendo tudo para uma funcao auxiliar que eu chamo de inline:

```python
def number_group(i):
	if i % 2 == 0:
		return 'even'
	else:
		return 'odd'

x = number_group(i) # Short call
```

Como um benefício adicional, a funcao auxiliar pode ser reutilizada em vários lugares em vez de ser única, como seria uma expressao condicional.

Se vice deve usar expressoes condicionais, instrucoes if completas ou if instrucoes encapsuladas em funcoes auxiliares dependerá da situacao específica.

Voce deve evitar expressoes condicionais quando elas devem ser divididas em várias linhas. Por exemplo, aqui as chamadas de funcao que faco sao tao longas que a expressao condicional deve ser encapsulada em linha com parenteses circundadntes:

```python
x = (my_long_function_call(1, 2, 3) if i % 2 == 0
	else my_other_long_function_call(4, 5, 6)
```

Isso é muito difícil de ler. E se voce aplicar um formatador automático a este códigom a expressao condicional provavlemnte será reescrita para usar mais linhas de código do que uma instrucao if/else padrao de qualquer maneira:

```python
x = (
	my_long_function_call(1, 2, 3)
	if i % 2 == 0
	else my_other_long_function_call(4, 5, 6)
)
```

Outro recurso da linguagem Python para comparar com expressões condicionais são as expressões de atribuiçã, que também permitem comportamento semelhante a instruções em expressões. A diferença crítica é que as expressões de atribuição devem ser cercadas por parênteses quando são usadas em um contexto ambíguo; expressões condicionais não exigem parênteses circundantes, e a falta de parênteses pode prejudicar a legibilidade.

Por exemplo, esta instrucao if com uma expressao de atribuicao entre parenteses é permitida:

```python
x = 2
y = 1

if x and (z := x > y):
	...
```

Mas esta instucao if sem colocar parenteses é um erro de sintaxe:

```python
if x and z := x > y:
	...

>>>

Traceback ...
SyntaxError: cannot use assignment expressions with expression
```

Conclusao: Use seu julgamento. Em muitas situacoes, as expressoes condicionais podem ser valiosas e melhroar a clareza. As vezes eles sao melhores com parenteses circundantes e as vezes nao. Expressoes condicionais podem facilmente ser usadas em excesso para escrever código ofuscado que é difícil para novos leitores entenderem. Em caso de dúvida, escolha uma declaracao if normal.
## Impedir a repeticao com expressoes de atribuicao

Uma expressao de atribuicao - também conhecida como operador walrus - é um novo recurso de sintaxe introduzido no Python 3.8 para resolver um problema de longa data com a linguagem que pode causar duplicacao de código. Enquanto as declaracoes de atribuicao normais sao escritas a = b e pronunciadas 'a igual a b', essas atribuicoes sao escritas `a := b` e pronunciadas 'a morsa b' (porque := parece um par de globo oculares e presas).

As expressoes de atribuicao sao úteis porque permitem atribuir variáveis em locais onde as instrucoes de atribuicao nao sao permitidas, como na expressao de teste de uma instrucao if. O valor de uma expressao de atribuicao avalia o que foi atribuído ao identificador no lado esquerdo do operador de morsa.

Por exmplo, digamos que tenho uma cesta de frutas frescas que estou tentando gerenciar para uma barra de sucos. Aqui defino o conteúdo do cesto:

```python
fresh_fruit = {
	'apple': 10,
	'banana': 8,
	'lemon': 5,
}
```

Quando um cliente chega ao balcao para pedir uma limonada, preciso ter certeza de que há pelo menos um limao na cesta para apertar. Aqui eu faco isso recuperando a contagem de limoes e, em seguida, usando uma instrucao if para verificar um valor diferente de zero:

```python
def make_lemonade(count):
	...

def out_of_stock():
	...

count = fresh_fruit.get('lemon', 0)
if count:
	make_lemonade(count)
else:
	out_of_stock()

>>>

Making 5 lemon into lemonade 
```

O problema com este código aparentemente simples é que ele é mais sujo do que precisa ser. A variável count é usada apenas no primeiro bloco da instrucao if. Definir contagem acima da instrucao if faz com que ela pareca ser mais importante do que realmente é, como se todo o código a seguir, incluindo o bloco else, precisasse acessar a variável count, quando esse nao for o caso. 

Esse padrao de buscar um valor, verifica se ele é verdadeiro e, em seguida, usá-lo é extremamente comum em Python. Muitos programadores tentam contornar as múltiplas referencias apra contar com uma variedade de truques que prejudicam a legibilidade. Felizmente, expressoes de atribuicao foram adicionadas a linguagem para simplificar esse tipo de código. Aqui eu reescrevo o exemplo acima usando o operado de morsa:

```python
if count := fresh_fruit.get('lemon', 0):
	make_lemonade(count)
else:
	out_of_stock()
```

Embora esta seja apenas uma linha mais curta, é muito mais legível porque agora está claro que a contagem só é relevante para o primeiro bloco da instrucao if. A expressao de atribuicao primeiro atribui um valor a varivel count e, em seguida, avalia esse valor no contexto da instrucao if para determinar como proceder com o controle de fluxo. Esse comportamento em duas etaps - atribuir e depois avaliar - é a natureza fundamental do operador de morsa.

Os limoes sao bastante potentes, entao apenas um é necessário para a minha receita de limonada, o que significa que uma verificacao diferente de zero e verdadeira é boa o suficiente. No entanto, se um cliente encomedar uma sidra, preciso de me certificar de que tenho pelo menos quatro macas. Aqui faco isso buscando o valor de count no dicionário fresh_fruit e , em seuida, usando uma compracao na expressao de teste da instrucao if:

```python
def make_cider (count):
	...

count = fresh_fruit.get('apple', 0)
if count >= 4:
	make_cider(count)
else:
	out_of_stock()

>>>

Making cider with 100 apples
```

Isso tem o mesmo problema que o exemplo da limonada, onde a atribuicao de count coloca enfase pertubadora nessa variável. Aqui eu melhoro a clareza deste c'doigo usando também o operador da morsa:

```python
if (count := fresh_fruit.get('apple', 0) >= 4:)
	make_cider(count)
else:
	out_of_stock()
```

Isso funciona como esperado e torna o código uma linha mais curta. É importante notar como eu precisava cercar a expressao de atribuicao com parenteses para compará-la com 4 na instrucao if. No exemplo da limonada, nao foram necessários parenteses circundantes porque a expressao de atribuicao se mantinha por si só como uma verificacao diferente de zero e verdadeira; nao era uma subexpressao de uma expressao maior. Tal como acontece com outra expressoes, deve evitar cercar expressoes de atribuicao entre parenteses sempre que possível para reduzir o ruído visual.

Por exemplo, imagine que eu queria implementar um sistema de precedencia para que cada cliente receba automaticamente o melhor suco disponível e nao precise encomendar. Aqui eu defino lógica paraque os smoothis de banana sejam servidos primeiro, seguidos de sidra de maca e, finalmente, limonada:

```python
count = fresh_fruit.get("banana", 0)
if count >= 2:
	pieces = slice_bananas(count)
	to_enjoy = make_smoothies(pieces)
else:
	count = fresh_fruit.get("apple", 0)
	if count >= 4:
		to_enjoy = make_cider(count)
	else:
		count = fresh_fruit.get("lemon", 0)
		if count:
			to_enjoy = make_lemonade(count)
		else:
			to_enjoy ="Nothing"
```

Contrucoes feias como esta sao surpreendentemente comuns no código Python. Felizmente, o operador de morsa fornece uma solucao elegante que pode parecer quase tao versátil quanto a sintaxe dedicada para instrucoes de `switch/case`:

```python
if (count := fresh_fruit.get("banana", 0)) >= 2:
	pieces = slice_bananas(count)
	to_enjoy = make_smoothies(pieces)
elif(count := fresh_fruit.get("apple", 0)) >= 4:
	to_enjoy = make_cider(count)
elif count := fresh_fruit.get("lemon", 0):
	to_enjoy = make_lemonade(count)
else:
	to_enjoy ="Nothing"
```

A versao que usa expressoes de atribuicao é apenas cinco linhas mais curta do que a original, mas a melhoria na legibilidade é vasta devido a reducao no aninhamento e recuo. Se voce vir as contrucoes feias anteriores emergirem em seu código, sugiro que voce as mova para usar o operador de morsa, se possível.

Outra frustracao comum dos novos programadores Python é a falta de uma construcao de loop `do/while`. Por exemplo, digamos que eu quero engarrafar suco a medida que novas frutas sao entregues até que nao reste nenhuma fruta. Aqui eu implemento essa lógica com um loop while:

```python
bottles = []
while fresh_fruit := pick_fruit(): 
	for fruit, count in fresh_fruit.items():
		batch = make_juice (fruit, count)
		bottles.extend(batch)
```

Há muitas outras situacoes em que as expressoes de atribuicao podem ser usadas para eliminar a redundancia. Em geral, quando voce se ve repetindo a mesma expressao ou atribuicao várias vezes dentro de um agrupamento de linhas, é hora de considerar o uso de expressoes de atribuicao para melhorar a legibilidade.

### Considerar match para Desestruturacao no Controle de Fluxo; Evite quando if declaracoes sao suficientes



