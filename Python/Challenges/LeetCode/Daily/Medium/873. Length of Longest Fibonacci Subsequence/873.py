from typing import List


class Solution:
    def lenLongestFibSubseq(self, arr: List[int]) -> int:
        n = len(arr)

        s = set(arr)

        index = {arr[i]: i for i in range(n)}

        max_length = 0

        for i in range(n):
            for j in range(i + 1, n):

                a, b = arr[i], arr[j]

                while a + b in s:

                    a, b = b, a + b
                    length += 1

                    max_length = max(max_length, length)

        return max_length if max_length >= 3 else 0
