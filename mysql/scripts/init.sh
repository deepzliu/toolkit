#!/bin/sh

cmd=/usr/local/mysql-8.0/bin/mysqld
conf=/data1/mysqldata/3306/my.cnf

${cmd} --defaults-file=${conf} --initialize --user=mysql

