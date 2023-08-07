
# [catch-the-cat writeup](http://47.100.106.88:8001/)

尝试玩游戏一般都是达成条件弹出结果, 所以可以考虑如何达成条件  
除了正常玩, WEB游戏如果弄到源码, 可以审计下js源码的条件  
`catch-the-cat.js`有如下一段, 就是达成时的事件

```javascript
i.WIN:this.setStatusText(f.default("key:676BBB807DEA8E3D"));
```
