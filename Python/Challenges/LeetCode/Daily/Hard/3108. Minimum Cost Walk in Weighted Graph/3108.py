class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [1] * n
    
    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]
    
    def union(self, x, y):
        x_root = self.find(x)
        y_root = self.find(y)
        if x_root == y_root:
            return
        if self.rank[x_root] < self.rank[y_root]:
            self.parent[x_root] = y_root
        else:
            self.parent[y_root] = x_root
            if self.rank[x_root] == self.rank[y_root]:
                self.rank[x_root] += 1

class Solution:
    def minimumCost(self, n: int, edges: List[List[int]], query: List[List[int]]) -> List[int]:
        dsu = DSU(n)
        for u, v, w in edges:
            dsu.union(u, v)
        
        edges_dict = defaultdict(list)
        for u, v, w in edges:
            root = dsu.find(u)
            edges_dict[root].append(w)
        
        component_and = {}
        for root in edges_dict:
            and_val = edges_dict[root][0]
            for w in edges_dict[root][1:]:
                and_val &= w
            component_and[root] = and_val
        
        answer = []
        for s, t in query:
            s_root = dsu.find(s)
            t_root = dsu.find(t)
            if s_root != t_root:
                answer.append(-1)
            else:
                answer.append(component_and[s_root])
        
        return answer