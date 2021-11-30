After having cloned the related repositories 

Add 

printf '\n# Il super error handler scoperto da Ivano' >> /etc/nginx/fastcgi_params
printf '\nfastcgi_param  PHP_VALUE   "auto_prepend_file=/srv/www/phpCommon/errorHandler.php";' >> /etc/nginx/fastcgi_params

printf '\n#srly ? how do they think is going to work whitout that ?' >> /etc/nginx/fastcgi_params
printf '\nfastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> /etc/nginx/fastcgi_params
