import Foundation

class Solution {
    func minimumOperations(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 0 {
            return 0
        }

        // Corrected initializer: minimumCapacity instead of capacity
        var seen = Set<Int>(minimumCapacity: n) 
        var firstDuplicateIndex = -1 

        for i in stride(from: n - 1, through: 0, by: -1) {
            if seen.contains(nums[i]) {
                firstDuplicateIndex = i
                break 
            } else {
                seen.insert(nums[i])
            }
        }

        if firstDuplicateIndex == -1 {
            return 0
        }

        let removalLength = firstDuplicateIndex + 1
        // Using ceiling division: (numerator + denominator - 1) / denominator
        let operations = (removalLength + 2) / 3 

        return operations
    }
}