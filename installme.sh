#at one point or another I will use all of that
#-n means non interactive
zypper -n in sshfs moreutils strace vnstat sysstat iotop percona-toolkit
zypper -n install net-snmp net-snmp-devel autossh
zypper rm nano

rcvnstatd start
chkconfig vnstatd on

rcsnmpd start
chkconfig snmpd on
