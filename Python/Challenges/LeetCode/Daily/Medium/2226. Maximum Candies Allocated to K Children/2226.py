class Solution:
    def maximumCandies(self, candies: List[int], k: int) -> int:
        total = sum(candies)
        if total < k:
            return 0
        left = 1
        right = total // k
        ans = 0
        while left <= right:
            mid = (left + right) // 2
            s = sum(c // mid for c in candies)
            if s >= k:
                ans = mid
                left = mid + 1
            else:
                right = mid - 1
        return ans
