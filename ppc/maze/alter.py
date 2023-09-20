from z3 import *

def print_matrix(m, align=4):
    for row in m:
        print(' '.join(str(x).rjust(align) for x in row))

X = [[Int("x_%s_%s" % (i + 1, j + 1)) for j in range(9)] for i in range(9)]
cells_c = [And(1 <= X[i][j], X[i][j] <= 9) for i in range(9) for j in range(9)]
rows_c = [Distinct(X[i]) for i in range(9)]
cols_c = [Distinct([X[i][j] for i in range(9)]) for j in range(9)]
sq_c = [
    Distinct([X[3 * i0 + i][3 * j0 + j] for i in range(3) for j in range(3)])
    for i0 in range(3) for j0 in range(3)
]

sudoku_c = cells_c + rows_c + cols_c + sq_c

instance = [
list(map(int, line)) for line in '''
000300200
860000000
009020000
007000091
010000300
500609000
024000100
090082007
000007040
'''.strip().splitlines()
]
instance_c = [
    If(instance[i][j] == 0, True, X[i][j] == instance[i][j]) for i in range(9)
    for j in range(9)
]

s = Solver()
s.add(sudoku_c + instance_c)
if s.check() == sat:
    m = s.model()
    r = [[m.evaluate(X[i][j]).as_long() for j in range(9)] for i in range(9)]
    print_matrix(r, 1)
else:
    print("failed to solve")

import hashlib
print(hashlib.md5(b'175348269862591473439726815247853691916274358583619724724935186691482537358167942').hexdigest()) # f0c4b34b60dbd35f16339b98ee47b582
