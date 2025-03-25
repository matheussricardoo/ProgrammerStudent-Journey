class Solution:
    def checkValidCuts(self, n: int, rectangles: List[List[int]]) -> bool:
        def check_dimension(dim: int) -> bool:
            # Sort rectangles by their starting coordinate in the given dimension
            sorted_rects = sorted(rectangles, key=lambda x: x[dim])
            gap_count = 0
            furthest_end = sorted_rects[0][dim + 2]  # End coordinate in the same dimension
            
            for rect in sorted_rects[1:]:
                current_start = rect[dim]
                current_end = rect[dim + 2]
                
                if current_start >= furthest_end:
                    gap_count += 1
                    if gap_count >= 2:
                        return True  # Early exit if two gaps are found
                # Update the furthest end coordinate
                furthest_end = max(furthest_end, current_end)
            
            return gap_count >= 2
        
        # Check both dimensions, return True if any allows at least two gaps
        return check_dimension(0) or check_dimension(1)