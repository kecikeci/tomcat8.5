#!/usr/bin/python
# -*- coding: UTF-8 -*-
# 启动时运行的脚本
import os

#启动ssh
os.system("/usr/sbin/sshd -D")
#启动tomcat
os.system("/data/apache-tomcat-8.5.27/bin/startup.sh")

print("启动成功。。。")


