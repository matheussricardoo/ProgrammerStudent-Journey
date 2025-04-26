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