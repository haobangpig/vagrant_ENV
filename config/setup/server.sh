#!/bin/bash -ex

MYSQL_VERSION=5.6.36-1.el6.x86_64

yum -y update

# timezone
rm -f /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --localtime --hctosys

# iptables
service iptables stop
chkconfig iptables off

# for ruby install
yum install -y make gcc gcc-g++ ncurses-devel gdbm-devel db4-devel libffi-devel tk-devel libyaml-devel nss

# application
yum install -y \
    wget vim expect libyaml libyaml-devel zlib zlib-devel \
    readline readline-devel openssl openssl-devel \
    libxml2 libxml2-devel libxslt libxslt-devel \
    git-core

# memcached
yum -y install memcached
chkconfig memcached on
service memcached restart

mkdir -p /var/www/ncsa/current/public
chown -R vagrant:vagrant /var/www/ncsa

# mysql
if [ `rpm -qa | grep -e "MySQL-\(client\|devel\|server\|shared\|shared-compat\)-${MYSQL_VERSION}" | wc -l` -ne 5 ]; then
    yum -y remove MySQL-{client,devel,server,shared,shared-compat}
    rm -f MySQL-{client,devel,server,shared,shared-compat}-${MYSQL_VERSION}.rpm
    wget http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-client-${MYSQL_VERSION}.rpm \
        http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-devel-${MYSQL_VERSION}.rpm \
        http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-server-${MYSQL_VERSION}.rpm \
        http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-shared-${MYSQL_VERSION}.rpm \
        http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-shared-compat-${MYSQL_VERSION}.rpm
    yum -y install MySQL-{client,devel,server,shared-compat}-${MYSQL_VERSION}.rpm
    yum -y install MySQL-shared-${MYSQL_VERSION}.rpm
    rm -f MySQL-{client,devel,server,shared,shared-compat}-${MYSQL_VERSION}.rpm
else
    echo "MySQL 5.6 is already installed."
fi
[ ! -d /etc/mysql.d ] && mkdir -m 755 -p /etc/mysql.d
cat <<MYCNF_DEFAULT > /etc/my_default.cnf
[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
user=mysql
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
innodb_buffer_pool_size = 256M

[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
MYCNF_DEFAULT
cat <<MYCNF_LOCALE > /etc/mysql.d/locale.cnf
[mysqld]
character-set-server=utf8mb4
default-time-zone=+09:00

[mysql]
default-character-set=utf8mb4
MYCNF_LOCALE
cat <<MYCNF > /etc/my.cnf
!include /etc/my_default.cnf
!includedir /etc/mysql.d/
MYCNF
if [ -f /root/.mysql_secret ]; then
    service mysql start
    MYSQL_PASSWORD=`tr -d "\n" < /root/.mysql_secret | awk '{print $(NF)}'`
    mysqladmin -u root -p$MYSQL_PASSWORD password ''
    mv /root/.mysql_secret /root/.mysql_secret.save
fi
chkconfig mysql on
service mysql restart

# japanese
yum -y groupinstall "Japanese Support"
yum -y install glibc-common

# etc
yum -y install vim mosh tmux crontabs
