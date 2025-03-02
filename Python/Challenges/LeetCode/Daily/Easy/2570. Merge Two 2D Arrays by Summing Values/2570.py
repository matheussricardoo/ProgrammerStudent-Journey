class Solution:
    def mergeArrays(
        self, nums1: List[List[int]], nums2: List[List[int]]
    ) -> List[List[int]]:

        id_sum = {}

        for id_val, value in nums1:
            id_sum[id_val] = value

        for id_val, value in nums2:
            if id_val in id_sum:
                id_sum[id_val] += value
            else:
                id_sum[id_val] = value

        result = [[id_val, value] for id_val, value in id_sum.items()]
        result.sort()

        return result
