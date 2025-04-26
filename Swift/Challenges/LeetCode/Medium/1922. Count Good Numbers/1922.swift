import Foundation

class Solution {
    let MOD = 1_000_000_007

    private func power(_ base: Int, _ exp: Int, _ mod: Int) -> Int {
        if exp == 0 {
            return 1 % mod
        }
        if base == 0 {
            return 0
        }

        var result: Int = 1
        var b: Int = base % mod
        var e: Int = exp 

        while e > 0 {
            if e % 2 == 1 {
                result = (result * b) % mod
            }
            b = (b * b) % mod
            e /= 2
        }
        
        return result
    }

    func countGoodNumbers(_ n: Int) -> Int {
        let choicesEven = 5
        let choicesOdd = 4

        let evenCount = (n + 1) / 2
        let oddCount = n / 2

        let pow5 = power(choicesEven, evenCount, MOD)
        let pow4 = power(choicesOdd, oddCount, MOD)

        let result = (pow5 * pow4) % MOD

        return result
    }
}