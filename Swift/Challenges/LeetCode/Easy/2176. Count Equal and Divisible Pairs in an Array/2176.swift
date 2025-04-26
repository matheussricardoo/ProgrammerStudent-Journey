import Foundation 

class Solution {
    func countPairs(_ nums: [Int], _ k: Int) -> Int {
        var count = 0
        let n = nums.count

        for i in 0..<n {
            for j in (i + 1)..<n {
                if nums[i] == nums[j] && (i * j) % k == 0 {
                    count += 1
                }
            }
        }

        return count
    }
}