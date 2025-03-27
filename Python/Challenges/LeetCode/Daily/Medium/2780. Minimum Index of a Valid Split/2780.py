class Solution:
    def minimumIndex(self, nums: List[int]) -> int:
        count = 0
        candidate = None
        for num in nums:
            if count == 0:
                candidate = num
                count = 1
            else:
                count += 1 if num == candidate else -1
        
        total_dom = 0
        for num in nums:
            if num == candidate:
                total_dom += 1
        
        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + (1 if nums[i] == candidate else 0)
        
        for i in range(n - 1):
            left_len = i + 1
            left_count = prefix[i + 1]
            if left_count * 2 <= left_len:
                continue  
            
            right_len = n - left_len
            right_count = total_dom - left_count
            if right_count * 2 > right_len:
                return i  
        
        return -1  
            