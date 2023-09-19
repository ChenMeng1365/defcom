
# writeup

通过wireshark查看报文,过滤这个IP的用户报文`ip.src==192.168.173.1 && http`, 发现是在sql注入

观察最后结果, 只看`GET /index.php?id=1%27and%20(select%20ascii(substr((select%20skyflag_is_here2333%20from%20flag%20limit%200,1),1,1)))=XXX%23`这样的载荷, 按他的流程一遍来,最后得到的报文是

```ruby
lines = (File.read "hack-abs.txt").split("\n").select{|l|l.include?("id=1%27and%20(select%20ascii(")}.map{|l|l.split("GET ")[1].split(" HTTP/1.1")[0]}

list = lines.select{|l|l.include?("flag")}.inject({}){|t, l|
  idx = l.split("limit%200,1),")[1].split(",1)))")[0]
  char = l.split("=")[-1].split("%23")
  t[idx] = char;t
}

p list.map{|pile|pile[1].pop.to_i.chr}.join # "flag{skysql_is_very_cool!233}~~~$"
```
