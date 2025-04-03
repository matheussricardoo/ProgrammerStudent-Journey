import Foundation 

class Solution {
    func maximumTripletValue(_ nums: [Int]) -> Int {
        var maxTripletValue: Int = 0
        var maxIValue: Int = 0 
        var maxDiff: Int = 0 
        
        for num in nums {
            let currentTripletValue = maxDiff * num
            maxTripletValue = max(maxTripletValue, currentTripletValue)
            let potentialNewDiff = maxIValue - num
            maxDiff = max(maxDiff, potentialNewDiff)
            
            maxIValue = max(maxIValue, num)
        }
        return maxTripletValue
    }
}