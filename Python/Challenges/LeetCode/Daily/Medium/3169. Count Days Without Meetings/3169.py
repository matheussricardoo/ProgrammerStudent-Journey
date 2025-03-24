class Solution:
    def countDays(self, days: int, meetings: List[List[int]]) -> int:
        meetings.sort()
        merged = []
        current_start, current_end = meetings[0]

        for meet in meetings[1:]:
            start, end = meet
            if start <= current_end:
                current_end = max(current_end, end)
            else:
                merged.append((current_start, current_end))
                current_start, current_end = start, end
        merged.append((current_start, current_end))
        total_covered = 0
        for s, e in merged:
            total_covered += e - s + 1

        return days - total_covered
