#mysql
#version:5.7.9
#This image is constructed for youwin trs
FROM centos:7
MAINTAINER Lance Lin <lance7in@gmail.com>
RUN yum update
RUN yum -y install tar gcc-c++ ncurses-devel libtool bison bison-devel  pwgen make optware-devel boost-dev boost-thread boost-system boost-date-time libcurl-dev pwgen  python-setuptools openssh-server
RUN easy_install supervisor
RUN mkdir -p /var/log/supervisor
ADD ./supervisord.conf          /etc/supervisord.conf
ADD ./cmake-3.2.2.tar.gz        /root/tools/
ADD ./mysql-5.6.24.tar.gz       /root/tools/
ADD ./install_mysql-5.6.24.sh   /root/tools/
ADD ./create_mysql_user.sh      /create_mysql_user.sh
WORKDIR /root/tools/
VOLUME /data
RUN sh install_mysql-5.6.24.sh
ADD ./my.cnf    /data/server/mysql-5.6.24/etc/my.cnf
RUN rm -rf /root/tools/mysql-5.6.24
RUN rm -rf /root/tools/mysql-5.6.24.tar.gz
RUN rm -rf /root/tools/cmake-3.2.2
RUN rm -rf /root/tools/cmake-3.2.2.tar.gz
RUN echo 'root:root' | chpasswd
RUN sed  's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
EXPOSE 22 3306

