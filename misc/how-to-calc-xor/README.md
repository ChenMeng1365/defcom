
# how_to_calc_xor

```python
from Crypto.Util.number import *
from hashlib import md5
import base64

flag1 = "**********"
flag2 = 0
assert len(flag1) == 10
b64 = bytes_to_long(base64.b64encode(flag1))
for char in flag1:
  flag2 += b64^ord(char)
# flag2 = 1307182736072934982876214888159731541302
# flag1 = "flag{" + flag + "}"
```
