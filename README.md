# serverConfig
some common things to prime a new suse server, you can upload wherever, even in the same machine


# firewall and change ssh port
```
zypper in firewalld
rcfirewalld start
chkconfig firewalld on
firewall-cmd --zone=public --permanent --add-port=1022/tcp
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --reload
```


# SSH KEY! and disable password login 

```
ssh-keygen

### On your machine
### cat ~/.ssh/id_rsa.pub 

vi /root/.ssh/authorized_keys

### DO NOT DISCONNECT! Open another session and check if asking for the password or not

wget "https://raw.githubusercontent.com/dublinbranch/serverConfig/master/sshd.patch" -O -> /tmp/sshd.patch
cd /etc 
git apply /tmp/sshd.patch
rcsshd restart 
and reconnect using port 1022
```


# set proper git usage and first repo
```
zypper in git
git config --global ubmodule.fetchJobs 10
git config --global --edit
cd /etc
touch .gitignore
echo echo "ld.so.cache" >> .gitignore
echo echo "udev/*" >> .gitignore
echo echo "udev/*" >> .gitignore
echo echo "ssh/moduli" >> .gitignore


git init
git add *
git commit -a -m"init"
#create repo to push
```



# NO SWAP, this is a server, this is 2021 just buy more RAM
to check if is active something
 ```
swapon
 ```
to disable all
 ```
swapoff -a
 ```

# bashrc
```
wget "https://raw.githubusercontent.com/dublinbranch/serverConfig/master/bashrc" -O -> ~/.bashrc
```


# journald persistent
```
mkdir /var/log/journal
systemd-tmpfiles --create --prefix /var/log/journal
echo "SystemMaxUse=10G" >> /etc/systemd/journald.conf
echo "Storage=persistent" >> /etc/systemd/journald.conf
systemctl restart systemd-journald.service
```

# common tooling
```
wget "https://raw.githubusercontent.com/dublinbranch/serverConfig/master/installme.sh" -O -> /tmp/installme.sh
chmod +x /tmp/installme.sh
/tmp/installme.sh
```

# mariadb 10.4 / 10.5 
```
wget "https://seisho.us/serverConfig/mariadb14.sh" -O -> /tmp/mariadb.sh
wget "https://raw.githubusercontent.com/dublinbranch/serverConfig/master/mariadb15.sh" -O -> /tmp/mariadb.sh
chmod +x /tmp/mariadb.sh
/tmp/mariadb.sh
#now create the first user if needed
```
# ephemeral port exaustion (TCP Port Lingering)
```
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
```
# php 7.4 (check if you have php installed, if so remove completely, script tested only for fresh install)
#this script will apply a patch so commit git!
```
cd /etc/
git commit -m"setup in progress"
git add *

# this also contain basic nginx
wget "https://raw.githubusercontent.com/dublinbranch/serverConfig/master/php74.sh" -O -> /tmp/php74.sh
chmod +x /tmp/php74.sh
/tmp/php74.sh
```

# create another user
```
useradd ivano.mercuri
mkdir /home/ivano.mercuri
chown ivano.mercuri:users /home/ivano.mercuri
usermod -g nginx ivano.mercuri
su ivano.mercuri
```
# FINAL NOTES
in case of failed patch use 
patch -p1 < /tmp/phpfpm.patch 
to see why is failing, maybe some update somewhere broke something...

# Munin
Please check the internal wiki (Munin-node) as is complex and interleaved a bit
