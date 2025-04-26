class Solution {
    func countInterestingSubarrays(_ nums: [Int], _ modulo: Int, _ k: Int) -> Int {
        var totalCount: Int = 0
        var freq: [Int: Int] = [:]
        freq[0] = 1
        var currentPrefixSumMod = 0

        for num in nums {
            let contribution = (num % modulo == k) ? 1 : 0
            currentPrefixSumMod = (currentPrefixSumMod + contribution) % modulo
            
            let targetRem = (currentPrefixSumMod - k + modulo) % modulo
            
            totalCount += freq[targetRem, default: 0]
            
            freq[currentPrefixSumMod, default: 0] += 1
        }

        return totalCount
    }
}