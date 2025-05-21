class Solution {
    func isZeroArray(_ nums: [Int], _ queries: [[Int]]) -> Bool {
        let n = nums.count
        var diff = [Int](repeating: 0, count: n + 2)
        
        for q in queries {
            let l = q[0]
            let r = q[1]
            diff[l] += 1
            if r + 1 < n {
                diff[r + 1] -= 1
            }
        }
        
        var currDec = 0
        for i in 0..<n {
            currDec += diff[i]
            if currDec < nums[i] {
                return false
            }
        }
        return true
    }
}