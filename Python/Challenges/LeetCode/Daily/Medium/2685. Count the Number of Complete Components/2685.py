class Solution:
    def countCompleteComponents(self, n: int, edges: List[List[int]]) -> int:

        adj = [[] for _ in range(n)]
        for a, b in edges:
            adj[a].append(b)
            adj[b].append(a)

        visited = [False] * n
        components = []

        for i in range(n):
            if not visited[i]:
                queue = deque([i])
                visited[i] = True
                component = {i}
                while queue:
                    node = queue.popleft()
                    for neighbor in adj[node]:
                        if not visited[neighbor]:
                            visited[neighbor] = True
                            component.add(neighbor)
                            queue.append(neighbor)
                components.append(component)

        result = 0

        for comp in components:
            m = len(comp)
            required_edges = m * (m - 1) // 2
            actual_edges = 0

            for a, b in edges:
                if a in comp and b in comp:
                    actual_edges += 1
            if actual_edges == required_edges:
                result += 1

        return result
