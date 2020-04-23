# serverConfig
some common things to prime a new suse server, you can upload wherever, even in the same machine

#bashrc
wget "https://seisho.us/serverConfig/bashrc" -O -> ~/.bashrc

#set proper git usage and first repo
zypper in git
git config --global --edit
cd /etc
git init
git add *
git commit -a -m"init"
#create repo to push


#firewall
zypper in firewalld
rcfirewalld start
chkconfig firewalld on
firewall-cmd --zone=public --permanent --add-port=1022/tcp
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --reload

#sshd
wget "https://seisho.us/serverConfig/sshd.patch" -O -> /tmp/sshd.patch
cd /etc 
git apply /tmp/sshd.patch
rcsshd restart 
and reconnect using port 1022

#common tooling
wget "https://seisho.us/serverConfig/installme.sh" -O -> /tmp/installme.sh
chmod +x /tmp/installme.sh
/tmp/installme.sh

#mariadb 10.4
wget "https://seisho.us/serverConfig/mariadb14.sh" -O -> /tmp/mariadb14.sh
chmod +x /tmp/mariadb14.sh
/tmp/mariadb14.sh
#now create the first user if needed

#ephemeral port exaustion (TCP Port Lingering)
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse

#php 7.4 (check if you have php installed, if so remove completely, script tested only for fresh install)
#this script will apply a patch so commit git!

cd /etc/
git commit -m"setup in progress"
git add *

wget "https://seisho.us/serverConfig/php74.sh" -O -> /tmp/php74.sh
chmod +x /tmp/php74.sh
/tmp/php74.sh

#create another user
useradd ivano.mercuri
mkdir /home/ivano.mercuri
chown ivano.mercuri:users /home/ivano.mercuri
usermod -g nginx ivano.mercuri
su ivano.mercuri

ssh-keygen

#save where needed
cat ~/.ssh/id_rsa.pub 

#FINAL NOTES
in case of failed patch use 
patch -p1 < /tmp/phpfpm.patch 
to see why is failing, maybe some update somewhere broke something...
