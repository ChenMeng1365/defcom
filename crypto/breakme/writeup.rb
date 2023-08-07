#coding:utf-8

a = DATA.read[5..-2].split('')
s = []
t = a.uniq.sort

a.each_with_index do|chr,idx|
  s << t[ (t.index(chr) - idx + t.size) % t.size ]
end

p s.join # flag{98b82h96629e1424ed6122f661d6728h}

__END__
fmcj{99db74fdec18e0h2dd73672cda4g0f3e}