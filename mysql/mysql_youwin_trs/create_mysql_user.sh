#!/bin/sh
# @Author: lance7in
# @Date:   2015-12-17 00:54:41
# @Last Modified by:   lance7in
# @Last Modified time: 2015-12-17 00:55:05
/data/server/mysql/bin/mysqld_safe >> /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    /data/server/mysql/bin/mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done


echo "============================MYSQL_PASS_INFO=============================== "
echo ""
PASS_ROOT=${MYSQL_PASS:-$(pwgen -s 8 1)}
PASS_DBA=${MYSQL_PASS:-$(pwgen -s 8 1)}
echo ""
echo "=> Creating MySQL root user with ${PASS_ROOT} password"
echo "=> Creating MySQL dba user with ${PASS_DBA} password"
echo ""
/data/server/mysql/bin/mysql -uroot -e "grant all privileges on *.* to 'dba'@'%' identified by '${PASS_DBA}'";
/data/server/mysql/bin/mysql -uroot -e "update mysql.user set password=PASSWORD('${PASS_ROOT}') where user='root' and host='localhost'";
echo ""
echo "===================================END====================================="
echo ""
echo "=> Done!"

echo ""
echo ""
echo "==============================REMOTE_MYSQL_PASSWORD====================="
echo "You can now connect to this MySQL Server using:"
echo ""
echo "    mysql -udba -p${PASS_DBA} -h<host> -P<port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "MySQL user 'root' has no password but only allows local connections"
echo "========================================================================"
