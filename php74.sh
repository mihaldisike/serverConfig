
#lower number = higher in the list
#flag G to ignore gpg check (else you will need manual action)
zypper -n addrepo --gpgcheck -p 90 http://download.opensuse.org/repositories/devel:/languages:/php/openSUSE_Leap_15.1/devel:languages:php.repo

#more recent version and other stuff
#zypper -n addrepo --gpgcheck -p 90 https://download.opensuse.org/repositories/server:http/openSUSE_Leap_15.1/server:http.repo

zypper -n --gpg-auto-import-keys refresh
zypper -n install php7 php7-devel php7-fpm composer php7-mbstring php7-fileinfo php7-curl php7-mysql php7-soap php7-opcache php7-shmop php7-tidy

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

wget "https://seisho.us/serverConfig/phpfpm.patch" -O -> /tmp/phpfpm.patch
cd /etc/
git apply /tmp/phpfpm.patch

#just  a few defaults
wget "https://seisho.us/serverConfig/nginx.sh" -O -> /tmp/nginx.sh
chmod +x /tmp/nginx.sh
/tmp/nginx.sh

#srly ? how do they think is going to work whitout that ?
echo "\nfastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;" >> /etc/nginx/fastcgi_params

