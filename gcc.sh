#qt need to be installed by itself

zypper in cmake git okteta clazy cmake binutils-gold mold
zypper in cpp10 gcc gcc10 gcc10-c++ gcc7 gcc7-c++ gcc-c++

#In 99.99% is ok to use ld-gold instead of bfg
rm /etc/alternatives/ld
ln -s /usr/bin/ld.gold /etc/alternatives/ld

#mold instead, faster but still some minor annoyances with valgrind or slow debug in some cases 

zypper in libcurl-devel jemalloc-devel libzip-devel libmaxminddb-devel libdw-devel libmariadb-devel
