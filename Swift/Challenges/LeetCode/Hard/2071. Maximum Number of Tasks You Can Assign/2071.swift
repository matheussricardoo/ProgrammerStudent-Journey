class Solution {
    func maxTaskAssign(_ tasks: [Int], _ workers: [Int], _ pills: Int, _ strength: Int) -> Int {
        let sortedTasks = tasks.sorted()
        let sortedWorkers = workers.sorted()
        var left = 0, right = min(tasks.count, workers.count)

        while left < right {
            let mid = (left + right + 1) / 2
            var usedPills = 0
            var available = Array(sortedWorkers.suffix(mid))
            var canAssign = true

            for task in sortedTasks.prefix(mid).reversed() {
                if let last = available.last, last >= task {
                    available.removeLast()
                } else {
                    if let idx = binarySearchGE(available, task - strength) {
                        if usedPills == pills {
                            canAssign = false
                            break
                        }
                        usedPills += 1
                        available.remove(at: idx)
                    } else {
                        canAssign = false
                        break
                    }
                }
            }

            if canAssign {
                left = mid
            } else {
                right = mid - 1
            }
        }

        return left
    }

    private func binarySearchGE(_ arr: [Int], _ target: Int) -> Int? {
        var low = 0, high = arr.count - 1
        var result: Int? = nil

        while low <= high {
            let mid = (low + high) / 2
            if arr[mid] >= target {
                result = mid
                high = mid - 1
            } else {
                low = mid + 1
            }
        }

        return result
    }
}