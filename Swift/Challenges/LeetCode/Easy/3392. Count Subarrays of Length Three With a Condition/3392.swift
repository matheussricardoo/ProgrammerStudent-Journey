class Solution {
    func countSubarrays(_ nums: [Int]) -> Int {
        var count = 0
        let n = nums.count

        guard n >= 3 else { 
            return 0
        }

        for i in 0...(n - 3) {
            let first = nums[i]
            let middle = nums[i + 1]
            let third = nums[i + 2]

            if 2 * (first + third) == middle {
                count += 1
            }
        }

        return count
    }
}