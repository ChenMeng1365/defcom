
# breakme

fmcj{99db74fdec18e0h2dd73672cda4g0f3e}

题干中fmcj和flag有一定的差距，m和l差1，c和a差2，j和g差3，即密文依次减去0、1、2、3……会得到明文  
再来看括号内密文，这不是一串十六进制数字（除了0-9、a-f还有g、h），所以不应按照十六进制数或数字来处理  
把十八个字符排序，按照当前位数得到差值，将字符移位差值，在十八位里循环，得到结果
