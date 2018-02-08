# openjdk8+tomcat8.5
# 基于centos6.8+阿里云yum源+ssh密码登录+常用软件,https://github.com/kecikeci/centos6.8-tools
# 镜像仓库在网易云镜像仓库，
FROM hub.c.163.com/gu641034445/public/centos6.8-tools:latest
MAINTAINER https://4xx.me

# 安装jdk
RUN yum install java-1.8.0-openjdk* -y

# 安装tomcat8.5
RUN wget --no-check-certificate -O /root/apache-tomcat-8.5.27.tar.gz https://mirrors.aliyun.com/apache/tomcat/tomcat-8/v8.5.27/bin/apache-tomcat-8.5.27.tar.gz
RUN tar xzf /root/apache-tomcat-8.5.27.tar.gz -C /root
RUN mkdir /data
RUN mv /root/apache-tomcat-8.5.27 /data
RUN chmod -R 777 /data/apache-tomcat-8.5.27/bin/*

EXPOSE 8080
EXPOSE 22

COPY run.py /root/run.py
RUN chmod -R 777 /root/run.py
CMD ["./run.py"]
