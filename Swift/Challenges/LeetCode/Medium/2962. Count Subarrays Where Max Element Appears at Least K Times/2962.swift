class Solution {
    func countSubarrays(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        guard n > 0 else { return 0 }

        guard let maxVal = nums.max() else { return 0 }

        var left = 0
        var countMaxInWindow = 0
        var totalGoodSubarrays: Int = 0

        for right in 0..<n {
            if nums[right] == maxVal {
                countMaxInWindow += 1
            }

            while countMaxInWindow >= k {
                if nums[left] == maxVal {
                    countMaxInWindow -= 1
                }
                left += 1
            }
            totalGoodSubarrays += left
        }

        return totalGoodSubarrays
    }
}