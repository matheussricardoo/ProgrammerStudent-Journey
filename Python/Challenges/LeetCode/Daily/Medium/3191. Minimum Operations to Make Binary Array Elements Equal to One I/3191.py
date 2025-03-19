class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        flips = deque()
        result = 0

        for i in range(n):

            while flips and flips[0] + 2 < i:
                flips.popleft()

            current_bit = nums[i] ^ (len(flips) % 2)

            if current_bit == 0:

                if i + 2 >= n:
                    return -1

                flips.append(i)
                result += 1

        return result
