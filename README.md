# defcom

def com是一个收集各类ctf题目、题解以及AWD环境的仓库，用以记录吃瘪的历史

## 目录

- [Web](web/README.md)
- [Reverse](reverse/README.md)
- [Pwn](pwn/README.md)
- [Crypto](crypto/README.md)
- [Android](android/README.md)
- [IoT](iot/README.md)
- [Misc](misc/README.md)

※ 有些题即使参考了解答也依然不能复现或无法理解, 就会在相应的步骤和标题上打上[x]标记

---

## 环境搭建

为了练习和对抗，也准备一些环境的搭建

<details>
  <summary><a src="https://github.com/CTFd/CTFd">CTFd</a></summary>

  安装要求:

  - python3及安装包一堆...
  - centos下先安装`libffi-devel`这个库再编译python，否则python3执行requirements可能会失败，提示`ModuleNotFoundError: No module named '_ctypes'`
  - 可选[汉化界面](https://github.com/Gu-f/CTFd_chinese_CN)，下载后将对应主题放到`CTFd/themes`中

  安装方法:

  ```shell
  git clone https://github.com/CTFd/CTFd
  cd CTFd
  pip3 install Flask
  pip3 install -r requirements.txt # 或者./prepare.sh
  ```

  运行:

  ```shell
  sudo python3 serve.py --port 4000 # 非特权模式下配置无法完成
  ```

  第一次运行进入配置模式，设好管理员账号，就可以维护练习场了

  其他问题:

  练习场很慢的一个原因是主题文件引用了一个css文件延时很高，将其更换速度就会起来

  ```shell
  find . -name fonts.min.css
  vi ./CTFd/themes/core/static/css/fonts.min.css
  # 将'https://use.fontawesome.com/releases/v5.9.0/css/all.css'替换为'https://cdn.bootcss.com/font-awesome/5.13.0/css/all.css'即可
  ```
</details>

<details>
  <summary><a src="https://www.xp.cn/">PHPStudy</a></summary>

  几个常见PHPStudy练习环境搭建:

  1. [upload-labs](https://github.com/c0ny1/upload-labs) 直接扔www里
  2. [php-bugs](https://github.com/bowu678/php_bugs) 直接扔www里
  3. [sqli-labs](https://github.com/Audi-1/sqli-labs) 修改php版本为php5, 确保根文件夹下有`sql-lab.sql`，然后执行主页上的`Setup/reset Database for labs`选项生成环境
  4. [DVWA](https://github.com/digininja/DVWA) 拷贝`config/config.inc.php.dist`模板为`config/config.inc.php`，修改用户名和密码，同时修改数据库名、用户名、密码保持和配置文件一致，然后执行`http://localhost/DVWA/setup.php`生成环境
</details>

<details>
  <summary><a src="https://github.com/zhl2008/awd-platform">AWD Platform</a></summary>

  ```shell
  # 安装平台&下载镜像
  git clone https://github.com/zhl2008/awd-platform.git

  docker pull zhl2008/web_14.04
  docker tag zhl2008/web_14.04 web_14.04
  ```

  ```shell
  # 1. 选中话题, 指定队伍数量
  python batch.py WEB_TOPIC TEAM_NUMBER
  # 2. 加载配置未见, 生成容器
  python start.py ./ TEAM_NUMBER
  ```

  [备份云盘](https://cloud.189.cn/web/main/file/folder/51543115123787296)

  优化建议: [1](https://rj45mp.github.io/awd-platform%E7%9A%84%E6%90%AD%E5%BB%BA/) [2](https://www.heibai.org/post/1468.html) [3](https://www.cnblogs.com/pureqh/p/10869327.html) [4](https://cloud.tencent.com/developer/article/1423407) [5](https://blog.csdn.net/huanghelouzi/article/details/90204325)
</details>

<details>
  <summary><a src="https://github.com/DasSecurity-Labs/AoiAWD">AoiAWD</a></summary>

  ```shell
  git clone https://github.com/DasSecurity-Labs/AoiAWD
  ```

  安装方法参看README.md

  [备份云盘](https://cloud.189.cn/web/main/file/folder/51543115123787296)
</details>
