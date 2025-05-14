class Solution {
    func lengthAfterTransformations(_ s: String, _ t: Int) -> Int {
        let MOD = 1000000007
        var currentCounts = [Int](repeating: 0, count: 26)
        
        // Initialize the count of each character
        for c in s {
            let idx = Int(c.asciiValue!) - Int(Character("a").asciiValue!)
            currentCounts[idx] += 1
        }
        
        var length = s.count
        
        for _ in 0..<t {
            let zCount = currentCounts[25]
            // Update the length with the current number of 'z's
            length = (length + zCount) % MOD
            
            // Calculate the next state's character counts
            var nextCounts = [Int](repeating: 0, count: 26)
            for i in 0..<26 {
                // Add contributions from the previous character (i-1)
                if i >= 1 {
                    nextCounts[i] += currentCounts[i - 1]
                    nextCounts[i] %= MOD
                }
                // Add contributions from 'z's (i == 0 or i == 1)
                if i == 0 || i == 1 {
                    nextCounts[i] += currentCounts[25]
                    nextCounts[i] %= MOD
                }
            }
            currentCounts = nextCounts
        }
        
        return length % MOD
    }
}