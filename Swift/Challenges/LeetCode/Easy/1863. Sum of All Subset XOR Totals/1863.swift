import Foundation

class Solution {
    func subsetXORSum(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 0 {
            return 0
        }

        var orTotal = 0
        for num in nums {
            orTotal |= num
        }

        let multiplier = 1 << (n - 1)
        
        return orTotal * multiplier
    }
}