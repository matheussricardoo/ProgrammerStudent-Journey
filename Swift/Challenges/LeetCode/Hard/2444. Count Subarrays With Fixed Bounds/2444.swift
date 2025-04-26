class Solution {
    func countSubarrays(_ nums: [Int], _ minK: Int, _ maxK: Int) -> Int {
        var count: Int = 0 
        var minKIdx = -1
        var maxKIdx = -1
        var badIdx = -1
        let n = nums.count

        for i in 0..<n {
            let currentNum = nums[i]

            if currentNum < minK || currentNum > maxK {
                badIdx = i 
            }

            if currentNum == minK {
                minKIdx = i
            }
            if currentNum == maxK {
                maxKIdx = i
            }

            let potentialStartBound = min(minKIdx, maxKIdx)
            let validStartsCount = max(0, potentialStartBound - badIdx)
            
            count += validStartsCount
        }

        return count
    }
}