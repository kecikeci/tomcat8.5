#!/bin/bash

# 设置jvm
limit_in_bytes=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
heap_size=256
# If not default limit_in_bytes in cgroup
if [ "$limit_in_bytes" -ne "9223372036854771712" ]
then
    limit_in_megabytes=$(expr $limit_in_bytes \/ 1048576)
    heap_size=$(expr $limit_in_megabytes - $RESERVED_MEGABYTES)
fi
echo 'export JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -server -Xms64m -Xmx${heap_size}m -Dfile.encoding=UTF-8"' >> /etc/profile
source /etc/profile

exec /data/tomcat-8.5.27/bin/startup.sh
