
# hbctf1 writeup

反编译源码

```java
// package: org.nisosaikou.hbctf1
// class: MainActivity
...
    public /* synthetic */ void lambda$onCreate$0$MainActivity(View view) {
        try {
            if (new CCTF().check_flag(this._edt_flag.getText().toString(), getPackageManager().getPackageInfo(getPackageName(), 0).versionCode)) {
                Toast.makeText(view.getContext(), "ok.你得到了正确的flag。", 0).show();
            } else {
                Toast.makeText(view.getContext(), "输入的flag不正确哟，请继续努力。", 0).show();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
...
```

这个`getPackageManager().getPackageInfo(getPackageName(), 0).versionCode`是从`AndroidManifest.xml`文件中找到`versionCode`  
`class BuildConfig`中也有这个值
即`check_flag(str, i=331)`

```java
// package: org.nisosaikou.hbctf1
// class: CCTF
...
    private boolean check_flag_content(int i) {
        byte[] bytes = this._flag_content.getBytes();
        for (int i2 = 0; i2 < 32; i2++) {
            bytes[i2] = (byte) (bytes[i2] ^ i);
            if (this.final_result[i2] != bytes[i2] + (i2 % 2)) {
                return false;
            }
        }
        return true;
    }
...
```

加密用到了XOR, 特性是再次XOR运算就会恢复原值  
然后是条件`final_result[i] == bytes[i] + (i % 2)`, 可以理解为运算后的`bytes[i] = final_result[i] - (i % 2)`
于是有如下逆运算:

```ruby
origin = []
final_result = [45, 46, 114, 123, 40, 48, 125, 123, 122, 124, 40, 121, 46, 121, 122, 48, 47, 126, 126, 115, 126, 116, 123, 42, 125, 121, 41, 42, 125, 126, 127, 41]
version_code = 331

final_result.each_with_index do|result, index|
  origin << (((result - (index%2)) ^ version_code ) %256).chr
end

puts "flag{#{origin.join}}" # flag{ff91cd6110c3e31dd659580b63bb664c}
```
