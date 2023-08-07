
# brute writeup

可视字符数量有限, 直接穷举
将明文按`*`划分成五组, 依次匹配

```ruby
require 'digest'

s1 = s2 = s3 = s4 = %Q{!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~}.split("")

sha1 = "e7ce8bd*93d4b0c*767c157*f0daa32*21fe52e*"
sha = sha1.split("*")

s1.each do|a|
  s2.each do|b|
    s3.each do|c|
      s4.each do|d|
        de = Digest::SHA1.hexdigest("#{a}3#{b}7-#{c}2#{d}9?")
        as = [de[0..6], de[8..14],de[16..22],de[24..30],de[32..38]]
        puts "#{a}3#{b}7-#{c}2#{d}9?" if as==sha
      end
    end
  end
end

#=> %3G7-#2M9?

__END__
"*" 7
"*" 15
"*" 23
"*" 31
"*" 39
```

穷举得出密码`%3G7-#2M9?`
