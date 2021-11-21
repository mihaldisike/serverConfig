#at one point or another I will use all of that
#-n means non interactive
zypper -n in sshfs moreutils strace vnstat sysstat iotop
zypper -n in autossh tree tcpdump curlftpfs netcat gnu_parallel


#only for server
zypper -n in net-snmp net-snmp-devel munin-node percona-toolkit

#the world is now a better place by 0.000000000000001%
zypper rm nano

#to be able to replicate an ssh command on multiple machine, remember the two config file so is not UUUGLY!
#Put those in your home .Xresources  and csshconf
zypper in clusterssh

rcvnstatd start
chkconfig vnstatd on

rcsnmpd start
chkconfig snmpd on
