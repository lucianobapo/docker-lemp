#rsync -rvztPhe ssh /home/luciano/configs/ 104.197.251.61:nginx-config
#ssh 104.197.251.61
#sudo ln -s /home/luciano/configs/spark.localhost.com /etc/nginx/sites-enabled/spark.localhost.com && sudo service nginx reload
#sudo ln -s /home/luciano/configs/spark.localhost.com /etc/nginx/sites-enabled/spark.localhost.com && sudo service nginx reload

#rm spark.localhost.com-* && rm certindex.txt* && rm cacert.pem && rm private/cakey.pem
#touch certindex.txt

#openssl req -newkey rsa:2048 -x509 -extensions v3_ca -keyout private/cakey.pem -out cacert.pem -days 365 -config ./openssl.cnf
#chmod 777 -R /etc/sslcert
#chmod 700 -R /etc/sslcert

#openssl req -days 365 -newkey rsa:2048 -nodes -out spark.localhost.com-req.pem -keyout private/spark.localhost.com-key.pem -config ./openssl.cnf
#openssl ca -out spark.localhost.com-cert.pem -config ./openssl.cnf -infiles spark.localhost.com-req.pem
#cp spark.localhost.com-cert.pem /etc/ssl/spark.localhost.com.crt
#cp private/spark.localhost.com-key.pem /etc/ssl/spark.localhost.com.key
#service nginx reload

server {
    # Port that the web server will listen on.
    listen 8080;

    # Host that will serve this project.
    server_name spark.localhost.com;

    #listen       443 ssl;
    #ssl          on;
    #ssl_certificate      /etc/ssl/spark.localhost.com.crt;
    #ssl_certificate_key  /etc/ssl/spark.localhost.com.key;
    #ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    #ssl_ciphers 'HIGH:!aNULL:!MD5:!kEDH';

    # Useful logs for debug.
    rewrite_log on;

    # The location of our projects public directory.
    root /code/erpnet-spark/public;

    # Point index to the Laravel front controller.
    index index.php;

    location / {
        # URLs to attempt, including pretty ones.
        try_files $uri $uri/ /index.php?$query_string;
    }

    # Remove trailing slash to please routing system.
    if (!-d $request_filename) {
        rewrite ^/(.+)/$ /$1 permanent;
    }

    # PHP FPM configuration.
    #include /home/luciano/configs/conf-fpm.conf;
    location ~ \.php$ {
        fastcgi_index index.php;
        fastcgi_pass unix:/tmp/php-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include /etc/nginx/fastcgi_params;
    }

    # We don't need .ht files with nginx.
    location ~ /\.ht {
            deny all;
    }

}