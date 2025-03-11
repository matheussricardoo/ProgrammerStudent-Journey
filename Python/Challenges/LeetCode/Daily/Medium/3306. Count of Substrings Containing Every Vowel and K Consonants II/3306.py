class Solution:
    def countOfSubstrings(self, word: str, k: int) -> int:

        vowels = set("aeiou")
        n = len(word)

        cons = [0] * n
        if word[0] not in vowels:
            cons[0] = 1
        for j in range(1, n):
            cons[j] = cons[j - 1] + (1 if word[j] not in vowels else 0)

        last_v = {v: -1 for v in "aeiou"}

        freq = defaultdict(int)

        answer = 0
        current_max_min_last = -1

        for j in range(n):

            if word[j] in vowels:
                last_v[word[j]] = j

            if all(last_v[v] >= 0 for v in "aeiou"):
                min_last = min(last_v[v] for v in "aeiou")

                while current_max_min_last < min_last - 1:
                    current_max_min_last += 1
                    freq[cons[current_max_min_last]] += 1

                if cons[j] == k:
                    answer += 1

                if cons[j] - k in freq:
                    answer += freq[cons[j] - k]

        return answer
