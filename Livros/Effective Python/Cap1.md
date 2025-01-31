### PEP 8 : https://peps.python.org/pep-0008/
### Expressões e Declarações

- Use negação inline (if a is not b) em vez de negação de expressões positivas (if not a is b).
- Não verifique se há recipientes vazios ou sequências (como [] ou '') comparando o comprimento com zero (if len(somelist) == 0). Use if not somelist e assuma que os valores vazios serão implicitamente avaliados como False.
- O mesmo vale para recipientes ou sequências não vazias (como [1] ou 'oi'). A instrução if somelist é implicitamente True para valores não vazios.
- Evite instruções if de linha única, loops for e while e except instruções compostas. Espalhe-os por várias linhas para maior clareza.
- Se não conseguir ajustar uma expressão numa linha, rodeie-a entre parênteses e adicione quebras de linha e recuo para facilitar a leitura.

Existe uma ferramenta de formatação automática PEP 8: É chamada de black (https://github.com/psf/black), é um projeto oficial da Python Software Foundation.

### Escrever funções auxiliares em vez de expressões complexas

A boa sintaxe de Python facilita a escrita de expressões de linha única que implementam muita lógica. Por exemplo, digamos que eu queria decodificar a cadeia de caracteres de consulta de uma URL de maneira elegante:

```python
from urllib.parse import parse_qs

my_values = parse_qs("red=5&blue=0&green=", keep_blank_values=True)
print(repr(my_values))

>>>

{'red': ['5'], 'blue': ['0'], 'green': ['']}
```

Alguns parâmetros de cadeia de caracteres de consulta podem ter vários valores, alguns podem ter valores únicos, alguns podem estar presentes, mas têm valores em branco, e alguns podem estar totalmente ausentes.

```python
print("Red: ", my_values.get("red"))
print("Green: ", my_values.get("green"))
print("Opacity:", my_values.get("opacity"))

>>>

Red: ['5']
Green: ['']
Opacity: None
```

Seria bom se um valor padrão de 0 fosse atribuído quando um parâmetro não é fornecido ou está em branco. Eu poderia inicialmente optar por fazer isso com expressões booleanas porque parece que essa é a escolha mais natural.

A sintaxe do Python torna essa escolha muito fácil. O truque aqui é que a cadeia de caracteres vazia, a lista vazia e o zero todos avaliam como `False` implicitamente. Assim, as expressões abaixo se comportam da maneira esperada:

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

O caso 'red' funciona porque a chave 'red' está presente no dicionário `my_values`. O valor recuperado pelo método `get` é uma lista com um membro: a string `'5'`. Este item é recuperado acessando o índice 0 da lista e a expressão or determina que o valor final é `'5'`.

O caso 'green' funciona porque o valor no dicionário `my_values` é uma lista com um membro: uma cadeia de caracteres vazia. O item no índice 0 da lista é recuperado. A expressão or determina que a cadeia de caracteres vazia deve ser substituída pelo valor 0.

O caso de 'opacity' funciona porque o valor no dicionário `my_values` está completamente ausente. O comportamento do método get é retornar seu segundo argumento se a chave não existir no dicionário, que neste caso é uma lista contendo uma cadeia de caracteres vazia. A expressão or então substitui a cadeia de caracteres vazia por 0.

A expressão complexa com get, [""], [0] e or é difícil de ler, e ainda assim não faz tudo o que preciso. Também quero garantir que todos os valores de parâmetros sejam convertidos em inteiros para evitar erros de tipo.

```python
red = int(my_values.get("red", [""])[0] or 0)
```

Essa lógica é agora extremamente difícil de ler. Há muito ruído visual. O código não é acessível. Um novo leitor do código teria que gastar muito tempo separando a expressão para descobrir o que está acontecendo.

Embora o Python ofereça suporte a expressões condicionais para comportamento `inline if/else`, usá-las nessa situação resulta em um código que não é muito mais claro do que o exemplo de operador booleano.

```python
red_str = my_values.get("red", [""])
red = int(red_str[0]) if red_str[0] else 0
```

Como alternativa, posso usar uma instrução if completa em várias linhas para implementar a mesma lógica. Ver todas as etapas espalhadas assim faz com que a versão densa pareça ainda mais complexa:

```python
green_str = my_values.get("green", [""])
if green_str[0]:
	green = int(green_str[0])
else:
	green = 0
```

Agora que essa lógica está espalhada por várias linhas, é um pouco mais difícil copiar e colar para atribuir outras variáveis (por exemplo, `red`). Se eu quiser reutilizar essa funcionalidade regularmente, posso movê-la para uma função auxiliar:

```python
def get_first_int(values, key, default=0):
	found = values.get(key, [""])
	if found[0]:
		return int(found[0])
	return default
```

O código de chamada é muito mais claro do que a expressão complexa usando `or` e a versão de duas linhas usando a expressão condicional:

```python
green = get_first_int(my_values, "green")
```

Assim que suas expressões se complicarem, é hora de considerar dividi-las em partes menores, como variáveis intermediárias, e mover a lógica em funções auxiliares. O que você ganha em legibilidade geralmente vale a pena.

### Prefira a descompactação de atribuições múltiplas à indexação

Python tem um tipo de `tupla` embutido que pode ser usado para criar sequências imutáveis e ordenadas de valores. Uma tupla pode estar vazia ou pode conter um único item:

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

Depois que uma tupla é criada, você não pode modificá-la atribuindo um novo valor a um índice:

```python
pair = ("Chocolate", "Peanut butter")
pair[0] = "Honey"

>>>

Traceback ...
TypeError: 'tuple' object does not support item assignment
```

Python também tem sintaxe para descompactar, o que permite atribuir vários valores em uma única instrução. Os padrões que você especifica nas tarefas de descompactação se parecem muito com tentar acessar índices:

```python
item = ("Peanut butter", "Jelly")
first, second = item # Unpacking
print(first, "and", second)

>>>

Peanut butter and Jelly
```

Descompactar tem menos ruído visual do que acessar os índices da tupla, e muitas vezes, requer menos linhas de código. A mesma sintaxe de correspondência de padrões de descompactação funciona ao atribuir valores de uma estrutura de dados aninhada, como um dicionário que retorna tuplas:

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

Tem como usar o descompactamento para trocar valores no local sem a necessidade criar variáveis temporárias. Aqui eu uso sintaxe típica com índices para trocar os valores entre duas posições em um array:

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

No entanto, com a sintaxe de descompactação, é possível trocar índices em uma única linha:

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

A maneira como essa troca funciona é que o lado direito da atribuição (a[i], a[i-1]) é avaliado primeiro, e seus valores são colocados em uma nova tupla temporária sem nome (como "carrots", "pretzels"). Em seguida, os valores na nova tupla são atribuídos aos índices no lado esquerdo da expressão (a[i-1], a[i]).

Outra aplicação valiosa do descompactamento está na listas de destino de loops for e construções semelhantes, como compreensões e expressões geradoras. Por exemplo, aqui eu itero sobre uma lista de listas de snacks, descompactando cada lista em duas variáveis:

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

Isso funciona, mas há muito ruído. Há muitos caracteres extras necessários para indexar os vários níveis da estrutura snacks. Agora eu obtenho a mesma saída usando descompactar junto com a função enumerate:

```python
for rank, (name, calories) in enumerate (snacks, 1):
	print(f'#{rank}: {name} has {calories} calories')

>>>

#1: bacon has 350 calories
#2: donut has 240 calories
#3: muffin has 190 calories
```

Essa é a maneira Pythonic de escrever esse tipo de loop; é curto e fácil de entender. Normalmente, não há necessidade de acessar nada usando índices.

Usar a descompactação com sabedoria permitirá que você evite a indexação quando possível, resultando em um código Python mais claro e mais limpo. No entanto, essas características não estão isentas de riscos. 

### Sempre envolva tuplas de elemento único com parênteses

Em Python existem quatro tipos de valores literais de tupla. O primeiro tipo é uma lista separada por vírgulas de itens entre parênteses abertos e fechados:

```python
first = (1, 2, 3)
```

O segundo tipo é exatamente como o primeiro, mas com uma vírgula à direita opcional incluída, o que permite consistência ao atravessar várias linhas e facilita a edição:

```python
second = (1, 2, 3,)
second_wrapped = (
	1,
	2,
	3, # Optional comma
)
```

O terceiro tipo é uma lista de itens separados por vírgulas sem parênteses circundantes:

```python
third = 1, 2, 3
```

E, finalmente, o quarto tipo é como o terceiro, mas com uma vírgula à direita opcional:

```python
fourth = 1, 2, 3,
```

Python trata todas essas construções como o mesmo valor:

```python
assert first == second == third == fourth
```

No entanto, há também três casos especiais na criação de tuplas que precisam ser considerados. O primeiro caso é a tupla vazia, que é apenas parênteses abertos e fechados:

```python
empty = ()
```

O segundo caso especial é a forma de tuplas de elemento único: você deve incluir uma vírgula à direita. Se você deixar de fora a vírgula à direita, então o que você tem é uma expressão entre parênteses, não uma tupla:

```python
single_with = (1,)
single_without = (1)
assert single_with != single_without
assert single_with[0] == single_without
```

E o terceiro caso especial é semelhante ao segundo, exceto sem os parênteses:

```python
single_parens = (1,)
single_no_parens = 1,
assert single_parens == single_no_parens
```

Esse terceiro caso especial - uma vírgula sem parênteses - pode causar problemas inesperados que são difíceis de diagnosticar. Considere a seguinte chamada de função de um site de comércio eletrônico:

```python
to_refund = calculate_refund(
	get_order_value(user, order.id),
	get_tax(user.address, order.dest),
	adjust_discount(user) + 0.1),
```

Você pode esperar que o tipo de retorno seja um número inteiro, flutuante ou decimal contendo a quantidade de dinheiro a ser reembolsada a um cliente. Mas, na verdade, é uma tupla!

```python
print(type(to_refund))

>>>

<class 'tuple'>
```

O problema é a vírgula estranha no final da linha final. Remover a vírgula corrige o código:

```python
to_refund2 = calculate_refund(
	get_order_value(user, order.id),
	get_tax(user.address, order.dest),
	adjust_discount(user) + 0.1) # No trailing comma

print(type(to_refund2))

>>>

<class 'int'>
```

Um caractere de vírgula como este pode ser inserido em seu código por acidente, causando uma mudança de comportamento que é difícil de rastrear mesmo após uma inspeção minuciosa. O separador errado pode ser difícil de detectar à primeira vista. É melhor evitar fazer isso.

### Considerar expressões condicionais para lógica in-line simples

Python `if` as instruções não são expressões. Os blocos `if`, `elif` e `else` cada um pode conter várias instruções adicionais. O grupo inteiro de bloco não avalia para um único valor que pode ser atribuído diretamente a uma variável.

Python também suporta expressões condicionais que permitem inserir o comportamento `if/elif/else` em praticamente qualquer lugar onde uma expressão é permitida. Por exemplo, aqui eu uso uma expressão condicional para determinar se um número é par ou ímpar:

```python
i = 3
x = "even" if i % 2 == 0 else "odd"
print(x)

>>>

odd
```

Essa estrutura de expressão parece conveniente, especialmente para usos únicos, e é uma reminiscência do operador ternário que você pode conhecer de C e outras línguas (por exemplo, condition ? true_value : false_value).

É importante notar um detalhe sobre como as expressões condicionais em Python são diferentes dos operadores ternários em outras linguagens: Em C, a expressão de teste vem primeiro; em Python, a expressão para o valor verdadeiro vem primeiro, seguida pelo teste e, em seguida, pela expressão para o valor falso:

```python
def fail():
	raise Exception('Oops')

x = fail() if False else 20
print(x)

>>>

20
```

`if` as cláusulas em compreensões Python têm sintaxe e comportamento semelhantes para filtragem. Por exemplo, aqui eu uso a cláusula if em uma compreensão de lista para incluir apenas valores pares:

```python
result = [x / 4 for x in range(10) if x % 2 == 0]
print(result)

>>>

[0.0, 0.5, 1.0, 1.5, 2.0]
```

A expressão a avaliar (x / 4) vem antes da expressão if (x % 2 == 0), tal como numa expressão condicional.

Antes das expressões condicionais estarem disponíveis em Python, as pessoas às vezes usavam a lógica booleana para implementar um comportamento semelhante. Por exemplo, a seguinte expressão é equivalente a uma expressão condicional:

```python
x = (i % 2 == 0 and 'even') or 'odd'
```

Essa forma de lógica é bastante confusa porque você precisa saber que `and` retorna o primeiro valor falso ou o último valor verdadeiro, enquanto `or` retorna o primeiro valor verdadeiro ou o último valor falso. Além disso, a abordagem de usar operadores booleanos não funciona se você quiser retornar um valor falso como resultado de uma condição verdadeira por exemplo:

```python
x = (i % 2 == and []) or [1]
```

Sempre avalia como [1]. É tudo não óbvio e propenso a erros, o que é parte do motivo pelo qual expressões condicionais foram adicionadas à linguagem em primeiro lugar.

Agora, considere a mesma lógica de uma instrução if de quatro linhas em vez do exemplo anterior de linha única:

```python
if i % 2 == 0:
	x = 'even'
else:
	x = 'odd'
```

Embora seja mais longo, pode ser melhor por algumas razões. Primeiro, se mais tarde eu quiser fazer mais dentro de cada uma das ramificações de condição, como imprimir informações de depuração, posso alterar estruturalmente o código:

```python
if i % 2 == 0:
	x = 'even'
	print('It was even!') # Added
else:
	x = 'odd'
```

Também posso inserir ramificações adicionais com blocos elif na mesma instrução:

```python
if i % 2 == 0:
	x = 'even'
elif i % 3 == 0: # Added
	x = 'divisible by three'
else:
	x = 'odd'
```

Se eu realmente precisar alcançar a brevidade e colocar essa lógica em uma única expressão, posso fazer isso movendo tudo para uma função auxiliar que eu chamo inline:

```python
def number_group(i):
	if i % 2 == 0:
		return 'even'
	else:
		return 'odd'

x = number_group(i) # Short call
```

Como um benefício adicional, a função auxiliar pode ser reutilizada em vários lugares em vez de ser única, como seria uma expressão condicional.

Se você deve usar expressões condicionais, instruções if completas ou if instruções encapsuladas em funções auxiliares dependerá da situação específica.

Você deve evitar expressões condicionais quando elas devem ser divididas em várias linhas. Por exemplo, aqui as chamadas de função que faço são tão longas que a expressão condicional deve ser encapsulada em linha com parênteses circundantes:

```python
x = (my_long_function_call(1, 2, 3) if i % 2 == 0
	else my_other_long_function_call(4, 5, 6))
```

Isso é muito difícil de ler. E se você aplicar um formatador automático a este código, a expressão condicional provavelmente será reescrita para usar mais linhas de código do que uma instrução if/else padrão de qualquer maneira:

```python
x = (
	my_long_function_call(1, 2, 3)
	if i % 2 == 0
	else my_other_long_function_call(4, 5, 6)
)
```

Outro recurso da linguagem Python para comparar com expressões condicionais são as expressões de atribuição, que também permitem comportamento semelhante a instruções em expressões. A diferença crítica é que as expressões de atribuição devem ser cercadas por parênteses quando são usadas em um contexto ambíguo; expressões condicionais não exigem parênteses circundantes, e a falta de parênteses pode prejudicar a legibilidade.

Por exemplo, esta instrução if com uma expressão de atribuição entre parênteses é permitida:

```python
x = 2
y = 1

if x and (z := x > y):
	...
```

Mas esta instrução if sem colocar parênteses é um erro de sintaxe:

```python
if x and z := x > y:
	...

>>>

Traceback ...
SyntaxError: cannot use assignment expressions with expression
```

Conclusão: Use seu julgamento. Em muitas situações, as expressões condicionais podem ser valiosas e melhorar a clareza. Às vezes elas são melhores com parênteses circundantes e às vezes não. Expressões condicionais podem facilmente ser usadas em excesso para escrever código ofuscado que é difícil para novos leitores entenderem. Em caso de dúvida, escolha uma declaração if normal.

## Impedir a repetição com expressões de atribuição

Uma expressão de atribuição - também conhecida como operador walrus - é um novo recurso de sintaxe introduzido no Python 3.8 para resolver um problema de longa data com a linguagem que pode causar duplicação de código. Enquanto as declarações de atribuição normais são escritas a = b e pronunciadas 'a igual a b', essas atribuições são escritas `a := b` e pronunciadas 'a morsa b' (porque := parece um par de globos oculares e presas).

As expressões de atribuição são úteis porque permitem atribuir variáveis em locais onde as instruções de atribuição não são permitidas, como na expressão de teste de uma instrução if. O valor de uma expressão de atribuição avalia o que foi atribuído ao identificador no lado esquerdo do operador de morsa.

Por exemplo, digamos que tenho uma cesta de frutas frescas que estou tentando gerenciar para uma barra de sucos. Aqui defino o conteúdo do cesto:

```python
fresh_fruit = {
	'apple': 10,
	'banana': 8,
	'lemon': 5,
}
```

Quando um cliente chega ao balcão para pedir uma limonada, preciso ter certeza de que há pelo menos um limão na cesta para apertar. Aqui eu faço isso recuperando a contagem de limões e, em seguida, usando uma instrução if para verificar um valor diferente de zero:

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

O problema com este código aparentemente simples é que ele é mais sujo do que precisa ser. A variável count é usada apenas no primeiro bloco da instrução if. Definir contagem acima da instrução if faz com que ela pareça ser mais importante do que realmente é, como se todo o código a seguir, incluindo o bloco else, precisasse acessar a variável count, quando esse não for o caso. 

Esse padrão de buscar um valor, verificar se ele é verdadeiro e, em seguida, usá-lo é extremamente comum em Python. Muitos programadores tentam contornar as múltiplas referências para contar com uma variedade de truques que prejudicam a legibilidade. Felizmente, expressões de atribuição foram adicionadas à linguagem para simplificar esse tipo de código. Aqui eu reescrevo o exemplo acima usando o operador de morsa:

```python
if count := fresh_fruit.get('lemon', 0):
	make_lemonade(count)
else:
	out_of_stock()
```

Embora esta seja apenas uma linha mais curta, é muito mais legível porque agora está claro que a contagem só é relevante para o primeiro bloco da instrução if. A expressão de atribuição primeiro atribui um valor à variável count e, em seguida, avalia esse valor no contexto da instrução if para determinar como proceder com o controle de fluxo. Esse comportamento em duas etapas - atribuir e depois avaliar - é a natureza fundamental do operador de morsa.

Os limões são bastante potentes, então apenas um é necessário para a minha receita de limonada, o que significa que uma verificação diferente de zero e verdadeira é boa o suficiente. No entanto, se um cliente encomendar uma sidra, preciso me certificar de que tenho pelo menos quatro maçãs. Aqui faço isso buscando o valor de count no dicionário fresh_fruit e, em seguida, usando uma comparação na expressão de teste da instrução if:

```python
def make_cider(count):
	...

count = fresh_fruit.get('apple', 0)
if count >= 4:
	make_cider(count)
else:
	out_of_stock()

>>>

Making cider with 100 apples
```

Isso tem o mesmo problema que o exemplo da limonada, onde a atribuição de count coloca ênfase perturbadora nessa variável. Aqui eu melhoro a clareza deste código usando também o operador da morsa:

```python
if (count := fresh_fruit.get('apple', 0)) >= 4:
	make_cider(count)
else:
	out_of_stock()
```

Isso funciona como esperado e torna o código uma linha mais curta. É importante notar como eu precisava cercar a expressão de atribuição com parênteses para compará-la com 4 na instrução if. No exemplo da limonada, não foram necessários parênteses circundantes porque a expressão de atribuição se mantinha por si só como uma verificação diferente de zero e verdadeira; não era uma subexpressão de uma expressão maior. Tal como acontece com outras expressões, deve-se evitar cercar expressões de atribuição entre parênteses sempre que possível para reduzir o ruído visual.

Por exemplo, imagine que eu queria implementar um sistema de precedência para que cada cliente receba automaticamente o melhor suco disponível e não precise encomendar. Aqui eu defino lógica para que os smoothies de banana sejam servidos primeiro, seguidos de sidra de maçã e, finalmente, limonada:

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
			to_enjoy = "Nothing"
```

Construções feias como esta são surpreendentemente comuns no código Python. Felizmente, o operador de morsa fornece uma solução elegante que pode parecer quase tão versátil quanto a sintaxe dedicada para instruções de `switch/case`:

```python
if (count := fresh_fruit.get("banana", 0)) >= 2:
	pieces = slice_bananas(count)
	to_enjoy = make_smoothies(pieces)
elif (count := fresh_fruit.get("apple", 0)) >= 4:
	to_enjoy = make_cider(count)
elif count := fresh_fruit.get("lemon", 0):
	to_enjoy = make_lemonade(count)
else:
	to_enjoy = "Nothing"
```

A versão que usa expressões de atribuição é apenas cinco linhas mais curta do que a original, mas a melhoria na legibilidade é vasta devido à redução no aninhamento e recuo. Se você vir as construções feias anteriores emergirem em seu código, sugiro que as mova para usar o operador de morsa, se possível.

Outra frustração comum dos novos programadores Python é a falta de uma construção de loop `do/while`. Por exemplo, digamos que eu quero engarrafar suco à medida que novas frutas são entregues até que não reste nenhuma fruta. Aqui eu implemento essa lógica com um loop while:

```python
bottles = []
while fresh_fruit := pick_fruit(): 
	for fruit, count in fresh_fruit.items():
		batch = make_juice(fruit, count)
		bottles.extend(batch)
```

Há muitas outras situações em que as expressões de atribuição podem ser usadas para eliminar a redundância. Em geral, quando você se vê repetindo a mesma expressão ou atribuição várias vezes dentro de um agrupamento de linhas, é hora de considerar o uso de expressões de atribuição para melhorar a legibilidade.

### Considerar match para Desestruturação no Controle de Fluxo; Evite quando if declarações são suficientes

---
