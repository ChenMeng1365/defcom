#coding:utf-8
$LOAD_PATH << '.'
require 'imkit/webot/webot'

headers = {
  'Upgrade-Insecure-Requests'=> '1',
  'User-Agent'=> 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36',
  'Accept'=> 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
  'Accept-Language'=> 'zh-CN,zh;q=0.9',
  'Cookie'=> 'PHPSESSID=c8t9uq35cq27r6trvq4rov86pe; u=351e766803bf804e5c1709d45d65350e3ab4dbe775; r=351e766803d63c7ede8cb1e1c8db5e51c63fd47cff',
  'X-Forwarded-For'=>'127.0.0.1',
  'X-Client-IP'=>'127.0.0.1',
  'X-Real-IP'=>'127.0.0.1',
  'Referer'=>'www.google.com',
}
payload = {"admin": '1'}
result = Webot.post( url: '10.10.26.183', port: 22402, path: '/', headers: headers, data: payload )
pp result
