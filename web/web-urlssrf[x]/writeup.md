
# writeup

源码重复了一次, 只看一半

1. 构造的代码是POST
2. URL以`http://`或`https://`开头
3. URL的地址如是私网地址, parse_url解析到后则不访问
4. 使用curl访问URL, 如果有重定向连接则也走重定向URL

访问flag.php会提示`Your ip is not 127.0.0.1,so you can not see flag!`, 即要改成一个内网IP, 但改成内网又会因为检查不在访问

这里就要考虑parse_url和libcurl的解析是否是有差异的
详见[文章](https://cloud.tencent.com/developer/article/1165186)

以这种混淆的方式构造地址 [x]

```
?url=http://u:p@127.0.0.1:80@baidu.com/flag.php
```

`flag{100e8a82eea1ef8416e585433fd8462e}`
