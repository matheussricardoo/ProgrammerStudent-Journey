class Solution {
  struct HeapItem:Comparable {
    var x,y,t,p:Int
    var tuple:(Int,Int,Int,Int) {(x,y,t,p)}
    static func <(a:Self, b:Self)->Bool {a.t < b.t}
  }

  func minTimeToReach(_ moveTime: consuming [[Int]]) -> Int {
    let (n,m) = (moveTime.count, moveTime[0].count)
    var heap = Heap([HeapItem(x:0, y:0, t:0, p:1)])

    while let (x,y,t,p) = heap.popMin()?.tuple {
      for (dx, dy) in [1,0,-1,0,1].adjacentPairs() {
        let (x,y) = (x+dx, y+dy)
        guard 0..<n ~= y, 0..<m ~= x, moveTime[y][x] >= 0 else { continue }
        let t = max(t,moveTime[y][x])+1+(p^1)
        guard x < m-1 || y < n-1 else { return t }
        heap.insert(HeapItem(x:x, y:y, t:t, p:p^1))
        moveTime[y][x] = -1
      }
    }
    return 0
  }
}