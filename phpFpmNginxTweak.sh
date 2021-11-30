After having cloned the related repositories 

Add inside 

vi /etc/nginx/fastcgi_params

# Il super error handler scoperto da Ivano
fastcgi_param  PHP_VALUE   "auto_prepend_file=/srv/www/phpCommon/errorHandler.php";
