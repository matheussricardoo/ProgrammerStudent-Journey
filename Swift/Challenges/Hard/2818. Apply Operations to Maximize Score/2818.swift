import Foundation

class Solution {
    func getPrimeScore(_ x: Int) -> Int {
        if x == 1 {
            return 0
        }
        var score = 0
        var num = x
        var d = 2
        while d * d <= num {
            if num % d == 0 {
                score += 1
                while num % d == 0 {
                    num /= d
                }
            }
            d += 1
        }
        if num > 1 {
            score += 1
        }
        return score
    }

    func maximumScore(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var primeScores = [Int](repeating: 0, count: n)
        for i in 0..<n {
            primeScores[i] = getPrimeScore(nums[i])
        }

        var lPrimeIndex = [Int](repeating: -1, count: n)
        var stack = [Int]()
        for i in 0..<n {
            while !stack.isEmpty && primeScores[stack.last!] < primeScores[i] {
                stack.removeLast()
            }
            if !stack.isEmpty {
                lPrimeIndex[i] = stack.last!
            }
            stack.append(i)
        }

        var rPrimeIndex = [Int](repeating: n, count: n)
        stack.removeAll()
        for i in (0..<n).reversed() {
            while !stack.isEmpty && primeScores[stack.last!] <= primeScores[i] {
                stack.removeLast()
            }
            if !stack.isEmpty {
                rPrimeIndex[i] = stack.last!
            }
            stack.append(i)
        }

        var offers: [(value: Int, count: Int)] = []
        for i in 0..<n {
            let L = lPrimeIndex[i] == -1 ? 0 : lPrimeIndex[i] + 1
            let R = rPrimeIndex[i] == n ? n - 1 : rPrimeIndex[i] - 1
            let count = (i - L + 1) * (R - i + 1)
            if count > 0 {
                offers.append((value: nums[i], count: count))
            }
        }

        offers.sort(by: { $0.value > $1.value })

        var score: Int = 1
        var kRemaining = k
        let modulo = 1000000007

        for offer in offers {
            if kRemaining == 0 {
                break
            }
            let uses = min(offer.count, kRemaining)
            score = (score * power(offer.value, uses, modulo)) % modulo
            kRemaining -= uses
        }

        return score
    }

    private func power(_ base: Int, _ exp: Int, _ modulus: Int) -> Int {
        var res = 1
        var a = base % modulus
        var b = exp
        while b > 0 {
            if b % 2 == 1 {
                res = (res * a) % modulus
            }
            a = (a * a) % modulus
            b /= 2
        }
        return res
    }
}