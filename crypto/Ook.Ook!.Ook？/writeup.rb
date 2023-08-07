
# 对于简写Ook的进行补全，补全后解码

o = File.read(".！？.txt")
l = []
o.split.each do|k|
  l << k.each_char.map{|c|"Ook"+c}.join(" ")
end

File.write "out.txt",l.join(" ")

__END__
flag{bugku_jiami}