class Solution {
    func getLongestSubsequence(_ words: [String], _ groups: [Int]) -> [String] {
        var result = [words[0]]
        var prevGroup = groups[0]
        
        for i in 1..<groups.count {
            if groups[i] != prevGroup {
                result.append(words[i])
                prevGroup = groups[i]
            }
        }
        
        return result
    }
}