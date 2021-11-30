After having cloned the related repositories 

Add 

printf '\n# Il super error handler scoperto da Ivano' >> /etc/nginx/fastcgi_params
printf '\nfastcgi_param  PHP_VALUE   "auto_prepend_file=/srv/www/phpCommon/errorHandler.php";' >> /etc/nginx/fastcgi_params

printf '\n#srly ? how do they think is going to work whitout that ?' >> /etc/nginx/fastcgi_params
printf '\nfastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> /etc/nginx/fastcgi_params

#just  a few defaults
wget "https://raw.githubusercontent.com/dublinbranch/serverConfig/master/nginx.sh" -O -> /tmp/nginx.sh
chmod +x /tmp/nginx.sh
/tmp/nginx.sh

cd /etc

git add *
git commit -am"php done"

*****************

Certain php pool are ok to run for an extended period of time like the one for adminer
In nginx 
        proxy_read_timeout 300;
        proxy_connect_timeout 300;
        proxy_send_timeout 300;
