## [PT/BR]

### O Problema

Dado um conjunto de receitas, uma lista de ingredientes necessários para cada receita e um conjunto inicial de suprimentos disponíveis, queremos determinar quais receitas podem ser criadas. Uma receita pode ser criada se todos os seus ingredientes estiverem disponíveis nos suprimentos ou puderem ser criados como outras receitas.

Você recebe:
- Uma lista `recipes`, onde cada elemento é o nome de uma receita.
- Uma lista de listas `ingredients`, onde `ingredients[i]` contém os ingredientes necessários para criar a receita `recipes[i]`.
- Uma lista `supplies`, que representa os ingredientes disponíveis inicialmente.

Retorne uma lista das receitas que podem ser criadas.

### Raciocínio

Para resolver este problema, segui o seguinte raciocínio:

1. **Dependências entre receitas**: Algumas receitas podem depender de outras receitas como ingredientes. Isso cria uma relação de dependência que precisa ser resolvida antes de determinar se uma receita pode ser criada. Utilizei uma abordagem baseada em **ordenação topológica** (Kahn's Algorithm) para processar as receitas na ordem correta.

2. **Validação inicial**: Antes de processar as receitas, verifiquei se todos os ingredientes de uma receita são válidos. Um ingrediente é válido se ele está disponível nos suprimentos ou é outra receita que pode ser criada. Receitas com ingredientes inválidos são descartadas imediatamente.

3. **Grafo de dependências**: Construí um grafo direcionado onde os nós representam receitas e as arestas representam dependências. Por exemplo, se a receita A depende da receita B como ingrediente, há uma aresta de B para A no grafo.

4. **Processamento em ordem topológica**: Utilizei uma fila para processar as receitas sem dependências primeiro. Para cada receita processada, verifiquei se todos os seus ingredientes estão disponíveis nos suprimentos ou foram criados anteriormente. Se sim, marquei a receita como criada e atualizei as dependências de outras receitas.

5. **Resultado final**: Após processar todas as receitas possíveis, retornei a lista de receitas que foram marcadas como criadas.

### Análise da Complexidade

- **Complexidade de tempo**:
  - Construção do grafo: \( O(n \cdot m) \), onde \( n \) é o número de receitas e \( m \) é o número máximo de ingredientes por receita.
  - Ordenação topológica: \( O(n + e) \), onde \( e \) é o número total de dependências (arestas no grafo).
  - Total: \( O(n \cdot m + n + e) \).

- **Complexidade de espaço**: \( O(n + e) \), devido ao armazenamento do grafo e das estruturas auxiliares.

### Solução em Código

```python
from collections import deque, defaultdict
from typing import List

class Solution:
    def findAllRecipes(self, recipes: List[str], ingredients: List[List[str]], supplies: List[str]) -> List[str]:
        # Conjunto de suprimentos e receitas
        supplies_set = set(supplies)
        recipe_to_index = {recipe: i for i, recipe in enumerate(recipes)}
        
        # Filtro inicial: identificar receitas válidas
        valid_recipes = []
        for i, recipe in enumerate(recipes):
            if all(ing in supplies_set or ing in recipe_to_index for ing in ingredients[i]):
                valid_recipes.append(recipe)
        
        # Construir grafo de dependências
        adj = defaultdict(list)
        in_degree = defaultdict(int)
        for recipe in valid_recipes:
            idx = recipe_to_index[recipe]
            for ing in ingredients[idx]:
                if ing in recipe_to_index:
                    adj[ing].append(recipe)
                    in_degree[recipe] += 1
        
        # Inicializar fila com receitas sem dependências
        queue = deque([recipe for recipe in valid_recipes if in_degree[recipe] == 0])
        created = set()
        result = []
        
        while queue:
            current = queue.popleft()
            idx = recipe_to_index[current]
            
            # Verificar se todos os ingredientes estão disponíveis
            can_create = True
            for ing in ingredients[idx]:
                if ing not in supplies_set and ing not in created:
                    can_create = False
                    break
            
            if can_create:
                created.add(current)
                result.append(current)
                
                # Atualizar dependências de outras receitas
                for neighbor in adj[current]:
                    in_degree[neighbor] -= 1
                    if in_degree[neighbor] == 0:
                        queue.append(neighbor)
        
        return result
```

### Exemplos

#### Exemplo 1:
**Input**:  
```plaintext
recipes = ["bread", "sandwich"]
ingredients = [["yeast", "flour"], ["bread", "meat"]]
supplies = ["yeast", "flour", "meat"]
```
**Output**:  
```plaintext
["bread", "sandwich"]
```
**Explicação**:
1. A receita `"bread"` pode ser criada porque seus ingredientes (`"yeast"` e `"flour"`) estão nos suprimentos.
2. A receita `"sandwich"` pode ser criada porque seu ingrediente `"bread"` foi criado e `"meat"` está nos suprimentos.

#### Exemplo 2:
**Input**:  
```plaintext
recipes = ["bread", "sandwich", "burger"]
ingredients = [["yeast", "flour"], ["bread", "meat"], ["sandwich", "meat", "bread"]]
supplies = ["yeast", "flour", "meat"]
```
**Output**:  
```plaintext
["bread", "sandwich", "burger"]
```
**Explicação**:
1. A receita `"bread"` pode ser criada porque seus ingredientes (`"yeast"` e `"flour"`) estão nos suprimentos.
2. A receita `"sandwich"` pode ser criada porque seu ingrediente `"bread"` foi criado e `"meat"` está nos suprimentos.
3. A receita `"burger"` pode ser criada porque seus ingredientes (`"sandwich"`, `"meat"` e `"bread"`) foram criados ou estão nos suprimentos.

#### Exemplo 3:
**Input**:  
```plaintext
recipes = ["cake"]
ingredients = [["eggs", "flour", "butter"]]
supplies = ["flour", "butter"]
```
**Output**:  
```plaintext
[]
```
**Explicação**:
- A receita `"cake"` não pode ser criada porque o ingrediente `"eggs"` não está nos suprimentos nem pode ser criado.

### Conclusão

A solução utiliza uma abordagem eficiente baseada em ordenação topológica para lidar com dependências entre receitas. Ao construir um grafo de dependências e processar as receitas na ordem correta, garantimos que todas as dependências sejam resolvidas antes de criar uma receita. A complexidade de tempo \( O(n \cdot m + n + e) \) torna a solução adequada para entradas razoáveis.

---

## [EN]

### The Problem

Given a set of recipes, a list of ingredients required for each recipe, and an initial set of available supplies, we want to determine which recipes can be created. A recipe can be created if all its ingredients are either available in the supplies or can be created as other recipes.

You are given:
- A list `recipes`, where each element is the name of a recipe.
- A list of lists `ingredients`, where `ingredients[i]` contains the ingredients required to create the recipe `recipes[i]`.
- A list `supplies`, representing the ingredients initially available.

Return a list of recipes that can be created.

### Reasoning

To solve this problem, I followed this reasoning:

1. **Dependencies between recipes**: Some recipes may depend on other recipes as ingredients. This creates a dependency relationship that needs to be resolved before determining if a recipe can be created. I used a **topological sorting** approach (Kahn's Algorithm) to process recipes in the correct order.

2. **Initial validation**: Before processing the recipes, I checked if all ingredients for a recipe are valid. An ingredient is valid if it is available in the supplies or can be created as another recipe. Recipes with invalid ingredients are discarded immediately.

3. **Dependency graph**: I constructed a directed graph where nodes represent recipes and edges represent dependencies. For example, if recipe A depends on recipe B as an ingredient, there is an edge from B to A in the graph.

4. **Topological processing**: I used a queue to process recipes without dependencies first. For each processed recipe, I checked if all its ingredients are available in the supplies or were created earlier. If so, I marked the recipe as created and updated the dependencies of other recipes.

5. **Final result**: After processing all possible recipes, I returned the list of recipes marked as created.

### Complexity Analysis

- **Time complexity**:
  - Graph construction: \( O(n \cdot m) \), where \( n \) is the number of recipes and \( m \) is the maximum number of ingredients per recipe.
  - Topological sorting: \( O(n + e) \), where \( e \) is the total number of dependencies (edges in the graph).
  - Total: \( O(n \cdot m + n + e) \).

- **Space complexity**: \( O(n + e) \), due to storage of the graph and auxiliary structures.

### Code Solution

```python
from collections import deque, defaultdict
from typing import List

class Solution:
    def findAllRecipes(self, recipes: List[str], ingredients: List[List[str]], supplies: List[str]) -> List[str]:
        # Set of supplies and recipes
        supplies_set = set(supplies)
        recipe_to_index = {recipe: i for i, recipe in enumerate(recipes)}
        
        # Initial filtering: identify valid recipes
        valid_recipes = []
        for i, recipe in enumerate(recipes):
            if all(ing in supplies_set or ing in recipe_to_index for ing in ingredients[i]):
                valid_recipes.append(recipe)
        
        # Build dependency graph
        adj = defaultdict(list)
        in_degree = defaultdict(int)
        for recipe in valid_recipes:
            idx = recipe_to_index[recipe]
            for ing in ingredients[idx]:
                if ing in recipe_to_index:
                    adj[ing].append(recipe)
                    in_degree[recipe] += 1
        
        # Initialize queue with recipes having zero dependencies
        queue = deque([recipe for recipe in valid_recipes if in_degree[recipe] == 0])
        created = set()
        result = []
        
        while queue:
            current = queue.popleft()
            idx = recipe_to_index[current]
            
            # Check if all ingredients are available
            can_create = True
            for ing in ingredients[idx]:
                if ing not in supplies_set and ing not in created:
                    can_create = False
                    break
            
            if can_create:
                created.add(current)
                result.append(current)
                
                # Update dependencies of other recipes
                for neighbor in adj[current]:
                    in_degree[neighbor] -= 1
                    if in_degree[neighbor] == 0:
                        queue.append(neighbor)
        
        return result
```

### Examples

#### Example 1:
**Input**:  
```plaintext
recipes = ["bread", "sandwich"]
ingredients = [["yeast", "flour"], ["bread", "meat"]]
supplies = ["yeast", "flour", "meat"]
```
**Output**:  
```plaintext
["bread", "sandwich"]
```
**Explanation**:
1. The recipe `"bread"` can be created because its ingredients (`"yeast"` and `"flour"`) are in the supplies.
2. The recipe `"sandwich"` can be created because its ingredient `"bread"` was created and `"meat"` is in the supplies.

#### Example 2:
**Input**:  
```plaintext
recipes = ["bread", "sandwich", "burger"]
ingredients = [["yeast", "flour"], ["bread", "meat"], ["sandwich", "meat", "bread"]]
supplies = ["yeast", "flour", "meat"]
```
**Output**:  
```plaintext
["bread", "sandwich", "burger"]
```
**Explanation**:
1. The recipe `"bread"` can be created because its ingredients (`"yeast"` and `"flour"`) are in the supplies.
2. The recipe `"sandwich"` can be created because its ingredient `"bread"` was created and `"meat"` is in the supplies.
3. The recipe `"burger"` can be created because its ingredients (`"sandwich"`, `"meat"`, and `"bread"`) were created or are in the supplies.

#### Example 3:
**Input**:  
```plaintext
recipes = ["cake"]
ingredients = [["eggs", "flour", "butter"]]
supplies = ["flour", "butter"]
```
**Output**:  
```plaintext
[]
```
**Explanation**:
- The recipe `"cake"` cannot be created because the ingredient `"eggs"` is neither in the supplies nor can it be created.

### Conclusion

The solution uses an efficient approach based on topological sorting to handle dependencies between recipes. By constructing a dependency graph and processing recipes in the correct order, we ensure that all dependencies are resolved before creating a recipe. The time complexity \( O(n \cdot m + n + e) \) makes the solution suitable for reasonable inputs.