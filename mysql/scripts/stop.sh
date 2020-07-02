#!/bin/sh

cmd=/usr/local/mysql-8.0/bin/mysqladmin
host=127.0.0.1
port=3306
user=root
passwd=123456

${cmd} -h${host} -P${port} -u${user} -p${passwd} shutdown
