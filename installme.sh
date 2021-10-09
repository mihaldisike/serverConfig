#at one point or another I will use all of that
#-n means non interactive
zypper -n in sshfs moreutils strace vnstat sysstat iotop percona-toolkit
zypper -n in autossh tree tcpdump curlftpfs netcat


#only for server
zypper -n in net-snmp net-snmp-devel munin-node

#the world is now a better place by 0.000000000000001%
zypper rm nano

rcvnstatd start
chkconfig vnstatd on

rcsnmpd start
chkconfig snmpd on
