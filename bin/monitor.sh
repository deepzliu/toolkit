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
		proc_start "${name}" "${cmd}"
	fi
}

# (full process name, start command) 
monitor "httpd" "service httpd start"


