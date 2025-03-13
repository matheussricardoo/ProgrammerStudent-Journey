class Solution:
    def minZeroArray(self, nums: List[int], queries: List[List[int]]) -> int:
        n = len(nums)
        q = len(queries)
        low, high = 0, q
        answer = -1

        queries_list = [(l, r, val) for l, r, val in queries]

        diff = [0] * (n + 1)

        while low <= high:
            mid = (low + high) // 2

            for i in range(n + 1):
                diff[i] = 0

            for j in range(mid):
                l, r, val = queries_list[j]
                diff[l] += val
                if r + 1 < n:
                    diff[r + 1] -= val

            current_sum = 0
            valid = True
            for i in range(n):
                current_sum += diff[i]
                if current_sum < nums[i]:
                    valid = False
                    break

            if valid:
                answer = mid
                high = mid - 1
            else:
                low = mid + 1

        return answer if answer != -1 else -1
