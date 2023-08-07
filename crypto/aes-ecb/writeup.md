
# AES-ECB writeup

根据题目提示是AES ECB方式加密，而AES ECB需要知道密文、key/password，iv=nil

AES有时候密文为base64加密密文，有时候则不是，解密时可以区分尝试

key这些字符的特征除了像16进数字，还落入了可打印字符的范围，遂将其按2字符转1字节格式化为字符串

|char|dec|hex|
|--|--|--|
|0-9|48-57|0x30-39|
|A-Z|65-90|0x41-5a|
|a-z|97-122|0x61-7a|

之后一路Base64/32解码

最后得到一串十进制类似大数字的字符串

```shell
73482869966941568986070483420949346593
```

几种方式实验未果后，怀疑是大数字编码字符串，将其改为二/十六进制重新按字节编排

```shell
7HI5 15 7h3 key!
```

刚好16字节，如果key是16字节，那么应该是AES-128-ECB(key.size*8)

解密得到结果

```shell
flag{f44b8a985879018ac218c58b1af987e6}
```