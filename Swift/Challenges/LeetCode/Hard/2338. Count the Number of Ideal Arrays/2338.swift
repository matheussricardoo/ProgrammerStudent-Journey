import Foundation

let MOD = Int(1e9 + 7)
let MAX_N = 10010  
let MAX_P = 15     

var sieve = [Int](repeating: 0, count: MAX_N)

for i in 2..<MAX_N {
    if sieve[i] == 0 {
        for j in stride(from: i, to: MAX_N, by: i) {
            sieve[j] = i
        }
    }
}

var ps = [[Int]](repeating: [], count: MAX_N)
for i in 2..<MAX_N {
    var x = i
    while x > 1 {
        let p = sieve[x]
        var count = 0
        while x % p == 0 {
            x /= p
            count += 1
        }
        ps[i].append(count)
    }
}

var c = [[Int]](
    repeating: [Int](repeating: 0, count: MAX_P + 1),
    count: MAX_N + MAX_P
)

c[0][0] = 1
for i in 1..<MAX_N + MAX_P {
    c[i][0] = 1
    for j in 1...min(i, MAX_P) {
        c[i][j] = (c[i - 1][j] + c[i - 1][j - 1]) % MOD
    }
}

class Solution {
    func idealArrays(_ n: Int, _ maxValue: Int) -> Int {
        var ans = 0
        for x in 1...maxValue {
            var mul = 1
            for p in ps[x] {
                mul = mul * c[n + p - 1][p] % MOD
            }
            ans = (ans + mul) % MOD
        }
        return ans
    }
}