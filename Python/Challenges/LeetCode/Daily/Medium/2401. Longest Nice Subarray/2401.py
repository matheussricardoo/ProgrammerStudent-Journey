def longestNiceSubarray(self, nums: List[int]) -> int:
    max_length = 1
    used_bits = 0
    left = 0

    for right in range(len(nums)):
        while left < right and (used_bits & nums[right]) != 0:
            used_bits ^= nums[left]
            left += 1

        used_bits |= nums[right]

        max_length = max(max_length, right - left + 1)

    return max_length
