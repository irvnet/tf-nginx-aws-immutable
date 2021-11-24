#!/bin/bash

echo 'prepping web server image... '
sudo apt-get --yes update
sudo apt-get --yes upgrade
sudo apt-get --yes autoremove
sudo apt-get --yes install unzip

## install nginx
sudo apt-get install nginx -y

## enable/start nginx
sudo systemctl start nginx
sudo systemctl status nginx
