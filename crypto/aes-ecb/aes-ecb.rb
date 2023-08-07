#coding:utf-8
$LOAD_PATH << '.'
require 'ccc/ccc'
require 'ccc/crypto'
require 'ccc/coding'

key = DATA.read.split('').each_slice(2).map{|c|eval("0x"+c.join).chr}.join

a = Base32.decode key
b = Base64.decode a
c = Base32.decode b
d = Base64.decode c

num = eval d
p e = ("%016x"%num.to_i).split('').each_slice(2).map{|c|eval("0x"+c.join).chr}.join
puts "a: #{a}\nb: #{b}\nc: #{c}\nd: #{d}\ne: #{e}"
key = e
puts "key length: #{e.size}"

type = "aes-#{key.size*8}-ecb"
cipher = "HGX72PnvzrcD9WkWgoTsrb3ypdoF0p9PKy+qL0EiBJjgW0UidZSk4oDNfs4i3Ltq"
puts AES::decrypt({key: key, type: type, cipher: cipher}, :base64)

__END__
4b4e5747364d4b534b52464534554a52494a46464b3232574b564a564d5553564b4d59444b54534e4e524b5441544c4d4a5a5156454d4b324a464a464b3343544b4e5745555332584e524e4551564251475647464b524c4d4b4e4b464d3243514b5a444643364b544b564c46555553554c4a4a56434d42564a424957575a43594b5a4c454d5332574e4e594743554a514d524d453433434f4b424a564d53534f4b5a435534564b4e4e524c45575653554c4a4a46415642514846494643504a35