
# wp

打开压缩包，不是所有文件都有加密，misc1.zip没有加密，解压后发现一张图片写着2020

以此为密码解压misc1.zip的music.doc文件

```
♭‖♭‖‖♯♭♭♬‖♩♫‖♬∮♭♭¶♭‖♯‖¶♭♭‖∮‖‖♭‖§♭‖♬♪♭♯§‖‖♯‖‖♬‖‖♪‖‖♪‖¶§‖‖♬♭♯‖♭♯♪‖‖∮‖♬§♭‖‖‖♩♪‖‖♬♭♭♬‖♩♪‖♩¶‖♩♪‖♩♬‖¶§‖‖♩‖¶♫♭♭♩‖♬♯‖♬§♭‖♭‖♩¶‖‖∮♭♭♬‖‖♭‖♫§‖¶♫‖♩∮♭♭§‖♭§‖♭§§=
```

搜索一下这个音乐文件如何解密，发现真有[音乐文本加密法](https://www.qqxiuzi.cn/bianma/wenbenjiami.php?s=yinyue)  
解密得到`U2FsdGVkX1/eK2855m8HM4cTq8Fquqtm6QDbcUu4F1yQpA==`

这个字符串也不是base64加密，而是一种[rabbit](http://www.yzcopen.com/ende/rabbit)的流加密  
解密还需要密钥，填入前面的2020试下，得到`welcome_to_payhelp`

以此作为misc2.rar中的hint.txt的密码试下，得到`VmpKMFUxTXhXWGxVV0dob1RUSjRVVll3V2t0aFJscDBZMGhLYTAxWGVIaFZiRkpUWWtaYVZWSnJXbFpOVjJoeVZYcEdZVkpzVG5KVWJHaHBWa1ZWZDFkV1ZtRmtNRFZYVjJ4c2FWSlVWbFJVVnpWdVRXeFZlV1ZHVGxSaVZrWTBXVlJPYzFWR1pFZFRiVGxYWW01Q1dGcEdXbE5UUjBZMlVXMTBWMWRGU2xkV1ZtUXdVekpGZUZOWWJHaFRSVFZWV1d0YVMxTXhjRVZUYTFwc1ZteHdlRlp0ZERCV01VcFlaRE53V0Zac2NIWldSekZMVW1zeFdWSnNTbWxXUjNodlZtMXdUMkl5Vm5OaVNGWnBVbXh3YzFac1VrZFNiRlY0WVVkMFZXSlZXbmxWYlRWUFZsWlplbEZyWkZSaVJrcFFWV3hGYkUwd1VXeE5NRkVsTTBRJTNE`

接着是base64和urldecode反复解码，得到

```shell
welcome_to_2020
flag is coming...
the key is hello 2020!
```

flag.txt的密码就是`hello 2020!`，输入后得到flag

`flag{g00d_f0r_y0u}`

本题最难的地方就是判别出音乐符号和rabbit两种加密方法
