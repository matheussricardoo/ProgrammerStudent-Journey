class Solution:
    def repairCars(self, ranks: List[int], cars: int) -> int:
        min_rank = min(ranks)
        left = 1
        right = min_rank * cars * cars

        ans = right

        def is_feasible(T):
            total = 0
            for r in ranks:
                max_cars = math.isqrt(T // r)
                total += max_cars
                if total >= cars:
                    return True
            return total >= cars

        while left <= right:
            mid = (left + right) // 2
            if is_feasible(mid):
                ans = mid
                right = mid - 1
            else:
                left = mid + 1

        return ans
