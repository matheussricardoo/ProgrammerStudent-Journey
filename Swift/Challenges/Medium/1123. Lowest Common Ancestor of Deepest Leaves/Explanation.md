## [PT/BR]

### O Problema

Dada a raiz de uma árvore binária, precisamos retornar o ancestral comum mais baixo (LCA - Lowest Common Ancestor) de suas folhas mais profundas. 

- Um nó é considerado folha se não tiver filhos
- A profundidade da raiz é 0, e cada nível abaixo aumenta a profundidade em 1
- O LCA de um conjunto de nós é o nó com maior profundidade que contém todos os nós do conjunto em sua subárvore

### Raciocínio

1. **Identificar Folhas Mais Profundas**:
   - Precisamos primeiro encontrar a profundidade máxima das folhas
   - Todas as folhas nessa profundidade são nossas folhas mais profundas

2. **Encontrar o LCA**:
   - Usamos uma abordagem recursiva pós-ordem (post-order)
   - Para cada nó, calculamos a profundidade máxima de suas subárvores esquerda e direita
   - Se uma subárvore for mais profunda que a outra, o LCA está na subárvore mais profunda
   - Se ambas subárvores tiverem a mesma profundidade, o nó atual é o LCA

3. **Estrutura Auxiliar**:
   - Criamos uma estrutura `DepthLca` para armazenar a profundidade e o LCA de cada subárvore

### Análise da Complexidade

- **Tempo**: O(n) - Visitamos cada nó exatamente uma vez
- **Espaço**: O(h) - Onde h é a altura da árvore (espaço usado na pilha de chamadas recursivas)

### Solução em Código

```swift
import Foundation

class Solution {
    private struct DepthLca {
        let depth: Int
        let lca: TreeNode?
    }

    func lcaDeepestLeaves(_ root: TreeNode?) -> TreeNode? {
        return findLcaAndDepthHelper(root).lca
    }

    private func findLcaAndDepthHelper(_ node: TreeNode?) -> DepthLca {
        guard let node = node else {
            return DepthLca(depth: -1, lca: nil)
        }

        let leftResult = findLcaAndDepthHelper(node.left)
        let rightResult = findLcaAndDepthHelper(node.right)

        if leftResult.depth > rightResult.depth {
            return DepthLca(depth: leftResult.depth + 1, lca: leftResult.lca)
        } else if rightResult.depth > leftResult.depth {
            return DepthLca(depth: rightResult.depth + 1, lca: rightResult.lca)
        } else {
            return DepthLca(depth: leftResult.depth + 1, lca: node)
        }
    }
}
```

### Exemplos

#### Exemplo 1:
**Input**: `root = [3,5,1,6,2,0,8,null,null,7,4]`  
**Output**: `[2,7,4]`  
**Explicação**:
- As folhas mais profundas são 7 e 4 (profundidade 3)
- O LCA delas é o nó 2 (profundidade 2)

#### Exemplo 2:
**Input**: `root = [1]`  
**Output**: `[1]`  
**Explicação**:
- A raiz é a única folha e seu próprio LCA

#### Exemplo 3:
**Input**: `root = [0,1,3,null,2]`  
**Output**: `[2]`  
**Explicação**:
- A folha mais profunda é 2, que é seu próprio LCA

### Conclusão

Esta solução eficiente encontra o LCA das folhas mais profundas em tempo linear, usando uma abordagem recursiva que calcula simultaneamente a profundidade e o LCA para cada subárvore. A estrutura auxiliar `DepthLca` permite combinar essas informações de maneira elegante.

---

## [EN]

### The Problem

Given the root of a binary tree, we need to return the lowest common ancestor (LCA) of its deepest leaves.

- A node is a leaf if it has no children
- The root's depth is 0, and each level below increases depth by 1
- The LCA of a set of nodes is the node with greatest depth that contains all nodes in its subtree

### Reasoning

1. **Identify Deepest Leaves**:
   - First find the maximum depth of leaves
   - All leaves at this depth are our deepest leaves

2. **Find the LCA**:
   - Use a post-order recursive approach
   - For each node, calculate max depth of left and right subtrees
   - If one subtree is deeper, the LCA is in that subtree
   - If both subtrees have equal depth, current node is the LCA

3. **Helper Structure**:
   - Create `DepthLca` struct to store depth and LCA for each subtree

### Complexity Analysis

- **Time**: O(n) - Visit each node exactly once
- **Space**: O(h) - Where h is tree height (recursive call stack space)

### Code Solution

```swift
import Foundation

class Solution {
    private struct DepthLca {
        let depth: Int
        let lca: TreeNode?
    }

    func lcaDeepestLeaves(_ root: TreeNode?) -> TreeNode? {
        return findLcaAndDepthHelper(root).lca
    }

    private func findLcaAndDepthHelper(_ node: TreeNode?) -> DepthLca {
        guard let node = node else {
            return DepthLca(depth: -1, lca: nil)
        }

        let leftResult = findLcaAndDepthHelper(node.left)
        let rightResult = findLcaAndDepthHelper(node.right)

        if leftResult.depth > rightResult.depth {
            return DepthLca(depth: leftResult.depth + 1, lca: leftResult.lca)
        } else if rightResult.depth > leftResult.depth {
            return DepthLca(depth: rightResult.depth + 1, lca: rightResult.lca)
        } else {
            return DepthLca(depth: leftResult.depth + 1, lca: node)
        }
    }
}
```

### Examples

#### Example 1:
**Input**: `root = [3,5,1,6,2,0,8,null,null,7,4]`  
**Output**: `[2,7,4]`  
**Explanation**:
- Deepest leaves are 7 and 4 (depth 3)
- Their LCA is node 2 (depth 2)

#### Example 2:
**Input**: `root = [1]`  
**Output**: `[1]`  
**Explanation**:
- Root is the only leaf and its own LCA

#### Example 3:
**Input**: `root = [0,1,3,null,2]`  
**Output**: `[2]`  
**Explanation**:
- Deepest leaf is 2, which is its own LCA

### Conclusion

This efficient solution finds the LCA of deepest leaves in linear time using a recursive approach that simultaneously calculates depth and LCA for each subtree. The `DepthLca` helper structure elegantly combines this information.