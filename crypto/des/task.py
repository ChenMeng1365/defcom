from Crypto.Cipher import DES


flag = b'flag{**********}'
key = b'********'
cipher = DES.new(key, DES.MODE_ECB)
msg = cipher.encrypt(flag)
print(msg.hex())
assert str(int(key)) == key.decode()
assert key[:3] == b'952'
# 5defdf5206488c386d1b996b045c85db