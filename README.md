# gcc 6.5.0脚本安装

## 脚本说明

gcc_650.sh在姜峰等同学编写的gcc 6.5.0安装编译文档的基础上完成，由于时间仓促，仅支持6.5.0版本，需要其他版本的同学请自行修改脚本中相关版本内容，且仅支持在VGPU01-04上使用。

由于类脑集群共享存储，因此只需要在一台服务器上安装，无需在其他服务器重复安装

## 使用方法

由于安装编译时间较长，所以建议挂后台运行，建议使用tmux运行，命令如下:

```shell
bash gcc_650.sh [usr] [path]
```

其中`[usr]`和`[path]`分别填入用户名(如zhangsy)和指定的安装目录(如gcc_650)

## 校验

如果最终正确输出gcc版本号，即如下内容:

```shell
gcc (GCC) 6.5.0
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

说明安装成功，否则安装失败。
### 安装完成后请清理不必要的压缩文件.
