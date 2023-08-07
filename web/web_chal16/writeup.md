
# writeup

从内容上看是有隐藏内容, 在没有好的思路下先扫描下站点

```
D:\tools\ECS\dirsearch-0.4.3>python dirsearch.py -u http://39.104.60.50:18428/

  _|. _ _  _  _  _ _|_    v0.4.3
 (_||| _) (/_(_|| (_| )

Extensions: php, aspx, jsp, html, js | HTTP method: GET | Threads: 25 | Wordlist size: 11460

Output File: D:\tools\ECS\dirsearch-0.4.3\reports\http_39.104.60.50_18428\__23-03-14_02-05-22.txt

Target: http://39.104.60.50:18428/

[02:05:22] Starting:
......
[02:06:02] 200 -   98B  - /robots.txt
[02:06:03] 200 -  519B  - /secret/
[02:06:03] 301 -  241B  - /secret  ->  http://39.104.60.50:18428/secret/
[02:06:06] 301 -  242B  - /stories  ->  http://39.104.60.50:18428/stories/

Task Completed
```

robots内容是:

```
User-agent: *
Allow: /index.html
Disallow: /secret/flaggggggy.html
Sitemap: /sitemaps/sitemap.xml
```

但secret和stories都没有内容

```
Trying to cheat?
```

/secret/flaggggggy.html会提示如下:

```
no flag here

you should probably find the treasure map before going on an easter hunt
```

即去站点导航中寻找

```
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
   <sitemap>
      <loc>http://172.105.214.27:10516/sitemaps/sitemap1.xml</loc>
   </sitemap>
   <sitemap>
      <loc>http://172.105.214.27:10516/sitemaps/sitemap2.xml</loc>
   </sitemap>
</sitemapindex>
```

这些站点都是不可访问的, 和本机(39.104.60.50:18428)也不是同一个地址

但会不会是不同站点的同样站点导航样式?试一下

[sitemap1](http://39.104.60.50:18428/sitemaps/sitemap1.xml)

[story1](http://39.104.60.50:18428/stories/story1.html)
[story2](http://39.104.60.50:18428/stories/story2.html)
[story3](http://39.104.60.50:18428/stories/story3.html)
[story4](http://39.104.60.50:18428/stories/story4.html)
[story5](http://39.104.60.50:18428/stories/story5.html)

[sitemap2](http://39.104.60.50:18428/sitemaps/sitemap2.xml)

[dictionary](http://39.104.60.50:18428/dictionary/dictionary.html)

故事出自MONSTER, 应该不会专业性太强, 第二个站点就只是个对照表

<pre>
<h2>some simple čeština phrases</h2>
<p>Bůh         : God</p>
<p>Dívka       : Girl</p>
<p>Hledání     : Quest</p>
<p>Jméno       : Name</p>
<p>Která       : That</p>
<p>Monstrum    : Monster</p>
<p>Míru        : Peace</p>
<p>Nemá        : Does not</p>
<p>Obluda      : Monster</p>
<p>Probuzení   : Awakening</p>
<p>Příběh      : ?????</p> <!-- story -->
<p>Své         : Your</p>
<p>Velikonoční : Easter</p>
<p>Vejce       : Egg</p>
<p>Vlajka      : ????</p> <!-- flag -->
<p>Šedesát-Osm : ?????-?????</p> <!-- 68 -->
</pre>

[flag](http://39.104.60.50:18428/stories/story68.html)

`flag{78d61a16-127f-4110-a8bd-073c9a14de41}`

如果一开始就dirsearch stories/为什么没有爆出来?
