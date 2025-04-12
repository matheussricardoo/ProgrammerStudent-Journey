import Foundation

class Solution {
    let factorial: [Int] = {
        var fact = [1] 
        for i in 1...10 {
             guard fact.last! <= Int.max / i else {
                 return [] 
             }
            fact.append(fact.last! * i)
        }
        return fact
    }()

    private func calculatePerms(numDigits: Int, counts: [Int]) -> Int {
        guard numDigits >= 0 && numDigits < factorial.count else { return 0 }
        guard counts.count == 10 else { return 0 }

        let numerator = factorial[numDigits]
        var denominator = 1

        for i in 0...9 {
            let count = counts[i]
            guard count >= 0 && count < factorial.count else { return 0 } 
            
            let fact_ci = factorial[count]
            guard fact_ci > 0 else { return 0 } 
            
            guard denominator <= Int.max / fact_ci else { return 0 }
            denominator *= fact_ci
        }
        
        guard denominator > 0 else { return 0 } 
        
        return numerator / denominator
    }


    func countGoodIntegers(_ n: Int, _ k: Int) -> Int {
        guard n >= 1 && n <= 10 else { return 0 }
        guard !factorial.isEmpty else { return 0 } 

        var uniqueMultisets = Set<[Int]>()
        
        let m = (n + 1) / 2
        
        var startHalf = 1
        if m > 1 {
            for _ in 1..<m { 
                 guard startHalf <= Int.max / 10 else { return 0 } 
                 startHalf *= 10 
            }
        }
        
        var endHalf = 1
        for _ in 1...m { 
            guard endHalf <= Int.max / 10 else { return 0 } 
            endHalf *= 10 
        }
        guard endHalf >= 1 else { return 0 } 
        endHalf -= 1
        
        guard startHalf <= endHalf else { return 0 }

        for half in startHalf...endHalf {
            let halfStr = String(half)
            let xStr: String 
            
            if n % 2 == 1 { 
                if m == 1 { 
                     xStr = halfStr 
                } else {
                     let prefix = halfStr.prefix(m - 1)
                     xStr = halfStr + String(prefix.reversed())
                }
            } else { 
                xStr = halfStr + String(halfStr.reversed())
            }

            guard let x = Int(xStr) else { continue } 

            if x % k == 0 {
                var counts = Array(repeating: 0, count: 10)
                var validCounts = true
                for char in xStr {
                    guard let digit = char.wholeNumberValue else {
                        validCounts = false; break 
                    }
                    guard digit >= 0 && digit <= 9 else {
                         validCounts = false; break 
                    }
                    counts[digit] += 1
                }
                
                if validCounts { 
                    uniqueMultisets.insert(counts)
                }
            }
        }

        var totalGoodCount = 0
        for counts in uniqueMultisets {
            let totalPerms = calculatePerms(numDigits: n, counts: counts)

            var zeroPerms = 0
            if counts[0] > 0 { 
                var countsZero = counts 
                countsZero[0] -= 1      
                zeroPerms = calculatePerms(numDigits: n - 1, counts: countsZero)
            }
            
            let validPerms = totalPerms - zeroPerms
            
            guard totalGoodCount <= Int.max - validPerms else { 
                return Int.max 
            }
            totalGoodCount += validPerms
        }

        return totalGoodCount
    }
}