#!/bin/sh
# @Author: lance7in
# @Date:   2015-12-17 00:53:58
# @Last Modified by:   lance7in
# @Last Modified time: 2015-12-17 00:54:26
grep "^mysql:" /etc/passwd &> /dev/null  || groupadd mysql && useradd -g mysql  -s /sbin/nologin  mysql


if [ ! -d cmake-3.2.2 ];then
    tar xzvf cmake-3.2.2.tar.gz
fi
cd cmake-3.2.2
./bootstrap && gmake && gmake install && cd ..


if [ ! -d mysql-5.6.24 ];then
    tar xzf mysql-5.6.24.tar.gz
fi
cd mysql-5.6.24
cmake \
-DCMAKE_INSTALL_PREFIX=/data/server/mysql-5.6.24 \
-DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
-DMYSQL_DATADIR=/data/mysql-5.6.24/ \
-DSYSCONFDIR=/data/server/mysql-5.6.24/etc/ \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITH_PERFSCHEMA_STORAGE_ENGINE=1 \
-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITH_EXTRA_CHARSETS=complex \
-DENABLED_LOCAL_INFILE=1 \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_unicode_ci \
-DWITH_DEBUG=0
CPU_NUM=$(cat /proc/cpuinfo | grep processor | wc -l)
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install

echo "PATH=\$PATH:/data/server/mysql/bin" >> /etc/profile && . /etc/profile
ln -s /data/server/mysql-5.6.24/  /data/server/mysql
rm -rf /etc/my.cnf

mkdir -p  /data/server/mysql-5.6.24/etc/
mkdir -p  /data/server/mysql/data/
mkdir -p  /data/log/mysql/

chown -R mysql:mysql /data/server/mysql/
chown -R mysql:mysql /data/server/mysql/data/
chown -R mysql:mysql /data/log/mysql
\cp -f /data/server/mysql/support-files/mysql.server /etc/init.d/mysqld
sed -i 's#^basedir=$#basedir=/data/server/mysql#' /etc/init.d/mysqld
sed -i 's#^datadir=$#datadir=/data/server/mysql/data#' /etc/init.d/mysqld
chmod 755 /etc/init.d/mysqld
/data/server/mysql/scripts/mysql_install_db --datadir=/data/server/mysql/data/ --basedir=/data/server/mysql --user=mysql
