---
marp: true
---

# how to calc xor

根据题目的意思，b64是flag1 bas64加密后转成的长整数，然后依次和flag1的每一字节做异或运算
flag1的长度为10，按位异或只会改变最后一个字节，所以flag2除以10即为原始值（最后一字节不准）
然后遍历最后一字节，逆向base64解密得到flag1（由于本身是base64最后要么数字，要么=）

```ruby
require 'base64'

flag2 = 1307182736072934982876214888159731541302
n = flag2/10
raw = ("%x"%n).split('').each_slice(2).map{|c|eval("0x"+c.join).chr}.join[0..-2]

(0..255).each do|i|
  guess = "#{raw}#{i.chr}"
  p Base64::decode64(guess)
end
```
