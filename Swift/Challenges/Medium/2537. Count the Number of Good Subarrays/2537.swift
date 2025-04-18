import Foundation

class Solution {
    func countGood(_ nums: [Int], _ k: Int) -> Int {
        var left = 0
        var currentPairs: Int = 0
        var totalGoodCount: Int = 0
        var counts: [Int: Int] = [:]
        let n = nums.count

        for right in 0..<n {
            let numRight = nums[right]
            let oldCount = counts[numRight, default: 0]
            currentPairs += oldCount
            counts[numRight, default: 0] += 1

            while currentPairs >= k {
                let numLeft = nums[left]
                let countLeft = counts[numLeft]! 

                currentPairs -= (countLeft - 1)

                counts[numLeft]! -= 1
                if counts[numLeft]! == 0 {
                    counts[numLeft] = nil
                }
                left += 1
            }
            totalGoodCount += left
        }

        return totalGoodCount
    }
}