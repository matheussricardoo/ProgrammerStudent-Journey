import Foundation

class Solution {
    private func sumOfDigits(_ num: Int) -> Int {
        var sum = 0
        var currentNum = num
        while currentNum > 0 {
            sum += currentNum % 10
            currentNum /= 10
        }
        return sum
    }

    func countLargestGroup(_ n: Int) -> Int {
        var groupSizes: [Int: Int] = [:]

        for i in 1...n {
            let s = sumOfDigits(i)
            groupSizes[s, default: 0] += 1
        }

        var maxSize = 0
        for size in groupSizes.values {
            maxSize = max(maxSize, size)
        }
        
        if maxSize == 0 { 
            return 0
        }

        var largestGroupCount = 0
        for size in groupSizes.values {
            if size == maxSize {
                largestGroupCount += 1
            }
        }

        return largestGroupCount
    }
}