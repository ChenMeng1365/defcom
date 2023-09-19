
# writeup

IDA读取主程序,发现是做了一个RC4加密

```c
int __cdecl main(int argc, const char **argv, const char **envp)
{
  char Str1[112]; // [rsp+20h] [rbp-60h] BYREF
  char Str2[8]; // [rsp+90h] [rbp+10h] BYREF
  __int64 v6; // [rsp+98h] [rbp+18h]
  __int64 v7; // [rsp+A0h] [rbp+20h]
  __int64 v8; // [rsp+A8h] [rbp+28h]
  __int64 v9; // [rsp+B0h] [rbp+30h]
  __int64 v10; // [rsp+B8h] [rbp+38h]
  __int64 v11; // [rsp+C0h] [rbp+40h]
  __int64 v12; // [rsp+C8h] [rbp+48h]
  __int64 v13; // [rsp+D0h] [rbp+50h]
  __int64 v14; // [rsp+D8h] [rbp+58h]
  __int64 v15; // [rsp+E0h] [rbp+60h]
  __int64 v16; // [rsp+E8h] [rbp+68h]
  __int64 v17; // [rsp+F0h] [rbp+70h]
  __int64 v18; // [rsp+F8h] [rbp+78h]
  __int64 v19; // [rsp+100h] [rbp+80h]
  __int64 v20; // [rsp+108h] [rbp+88h]
  __int64 v21; // [rsp+110h] [rbp+90h]
  __int64 v22; // [rsp+118h] [rbp+98h]
  __int64 v23; // [rsp+120h] [rbp+A0h]
  __int64 v24; // [rsp+128h] [rbp+A8h]
  __int64 v25; // [rsp+130h] [rbp+B0h]
  __int64 v26; // [rsp+138h] [rbp+B8h]
  __int64 v27; // [rsp+140h] [rbp+C0h]
  __int64 v28; // [rsp+148h] [rbp+C8h]
  __int64 v29; // [rsp+150h] [rbp+D0h]
  __int64 v30; // [rsp+158h] [rbp+D8h]
  __int64 v31; // [rsp+160h] [rbp+E0h]
  __int64 v32; // [rsp+168h] [rbp+E8h]
  __int64 v33; // [rsp+170h] [rbp+F0h]
  __int64 v34; // [rsp+178h] [rbp+F8h]
  __int64 v35; // [rsp+180h] [rbp+100h]
  __int64 v36; // [rsp+188h] [rbp+108h]
  unsigned __int8 v37[8]; // [rsp+190h] [rbp+110h] BYREF
  __int64 v38; // [rsp+198h] [rbp+118h]
  __int64 v39; // [rsp+1A0h] [rbp+120h]
  __int64 v40; // [rsp+1A8h] [rbp+128h]
  int v41; // [rsp+1B0h] [rbp+130h]
  __int16 v42; // [rsp+1B4h] [rbp+134h]
  char v43[517]; // [rsp+1C0h] [rbp+140h] BYREF
  char v44[275]; // [rsp+3C5h] [rbp+345h] BYREF
  int v45; // [rsp+4D8h] [rbp+458h]
  int i; // [rsp+4DCh] [rbp+45Ch]

  _main(argc, argv, envp);
  memset(&v44[11], 0, 256);
  strcpy(v44, "monochrome");
  v45 = 11;
  RC4::SetKey((RC4 *)v43, v44, 11);
  for ( i = 0; i < strlen(&v44[11]); ++i )
    printf("%02x\n", (unsigned __int8)v44[i + 11]);
  *(_QWORD *)v37 = 0x7BF9D001684C2673i64;
  v38 = 0x21B8C79BB431C50i64;
  v39 = 0xD4638695368229F9ui64;
  v40 = 0x14C27F31ACBBA07i64;
  v41 = -452765424;
  v42 = -4629;
  *(_QWORD *)Str2 = 0i64;
  v6 = 0i64;
  v7 = 0i64;
  v8 = 0i64;
  v9 = 0i64;
  v10 = 0i64;
  v11 = 0i64;
  v12 = 0i64;
  v13 = 0i64;
  v14 = 0i64;
  v15 = 0i64;
  v16 = 0i64;
  v17 = 0i64;
  v18 = 0i64;
  v19 = 0i64;
  v20 = 0i64;
  v21 = 0i64;
  v22 = 0i64;
  v23 = 0i64;
  v24 = 0i64;
  v25 = 0i64;
  v26 = 0i64;
  v27 = 0i64;
  v28 = 0i64;
  v29 = 0i64;
  v30 = 0i64;
  v31 = 0i64;
  v32 = 0i64;
  v33 = 0i64;
  v34 = 0i64;
  v35 = 0i64;
  v36 = 0i64;
  convertUnCharToStr(Str2, v37, 38);
  RC4::Transform((RC4 *)v43, Str2, Str2, 38);
  std::operator>><char,std::char_traits<char>>(refptr__ZSt3cin, Str1);
  if ( !strcmp(Str1, Str2) )
    printf("congrulation!!!");
  return 0;
}
```

v45传给v43是个密钥, `monochrome\0`, 共11个字节最后一个字节为`0x00`  
v37到v42的38个字节传给Str2是明文  
然后调用`RC4::Transform`加密

程序运行时输入Str1, 如果它和Str2相等则成功, 输入Str1就应该是flag

可以运行程序在检测strcmp处停留并查看Str2的值

也可以逆向计算明文Str2, 注意程序是小端序, 从最低字节存起

```ruby
v11 = "monochrome\0"
v37 = '7BF9D001684C2673'
v38 = '021B8C79BB431C50'
v39 = 'D4638695368229F9'
v40 = '014C27F31ACBBA07'
v41 = 'E5035910' # -452765424 # 0xfe5035910
v42 = 'EDEB' # -4629 # 0xfedeb

proc = lambda{|b|b.split("").each_slice(2).map{|c|c.join}.reverse.join}

puts v11.split('').map{|c|"%02x"%c.ord}.join(' ') # 6d 6f 6e 6f 63 68 72 6f 6d 65 00
puts r37 = proc.call(v37) # 73 26 4C 68 01 D0 F9 7B
puts r38 = proc.call(v38) # 50 1C 43 BB 79 8C 1B 02
puts r39 = proc.call(v39) # F9 29 82 36 95 86 63 D4
puts r40 = proc.call(v40) # 07 BA CB 1A F3 27 4C 01
puts r41 = proc.call(v41) # 10 59 03 E5
puts r42 = proc.call(v42) # EB ED
```

直接cyberchef选择RC4, 输入和密钥都选HEX编码输出ASCII码(Latin1), 得到结果

`flag{a8104075ebacdf71b54a2e61acd6f7d7}`

※程序执行缺一些dll, 可以搜搜找到, 但一定要找一套不要拼凑