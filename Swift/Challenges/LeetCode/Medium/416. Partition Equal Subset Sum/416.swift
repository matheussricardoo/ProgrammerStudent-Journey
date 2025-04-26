import Foundation

class Solution {
    func canPartition(_ nums: [Int]) -> Bool {
        let totalSum = nums.reduce(0, +)

        if totalSum % 2 != 0 {
            return false
        }

        let targetSum = totalSum / 2

        var dp = Array(repeating: false, count: targetSum + 1)
        dp[0] = true 

        for num in nums {
            for s in stride(from: targetSum, through: num, by: -1) {
                dp[s] = dp[s] || dp[s - num]
            }
        }

        return dp[targetSum]
    }
}