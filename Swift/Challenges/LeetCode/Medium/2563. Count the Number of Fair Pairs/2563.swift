class Solution {

    private func countPairsLessOrEqualToTarget(_ sortedNums: [Int], _ target: Int) -> Int {
        let n = sortedNums.count
        var count: Int = 0 
        var left = 0
        var right = n - 1

        while left < right {
            let sum = sortedNums[left] + sortedNums[right] 

            if sum <= target {
                count += (right - left)
                left += 1
            } else { 
                right -= 1
            }
        }
        return count
    }

    func countFairPairs(_ nums: [Int], _ lower: Int, _ upper: Int) -> Int {
        let n = nums.count
        if n < 2 {
            return 0
        }

        let sortedNums = nums.sorted()

        let countUpper = countPairsLessOrEqualToTarget(sortedNums, upper)
        let countLowerMinus1 = countPairsLessOrEqualToTarget(sortedNums, lower - 1)

        return countUpper - countLowerMinus1
    }
}