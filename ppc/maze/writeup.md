
# writeup

从图片上看是个数独计算题, 学一下数独的解法写出求解算法

```ruby
maze = %Q[
  500080090
  040063020
  300007140
  003200910
  000600502
  059041000
  170000006
  062050001
  000706009
]
board = set_board maze
solve(board)
pp board
# [[5, 2, 7, 1, 8, 4, 6, 9, 3],
#  [8, 4, 1, 9, 6, 3, 7, 2, 5],
#  [3, 9, 6, 5, 2, 7, 1, 4, 8],
#  [6, 8, 3, 2, 7, 5, 9, 1, 4],
#  [7, 1, 4, 6, 3, 9, 5, 8, 2],
#  [2, 5, 9, 8, 4, 1, 3, 6, 7],
#  [1, 7, 5, 4, 9, 2, 8, 3, 6],
#  [9, 6, 2, 3, 5, 8, 4, 7, 1],
#  [4, 3, 8, 7, 1, 6, 2, 5, 9]]
```

生成的数字是9x9=81, 不太像二进制编码, 转换成大数也是34字节

```ruby
p str = board.map{|c|c.join}.join # "527184693841963725396527148683275914714639582259841367175492836962358471438716259"
p long="%0x"%str                  # "11c8db1aab3cc525fdc564ffe1f7a9284a47de7e18158ab9376781cee630b9c14d63"
p long.size                       # 68
```

最后试下MD5编码

`p Digest::MD5.hexdigest(board.map{|c|c.join}.join) # "e4d1e2d669954894dcf152cdd1c8f11b"`

但是不对, 不是这个flag

考虑图片是否有其他信息

```shell
DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             PNG image, 930 x 946, 8-bit/color RGBA, non-interlaced
64            0x40            Zlib compressed data, best compression
232           0xE8            Zlib compressed data, default compression
```

查看二进制是否有隐写, 发现文件末尾一串有特异字符

```shell
000d21d0  18 4f 16 6d 22 af 00 00  00 00 49 45 4e 44 ae 42  |.O.m".....IEND.B|
000d21e0  60 82 50 79 41 2f 49 44  38 67 4d 79 41 2f 49 44  |`.PyA/ID8gMyA/ID|
000d21f0  38 67 4d 69 41 2f 49 44  38 67 43 6a 67 67 4e 69  |8gMiA/ID8gCjggNi|
000d2200  41 2f 49 44 38 67 50 79  41 2f 49 44 38 67 50 79  |A/ID8gPyA/ID8gPy|
000d2210  41 2f 49 41 6f 2f 49 44  38 67 4f 53 41 2f 49 44  |A/IAo/ID8gOSA/ID|
000d2220  49 67 50 79 41 2f 49 44  38 67 50 79 41 4b 50 79  |IgPyA/ID8gPyAKPy|
000d2230  41 2f 49 44 63 67 50 79  41 2f 49 44 4d 67 50 79  |A/IDcgPyA/IDMgPy|
000d2240  41 35 49 44 45 67 43 6a  38 67 4d 53 41 2f 49 44  |A5IDEgCj8gMSA/ID|
000d2250  38 67 50 79 41 2f 49 44  4d 67 50 79 41 2f 49 41  |8gPyA/IDMgPyA/IA|
000d2260  6f 31 49 44 38 67 50 79  41 32 49 44 38 67 4f 53  |o1ID8gPyA2ID8gOS|
000d2270  41 2f 49 44 38 67 50 79  41 4b 50 79 41 79 49 44  |A/ID8gPyAKPyAyID|
000d2280  51 67 50 79 41 2f 49 44  38 67 4d 53 41 2f 49 44  |QgPyA/ID8gMSA/ID|
000d2290  38 67 43 6a 38 67 4f 53  41 2f 49 44 38 67 4f 43  |8gCj8gOSA/ID8gOC|
000d22a0  41 79 49 44 38 67 50 79  41 33 49 41 6f 2f 49 44  |AyID8gPyA3IAo/ID|
000d22b0  38 67 50 79 41 2f 49 44  38 67 4e 79 41 2f 49 44  |8gPyA/ID8gNyA/ID|
000d22c0  51 67 50 79 41 3d                                 |QgPyA=|
```

将它按Base64解码得到

```ruby
puts Base64::decode64(File.open("maze.jpg",'rb'){|f|f.read}[-228..-1])
# ? ? ? 3 ? ? 2 ? ? 
# 8 6 ? ? ? ? ? ? ? 
# ? ? 9 ? 2 ? ? ? ? 
# ? ? 7 ? ? 3 ? 9 1 
# ? 1 ? ? ? ? 3 ? ? 
# 5 ? ? 6 ? 9 ? ? ? 
# ? 2 4 ? ? ? 1 ? ? 
# ? 9 ? ? 8 2 ? ? 7 
# ? ? ? ? ? 7 ? 4 ? 
```

这应该才是真的题目, 对其求解

```ruby
inner = %Q[
  000300200
  860000000
  009020000
  007003091
  010000300
  500609000
  024000100
  090082007
  000007040
]
board = set_board inner
solve(board)
pp board
# [[1, 7, 5, 3, 4, 8, 2, 6, 9],
#  [8, 6, 2, 5, 9, 1, 4, 7, 3],
#  [4, 3, 9, 7, 2, 6, 8, 1, 5],
#  [2, 4, 7, 8, 5, 3, 6, 9, 1],
#  [9, 1, 6, 2, 7, 4, 3, 5, 8],
#  [5, 8, 3, 6, 1, 9, 7, 2, 4],
#  [7, 2, 4, 9, 3, 5, 1, 8, 6],
#  [6, 9, 1, 4, 8, 2, 5, 3, 7],
#  [3, 5, 8, 1, 6, 7, 9, 4, 2]]

p Digest::MD5.hexdigest(board.map{|c|c.join}.join) # "f0c4b34b60dbd35f16339b98ee47b582"
```

将结果作为`flag{f0c4b34b60dbd35f16339b98ee47b582}`

附: 数独解法

```ruby
require 'digest'

def set_board text
  rows = text.split("\n").map{|s|s.strip}.select{|s|s.strip.size>1}
  board = rows.inject([]) do|board, row|
    board << row.split('').map{|c|c.to_i};board
  end
  return board
end

def find_empty board
  (0..8).each do|row|
    (0..8).each do|col|
      return [row,col] if board[row][col]==0
    end
  end
  return nil
end

def is_valid board, num, pos
  row, col = pos
  (0..8).each{|j|return false if board[row][j]==num}
  (0..8).each{|i|return false if board[i][col]==num}
  row_block_start = 3 * (row/3)
  col_block_start = 3 * (col/3)
  row_block_end = row_block_start + 3
  col_block_end = col_block_start + 3
  (row_block_start..(row_block_end-1)).each do|i|
    (col_block_start..(col_block_end-1)).each do|j|
      return false if board[i][j]==num
    end
  end
  return true
end

def solve board
  blank = find_empty board
  if blank
    row, col = blank
  else
    return true
  end
  (1..9).each do|i|
    if is_valid(board, i, blank)
      board[row][col] = i
      return true if solve(board)
      board[row][col] = 0
    end
  end
  return false
end
```
