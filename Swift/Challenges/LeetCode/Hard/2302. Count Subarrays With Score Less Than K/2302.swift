class Solution {
    func countSubarrays(_ nums: [Int], _ k: Int) -> Int {
        var count: Int = 0
        var currentSum: Int = 0
        var left = 0
        let n = nums.count
        let k_int = k 

        for right in 0..<n {
            currentSum += nums[right]

            while currentSum * (right - left + 1) >= k_int && left <= right {
                currentSum -= nums[left]
                left += 1
            }
            count += (right - left + 1)
        }

        return count
    }
}