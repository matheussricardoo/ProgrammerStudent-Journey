import Foundation

class Solution {
    func partitionLabels(_ s: String) -> [Int] {
        if s.isEmpty {
            return []
        }

        var lastOccurrence: [Character: Int] = [:]
        let sChars = Array(s)

        for (index, char) in sChars.enumerated() {
            lastOccurrence[char] = index
        }

        var result: [Int] = []
        var start = 0
        var end = 0

        for (i, char) in sChars.enumerated() {
             if let charLastOccurrence = lastOccurrence[char] {
                 end = max(end, charLastOccurrence)
             }

            if i == end {
                let partitionLength = i - start + 1
                result.append(partitionLength)
                start = i + 1
            }
        }

        return result
    }
}