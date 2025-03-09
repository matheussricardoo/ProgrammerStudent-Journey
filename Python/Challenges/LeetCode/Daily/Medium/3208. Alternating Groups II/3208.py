class Solution:
    def numberOfAlternatingGroups(self, colors: List[int], k: int) -> int:
        n = len(colors)
        if k < 3 or k > n:
            return 0

        valid = []
        for i in range(n):
            next_i = (i + 1) % n
            valid.append(1 if colors[i] != colors[next_i] else 0)

        window_size = k - 1
        doubled = valid * 2

        current_sum = sum(doubled[:window_size])
        count = 0

        for i in range(n):
            if current_sum == window_size:
                count += 1

            current_sum -= doubled[i]
            current_sum += doubled[i + window_size]

        return count
