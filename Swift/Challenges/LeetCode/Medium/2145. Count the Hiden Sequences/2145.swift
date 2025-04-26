class Solution {
    func numberOfArrays(_ differences: [Int], _ lower: Int, _ upper: Int) -> Int {
        var currentSum: Int = 0
        var minRelative: Int = 0
        var maxRelative: Int = 0

        for diff in differences {
            currentSum += diff
            minRelative = min(minRelative, currentSum)
            maxRelative = max(maxRelative, currentSum)
        }

        let minH0 = lower - minRelative
        let maxH0 = upper - maxRelative

        if minH0 > maxH0 {
            return 0
        } else {
            let count = maxH0 - minH0 + 1
            return count
        }
        
    }
}