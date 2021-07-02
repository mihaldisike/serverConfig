
#lower number = higher in the list
#flag G to ignore gpg check (else you will need manual action)
zypper -n addrepo --gpgcheck -p 90 http://download.opensuse.org/repositories/devel:/languages:/php/openSUSE_Leap_15.3/devel:languages:php.repo

#more recent version and other stuff
#zypper -n addrepo --gpgcheck -p 90 https://download.opensuse.org/repositories/server:http/openSUSE_Leap_15.3/server:http.repo

zypper -n --gpg-auto-import-keys refresh
zypper -n install php7 php7-devel php7-fpm composer php7-opcache php7-mbstring php7-fileinfo php7-curl php7-mysql php7-soap php7-shmop php7-tidy php7-intl php7-gd php7-gettext php7-gmp

zypper -n in nginx
#in some case this is quite usefull to enable the (just at the beginning)
# load_module lib64/nginx/modules/ngx_http_fancyindex_module.so;

#autostart
chkconfig php-fpm on
chkconfig nginx on

#used on several occasion and really handy!
#we just need to force say ok to it to go ahead...
#not tested but is probably ok
printf "\n" | pecl install apcu
echo "extension = apcu.so" > /etc/php7/conf.d/apcu.ini

#opcache is NOT ON for cli, a few things are needed to enable see for detail https://stackoverflow.com/a/35880017
#https://pierre-schmitz.com/using-opcache-to-speed-up-your-cli-scripts/
wget https://raw.githubusercontent.com/dublinbranch/serverConfig/master/opcache -O -> /tmp/opcache
cat /tmp/opcache >> /etc/php7/cli/php.ini
mkdir /tmp/php-file-cache
#create the script to create the folder, and clean old stuff
mkdir /etc/custom
echo "d /tmp/php-opcache 1777 root root 1d" >> /etc/custom/opcache.conf
systemd-tmpfiles --create /etc/custom/opcache.conf
systemctl daemon-reload

#not strictly needed 
#pecl install redis
#echo "extension = apcu.so" > /etc/php7/conf.d/apcu.ini
#pecl install igbinary
#echo "extension = apcu.so" > /etc/php7/conf.d/apcu.ini

#of course install only in local machine!
#pecl install xdebug
#wget "https://seisho.us/serverConfig/xdebug.ini" -O ->> /etc/php7/conf.d/xdebug.ini

#phpfpm tutto default
cd /etc/php7/fpm
cp php-fpm.conf.default php-fpm.conf
cd php-fpm.d/
cp www.conf.default www.conf

wget "https://raw.githubusercontent.com/dublinbranch/serverConfig/master/phpfpm_15.2.patch" -O -> /tmp/phpfpm.patch
cd /etc/
git apply /tmp/phpfpm.patch

#just  a few defaults
wget "https://raw.githubusercontent.com/dublinbranch/serverConfig/master/nginx.sh" -O -> /tmp/nginx.sh
chmod +x /tmp/nginx.sh
/tmp/nginx.sh

#srly ? how do they think is going to work whitout that ?
printf '\nfastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> /etc/nginx/fastcgi_params

nginx -t
rcnginx start

git add *
git commit -am"php done"
