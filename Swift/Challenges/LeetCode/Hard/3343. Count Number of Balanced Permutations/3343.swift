class Solution {
    func countBalancedPermutations(_ num: String) -> Int {
        let MOD = 1_000_000_007
        let max_n = 80
        var fact = [Int](repeating: 1, count: max_n + 1)
        for i in 1...max_n {
            fact[i] = fact[i - 1] * i % MOD
        }
        var inv_fact = [Int](repeating: 1, count: max_n + 1)
        inv_fact[max_n] = powMod(fact[max_n], MOD - 2, MOD)
        for i in (1...max_n).reversed() {
            inv_fact[i - 1] = inv_fact[i] * i % MOD
        }
        
        let n = num.count
        var cnt = [Int](repeating: 0, count: 10)
        var total_sum = 0
        for c in num {
            let d = Int(c.asciiValue! - 48)
            cnt[d] += 1
            total_sum += d
        }
        
        if total_sum % 2 != 0 {
            return 0
        }
        let s = total_sum / 2
        let k = (n + 1) / 2
        let m = n - k
        
        let max_digit = 10
        let max_sum = s
        let max_count = k
        
        var dp = Array(repeating: Array(repeating: Array(repeating: 0, count: max_count + 1), count: max_sum + 1), count: max_digit + 1)
        dp[0][0][0] = 1
        
        for d in 0..<10 {
            let current_cnt = cnt[d]
            for t in 0...max_sum {
                for u in 0...max_count {
                    let current_ways = dp[d][t][u]
                    if current_ways == 0 {
                        continue
                    }
                    let max_x = min(current_cnt, max_count - u)
                    for x in 0...max_x {
                        let added_sum = d * x
                        let new_t = t + added_sum
                        if new_t > max_sum {
                            continue
                        }
                        let new_u = u + x
                        if new_u > max_count {
                            continue
                        }
                        let comb_val = comb(n: current_cnt, k: x, fact: fact, inv_fact: inv_fact, MOD)
                        let new_ways = current_ways * comb_val % MOD
                        dp[d + 1][new_t][new_u] = (dp[d + 1][new_t][new_u] + new_ways) % MOD
                    }
                }
            }
        }
        
        let sum_subset = dp[10][s][k]
        if sum_subset == 0 {
            return 0
        }
        
        let fact_k = fact[k]
        let fact_m = fact[m]
        let numerator = (fact_k * fact_m % MOD) * sum_subset % MOD
        
        var denominator = 1
        for d in 0..<10 {
            denominator = denominator * fact[cnt[d]] % MOD
        }
        
        let inv_denominator = powMod(denominator, MOD - 2, MOD)
        let ans = (numerator * inv_denominator) % MOD
        return ans
    }
}

func powMod(_ a: Int, _ b: Int, _ mod: Int) -> Int {
    if mod == 1 {
        return 0
    }
    var result = 1
    var a = a % mod
    var b = b
    while b > 0 {
        if b % 2 == 1 {
            result = (result * a) % mod
        }
        a = (a * a) % mod
        b = b / 2
    }
    return result
}

func comb(n: Int, k: Int, fact: [Int], inv_fact: [Int], _ MOD: Int) -> Int {
    if k < 0 || k > n {
        return 0
    }
    return fact[n] * inv_fact[k] % MOD * inv_fact[n - k] % MOD
}