#!/bin/bash
#'EOF' will not interpret variables
cat << EOF > /etc/nginx/php
location ~ \.php$ {
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_index  index.php;
}
EOF


cat << EOF > /etc/nginx/disableSendingSensitiveInfo
location ~ /\.git {
    deny all;
}
location ~ \.sh {
    deny all;
}
EOF


cat << EOF > /etc/nginx/staticCache
location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
    expires 1h;
    log_not_found off;
}
EOF


#ovewrite default nginx, 'EOF' will not interpret variables
cat << 'EOF' > /etc/nginx/nginx.conf
worker_processes  1;
worker_rlimit_nofile 30000;

events {
    worker_connections  10000;
    use epoll;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format postdata escape=json '$remote_addr - $remote_user [$time_local] '
                       '"$request" $status $bytes_sent '
                       '"$http_referer" "$http_user_agent" "$request_body"';

    #access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    gzip  on;
    gzip_types
        text/plain
        text/css
        text/js
        text/xml
        text/javascript
        application/javascript
        application/json
        application/xml
        application/rss+xml
        image/svg+xml;

    include conf.d/*.conf;
    server {
        #listen ...
    
    }

    include vhosts.d/*.conf;
}
#location /wUAPbqwJSBYu2KEgPmxkyZAbtF6IAz7 {
#    stub_status on;
#    access_log   off;
#}


EOF

