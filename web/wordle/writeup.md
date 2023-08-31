
# [WORDLE](https://sspai.com/post/71768)

## 解题过程

简单谈谈WORDLE这个游戏.

这个网上有很多分析, 首先猜最优词为SALET, 然后扩展开来.

当然, 最好有AI辅助找词.

尝试元音i e o a u  
deary  
worth  
juice  
spike  
猜测几次后查询单词为shine

输入后得到`flag{6cf1ac6c60d1a5a8beacf81018dd1d4f}`

## 另类解法

一般游戏会在胜利达成时弹出答案, 那么flag往往就在那个位置

查找站点源码`static/js/lib/main.9b161c3f.js`

## 另类解法之二

cookie中隐藏了正确答案"SHINE", 输入就能看到flag!
