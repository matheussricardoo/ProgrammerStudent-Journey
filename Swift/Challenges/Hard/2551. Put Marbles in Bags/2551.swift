import Foundation 

class Solution {
    func putMarbles(_ weights: [Int], _ k: Int) -> Int {
        let n = weights.count
        
        if k == 1 || k == n {
            return 0
        }

        var boundaryCosts: [Int] = []
        boundaryCosts.reserveCapacity(n - 1) 
        
        // Calculate boundary costs efficiently
        // Using zip creates pairs (weights[i], weights[i+1])
        for i in 0..<(n - 1) {
             boundaryCosts.append(weights[i] + weights[i + 1])
        }

        boundaryCosts.sort()

        let numSplits = k - 1
        
        // Calculate sums using prefix and suffix for conciseness
        let minScoreContribution = boundaryCosts.prefix(numSplits).reduce(0, +)
        let maxScoreContribution = boundaryCosts.suffix(numSplits).reduce(0, +)

        return maxScoreContribution - minScoreContribution
    }
}