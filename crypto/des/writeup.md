
# DES

看题目可知是个DES加密过程，且key是一个8位数字的字符串。逆向过程为：

```ruby
require_relative 'ccc/ccc'
require_relative 'ccc/crypto'

flag = 'flag{**********}'
hex = '5defdf5206488c386d1b996b045c85db'.each_char.each_slice(2).map{|b|eval("0x"+b.join).chr}.join
# p stream.each_char.map{|c|"%02x" % c.ord }.join=='5defdf5206488c386d1b996b045c85db'

(0..9).each do|a|
  (0..9).each do|b| # puts [a,b]
    (0..9).each do|c|
      (0..9).each do|d|
        (0..9).each do|e|
          key = "952#{a}#{b}#{c}#{d}#{e}"
          stream = DES.decrypt hex, key, :ECB
          (puts key, stream) if stream[0..4]=='flag{' # => flag{descracker}
        end
      end
    end
  end
end
```
