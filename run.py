#!/usr/bin/python
# -*- coding: UTF-8 -*-

import commands
import os
import subprocess

#启动tomcat，并分配70%的内存给他
tomcat_m = 256
shell_r = commands.getstatusoutput("cat /sys/fs/cgroup/memory/memory.limit_in_bytes")
if(shell_r[1] and long(shell_r[1])!=9223372036854771712):
    os_m = long(shell_r[1])/1048576
    print("系统内存：%sM" % (os_m))
    if(os_m>=512):
        tomcat_m = int(os_m*0.7)
print("分配给JVM的内存：%sM" % (tomcat_m))

output=open('/etc/profile', 'a')
is_opts = commands.getstatusoutput('cat /etc/profile|grep "JAVA_OPTS"|wc -l')
if (is_opts[0]<1):
    output.write('export JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -server -Xms64m -Xmx'+str(tomcat_m)+'m -Dfile.encoding=UTF-8"')
output.close()

subprocess.call("source /etc/profile && exec /data/tomcat-8.5.27/bin/startup.sh", shell=True)