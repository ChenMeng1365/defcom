
# 残缺的md5

暴力破解唯一需要注意的就是范围，由于原文是可打印字符，所以枚举范围是有限的

```ruby
require 'digest/md5'

# TASC?O3RJMV?WDJKX?ZM
# e9032???da???08????911513?0???a2
(65..91).each do|i|
    (65..91).each do|j|
        (65..91).each do|k|
            string  = "TASC" + i.chr + "O3RJMV" + j.chr + "WDJKX" + k.chr + "ZM"
            enc_str = Digest::MD5.new.update(string).hexdigest
            if enc_str[0..3] == "e903"
                puts "The String is : #{string}\nThe Md5 of the string is : #{enc_str}"
            end

        end
    end
end
```

```shell
nctf{e9032994dabac08080091151380478a2}
```
