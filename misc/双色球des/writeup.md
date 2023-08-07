---
marp: true
---

# 双色球DES Writeup

先通过binwalk查看图片，发现存在一个附加文件

```shell
>binwalk blink.gif
DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             GIF image data, version "89a", 240 x 240
735555        0xB3943         PNG image, 240 x 320, 8-bit/color RGBA, non-interlaced
735596        0xB396C         Zlib compressed data, best compression
```

将其分离出来，可以发现一串提示`key:ctfer2333`

```shell
>dd if=blink.gif of=next.png skip=735555 bs=1
```

---

观察gif，光标每次位移到下一帧时颜色在两种颜色中选一种，这表示信息可能是一串二进制流

如此则要将其提取成二进制串来解码，分解思路如下：

1. gif文件可以看作是一组图片逐帧组成的，通过工具/程序将其分离为单张图片
2. 这个题目中的位图的特点是单纯的颜色表示两种选择，那么解析文件中的颜色即可批量识别单张图片表示的比特信息
3. png文件格式中，对单纯的颜色还有一种特殊的取值方法，就是取调色板

gif文件格式可以参考这篇文章[GIF文件格式详解](https://blog.csdn.net/Swallow_he/article/details/76165202)

---

GIF文件大致分为11个部分，4类功能

* header-block 控制块
* logical-screen-descriptor 控制块
* global-color-table 数据块
* image-descriptor 绘制块，可重复
* local-color-table 数据块，可重复
* image-data 数据块，可重复
* graphics-control-extension 控制块，可重复
* plain-text-extension 绘制块，可重复
* comment-extension 特殊信息块，可重复
* application-extension 特殊信息块，可重复
* trailer 控制块

---

分离gif有多种方法，以下其中之一：

```python
#coding:utf-8
from PIL import Image
import os
gifFileName = 'blink.gif'
#使用Image模块的open()方法打开gif动态图像时，默认是第一帧
im = Image.open(gifFileName)
pngDir = gifFileName[:-4]
#创建存放每帧图片的文件夹
os.mkdir(pngDir)
try:
  while True:
    #保存当前帧图片
    current = im.tell()
    im.save(pngDir+'/'+str(current)+'.png')
    #获取下一帧图片
    im.seek(current+1)
except EOFError:
    pass
```

---

png文件格式可以参考这篇文章[PNG文件格式详解](https://www.cnblogs.com/senior-engineer/p/9548347.html)

一个png文件分为可选块和必选块，必选块有：文件头(IHDR)，调色板(PLTE)，图像块(IDAT)，结束块(IEND)

简单的颜色从调色板中调取，组成图像块的内容

这个题目颜色很单纯，所以我们判断调色板的内容就可以判断文件是绿色还是紫色

调色板的结构也很简单，每三个字节表示一个颜色，总共有256个深度768个字节，每组颜色分别是RRGGBB格式，绿色即是0x00ff00，紫色则是0xff00ff

二进制获取文件后，解析调色板数据就可以得到颜色含义

---

对每张图解析二进制，进而求出调色板颜色，最后组成字符串

```ruby
#coding:utf-8
palette = {'00ff00' => '0', 'ff00ff' => '1'}
var = ""

Dir["blink/*.png"].sort_by{|i|i.split("/")[1].split(".")[0].to_i}.each_with_index do|png,index|
  report = []

  # binform
  raw = File.open(png,'rb'){|f|f.read}
  raw.each_char.each_with_index do|char,idx|
    report << "#{"%010d"%idx} : #{"%08b"%char.ord} | #{char}\r\n"
  end
  File.write "bin/#{index}.txt",report.join("")

  # get_palette
  pidx = raw.index("PLTE")
  rgb = raw[(pidx+4)..(pidx+6)].split("").map{|c|"%02x"%c.ord}.join
  var << palette[rgb]
end

puts bitstream = var.split('').each_slice(8).map{|n|eval("0b#{n.join}").chr}.join.split("==")[0]+"=="
# "o8DlxK+H8wsiXe/ERFpAMaBPiIcj1sHyGOMmQDkK+uXsVZgre5DSXw==hhhhhhhhhhhhhhhh"
```

---

解出的这个二进制串看起来很像base64，但格式不太对  
结合前面提示还有一个key，估计是加密算法

将BASE64部分用DES解密

```ruby
#coding:utf-8
$LOAD_PATH<<'.'
require 'ccc/ccc'
require 'ccc/crypto'

encrypt = Base64.decode64 "o8DlxK+H8wsiXe/ERFpAMaBPiIcj1sHyGOMmQDkK+uXsVZgre5DSXw=="
key = DES::Block.new 'ctfer2333'[0..7]
data = DES.decrypt encrypt,key,:ECB
```

---

PS：别人的分离位图逐帧解析颜色的解法……

```python
#coding:utf-8
import base64
from PIL import Image
from Crypto.Cipher import DES

im = Image.open('blink.gif')
data = []
for i in range(im.n_frames):
  im.seek(i)
  data.append(1 if im.getpalette()[0] else 0)

data = bytes( int(''.join(map(str, data[i*8: (i+1)*8])), 2) for i in range(len(data) // 8 ))

obj = DES.new('ctfer23333'[:8], DES.MODE_ECB)
print(obj.decrypt(base64.b64decode(data)))
```
