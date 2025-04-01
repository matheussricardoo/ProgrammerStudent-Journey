import Foundation

class Solution {
    func mostPoints(_ questions: [[Int]]) -> Int {
        let n = questions.count
        var dp = Array(repeating: 0, count: n + 1) // Use Int as sum can exceed typical Int32 limits

        for i in stride(from: n - 1, through: 0, by: -1) {
            let points = questions[i][0]
            let brainpower = questions[i][1]
            
            let nextQuestionIndex = i + brainpower + 1
            
            // Ensure index stays within bounds, mapping out-of-bounds to dp[n] which is 0
            let pointsIfSolved = points + dp[min(nextQuestionIndex, n)] 
            let pointsIfSkipped = dp[i + 1]

            dp[i] = max(pointsIfSolved, pointsIfSkipped)
        }

        return dp[0]
    }
}