class Solution {
    func maxPoints(_ grid: [[Int]], _ queries: [Int]) -> [Int] {
        let m = grid.count
        let n = grid[0].count
        var sortedCells: [(value: Int, row: Int, col: Int)] = []
        for r in 0..<m {
            for c in 0..<n {
                sortedCells.append((grid[r][c], r, c))
            }
        }
        sortedCells.sort(by: {$0.value < $1.value})
        
        let k = queries.count
        var sortedQueries: [(value: Int, originalIndex: Int)] = []
        for i in 0..<k {
            sortedQueries.append((queries[i], i))
        }
        sortedQueries.sort(by: {$0.value < $1.value})
        
        var answer = [Int](repeating: 0, count: k)
        var parent = [Int](repeating: 0, count: m * n)
        var size = [Int](repeating: 1, count: m * n)
        var active = [[Bool]](repeating: [Bool](repeating: false, count: n), count: m)
        for i in 0..<m * n {
            parent[i] = i
        }
        
        func findSet(_ i: Int) -> Int {
            if parent[i] == i {
                return i
            }
            parent[i] = findSet(parent[i])
            return parent[i]
        }
        
        func uniteSets(_ i: Int, _ j: Int) {
            let rootI = findSet(i)
            let rootJ = findSet(j)
            if rootI != rootJ {
                if size[rootI] < size[rootJ] {
                    parent[rootI] = rootJ
                    size[rootJ] += size[rootI]
                } else {
                    parent[rootJ] = rootI
                    size[rootI] += size[rootJ]
                }
            }
        }
        
        var cellsIndex = 0
        for (q, originalIndex) in sortedQueries {
            while cellsIndex < m * n && sortedCells[cellsIndex].value < q {
                let cell = sortedCells[cellsIndex]
                let r = cell.row
                let c = cell.col
                if !active[r][c] {
                    active[r][c] = true
                    let u = r * n + c
                    let neighbors = [(r - 1, c), (r + 1, c), (r, c - 1), (r, c + 1)]
                    for (nr, nc) in neighbors {
                        if nr >= 0 && nr < m && nc >= 0 && nc < n && active[nr][nc] {
                            let v = nr * n + nc
                            uniteSets(u, v)
                        }
                    }
                }
                cellsIndex += 1
            }
            if active[0][0] {
                answer[originalIndex] = size[findSet(0)]
            } else {
                answer[originalIndex] = 0
            }
        }
        
        return answer
    }
}