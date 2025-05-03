import Foundation

class Solution {
    func minDominoRotations(_ tops: [Int], _ bottoms: [Int]) -> Int {
        let n = tops.count
        
        func check(_ target: Int) -> Int {
            var rotationsTop = 0    
            var rotationsBottom = 0 

            for i in 0..<n {
                if tops[i] != target && bottoms[i] != target {
                    return Int.max 
                }
                else if tops[i] != target {
                    rotationsTop += 1
                }
                else if bottoms[i] != target {
                    rotationsBottom += 1
                }
            }
            
            return min(rotationsTop, rotationsBottom)
        }

        let rotations1 = check(tops[0])
        let rotations2 = check(bottoms[0])

        let result = min(rotations1, rotations2)

        return (result == Int.max) ? -1 : result
    }
}