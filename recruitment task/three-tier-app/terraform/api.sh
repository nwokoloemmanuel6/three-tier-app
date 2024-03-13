#!/bin/bash
git clone https://github.com/nwokoloemmanuel6/three-tier-app.git

git checkout blog-app

cd ~/three-tier-app

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

source ~/.bashrc

nvm install --lts=hydrogen


# SETUP AND INSTALL NGINX

sudo apt update -y

sudo apt install nginx -y 

sudo unlink /etc/nginx/sites-enabled/default

sudo rm -rf /etc/nginx/sites-enabled/default

sudo tee /etc/nginx/sites-available/api > /dev/null <<EOF
server {
    listen 8800;
    server_name localhost;

    location / {
        proxy_pass http://localhost:8800;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
EOF


sudo ln -s /etc/nginx/sites-available/api /etc/nginx/sites-enabled/

sudo systemctl restart nginx



# SETTING UP NPM


sudo cd ~/three-tier-app/api && npm install

pm2 start npm --name "api" -- run start