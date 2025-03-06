class Solution:
    def findMissingAndRepeatedValues(self, grid: List[List[int]]) -> List[int]:
        n = len(grid)
        total_numbers = n * n
        expected_sum = total_numbers * (total_numbers + 1) // 2
        actual_sum = 0
        seen = set()
        a = 0

        for row in grid:
            for num in row:
                actual_sum += num
                if num in seen:
                    a = num
                seen.add(num)

        b = expected_sum - (actual_sum - a)

        return [a, b]
