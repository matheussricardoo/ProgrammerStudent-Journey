class FenwickTree {
    private var tree: [Int]
    
    init(_ size: Int) {
        tree = Array(repeating: 0, count: size + 1) 
    }
    
    func update(_ index: Int, _ delta: Int) {
        var idx = index
        while idx < tree.count {
            tree[idx] += delta
            idx += idx & -idx
        }
    }
    
    func query(_ index: Int) -> Int {
        var idx = index
        var sum = 0
        while idx > 0 {
            sum += tree[idx]
            idx -= idx & -idx
        }
        return sum
    }
}

class Solution {
    func goodTriplets(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let n = nums1.count
        var pos2 = [Int](repeating: 0, count: n)
        for i in 0..<n {
            pos2[nums2[i]] = i
        }
        
        var A = [Int](repeating: 0, count: n)
        for i in 0..<n {
            A[i] = pos2[nums1[i]]
        }
        
        var left = [Int](repeating: 0, count: n)
        let ftLeft = FenwickTree(n)
        for j in 0..<n {
            let x = A[j]
            left[j] = ftLeft.query(x)
            ftLeft.update(x + 1, 1)
        }
        
        var right = [Int](repeating: 0, count: n)
        let ftRight = FenwickTree(n)
        for j in (0..<n).reversed() {
            let x = A[j]
            if x + 1 < n {
                right[j] = ftRight.query(n) - ftRight.query(x + 1)
            } else {
                right[j] = 0
            }
            ftRight.update(x + 1, 1)
        }
        
        var result = 0
        for j in 0..<n {
            result += left[j] * right[j]
        }
        return result
    }
}