#!/bin/bash
git clone https://github.com/nwokoloemmanuel6/three-tier-app.git

git checkout blog-app

cd three-tier-app

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

source ~/.bashrc

nvm install --lts=hydrogen


# SETUP AND INSTALL NGINX

sudo apt update -y

sudo apt install nginx -y 

sudo unlink /etc/nginx/sites-enabled/default

sudo rm -rf /etc/nginx/sites-enabled/default

sudo tee /etc/nginx/sites-available/clients > /dev/null <<EOF
server {
        listen 3000;
        listen [::]:3000;

        root /var/www/client;
        index index.html;

        server_name localhost;

        location / {
                try_files $uri $uri/ =404;
        }
}
EOF


sudo ln -s /etc/nginx/sites-available/clients /etc/nginx/sites-enabled/

sudo systemctl restart nginx



# SETTING UP NPM


sudo cd ~/three-tier-app/client && npm install

npm run build 

sudo cp -r build /var/www/client

sudo systemctl restart nginx