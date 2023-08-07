
# b64 writeup

Challenge | 2020 | 网鼎杯 | 白虎场 | Crypto | b64

从泄漏的明文和泄漏的密文推测, 是根据解析加密过程再依此反推题目的原明文即flag.

由于题目是b64, 密文加密也是类似base64, 所以先把泄漏的明文按base64加密看看

```ruby
require 'base64'
cipher = 'pTjMwJ9WiQHfvC+eFCFKTBpWQtmgjopgqtmPjfKfjSmdFLpeFf/Aj2ud3tN7u2+enC9+nLN8kgdWo29ZnCrOFCDdFCrOFoF='
data = 'ashlkj!@sj1223%^&*Sd4564sd879s5d12f231a46qwjkd12J;DJjl;LjL;KJ8729128713'

c0pher = Base64.encode64(data)
p c0pher.size, cipher.size # 98, 96

c0pher = c0pher.gsub("\n","")
p c0pher # "YXNobGtqIUBzajEyMjMlXiYqU2Q0NTY0c2Q4NzlzNWQxMmYyMzFhNDZxd2prZDEySjtESmpsO0xqTDtLSjg3MjkxMjg3MTM="
```

加密之后长度是一致的, 推测做了某种位移变换, 先建立一个映射表

```ruby
replace,matched = [], []
cipher.split('').zip( c0pher.split('') ) do|cc, c0c|
  replace << [cc, c0c, cc.ord-c0c.ord]
  matched << c0c
end

tree = replace.uniq.sort.inject({}) do|tree, record|
  (tree[ record[0] ] ||= []) << record[-1] # 无重复, 可优化存储
  tree
end
# pp tree

cipher2 = 'uLdAuO8duojAFLEKjIgdpfGeZoELjJp9kSieuIsAjJ/LpSXDuCGduouz'
c0pher2 = ['']
cipher2.each_char do|chipher|
  if tree[chipher]
    c0pher2[-1] << chipher.ord - tree[chipher].first
  else
    c0pher2 << "<#{chipher}>" << ""
  end
end
p c0pher2.select{|s|s!=""} # ZmxhZ3sxZTNhMm?lN?0xYz?yLT?mNGYtOWIyZ??hNGFmYW?kZj?xZTZ?


b64abl = ('a'..'z').to_a+('A'..'Z').to_a+('0'..'9').to_a+['+','/','=']
matched.uniq!
unmatched = b64abl - matched
p c0pher2.select{|s|s.include?"<"}, unmatched
# ["<E>", "<I>", "<G>", "<E>", "<I>", "<s>", "<X>", "<G>", "<z>"]
# ["e", "f", "n", "u", "v", "w", "A", "C", "H", "J", "K", "P", "R", "V", "1", "5", "6", "7", "8", "9", "+", "/"]
```

这里分析有三个重要的结论:  
1. 映射是一对一的, 也就是固定的, 不存在同一字符映射到多个字符的情况
2. 有9个密文字符从密文推不出映射关系, 共6类
3. 有22个明文base64字符推不出映射关系

结论2和3是需要同时关注的, 等于是从22种字符中挑选6个用于映射

现在可以做一个六重循环遍历了, 但不推荐, 空间太大耗时比较长

利用base64编码特性(凡base64必可视, 明文3字节对应密文4字节)只对局部进行检验

```ruby
def all_include?(part, all)part.each_char.inject(true){|flag,one|flag&&all.include?(one)} end

visual = ('a'..'f').to_a+('0'..'9').to_a+['-'] # 可以先局部爆破窥探一下flag的大概字符范围

al = []
unmatched.each do|a|
  r1 = Base64.decode64 "Mm#{a}l"
  r4 = Base64.decode64 "LT#{a}m"
  al << a if all_include?( r1, visual) && all_include?( r4, visual)
end
p al # ["J", "R", "V"]

bdl = []
unmatched.each do|b| unmatched.each do|d|
  r2 = Base64.decode64 "N#{b}0x"
  r5 = Base64.decode64 "Z#{b}#{d}h"
  bdl << [b,d] if all_include?( r2, visual) && all_include?( r5, visual)
end end
p bdl # [["C", "1"]]

cl = []
unmatched.each do|c|
  r3 = Base64.decode64 "Yz#{c}y"
  r7 = Base64.decode64 "Zj#{c}x"
  cl << c if all_include?( r3, visual) && all_include?( r7, visual)
end
p cl # ["A"]

el = []
unmatched.each do|e|
  r6 = Base64.decode64 "YW#{e}k"
  el << e if all_include?( r6, visual)
end
p el # ["J", "R", "V"]

fl = []
unmatched.each do|f|
  r8 = Base64.decode64 "ZTZ#{f}"
  fl << f if r8[-1]=='}' # 末位必定为}
end
p fl # ["9"]
```

做一个联合查询

```ruby
al.each do|a|
  bdl.each do|bdr|b,d=bdr
    cl.each do|c|
      el.each do|e|
        fl.each do|f|
          rev = Base64.decode64 "ZmxhZ3sxZTNhMm#{a}lN#{b}0xYz#{c}yLT#{a}mNGYtOWIyZ#{b}#{d}hNGFmYW#{e}kZj#{c}xZTZ#{f}"
          puts "#{rev} E:#{a} I:#{b} G:#{c} s:#{d} X:#{e} z:#{f}" if all_include?(rev, visual+['{','}','f', 'l', 'a', 'g']) && a!=e
        end
      end
    end
  end
end
# flag{1e3a2be4-1c02-2f4f-9b2d-a4afaddf01e6}
# flag{1e3a2be4-1c02-2f4f-9b2d-a4afaedf01e6}
# flag{1e3a2de4-1c02-4f4f-9b2d-a4afabdf01e6}
# flag{1e3a2de4-1c02-4f4f-9b2d-a4afaedf01e6}
# flag{1e3a2ee4-1c02-5f4f-9b2d-a4afabdf01e6}
# flag{1e3a2ee4-1c02-5f4f-9b2d-a4afaddf01e6}
```
