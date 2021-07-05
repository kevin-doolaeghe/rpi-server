# Proxy

```shell
sudo apt-get install nginx

/etc/nginx
/etc/nginx/conf/*.conf
/etc/nginx/modules-enables/*.conf
/etc/nginx/sites-enabled/*

sudo nano /etc/nginx/sites-available/01-www.example.com.conf
upstream backend_jenkins{
    server 127.0.0.1:8080;
}

upstream backend_apache{
    server 127.0.0.1:7080;
}

server {
    listen    80;
    server_name    www.example.com example.com;

    location /jenkins {
        include proxy_params;
        proxy_pass http://backend_jenkins;
    }

    location / {
        include proxy_params;
        proxy_pass http://backend_apache;
    }
}

cat /etc/nginx/proxy_params

sudo ln -s /etc/nginx/sites-available/01-www.example.com.conf /etc/nginx/sites-enabled/01-www.example.com.conf
sudo systemctl reload nginx

sudo apt-get install libapache2-mod-rpaf
systemctl restart apache2

sudo nano /etc/nginx/sites-available/01-www.example.org.conf
upstream backend_jenkins{
    server 127.0.0.1:8080;
}

upstream backend_apache{
    server 127.0.0.1:7080;
}

server {
    listen    80;
    server_name    www.example.com example.com;

    #Redirige toutes les requêtes http vers https
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem

    location /jenkins {
        include proxy_params;
        proxy_pass http://backend_jenkins;
    }

    location / {
        include proxy_params;
        proxy_pass http://backend_apache;
    }
}

sudo apt install squid

http_port 8888
visible_hostname weezie

sudo nano /etc/squid/squid.conf

http_access allow fortytwo_network

acl fortytwo_network src 192.168.42.0/24

acl biz_network src 10.1.42.0/24
acl biz_hours time M T W T F 9:00-17:00

http_access allow biz_network biz_hours
sudo systemctl restart squid.service
```