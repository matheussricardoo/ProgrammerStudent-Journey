class Solution {
    func getWordsInLongestSubsequence(_ words: [String], _ groups: [Int]) -> [String] {
        let n = words.count
        if n == 0 {
            return []
        }
        
        var dp = [Int](repeating: 1, count: n)
        var prev = [Int](repeating: -1, count: n)
        
        // Precompute transitions
        for i in 0..<n {
            for j in 0..<i {
                if groups[j] != groups[i] && isSameLengthAndHamming1(words[j], words[i]) {
                    if dp[j] + 1 > dp[i] {
                        dp[i] = dp[j] + 1
                        prev[i] = j
                    }
                }
            }
        }
        
        // Find the maximum dp value and its index
        var maxLen = 0
        var lastIndex = 0
        for i in 0..<n {
            if dp[i] > maxLen {
                maxLen = dp[i]
                lastIndex = i
            }
        }
        
        // Reconstruct the path
        var result = [String]()
        var index = lastIndex
        while index != -1 {
            result.append(words[index])
            index = prev[index]
        }
        result.reverse()
        return result
    }
    
    // Helper function to check if two words have same length and Hamming distance of 1
    private func isSameLengthAndHamming1(_ a: String, _ b: String) -> Bool {
        if a.count != b.count {
            return false
        }
        var diff = 0
        for (charA, charB) in zip(a, b) {
            if charA != charB {
                diff += 1
                if diff > 1 {
                    return false
                }
            }
        }
        return diff == 1
    }
}