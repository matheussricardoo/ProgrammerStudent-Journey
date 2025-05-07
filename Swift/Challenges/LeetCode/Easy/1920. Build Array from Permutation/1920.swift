import Foundation 

class Solution {
    // O(N) Space solution
    func buildArray(_ nums: [Int]) -> [Int] {
        let n = nums.count
        let ans = nums.indices.map { i in
            nums[nums[i]]
        }
        return ans
    }

    // O(1) Extra Space solution (modifies input conceptually, uses temp copy in Swift)
    func buildArray_O1_Space(_ nums: [Int]) -> [Int] {
        let n = nums.count
        guard n > 0 else { return [] }
        var tempNums = nums 

        // Pass 1: Encode
        for i in 0..<n {
            let b = tempNums[tempNums[i]] % n 
            tempNums[i] += b * n 
        }

        // Pass 2: Decode
        for i in 0..<n {
            tempNums[i] /= n
        }

        return tempNums
    }
}