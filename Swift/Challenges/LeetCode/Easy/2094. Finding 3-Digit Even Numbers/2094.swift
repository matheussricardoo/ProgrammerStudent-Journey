class Solution {
    func findEvenNumbers(_ digits: [Int]) -> [Int] {
        var counts = [Int](repeating: 0, count: 10)
        for digit in digits {
            counts[digit] += 1
        }
        
        var result = Set<Int>()
        
        for num in stride(from: 100, through: 999, by: 2) {
            let hundreds = num / 100
            let tens = (num / 10) % 10
            let units = num % 10
            
            // Check if the hundreds digit can be used (non-zero)
            guard counts[hundreds] > 0 else { continue }
            
            // Check if the tens digit can be used
            guard counts[tens] > 0 else { continue }
            
            // Check if the units digit can be used
            guard counts[units] > 0 else { continue }
            
            // To handle duplicates, temporarily decrement counts and check
            // Check if we have enough digits considering duplicates
            var tempCounts = counts
            tempCounts[hundreds] -= 1
            tempCounts[tens] -= 1
            tempCounts[units] -= 1
            
            if tempCounts[hundreds] >= 0 && tempCounts[tens] >= 0 && tempCounts[units] >= 0 {
                result.insert(num)
            }
        }
        
        return Array(result).sorted()
    }
}