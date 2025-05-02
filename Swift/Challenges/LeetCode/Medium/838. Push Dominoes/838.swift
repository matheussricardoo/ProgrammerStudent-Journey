class Solution {
    func pushDominoes(_ dominoes: String) -> String {
        var chars = Array("L" + dominoes + "R")
        var i = 0
        
        while i < chars.count {
            var j = i + 1
            while j < chars.count && chars[j] == "." {
                j += 1
            }
            
            if j < chars.count {
                let left = chars[i]
                let right = chars[j]
                
                if left == "R" && right == "L" {
                    var l = i + 1, r = j - 1
                    while l < r {
                        chars[l] = "R"
                        chars[r] = "L"
                        l += 1
                        r -= 1
                    }
                } else if left == "R" && right == "R" || left == "L" && right == "L" {
                    let fill = left
                    for k in (i + 1)..<j {
                        chars[k] = fill
                    }
                }
            }
            
            i = j
        }
        
        return String(chars[1..<chars.count-1])
    }
}