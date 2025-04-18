import Foundation

class Solution {
    func countAndSay(_ n: Int) -> String {
        if n == 1 {
            return "1"
        }

        var currentSay = "1"

        for _ in 2...n {
            var nextSay = "" 
            let currentChars = Array(currentSay) 
            var i = 0
            let len = currentChars.count

            while i < len {
                let currentChar = currentChars[i]
                var count = 1
                var j = i + 1 

                while j < len && currentChars[j] == currentChar {
                    count += 1
                    j += 1
                }

                nextSay.append(String(count))
                nextSay.append(currentChar)

                i = j
            }
            currentSay = nextSay
        }

        return currentSay
    }
}