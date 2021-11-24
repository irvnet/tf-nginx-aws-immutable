#!/bin/bash

echo 'prepping web server image... '
sudo apt-get --yes update
sudo apt-get --yes upgrade
sudo apt-get --yes autoremove
sudo apt-get --yes install unzip

## choose a random color for the 
array[0]="Tomato"
array[1]="Orange"
array[2]="DodgerBlue"
array[3]="MediumSeaGreen"
array[4]="Gray"
array[5]="SlateBlue"
array[6]="Violet"
array[7]="LightGray"

size=${#array[@]}
index=$(($RANDOM % $size))
HEADER_COLOR=${array[$index]}

## install nginx
sudo apt-get install nginx -y

## backup default page
sudo mv /var/www/html/index.nginx-debian.html /var/www/html/index.nginx-debian.bkp
sudo mv /tmp/index.html /var/www/html/index.html

## update the index page with a random color
sed -i "s/@COLOR@/${HEADER_COLOR}/" /tmp/index.html

## enable/start nginx
sudo systemctl start nginx
sudo systemctl status nginx
