#!/bin/sh

function sys()
{
	yum install -y net-tools
	yum install -y bzip2
}

function dev()
{
	yum install -y gcc gcc-c++
	yum install -y git
}

function vim80()
{
	type vim
	if [ $? == 0 ]; then
		echo "vim has installed"
		return 0
	fi

	vimfile='vim-8.0.tar.bz2'

	if [ -f "${vimfile}" ]; then
		echo "${vimfile} exist"
	else
		curl -O 'ftp://ftp.vim.org/pub/vim/unix/vim-8.0.tar.bz2'
		tar jxvf ${vimfile}
	fi

	# vim dependency
	yum install -y ncurses-devel

	cpu_count=`cat /proc/cpuinfo | grep processor | wc -l`

	cd vim80
	./configure --prefix=/usr/local/vim80
	make -j ${cpu_count}
	make install
	cd -
	rm -rf vim80

	echo "" >> /etc/profile
	echo "export PATH=$PATH:/usr/local/vim80/bin" >> /etc/profile
}

sys
dev
vim80
