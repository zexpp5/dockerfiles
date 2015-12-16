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
