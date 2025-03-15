class Solution:
    def minCapability(self, nums: List[int], k: int) -> int:
        left = min(nums)
        right = max(nums)
        ans = right

        while left <= right:
            mid = (left + right) // 2
            prev_prev, prev = 0, 0
            for num in nums:
                if num <= mid:
                    current = max(prev, prev_prev + 1)
                else:
                    current = prev
                prev_prev, prev = prev, current
            if prev >= k:
                ans = mid
                right = mid - 1
            else:
                left = mid + 1
        return ans
