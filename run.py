#!/usr/bin/python
# -*- coding: UTF-8 -*-
# 启动时运行的脚本
import commands
import subprocess


#启动tomcat，并分配70%的内存给他
tomcat_m = 256
shell_r = commands.getstatusoutput("cat /sys/fs/cgroup/memory/memory.limit_in_bytes")
if(shell_r[1]):
    os_m = long(shell_r[1])/1048576
    print("系统内存：%sM" % (os_m))
    if(os_m>=512):
        tomcat_m = int(os_m*0.7)
print("分配给JVM的内存：%sM" % (tomcat_m))
subprocess.call('export JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -server -Xms64m -Xmx'+str(tomcat_m)+'m -Dfile.encoding=UTF-8"', shell=True)
subprocess.call("/data/tomcat-8.5.27/bin/startup.sh", shell=True)

#启动ssh
subprocess.call("/usr/sbin/sshd -D", shell=True)

print("启动成功。。。")


