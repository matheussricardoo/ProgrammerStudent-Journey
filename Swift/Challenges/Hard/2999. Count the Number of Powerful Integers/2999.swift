import Foundation

fileprivate class DigitDPSolver {
    let K_str_digits: [Int] 
    let L_K: Int          
    let limit: Int        
    var memo: [[[Int?]]] 

    init(K: Int, limit: Int) {
        let K_str = String(K)
        self.K_str_digits = K_str.map { Int(String($0))! } 
        self.L_K = K_str_digits.count
        self.limit = limit
        self.memo = Array(repeating: Array(repeating: Array(repeating: nil, count: 2), count: 2), count: L_K)
    }

    func count() -> Int {
        return solve(idx: 0, is_less: false, is_leading: true)
    }

    private func solve(idx: Int, is_less: Bool, is_leading: Bool) -> Int {
        if idx == L_K { return 1 } 
      
        let isLessIdx = is_less ? 1 : 0
        let isLeadingIdx = is_leading ? 1 : 0
        if let cached = memo[idx][isLessIdx][isLeadingIdx] {
            return cached
        }

        var ans = 0 
        
        let current_limit_digit = K_str_digits[idx]
        let upper_bound = is_less ? limit : min(limit, current_limit_digit)
      
        for d in 0...upper_bound {
            let new_is_less = is_less || (d < current_limit_digit)
            
            if is_leading {
                if d == 0 {
                    ans += solve(idx: idx + 1, is_less: new_is_less, is_leading: true)
                } else { 
                    ans += solve(idx: idx + 1, is_less: new_is_less, is_leading: false)
                }
            } else { 
                ans += solve(idx: idx + 1, is_less: new_is_less, is_leading: false)
            }
        }
      
        memo[idx][isLessIdx][isLeadingIdx] = ans
        return ans
    }
}

class Solution {
    func numberOfPowerfulInt(_ start: Int, _ finish: Int, _ limit: Int, _ s: String) -> Int {
        guard let S = Int(s) else { 
            return 0 
        }
        let m = s.count 
        
        var P: Int = 1
        for _ in 0..<m {
             if P > Int.max / 10 { 
                 return 0 
             }
             P *= 10
        }

        let count_finish = calculateCount(N: finish, limit: limit, S: S, P: P)
        let count_start_minus_1 = calculateCount(N: start - 1, limit: limit, S: S, P: P)
      
        return count_finish - count_start_minus_1
    }

    private func calculateCount(N: Int, limit: Int, S: Int, P: Int) -> Int {
        if N < S { return 0 }
      
        var totalPowerfulCount = 0
      
        if S <= N {
            totalPowerfulCount = 1 
        }
      
        let diff = N - S 
        let N_prefix_limit = diff / P 
            
        if N_prefix_limit > 0 {
            let solver = DigitDPSolver(K: N_prefix_limit, limit: limit)
            let count_p_including_zero = solver.count() 
                
            let count_positive_p = count_p_including_zero - 1
                
            totalPowerfulCount += count_positive_p
        }

        return totalPowerfulCount
    }
}