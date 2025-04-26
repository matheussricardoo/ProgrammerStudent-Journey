import Foundation

class Solution {
    func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
        let n = nums.count
        if n <= 1 {
            return nums
        }

        let sortedNums = nums.sorted()

        var dp = Array(repeating: 1, count: n)
        var prevIndex = Array(repeating: -1, count: n) 

        var maxSize = 1
        var maxIndex = 0

        for i in 0..<n {
            for j in 0..<i {
                if sortedNums[i] % sortedNums[j] == 0 {
                    if 1 + dp[j] > dp[i] {
                        dp[i] = 1 + dp[j]
                        prevIndex[i] = j 
                    }
                }
            }
            if dp[i] > maxSize {
                maxSize = dp[i]
                maxIndex = i
            }
        }

        var result: [Int] = []
        var currentIndex = maxIndex
        while currentIndex != -1 {
            result.append(sortedNums[currentIndex])
            currentIndex = prevIndex[currentIndex] 
        }

        return result.reversed()
    }
}