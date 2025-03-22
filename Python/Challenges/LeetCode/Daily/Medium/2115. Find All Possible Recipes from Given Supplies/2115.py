class Solution:
    def findAllRecipes(
        self, recipes: List[str], ingredients: List[List[str]], supplies: List[str]
    ) -> List[str]:
        supplies_set = set(supplies)
        recipes_set = set(recipes)
        recipe_to_index = {recipe: i for i, recipe in enumerate(recipes)}
        valid = []
        n = len(recipes)

        for i in range(n):
            recipe = recipes[i]
            valid_recipe = True
            for ing in ingredients[i]:
                if ing not in supplies_set and ing not in recipes_set:
                    valid_recipe = False
                    break
            if valid_recipe:
                valid.append(recipe)

        adj = defaultdict(list)
        in_degree = defaultdict(int)
        for R in valid:
            idx = recipe_to_index[R]
            for ing in ingredients[idx]:
                if ing in recipes_set:
                    adj[ing].append(R)
                    in_degree[R] += 1

        queue = deque()
        for R in valid:
            if in_degree.get(R, 0) == 0:
                queue.append(R)

        created = set()
        result = []

        while queue:
            current = queue.popleft()
            idx = recipe_to_index[current]
            can_create = True

            for ing in ingredients[idx]:
                if ing in supplies_set:
                    continue
                elif ing in created:
                    continue
                else:
                    can_create = False
                    break

            if can_create:
                created.add(current)
                result.append(current)
                for neighbor in adj[current]:
                    in_degree[neighbor] -= 1
                    if in_degree[neighbor] == 0:
                        queue.append(neighbor)

        return result
