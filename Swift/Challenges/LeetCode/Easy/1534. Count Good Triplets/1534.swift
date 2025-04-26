class Solution {
    func countGoodTriplets(_ arr: [Int], _ a: Int, _ b: Int, _ c: Int) -> Int {
        var count = 0
        let n = arr.count

        for i in 0..<(n - 2) { 
            let val_i = arr[i] 
            for j in (i + 1)..<(n - 1) { 
                let val_j = arr[j]
                if abs(val_i - val_j) <= a {
                    for k in (j + 1)..<n { 
                        let val_k = arr[k]
                        if abs(val_j - val_k) <= b && abs(val_i - val_k) <= c {
                            count += 1
                        }
                    }
                }
            }
        }

        return count
    }
}