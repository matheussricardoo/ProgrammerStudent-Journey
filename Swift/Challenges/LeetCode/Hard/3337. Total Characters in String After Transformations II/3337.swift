class Solution {
    func lengthAfterTransformations(_ s: String, _ t: Int, _ nums: [Int]) -> Int {
        let MOD = 1000000007
        let n = 26
        
        // Build the transformation matrix M
        var M = Array(repeating: Array(repeating: 0, count: n), count: n)
        for i in 0..<n {
            let m = nums[i]
            let start = (i + 1) % 26
            for k in 0..<m {
                let j = (start + k) % 26
                M[i][j] = (M[i][j] + 1) % MOD
            }
        }
        
        // Function to multiply two matrices
        func multiply(_ a: [[Int]], _ b: [[Int]]) -> [[Int]] {
            var res = Array(repeating: Array(repeating: 0, count: n), count: n)
            for i in 0..<n {
                for k in 0..<n {
                    if a[i][k] == 0 { continue }
                    for j in 0..<n {
                        res[i][j] = (res[i][j] + a[i][k] * b[k][j]) % MOD
                    }
                }
            }
            return res
        }
        
        // Function to compute matrix power using exponentiation
        func matrixPower(_ matrix: [[Int]], _ power: Int) -> [[Int]] {
            var result = Array(repeating: Array(repeating: 0, count: n), count: n)
            for i in 0..<n {
                result[i][i] = 1
            }
            var current = matrix
            var remaining = power
            while remaining > 0 {
                if remaining % 2 == 1 {
                    result = multiply(result, current)
                }
                current = multiply(current, current)
                remaining /= 2
            }
            return result
        }
        
        // Compute M^t
        let powerMatrix = matrixPower(M, t)
        
        // Initialize the counts of each character in the input string
        var counts = Array(repeating: 0, count: n)
        for c in s {
            let idx = Int(c.asciiValue!) - Int(Character("a").asciiValue!)
            counts[idx] += 1
        }
        
        // Multiply the counts vector by the powerMatrix
        var finalCounts = Array(repeating: 0, count: n)
        for i in 0..<n {
            for j in 0..<n {
                finalCounts[j] = (finalCounts[j] + counts[i] * powerMatrix[i][j]) % MOD
            }
        }
        
        // Sum all counts to get the final length
        var totalLength = 0
        for count in finalCounts {
            totalLength = (totalLength + count) % MOD
        }
        
        return totalLength
    }
}