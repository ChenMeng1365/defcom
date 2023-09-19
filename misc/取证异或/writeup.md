
# 取证异或

打开img文件, 找出其中的图片文件

```shell
mkidr -p /mnt/img
mount -o loop blackhole.img /mnt/img
cd /mnt/iso/singularity/$'\t'$'\t'$'\t'\ 
cp masked_key.png /home/kali/Downloads 
```

发现图片并不能打开, 查看文件头发现并不是png文件格式

```shell
00000000  76 88 b1 a7 0d 1a 50 4c  49 46 00 48 1f 0d 0a 06  |v.....PLIF.H....|
00000010  48 4f 50 a7 5a 4f 4c 78  4d 50 45 4e 54 75 c1 31  |HOP.ZOLxMPENTu.1|
00000020  eb 5a 4f 4e 24 36 14 0c  1a 5c 40 47 5a 35 52 2b  |.ZON$6...\@GZ5R+|
00000030  c6 20 45 76 45 07 10 09  1b 2a d5 0e f3 97 50 bc  |. EvE....*....P.|
00000040
```

由于题目中提示有异或, 找了一张正常的png文件来对照

```shell
00000000  89 50 4e 47 0d 0a 1a 0a  00 00 00 0d 49 48 44 52  |.PNG........IHDR|
00000010  00 00 01 f4 00 00 02 e9  08 06 00 00 00 45 76 d4  |.............Ev.|
00000020  52 00 00 00 01 73 52 47  42 00 ae ce 1c e9 00 00  |R....sRGB.......|
00000030  00 04 67 41 4d 41 00 00  b1 8f 0b fc 61 05 00 00  |..gAMA......a...|
00000040
```

一个数对另一个数异或两次会恢复它本来的值, 假设现在是乱结果, 以一个正常的文件头来做异或, 得到文件头为(取前100个字符)

```ruby
m = File.open("masked_key.png","rb"){|f|f.read} # 983040 bytes
c = File.open("compare.png","rb"){|f|f.read}

x = (0..100).inject([]){|x,i|x << (m[i].ord ^ c[i].ord).chr;x}.join
File.open("xor_sample.png","wb"){|f|f.write x}
```

```shell
00000000  ff d8 ff e0 00 10 4a 46  49 46 00 45 56 45 4e 54  |......JFIF.EVENT|
00000010  48 4f 51 53 5a 4f 4e 91  45 56 45 4e 54 30 b7 e5  |HOQSZON.EVENT0..|
00000020  b9 5a 4f 4e 25 45 46 4b  58 5c ee 89 46 dc 52 2b  |.ZON%EFKX\..F.R+|
00000030  c6 24 22 37 08 46 10 09  aa a5 de f2 92 92 50 bc  |.$"7.F........P.|
00000040  16 a8 51 5f a2 e5 7f a8  ae ce 75 0b 0d f4 42 9c  |..Q_......u...B.|
00000050  ae 27 3e fa e1 89 b2 5b  2c 86 83 53 d2 35 36 4d  |.'>....[,..S.56M|
00000060  d8 a5 86 4d cd                                    |...M.|
00000065
```

暂时不看内容的差异, 至少文件头部格式是固定的, 说明和这张图异或的对象应该是一个JFIF结构的数据块

再观察图片文件的末尾, 发现文件尾也是这个结构

```shell
000effc0  ff d8 ff e0 00 10 4a 46  49 46 00 45 56 45 4e 54  |......JFIF.EVENT|
000effd0  48 4f 52 49 5a 4f 4e 20  45 56 45 4e 54 48 4f 52  |HORIZON EVENTHOR|
000effe0  49 5a 4f 4e 20 45 56 45  4e 54 48 4f 52 49 5a 4f  |IZON EVENTHORIZO|
000efff0  4e 20 45 56 45 4e 54 48  4f 52 49 5a 4f 4e ff d9  |N EVENTHORIZON..|
000f0000
```

这说明这一段数据跟JFIF异或后保持了原样, 那么原本的内容可能是为全0, 推断最后这64字节可能是就是参与异或的JFIF数据

使用末尾64字节异或整个文件得到原始图片

```ruby
key = m[-64..-1]

stream = []
m.split("").each_slice(64).each do|pack|
  pack.each_with_index do|rxor, idx|
    oxor = rxor.ord ^ key[idx].ord
    stream << oxor.chr
  end
end

File.open("xor_result.png","wb"){|f|f.write stream.join}
```

图片上文字:`Key: Hacking Radiation`
