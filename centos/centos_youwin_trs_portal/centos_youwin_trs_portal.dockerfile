#centos
#version:7
#This image is constructed for youwin trs
FROM centos:7
MAINTAINER Lance Lin <lance7in@gmail.com>
RUN yum update
RUN yum -y install wget
RUN wget -c -O /tmp/jdk-8u25-linux-x64.rpm --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.rpm
RUN yum -y localinstall /tmp/jdk-8u25-linux-x64.rpm
RUN rm -f /tmp/jdk-8u25-linux-x64.rpm
RUN cd /tmp&&wget http://mirror.olnevhost.net/pub/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
RUN mv apache-maven-3.0.5  /usr/local/apache-maven
RUN echo "export M2_HOME=/usr/local/apache-maven" >> /etc/profile
RUN echo "export M2=$M2_HOME/bin" >> /etc/profile
RUN echo "export PATH=$M2:$PATH" >> /etc/profile
RUN source /etc/profile