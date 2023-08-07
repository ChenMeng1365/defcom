
# timestamp writeup

首先看压缩包备注NmRpZ2l0cw==  
base64原文为6digits, 说明有6位数字密码  
暴力破解密码732654得到111.zip

111.zip中, 显示flag.zip为无加密压缩包, setup.sh为有加密压缩包  
而从010中setup.sh的数据区和目录区加密方式却不一样

ZIP文件的格式是:  
首先把压缩文件一个个紧密排列在前, 构成数据区, 每个数据区文件以`frSignature=[50 4B 03 04]`开头  
所有数据文件排列完后, 再一一排列目录区, 每个目录区文件以`deSignature=[50 4B 01 02]`开头  
最终文件以`elSignature=[50 4B 05 06]`结尾

本题考察的是伪加密, 要点在于每个文件的`frFlags`和`deFlags`要一致, 要么都为`[00 00]`表示无加密, 要么都为`[0X 00]`表示加密(X只要尾数为奇数即可)

```hex
50 4B 03 04 14 00 00 00 08 00 B3 56 1F 51 C2 65 # flag.zip/frSignature :: 4B , frVersion :: 2B, frFlags :: 2B, frCompression :: 2B, frFileTime :: 2B, frFileDate :: 2B, frCRC :: 4B/2=>
C9 18 9B 00 00 00 E2 00 00 00 08 00 00 00 66 6C # <= 2/4B, frCompressedSize :: 4B, frUncompressedSize :: 4B, frFileNameLength :: 2B, frExtraFieldLength :: 2B, FILENAME :: frFileNameLength/2=>
61 67 2E 7A 69 70 0B F0 66 66 E1 62 E0 64 60 60 # <=6/frFileNameLength, DATA :: frCompressedSize/...=>
98 12 26 1F A8 2A B4 54 DE 04 C8 D6 00 62 16 06
19 86 B4 9C C4 F4 D0 10 4E 06 E6 F2 6B 3E F1 20
5C 5A C1 CD C0 C8 C2 00 96 06 82 3D 13 DF 3F DF
10 E1 F9 A6 BE 7F 75 F3 89 23 76 D3 05 FE 70 C8
78 6C 7E 20 1D 26 93 6C 65 51 D2 74 2A 7B 42 D8
0D DE 5E FE 9E 33 8C D9 CA A2 5F 95 7E 07 5F ED
69 09 F0 66 E7 40 B6 27 C0 9B 91 49 8E 19 97 1B
24 40 D6 30 30 02 F1 92 46 10 0B E2 22 56 88 8B
D0 5C 13 E0 CD CA 06 51 CD C8 E0 05 A4 9B C0 7A
01 50 4B 03 04 14 00 00 00 08 00 2E 43 B1 4E 44 # <=1/frCompressedSize, setup.sh/frSignature :: 4B , frVersion :: 2B, frFlags :: 2B, frCompression :: 2B, frFileTime :: 2B, frFileDate :: 2B, frCRC :: 4B/1=>
A9 A1 D1 57 00 00 00 5D 00 00 00 08 00 00 00 73 # <= 3/4B, frCompressedSize :: 4B, frUncompressedSize :: 4B, frFileNameLength :: 2B, frExtraFieldLength :: 2B, FILENAME :: frFileNameLength/1=>
65 74 75 70 2E 73 68 15 CC B1 0D 80 20 10 40 D1 # <=7/frFileNameLength, DATA :: frCompressedSize/...=>
9E 29 4E 28 80 02 9C C0 59 10 14 F5 12 81 0B 90
18 9D DE 50 FD 57 7D 31 CD 01 F3 1C 7C BB 98 60
1F 12 98 08 C6 90 6F ED 29 75 5F 56 7A FB 55 32
98 0D 38 55 CC 5D 39 87 89 4A ED CE 29 D9 31 45
A9 ED 88 D2 9A AF 70 DC FE B4 E3 32 C0 7E 50 4B # <=14/frCompressedSize, flag.zip/deSignature :: 4B/2=>
01 02 14 00 14 00 00 00 08 00 B3 56 1F 51 C2 65 # <= 2/4B, deVersionMadeBy :: 2B, deVersionToExtract :: 2B, deFlags :: 2B, deCompression :: 2B, deFileTime :: 2B, deFileDate :: 2B, deCRC :: 4B/2=>
C9 18 9B 00 00 00 E2 00 00 00 08 00 24 00 00 00 # <= 2/4B, deCompressedSize :: 4B, deUncompressedSize :: 4B, deFileNameLength :: 2B, deExtraFieldLength :: 2B, deFileCommentLength :: 2B
00 00 00 00 20 00 00 00 00 00 00 00 66 6C 61 67 # ...=>
2E 7A 69 70 0A 00 20 00 00 00 00 00 01 00 18 00
58 4D 90 EC 41 7F D6 01 5E 76 8F EC 41 7F D6 01
3B 0E AE 92 4B 75 D6 01 50 4B 01 02 14 00 14 00 # <= 8/..., setup.sh/deSignature :: 4B, deVersionMadeBy :: 2B, deVersionToExtract :: 2B
09 00 08 00 2E 43 B1 4E 44 A9 A1 D1 57 00 00 00 # deFlags :: 2B, ...
5D 00 00 00 08 00 24 00 00 00 00 00 00 00 20 00
00 00 C1 00 00 00 73 65 74 75 70 2E 73 68 0A 00
20 00 00 00 00 00 01 00 18 00 00 8C 2E 07 47 0C
D5 01 0A BD 3F 2B 8C 0C D5 01 7D 79 8F 26 8C 0C
D5 01 50 4B 05 06 00 00 00 00 02 00 02 00 B4 00
00 00 3E 01 00 00 00 00
```

setup.sh的数据区`frFlags=[00 00]`, 目录区为`deFlags=[09 00]`, 可见它要么是伪加密, 要么是真加密, 把二者改成一致都试试, 发现就是伪加密, 内容如下

```shell
#!/bin/bash
#
zip -e --password=`python -c "print(__import__('time').time())"` flag.zip flag

```

这个脚本说明, flag.zip的加密方式是通过当时时间戳做密码打包的, 只要查看压缩包时间就可以逆向求得压缩密码

```python
import time

print(time.mktime(time.strptime('2020-08-31 10:56:04', f'%Y-%m-%d %H:%M:%S'))+8*3600) # 111.zip修改时间  # 1598871364.0
print(time.mktime(time.strptime('2020-08-31 10:52:40', f'%Y-%m-%d %H:%M:%S'))+8*3600) # flag.zip修改时间 # 1598871160.0
print(time.mktime(time.strptime('2020-08-18 18:37:29', f'%Y-%m-%d %H:%M:%S'))+8*3600) # flag.zip创建时间 # 1597775849.0
```

得到的密码时间戳不够精确, 但应该是在修改flag.zip和111.zip时间之间, 依次穷举小数位可得1598871183.81  
解压得到`flag{e2430ab24fba043be07800b2d1479be2}`
