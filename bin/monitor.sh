#!/bin/sh

function proc_start()
{
	name=$1
	cmd=$2
	${cmd}
}

function monitor()
{
	name=$1
	cmd=$2
	pid=`ps hf -opid -C "${name}" | awk '{print $1; exit }'`
	if [ "${pid}SS" == "SS" ]; then
		echo "'${name}' not found and to start"
		proc_start "${name}" "${cmd}"
	fi
}

# (full process name, start command) 
monitor "mysqld" "/sbin/service mariadb start"
monitor "httpd" "/sbin/service httpd start"
monitor "traffic_cop" "/usr/local/ats/bin/trafficserver start"


