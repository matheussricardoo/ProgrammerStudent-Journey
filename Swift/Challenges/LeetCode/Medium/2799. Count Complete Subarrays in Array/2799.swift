import Foundation

class Solution {
    func countCompleteSubarrays(_ nums: [Int]) -> Int {
        let n = nums.count
        let totalDistinct = Set(nums).count

        var count = 0
        var left = 0
        var windowFreq: [Int: Int] = [:] 

        for right in 0..<n {
            windowFreq[nums[right], default: 0] += 1

            while windowFreq.count == totalDistinct {
                count += (n - right)

                let leftNum = nums[left]
                windowFreq[leftNum]! -= 1 

                if windowFreq[leftNum] == 0 {
                    windowFreq.removeValue(forKey: leftNum)
                }

                left += 1
            }
        }

        return count
    }
}