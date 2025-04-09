import Foundation

class Solution {
    func minOperations(_ nums: [Int], _ k: Int) -> Int {
        var mask1: UInt64 = 0
        var mask2: UInt64 = 0
        var operationCount = 0

        for num in nums {
            if num < k {
                return -1
            }

            if num > k {
                if num <= 64 {
                    let bit: UInt64 = 1 << (num - 1)
                    if (mask1 & bit) == 0 {
                        mask1 |= bit 
                        operationCount += 1
                    }
                } else { // num range 65 to 100
                    let bit: UInt64 = 1 << (num - 65) // Maps 65 to bit 0, 100 to bit 35
                    if (mask2 & bit) == 0 {
                        mask2 |= bit 
                        operationCount += 1
                    }
                }
            }
        }

        return operationCount
    }
}