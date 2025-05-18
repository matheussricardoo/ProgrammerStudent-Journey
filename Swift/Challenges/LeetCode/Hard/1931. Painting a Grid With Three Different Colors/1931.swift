class Solution {
    func colorTheGrid(_ m: Int, _ n: Int) -> Int {
        let MOD = 1_000_000_007
        
        // Generate all valid column colorings
        var validColors = [[Int]]()
        func backtrack(_ path: [Int]) {
            if path.count == m {
                validColors.append(path)
                return
            }
            let last = path.last ?? -1
            for c in 0...2 {
                if last != c {
                    var newPath = path
                    newPath.append(c)
                    backtrack(newPath)
                }
            }
        }
        backtrack([])
        
        let k = validColors.count
        if k == 0 {
            return 0
        }
        
        // Build compatibility map
        var compatible = [Int: [Int]]()
        for i in 0..<k {
            compatible[i] = []
            for j in 0..<k {
                var allDifferent = true
                for idx in 0..<m {
                    if validColors[i][idx] == validColors[j][idx] {
                        allDifferent = false
                        break
                    }
                }
                if allDifferent {
                    compatible[i]?.append(j)
                }
            }
        }
        
        // DP initialization
        var dp = [Int](repeating: 1, count: k)
        
        // Iterate for remaining columns
        for _ in 1..<n {
            var newDp = [Int](repeating: 0, count: k)
            for i in 0..<k {
                for j in compatible[i] ?? [] { 
                    newDp[j] = (newDp[j] + dp[i]) % MOD
                }
            }
            dp = newDp
        }
        
        return dp.reduce(0, { ($0 + $1) % MOD })
    }
}