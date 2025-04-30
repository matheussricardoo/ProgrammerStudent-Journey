class Solution {
    func findNumbers(_ nums: [Int]) -> Int {
        var evenDigitCount = 0

        for num in nums {
            if (num >= 10 && num <= 99) ||         
               (num >= 1000 && num <= 9999) ||     
               num == 100000 {                    
                evenDigitCount += 1
            }
        }

        return evenDigitCount
    }
}