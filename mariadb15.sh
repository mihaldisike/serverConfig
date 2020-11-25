rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
zypper -n addrepo --gpgcheck --refresh https://yum.mariadb.org/10.5/opensuse/15/x86_64 mariadb
zypper -n --gpg-auto-import-keys refresh
#no silent install there is some output and the etc/my.cnf need to be changed
zypper rm mariadb mariadb-client
#in case version changes ecc ecc just zypper search -s mariadb to get the latest
zypper in MariaDB-server-10.5.6-1 MariaDB-rocksdb-engine MariaDB-oqgraph-engine MariaDB-columnstore-engine
zypper -n in MariaDB-backup mariadb-tools

#per motivi MISTICI non è presente come default di usare jemalloc, e questo ha causato problemi 
#sopratutto se usi rocksdb...
zypper -n in jemalloc
echo 'Environment="LD_PRELOAD=/usr/lib64/libjemalloc.so.2"' >> /usr/lib/systemd/system/mariadb.service

#also change in case of warning / failure to start
vi /usr/lib/systemd/system/mariadb.service
> ProtectHome=false
> LimitNOFILE=50000

systemctl daemon-reload

#those are just a few common thing
echo "plugin-load-add=ha_rocksdb.so" >> /etc/my.cnf.d/server.cnf
echo "rocksdb_flush_log_at_trx_commit = 2" >> /etc/my.cnf.d/server.cnf
#each server is different, take example from the various config file in gogs


systemctl start mariadb
chkconfig mariadb on

#in case you are doing an update also execute
# mysql_upgrade 

#verificare sia usato jemalloc tramite 
#lsof -p $(pidof mysqld) | grep "jemalloc"
#SHOW VARIABLES LIKE 'version_malloc_library';
echo "ricorda i timezone con mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql -p"
