class Solution {
    func minSum(_ nums1: [Int], _ nums2: [Int]) -> Int {
        var sum1 = 0, zeros1 = 0
        for num in nums1 {
            if num == 0 {
                zeros1 += 1
            } else {
                sum1 += num
            }
        }
        
        var sum2 = 0, zeros2 = 0
        for num in nums2 {
            if num == 0 {
                zeros2 += 1
            } else {
                sum2 += num
            }
        }
        
        if zeros1 == 0 && zeros2 == 0 {
            return sum1 == sum2 ? sum1 : -1
        } else if zeros1 == 0 {
            return sum1 >= sum2 + zeros2 ? sum1 : -1
        } else if zeros2 == 0 {
            return sum2 >= sum1 + zeros1 ? sum2 : -1
        } else {
            return max(sum1 + zeros1, sum2 + zeros2)
        }
    }
}