
# kk

通过提示可以发现图片可能存在压缩文件，用binwalk分析可以发现确实存在

```shell
$ binwalk kk.jpg

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             JPEG image data, JFIF standard 1.01
2317          0x90D           Zip archive data, encrypted at least v2.0 to extract, compressed size: 16455, uncompressed size: 28048, name: key.txt
18914         0x49E2          End of Zip archive, footer length: 22
```

将其分离出来(`binwalk -e`)，改为zip文件，暴力破解密码为R666

打开key文件发现是个Base64编码字符串，反复解码后出现一串摩斯码

```shell
.- -.. . .- ..-. . ..-. -...
```

最后解出摩斯码ADEAFEFB
