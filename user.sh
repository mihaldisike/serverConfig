useradd ivano.mercuri
usermod -aG wwwrun ivano.mercuri 
usermod -aG www ivano.mercuri 
mkdir /home/ivano.mercuri
chown ivano.mercuri /home/ivano.mercuri/
chown wwwrun:www /srv/www

#poi loggare come su e fare ssh-keygen per inizializzare ssh
