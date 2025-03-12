class Solution:
    def numberOfSubstrings(self, s: str) -> int:
        last_a = last_b = last_c = -1
        answer = 0
        for j in range(len(s)):
            if s[j] == "a":
                last_a = j
            elif s[j] == "b":
                last_b = j
            elif s[j] == "c":
                last_c = j
            if last_a >= 0 and last_b >= 0 and last_c >= 0:
                min_last = min(last_a, last_b, last_c)
                answer += min_last + 1
        return answer
