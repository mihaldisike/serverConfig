rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
zypper -n addrepo --gpgcheck --refresh https://yum.mariadb.org/10.4/opensuse/15/x86_64 mariadb
zypper -n --gpg-auto-import-keys refresh
zypper in -f MariaDB-server-10.4.11-1
zypper in MariaDB-backup
systemctl start mariadb
chkconfig mariadb on

#in case you are doing an update also execute
# mysql_upgrade 
