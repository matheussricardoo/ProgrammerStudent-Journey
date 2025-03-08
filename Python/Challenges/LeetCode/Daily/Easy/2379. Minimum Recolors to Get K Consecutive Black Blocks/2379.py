class Solution:
    def minimumRecolors(self, blocks: str, k: int) -> int:
        n = len(blocks)
        current_w = sum(1 for c in blocks[:k] if c == 'W')
        min_w = current_w
        
        for i in range(1, n - k + 1):
            outgoing = blocks[i - 1]
            incoming = blocks[i + k - 1]
            
            if outgoing == 'W':
                current_w -= 1
            if incoming == 'W':
                current_w += 1
            
            if current_w < min_w:
                min_w = current_w
        
        return min_w