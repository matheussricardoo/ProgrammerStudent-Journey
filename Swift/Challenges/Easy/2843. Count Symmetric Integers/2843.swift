import Foundation

class Solution {
    func countSymmetricIntegers(_ low: Int, _ high: Int) -> Int {
        var count = 0
        for num in low...high {
            if num < 10 || (num > 99 && num < 1000) {
                continue
            }

            if num < 100 { 
                if (num / 10) == (num % 10) { 
                    count += 1
                }
                continue 
            }

            if num < 10000 {
                 let d1 = num / 1000       
                 let d2 = (num / 100) % 10 
                 let d3 = (num / 10) % 10  
                 let d4 = num % 10         
                 if (d1 + d2) == (d3 + d4) { 
                     count += 1
                 }
                 continue 
            }
        }
        return count
    }
}