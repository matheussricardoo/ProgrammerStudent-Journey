import Foundation

class Solution {
    func numRabbits(_ answers: [Int]) -> Int {
        var counts: [Int: Int] = [:]
        for answer in answers {
            counts[answer, default: 0] += 1
        }

        var totalRabbits = 0
        
        for (answer, count) in counts {
            let groupSize = answer + 1 
            let numGroups = (count + groupSize - 1) / groupSize
            let rabbitsForThisAnswer = numGroups * groupSize
            totalRabbits += rabbitsForThisAnswer
        }

        return totalRabbits
    }
}