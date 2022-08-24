#qt need to be installed by itself

zypper in cmake git okteta clazy cmake mold
zypper in cpp gcc gcc-c++ gcc-c++

#mold instead, faster but still some minor annoyances with valgrind in some cases use at your own risk
#remember to change the .pro to use it (normally put in the mkSpec.pri
# QMAKE_LFLAGS += -B /usr/bin/mold

zypper in libcurl-devel jemalloc-devel libzip-devel libmaxminddb-devel libdw-devel libmariadb-devel boost-devel libxml++-devel

#boost version be sure to have at least the 71
