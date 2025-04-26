import Foundation

class Solution {
    func maximumTripletValue(_ nums: [Int]) -> Int {
        var maxTripletValue: Int = 0
        var maxI: Int = 0
        var maxDiffIJ: Int = 0

        for num in nums {
            let currentPotentialTripletValue = maxDiffIJ * num
            maxTripletValue = max(maxTripletValue, currentPotentialTripletValue)
            let currentPotentialDiff = maxI - num
            maxDiffIJ = max(maxDiffIJ, currentPotentialDiff)
            maxI = max(maxI, num)
        }
        return maxTripletValue
    }
}