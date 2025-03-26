class Solution:
    def minOperations(self, grid: List[List[int]], x: int) -> int:
        flat_grid = [cell for row in grid for cell in row]

        mod = flat_grid[0] % x
        for num in flat_grid:
            if num % x != mod:
                return -1

        flat_grid.sort()
        median = flat_grid[len(flat_grid) // 2]

        operations = 0
        for num in flat_grid:
            operations += abs(num - median) // x

        return operations
