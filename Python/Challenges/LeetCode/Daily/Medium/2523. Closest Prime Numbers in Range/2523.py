class Solution:
    def closestPrimes(self, left: int, right: int) -> List[int]:
        if right < 2:
            return [-1, -1]

        sieve = [True] * (right + 1)
        sieve[0] = sieve[1] = False
        for i in range(2, int(right**0.5) + 1):
            if sieve[i]:
                sieve[i * i : right + 1 : i] = [False] * len(
                    sieve[i * i : right + 1 : i]
                )

        primes = [num for num in range(left, right + 1) if sieve[num]]

        if len(primes) < 2:
            return [-1, -1]

        min_diff = float("inf")
        res = [primes[0], primes[1]]

        for i in range(len(primes) - 1):
            current_diff = primes[i + 1] - primes[i]
            if current_diff < min_diff:
                min_diff = current_diff
                res = [primes[i], primes[i + 1]]
                if min_diff == 2:
                    break

        return res
