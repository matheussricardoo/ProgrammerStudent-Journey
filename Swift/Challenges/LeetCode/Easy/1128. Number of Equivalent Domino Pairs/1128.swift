import Foundation

class Solution {
    func numEquivDominoPairs(_ dominoes: [[Int]]) -> Int {
        var pairCount = 0
        var counts: [Int: Int] = [:]

        for domino in dominoes {
            guard domino.count == 2 else { continue } 
            let a = domino[0]
            let b = domino[1]

            let key = min(a, b) * 10 + max(a, b)

            pairCount += counts[key, default: 0]

            counts[key, default: 0] += 1
        }

        return pairCount
    }
}