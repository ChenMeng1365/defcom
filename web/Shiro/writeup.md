
# writeup

打开网址到[URL](http://39.104.60.50:18852/login;jsessionid=24D14E11FDA79FE8ACCBD58263DB9042)

加入shiro反序列化漏洞利用工具

按步骤, 爆破密钥, 存在泄密密钥(kPH+bIxk5D2deZiIxcaaaA==)

在命令行执行`ls`, 回显含flag文件, 再执行`cat flag`, 得到flag_chaitin

按提示,外面还要加上flag{}, 即`flag{flag_chaitin}`才是结果

不需要生成木马, 使用木马反而连不上
