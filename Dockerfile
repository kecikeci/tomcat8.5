# openjdk8+tomcat8.5
# 基于centos6.8+阿里云yum源+ssh密码登录+常用软件,https://github.com/kecikeci/centos6.8-tools
# 镜像仓库在网易云镜像仓库，
FROM hub.c.163.com/gu641034445/public/centos6.8-tools:latest
MAINTAINER https://4xx.me

# 安装jdk
# RUN yum install java-1.8.0-openjdk* -y
RUN yum install java-1.8.0-openjdk java-1.8.0-openjdk-devel -y

# 安装tomcat8.5
RUN mkdir /data
COPY tomcat-8.5.27 /data/tomcat-8.5.27
RUN chmod -R 777 /data/tomcat-8.5.27/bin/*

# 清除yum缓存
RUN yum clean all
RUN rm -rf /var/cache/yum/*

EXPOSE 8080
EXPOSE 22

COPY run.sh /root/run.sh
RUN chmod -R 777 /root/run.sh

ENTRYPOINT /root/run.sh && /usr/sbin/sshd -D
