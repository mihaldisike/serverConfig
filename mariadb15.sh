rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
zypper -n addrepo --gpgcheck --refresh https://yum.mariadb.org/10.5/opensuse/15/x86_64 mariadb
zypper -n --gpg-auto-import-keys refresh
#no silent install there is some output and the etc/my.cnf need to be changed
zypper in mariadb
zypper -n in MariaDB-backup

#per motivi MISTICI non è presente come default di usare jemalloc, e questo ha causato problemi 
#sopratutto se usi rocksdb...
zypper in jemalloc
echo 'Environment="LD_PRELOAD=/usr/lib64/libjemalloc.so.2"' >> /usr/lib/systemd/system/mariadb.service
systemctl daemon-reload

systemctl start mariadb
chkconfig mariadb on

#in case you are doing an update also execute
# mysql_upgrade 

#verificare sia usato jemalloc tramite 
#lsof -p $(pidof mysqld) | grep "jemalloc"
#SHOW VARIABLES LIKE 'version_malloc_library';
