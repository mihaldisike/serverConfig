#qt need to be installed by itself

zypper in cmake git okteta clazy cmake binutils-gold mold
zypper in cpp11 gcc gcc11 gcc11-c++ gcc-c++

#In 99.99% is ok to use ld-gold instead of bfg, ATM I (Roy) the only problem is linking mariadb
rm /etc/alternatives/ld
ln -s /usr/bin/ld.gold /etc/alternatives/ld

#mold instead, faster but still some minor annoyances with valgrind or slow debug in some cases use at your own risk

zypper in libcurl-devel jemalloc-devel libzip-devel libmaxminddb-devel libdw-devel libmariadb-devel boost-devel libxml++-devel

#boost version be sure to have at least the 71
