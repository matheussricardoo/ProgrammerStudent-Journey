class Solution {
    func triangleType(_ nums: [Int]) -> String {
        let sorted = nums.sorted()
        let a = sorted[0]
        let b = sorted[1]
        let c = sorted[2]
        
        if a + b <= c {
            return "none"
        }
        
        if a == b && b == c {
            return "equilateral"
        } else if a == b || b == c {
            return "isosceles"
        } else {
            return "scalene"
        }
    }
}