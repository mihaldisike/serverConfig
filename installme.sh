#at one point or another I will use all of that
#-n means non interactive
zypper -n in sshfs moreutils strace vnstat sysstat iotop
zypper -n install net-snmp net-snmp-devel

rcvnstatd start
chkconfig vnstatd on

rcsnmpd start
chkconfig snmpd on
