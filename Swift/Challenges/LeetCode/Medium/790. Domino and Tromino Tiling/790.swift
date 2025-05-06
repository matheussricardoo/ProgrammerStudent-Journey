import Foundation

class Solution {
    func numTilings(_ n: Int) -> Int {
        if n == 1 {
            return 1
        }
        if n == 2 {
            return 2
        }

        let MOD = 1_000_000_007

        var dp_i_3 = 1 
        var dp_i_2 = 1 
        var dp_i_1 = 2 

        for _ in 3...n {
            let term1 = (2 * dp_i_1) % MOD
            let dp_i = (term1 + dp_i_3) % MOD 

            dp_i_3 = dp_i_2
            dp_i_2 = dp_i_1
            dp_i_1 = dp_i
        }

        return dp_i_1
    }
}